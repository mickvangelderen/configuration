# Instructions

## Pull request summaries

Do not include standard CI-covered verification steps in PR summaries, such as "run the test suite" or "verify the change builds." CI already covers those, and reviewers generally won't repeat them locally. Only list manual verification steps that CI can't cover, such as UI checks or behavior that needs a human to observe.

## Branch naming

Use `mick/branch-name` for new branches by default. If the work comes from an issue tracker, prefer fetching the expected branch name directly from the tracker when that functionality is available. Otherwise, if the tracker provides an expected branch name through some other readily available means, use that name. Do not spend extra time searching for tracker-specific branch conventions; if the expected name is not readily available, fall back to the `mick/branch-name` convention.

## Bugfixes with tests

When fixing a bug or issue, add the regression test before implementing the fix. Confirm that the test fails for the expected reason. A test written after the fix may also pass against the buggy code, which means it would not catch the bug if it were reintroduced.
