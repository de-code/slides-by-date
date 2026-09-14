---
marp: true
theme: slides
html: true
paginate: true
---

<!-- _class: title -->

# My Claude Code setup:<br>plan in one place, execute in many

Daniel Ecer &nbsp;·&nbsp; 15 September 2026

<!--
Lightning talk: 7 minutes + 3 minutes Q&A.
The through-line: isolate it so I can stop approving commands, then run several in parallel.
The parallel workflow is the main point; the VM and auto-approve are the short setup.
-->

---

# Most commands are harmless

<div class="term">
  <div class="term-bar">
    <span class="term-dot r"></span><span class="term-dot y"></span><span class="term-dot g"></span>
    <span class="term-title">myapp</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="term-body">
    <span class="ln"><span class="cc-dot">●</span> <span class="tok-b">Bash</span>(uv run pytest -q)</span>
    <span class="ln">  <span class="tok-d">run the auth tests</span></span>
    <div class="ln-gap"></div>
    <span class="ln">  Do you want to proceed?</span>
    <span class="ln">  <span class="tok-g">❯ 1. Yes</span></span>
    <span class="ln">    2. Yes, and do not ask again</span>
    <span class="ln">    3. No</span>
  </div>
</div>

<p class="note">Harmless, and it comes up dozens of times an hour. Before long you approve on reflex.</p>

<!--
The volume is the problem. Most commands are safe and repetitive, so approving them
becomes a reflex rather than a decision. Run over this slide quickly.
-->

---

# Some are not, and it is hard to tell

