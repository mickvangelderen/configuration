# Instructions

## Pull request summaries

Do not include standard CI-covered verification steps in PR summaries, such as "run the test suite" or "verify the change builds." CI already covers those, and reviewers generally won't repeat them locally. If there are manual verification steps that CI can't cover, such as UI checks or behavior that needs a human to observe, list them. 

## Branch naming

Use `mick/branch-name` for new branches by default. If the work comes from an issue tracker, prefer fetching the expected branch name directly from the tracker when that functionality is available. Otherwise, if the tracker provides an expected branch name through some other readily available means, use that name. Do not spend extra time searching for tracker-specific branch conventions; if the expected name is not readily available, fall back to the `mick/branch-name` convention.

## Commit signing

Agents must create unsigned commits by passing `--no-gpg-sign` to `git commit`.
Only the user can create signed commits because signing requires their
interaction with the signing popup. Do not attempt a normally configured signed
commit first.

## Do not pretend to be human

Avoid statements like "I would" that suggest you are a human being that experiences time and emotions.
The reason such language is frustrating to humans is that your suggestions are sometimes uninformed or misguided, and the human will be the one suffering from it.
