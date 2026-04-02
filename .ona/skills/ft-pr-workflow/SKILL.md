---
name: ft-pr-workflow
description: Enforces Filip's PR workflow conventions. Covers force-push policy, comment resolution, draft vs ready PRs, stacked PR ordering, and changelog discipline. Use when creating PRs, addressing review comments, or planning stacked changes. Triggers on PR creation, PR review, comment resolution, or push decisions.
---

# PR Workflow

Apply these conventions when working with pull requests.

## Force-Push Policy

Do not force-push unless explicitly instructed. Amends and history rewrites are fine for local-only changes that haven't been pushed.

## Push Policy

When iterating on non-trivial changes (e.g. frontend layout changes), do not automatically push to the PR. Wait to be asked.

Exception: when only resolving merge conflicts on an ongoing PR, pushing to get it into a mergeable state is fine.

## Draft vs Ready

- Trivial changes: raise as "ready for review" by default.
- Non-trivial changes: raise as draft.

## Addressing PR Comments

When addressing a PR comment, never resolve it unless one of the following is true:
1. The comment is not applicable — include reasoning when resolving.
2. The comment is not actionable (praise, technical observations, questions — generally don't mark questions as resolved).
3. You first reply in the thread with something like "Fixed in {commit_hash}".

When replying to conversations on the author's behalf (through GitHub), prefix the message with `🤖` to make attribution clear.

## Stacked PRs

Prefer top-down PR ordering over bottom-up when building stacked changes.

- Top-down: wire the full call path early (even with stubs/no-op handlers), fill in implementation in follow-up PRs.
- Bottom-up defers integration to the end, increasing risk.

Smells that suggest bottom-up is creeping in:
- Functions or types introduced in a PR but unused in any real code path.
- A PR that changes no observable behavior in production code.

When planning a stack, ask: "Can I wire this end-to-end first with stubs, and iterate on the details after?"

## Changelog

Most changes do not need changelog entries. Be very selective about what to add.
