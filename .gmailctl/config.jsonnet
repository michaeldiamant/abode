local lib = import 'gmailctl.libsonnet';

// These filters may provide inspiration:  https://gist.github.com/ldez/bd6e6401ad0855e6c0de6da19a8c50b5.

local filterBySubjectWithLabel(from, subject, labels) =
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

local ghNotifications = "notifications@github.com";

// Filters for Issues by absence of other modifiers (e.g. PR).  As of writing,
// responses to Issues do not include _Issue_ in the subject.
local filterIssues(organization, repo, label) =
  filterBySubjectWithLabel(
    ghNotifications,
    '-PR %s/%s' % [organization, repo],
    ['%s/Issues' % label, '%s' % label]
  );

local filterPullRequests(organization, repo, label) =
  filterBySubjectWithLabel(
    ghNotifications,
    '%s/%s PR' % [organization, repo],
    ['%s/PRs' % label, '%s' % label, '01-PRs']
  );

local filterGithubRepo(organization, repo) = [
  filterIssues(organization, repo, repo),
  filterPullRequests(organization, repo, repo),
];

local filterGithubRepoWithLabel(organization, repo, label) = [
  filterIssues(organization, repo, label),
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
  std.flattenArrays([
    filterGithubRepo('algorand', '%s' % repo)
    for repo in [
      'algorand-sdk-testing',
      'docs',
      'go-algorand',
      'go-algorand-sdk',
      'indexer',
      'java-algorand-sdk',
      'js-algorand-sdk',
      'py-algorand-sdk',
      'py-algorand-sdk',
      'pyteal',
      'pyteal-utils',
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
