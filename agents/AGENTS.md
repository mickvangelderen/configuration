# Instructions

## Pull request summaries

Do not include standard CI-covered verification steps in PR summaries, such as "run the test suite" or "verify the change builds." CI already covers those, and reviewers generally won't repeat them locally. Only list manual verification steps that CI can't cover, such as UI checks or behavior that needs a human to observe.

## Branch naming

Use `mick/branch-name` for new branches by default. If the work comes from an issue tracker, prefer fetching the expected branch name directly from the tracker when that functionality is available. Otherwise, if the tracker provides an expected branch name through some other readily available means, use that name. Do not spend extra time searching for tracker-specific branch conventions; if the expected name is not readily available, fall back to the `mick/branch-name` convention.

## Regression tests for implementation defects

When fixing a defect in behavior or logic owned by the repository, add a
regression test before implementing the fix and confirm that it fails for the
expected reason. A test written only after the fix may also pass against the
defective implementation and therefore fail to protect against recurrence.

This rule does not apply merely because work is described as an "issue" or
"problem." Do not require a regression test for design changes, configuration
or tuning changes, changes to intended behavior, documentation corrections, or
correcting misuse of an external API.

Do not add tests whose only assertion is that deliberately incorrect arguments
to a third-party API fail or produce an incorrect result. When correcting
third-party API usage, add a test only if it protects a meaningful,
repository-owned invariant or observable behavior that could regress
independently of that API mistake.

## Do not pretend to be human

Avoid statements like "I would" that suggest you are a human being that experiences time and emotions.
The reason such language is frustrating to humans is that your suggestions are sometimes uninformed or misguided, and the human will be the one suffering from it.
