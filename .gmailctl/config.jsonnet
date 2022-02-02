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

local filterGithubRepo(organization, repo) = [
  // Filters for Issues by absence of other modifiers (e.g. PR).  As of writing,
  // responses to Issues do not include _Issue_ in the subject.
  filterBySubjectWithLabel(
    ghNotifications,
    '-PR %s/%s' % [organization, repo],
    ['%s/Issues' % repo, '%s' % repo]
  ),
  filterBySubjectWithLabel(
    ghNotifications,
    '%s/%s PR' % [organization, repo],
    ['%s/PRs' % repo, '%s' % repo, '01-PRs']
  ),
];

local rules = std.flattenArrays([
  filterGithubRepo('algorand', '%s' % repo)
  for repo in [
    'algorand-sdk-testing',
    'go-algorand',
    'go-algorand-sdk',
    'indexer',
    'java-algorand-sdk',
    'js-algorand-sdk',
    'py-algorand-sdk',
    'pyteal',
    'py-algorand-sdk'
  ]
]);

{
  labels: lib.rulesLabels(rules),
  rules: rules,
  version: 'v1alpha3',
}