<div class="term">
  <div class="term-bar">
    <span class="term-dot r"></span><span class="term-dot y"></span><span class="term-dot g"></span>
    <span class="term-title">myapp</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="term-body">
    <span class="ln"><span class="cc-dot">●</span> <span class="tok-b">Bash</span>(curl -fsSL https://install.acme.dev/setup.sh | sh</span>
    <span class="ln">       find . -name '__pycache__' -type d -exec rm -rf {} +</span>
    <span class="ln">       rm -rf "$CACHE_DIR"/* build dist .venv</span>
    <span class="ln">       sudo chown -R "$(whoami)" /usr/local/lib/node_modules</span>
    <span class="ln">       docker system prune -af --volumes</span>
    <span class="ln">       aws s3 sync ./dist s3://acme-prod-assets --delete</span>
    <span class="ln">       git add -A && git commit -m "chore: refactor" && git push --force)</span>
    <span class="ln">  <span class="tok-d">set up, clean, and deploy</span></span>
    <div class="ln-gap"></div>
    <span class="ln">  Do you want to proceed?</span>
    <span class="ln">  <span class="tok-g">❯ 1. Yes</span></span>
    <span class="ln">    2. Yes, and do not ask again</span>
    <span class="ln">    3. No</span>
  </div>
</div>

<p class="note">Same prompt, same reflex. But if <code>CACHE_DIR</code> is unset, that <code>rm -rf</code> targets the filesystem root, and the <code>s3 sync --delete</code> runs against a production bucket.</p>

<!--
By now approval is a formality. This reads as routine setup, but almost every line can bite:
curl piped into sh runs remote code, rm -rf "$CACHE_DIR"/* deletes from the root when the
variable is unset, sudo chown touches system paths, docker prune --volumes drops local data,
s3 sync --delete removes remote files, and git push --force rewrites the branch.
This is why I stopped approving by hand and isolate instead.
-->

---

# Several agents, zero approvals

Each Claude Code session can run **any** command without asking me.

- the CLI runs in a **local Lima VM**, not on my host, and inside it I **auto-approve everything**
- worst case is a rebuilt VM and the project folders I share with it, not a wiped laptop
- **isolated worktrees** let several sessions run without interfering

<p class="note">The rest of this talk is about the workflow this makes possible.</p>

<!--
Pre-empt the auto-approve reaction here in one line: it is a disposable VM, the host is never exposed
beyond the folders I share with it. Anything committed and pushed survives a rebuild, uncommitted
work in a shared folder does not.
Keep this slide fast, under a minute. It is the setup, not the main point.
-->

---

# The planning session

- one long-lived, **named** session, used only for brainstorming and writing specs
- no code is written here; this is where the thinking happens
- the output is a short **requirements spec**, saved outside the code

<div class="term">
  <div class="term-bar">
    <span class="term-dot r"></span><span class="term-dot y"></span><span class="term-dot g"></span>
    <span class="term-title">planning</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="term-body">
    <span class="ln"><span class="tok-d">&gt;</span> draft a spec for refresh-token auth, high level for now</span>
    <div class="ln-gap"></div>
    <span class="ln"><span class="cc-dot">●</span> <span class="tok-b">Write</span>(.project-notes/specs/spec-auth.md)</span>
    <span class="ln">  <span class="tok-d">⎿</span> <span class="tok-m">## Goals</span>  rotate and revoke refresh tokens</span>
    <span class="ln">     <span class="tok-m">## Tasks</span>  1 token store  2 revoke endpoint  3 tests</span>
    <div class="ln-gap"></div>
    <span class="ln"><span class="tok-d">&gt;</span> good, each task becomes its own session</span>
    <div class="cc-input">&gt; _</div>
  </div>
  <div class="term-status">
    <span class="seg-name">planning</span>
    <span class="seg">⎇ main</span>
    <span class="seg-sep">·</span>
    <span class="seg">slides</span>
    <span class="seg-sep">·</span>
    <span class="seg">unicorn</span>
    <span class="seg-sep">·</span>
    <span class="seg">context 12%</span>
  </div>
</div>

<!--
This is the "one place" half of the title. The planning session is the single source
of intent that everything else follows from.
-->

---

# One session per spec, in parallel

<div class="flow-labeled">
  <div class="flow-col">
    <div class="flow-box">planning<br>session</div>
    <div class="flow-label">brainstorm<br>+ write specs</div>
  </div>
  <div class="flow-col-arrow">
    <div class="flow-arrow">→</div>
    <div class="flow-spacer"></div>
  </div>
  <div class="flow-col">
    <div class="flow-box flow-cmd">spec-auth</div>
    <div class="flow-label">own worktree<br>own session</div>
  </div>
  <div class="flow-col">
    <div class="flow-box flow-cmd">spec-export</div>
    <div class="flow-label">own worktree<br>own session</div>
  </div>
  <div class="flow-col">
    <div class="flow-box flow-cmd">spec-search</div>
    <div class="flow-label">own worktree<br>own session</div>
  </div>
</div>

- each spec gets its **own session, named after the spec**
- each runs in its **own git worktree**, so there is no shared checkout and no collisions
- **Zellij** manages them, so they run **in parallel** while I move between them

<p class="note">Main point of the talk. Walk through the Zellij mock on the next slide.</p>

---

# What this looks like

<div class="zellij">
  <div class="zj-tabs">
    <span class="zj-tab">planning</span>
    <span class="zj-tab active">spec-auth</span>
    <span class="zj-tab"><span class="run">●</span> spec-export</span>
    <span class="zj-tab"><span class="run">●</span> spec-search</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="zj-pane">
    <div class="zj-pane-title">spec-auth</div>
    <span class="ln"><span class="tok-d">&gt;</span> <span class="tok-m">/rename</span> spec-auth</span>
    <span class="ln">  <span class="tok-d">⎿</span> renamed session to spec-auth</span>
    <div class="ln-gap"></div>
    <span class="ln"><span class="tok-d">&gt;</span> brainstorm the details in .project-notes/specs/spec-auth.md</span>
    <div class="ln-gap"></div>
    <span class="ln"><span class="cc-dot">●</span> <span class="tok-b">Read</span>(.project-notes/specs/spec-auth.md)</span>
    <span class="ln">  <span class="tok-d">⎿</span> 3 goals, 3 tasks</span>
    <span class="ln"><span class="cc-dot">●</span> <span class="tok-b">Glob</span>(src/auth/**)</span>
    <span class="ln">  <span class="tok-d">⎿</span> tokens.py, session.py, middleware.py</span>
    <span class="ln"><span class="cc-dot">●</span> <span class="tok-b">Grep</span>(refresh_token)</span>
    <span class="ln">  <span class="tok-d">⎿</span> 4 matches in src/auth/tokens.py</span>
    <span class="ln"><span class="cc-dot">●</span> <span class="tok-b">Read</span>(src/auth/tokens.py)</span>
    <span class="ln">  <span class="tok-d">⎿</span> read 180 lines</span>
    <div class="ln-gap"></div>
    <span class="ln">Should refresh tokens rotate on every use, or only near expiry?</span>
  </div>
  <div class="zj-status">
    <span class="seg-name">spec-auth</span>
    <span class="seg">⎇ feature/auth-tokens</span>
    <span class="seg-sep">·</span>
    <span class="seg">slides/worktrees/auth</span>
    <span class="seg-sep">·</span>
    <span class="seg">unicorn</span>
    <span class="seg-sep">·</span>
    <span class="seg">context 38%</span>
  </div>
</div>

<!--
The idea of parallel agents is easy to say and hard to picture, so this mock does the work.
Point at the tabs (four named sessions, two marked busy) and the statusline (branch and
worktree), not the individual tool lines. Those carry the message from the back of the room.

Each tab is a session I review the same way as this one: I tab in, answer questions,
give feedback, and merge each branch as it finishes. The parallelism is in the waiting,
not in the reviewing.
-->

---

# Shared notes keep parallel sessions coherent

- currently a separate **project-notes repo**, shared across every session
- specs, decisions, and context live there, not in one session's history
- a customised **statusline** shows session, branch, and worktree

<!--
The mechanism is a shared place every session can read. I currently use a project-notes repo,
but the spec could equally live in the code repo, a GitHub issue, or a pull request.
-->

---

<!-- _class: dark -->

# Takeaway

- **Isolate** the whole thing in a disposable VM, then you can stop approving commands
- **Plan in one place**: a single session for brainstorming and specs
- **Execute in many**: one named session per spec, each in its own worktree, in parallel
- **Share notes** in a place every session can read so parallel work stays coherent

<blockquote>
This is what works for me now. Take what fits.
</blockquote>
