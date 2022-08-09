local lib = import 'gmailctl.libsonnet';

// These filters may provide inspiration:  https://gist.github.com/ldez/bd6e6401ad0855e6c0de6da19a8c50b5.

// Limitations:
// * Due to Gmail's limited filter search capabilities, it's _not_ easily
//   possible to disambiguate terms sharing a prefix.
//
//   For example:
//   * go-algorand and go-algorand-sdk share the go-algorand prefix.
//   * Notificatons to go-algorand-sdk show up in go-algorand-sdk and
//     go-algorand.
//
//   Chain filters provide if-else support to avoid the extra labels.  However,
//   chain filters don't work out-of-the-box because `filterGithubRepo` groups
//   _PRs_ and _!PRs_ filters.  I think the fix is to group _PR_ subscriptions.
// * PR approvals show up in _!PRs_ because the subject does not include _PR_.
//   A possible fix is to search the email body for keywords like _approved_.

local filterByRecipientWithLabels(from, to, labels) =
  {
    filter: {
      and: [
        { from: from },
        { to: to },
      ],
    },
    actions: {
      archive: true,
      labels: labels,
    },
  };

local filterBySubjectWithLabels(from, subject, labels) =
  {
    filter: {
      and: [
        { from: from },
        {
          isEscaped: true,
          subject: subject,
        },
      ],
    },
    actions: {
      archive: true,
      labels: labels,
    },
  };

local ghNotifications = 'notifications@github.com';

// Catalogs labels by priority.  Higher urgency labels sorted to appear at top
// of gmail label list.
local priorityLabels = {
  urgent: '01-PR-Urgent',
  ci: '02-PR-CI',
  mentions: '03-PR-Mentions',
  allPrs: '04-PRs'
};

local filterUrgentPullRequestActivity() =
  local sources = [
    { to: 'author@noreply.github.com', label: priorityLabels.mentions },
    { to: 'ci_activity@noreply.github.com', label: priorityLabels.ci },
    { to: 'mention@noreply.github.com', label: priorityLabels.mentions },
    { to: 'review_requested@noreply.github.com', label: priorityLabels.mentions },
  ];

  [
    filterByRecipientWithLabels(
      ghNotifications,
      s.to,
      [ s.label, priorityLabels.urgent ]
    )
    for s in sources
  ];

// Filters for non-PR notifications (e.g. Issues and Releases) by absence of
// other _PR_ modifier.
// As of writing, responses to Issues do not include _Issue_ in the subject.
// To avoid creating numerous sub-labels, bucket all non-PR notifications in
// the same label.
local filterNonPullRequestNotifications(organization, repo, label) =
  filterBySubjectWithLabels(
    ghNotifications,
    '-PR %s/%s' % [organization, repo],
    ['%s/!PRs' % label, '%s' % label]
  );

local filterPullRequests(organization, repo, label) =
  filterBySubjectWithLabels(
    ghNotifications,
    '%s/%s PR' % [organization, repo],
    ['%s/PRs' % label, '%s' % label, priorityLabels.allPrs ]
  );

local filterGithubRepo(organization, repo) = [
  filterNonPullRequestNotifications(organization, repo, repo),
  filterPullRequests(organization, repo, repo),
];

local filterGithubRepoWithLabel(organization, repo, label) = [
  filterNonPullRequestNotifications(organization, repo, label),
  filterPullRequests(organization, repo, label),
];

local chainFilterGithubRepos(organization, repos) =
  lib.chainFilters(
    std.flattenArrays([
      filterGithubRepo(organization, '%s' % repo)
      for repo in repos
    ])
  );

local rules =
  filterUrgentPullRequestActivity()  +
  std.flattenArrays(
    [
      filterGithubRepo('algorand', '%s' % repo)
      for repo in [
        'algorand-sdk-testing',
        'avm-abi',
        'docs',
        'generator',
        'go-algorand',
        'go-algorand-ci',
        'go-algorand-sdk',
        'graviton',
        'indexer',
        'java-algorand-sdk',
        'js-algorand-sdk',
        'py-algorand-sdk',
        'py-algorand-sdk',
        'pyteal',
        'pyteal-utils',
        'rialto',
        'sandbox'
    ]
  ]) +
  std.flattenArrays([
    filterGithubRepoWithLabel('algorand', 'go-algorand-internal', 'go-algorand')
  ]);

{
  labels: lib.rulesLabels(rules),
  rules: rules,
  version: 'v1alpha3',
}
