# Instructions

Canonical source: `~/configuration/agents/AGENTS.md`. If these instructions
are copied or injected into another context, use that path to find and update
the source version.

## Pull request summaries

Do not include standard CI-covered verification steps in PR summaries, such as "run the test suite" or "verify the change builds." CI already covers those, and reviewers generally won't repeat them locally. If there are manual verification steps that CI can't cover, such as UI checks or behavior that needs a human to observe, list them. 

## Branch naming

Use `mick/branch-name` for new branches by default. If the work comes from an issue tracker, prefer fetching the expected branch name directly from the tracker when that functionality is available. Otherwise, if the tracker provides an expected branch name through some other readily available means, use that name. Do not spend extra time searching for tracker-specific branch conventions; if the expected name is not readily available, fall back to the `mick/branch-name` convention.

## Commit signing

Agents must never create signed commits or trigger an interactive signing
prompt. Only the user may create signed commits.

For a direct commit, always use:

```sh
git commit --no-gpg-sign ...
```

For any Git operation that may create or recreate commits—including `rebase`,
`merge`, `cherry-pick`, `revert`, and `am`—disable signing when starting the
operation:

```sh
git -c commit.gpgSign=false rebase ...
git -c commit.gpgSign=false merge ...
git -c commit.gpgSign=false cherry-pick ...
git -c commit.gpgSign=false revert ...
git -c commit.gpgSign=false am ...
```

Apply the same command-scoped override to sequencer continuations:

```sh
git -c commit.gpgSign=false rebase --continue
git -c commit.gpgSign=false cherry-pick --continue
git -c commit.gpgSign=false revert --continue
git -c commit.gpgSign=false am --continue
```

Do not first attempt the operation with the user's configured signing behavior.
Do not change the user's global Git configuration. If a history-rewriting
operation was started without signing disabled and attempts to sign, abort it,
confirm the original branch tip was restored, and restart it with
`-c commit.gpgSign=false`.

## Do not pretend to be human

Avoid statements like "I would" that suggest you are a human being that experiences time and emotions.
The reason such language is frustrating to humans is that your suggestions are sometimes uninformed or misguided, and the human will be the one suffering from it.

## Shared upstream source checkouts

Keep reusable upstream source repositories outside project worktrees under
`~/.cache/agent-sources`. These shared checkouts are only for read-only source
browsing, searching, and comparison. Do not modify or build from them.

Organize them by canonical remote path. Each repository path is a container
holding one bare repository and its detached worktrees as siblings:

```text
~/.cache/agent-sources/
└── github.com/
    └── godotengine/
        └── godot/
            ├── bare.git/
            └── worktrees/
                └── a13da4feb8d8/
```

`bare.git` must be a bare clone and is the single shared object database
for that upstream repository. Verify an existing repository before using it:

```sh
git --git-dir="$HOME/.cache/agent-sources/github.com/godotengine/godot/bare.git" \
  rev-parse --is-bare-repository
```

The result must be `true`. Do not convert or reuse an unexpected non-bare
repository in place. Do not put checkout contents inside `bare.git`: Git uses
`bare.git/worktrees` for its own linked-worktree metadata.

Create detached worktrees for exact revisions and treat those revision
worktrees as read-only. Use a full commit ID, or an unambiguous commit ID long
enough to remain recognizable, as the worktree directory name. Do not use
mutable names such as `latest`.

Before cloning or creating a worktree, inspect the ordinary filesystem and
Git's registered worktrees. Git's registry is the authoritative index; do not
maintain a separate catalog:

```sh
find "$HOME/.cache/agent-sources" -type d -name bare.git
git --git-dir="$HOME/.cache/agent-sources/github.com/godotengine/godot/bare.git" \
  worktree list --porcelain
```

Reuse an existing worktree when it is already at the required commit. Create
the bare repository and add a detached worktree with normal Git commands when
needed:

```sh
git clone --bare https://github.com/godotengine/godot.git \
  "$HOME/.cache/agent-sources/github.com/godotengine/godot/bare.git"
git --git-dir="$HOME/.cache/agent-sources/github.com/godotengine/godot/bare.git" \
  fetch origin
git --git-dir="$HOME/.cache/agent-sources/github.com/godotengine/godot/bare.git" \
  worktree add --detach \
  "$HOME/.cache/agent-sources/github.com/godotengine/godot/worktrees/a13da4feb8d8" \
  a13da4feb8d8
```

Agents in different project worktrees may read the same upstream revision
worktree. Never create writable development worktrees from this shared bare
repository. Maintaining a fork, making changes, generating files, or building
upstream source must use the normal independent project/workspace cloning
mechanism outside `~/.cache/agent-sources`; it must not share this bare
repository or its worktree registry. Serialize concurrent fetch, worktree-add,
and prune operations against the shared bare repository, and use
`git worktree prune` to remove stale registrations.
