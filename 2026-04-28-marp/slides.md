---
marp: true
theme: slides
html: true
paginate: true
---

<!-- _class: title -->

# Marp:<br>presentations as code

Daniel Ecer &nbsp;·&nbsp; 28 Apr 2026

---

# What is Marp?

**Markdown Presentation Ecosystem**: open source, one file, no signup.

```markdown
---
marp: true
---

# My First Slide
Hello world

---

# Second Slide
- Bullet one
- Bullet two
```

That file is a complete deck of two slides.

<!-- The `marp: true` line in the frontmatter is the only thing that makes it a presentation rather than a document. The `---` lines are slide separators. -->

---

# It fits the way developers work.

- Your slides live in a **git repo**
- `git diff` shows exactly what changed
- Review slide changes in a PR
- One `.md` file, works anywhere, no account required

<!-- This is the main reason I switched. The ability to track changes in git and see exactly what was reworded between versions is something no conventional slide tool offers. -->

---

# What Marp includes.

- Export to **PDF**, **PPTX**, or HTML with one command
- Built-in themes, or write your own CSS if you want it
- Speaker notes in Markdown comments

<p class="note">I imported the PDF into Miro without issues. PPTX export also exists.</p>

---

# Getting started.

Two options:

- **VS Code**: install the Marp extension, live preview as you type
- **CLI**: `npx @marp-team/marp-cli slides.md --output slides.pdf`

Details at **marp.app**

<p class="note">No account, no subscription, no cloud required.</p>

---

# Claude Code + Marp.

Describe the structure of your talk. Claude Code drafts the Markdown. You iterate: adjust the wording, reorder slides, add examples.

> One note: Claude Code tends to write a lot of CSS. Marp itself is much simpler than the result might suggest.

---

<!-- _class: dark -->

# This deck was made with Marp.

Claude Code drafted the slides. I edited them.

The source is a single Markdown file.

