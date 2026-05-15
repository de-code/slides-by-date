---
marp: true
theme: default
html: true
paginate: true
style: |
  section {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    font-size: 2.1rem;
    padding: 60px 72px;
    color: #1a1a1a;
    background: #ffffff;
  }

  h1 {
    font-size: 3.2rem;
    font-weight: 700;
    color: #111;
    margin-bottom: 0.5em;
    border-bottom: 3px solid #0d9488;
    padding-bottom: 0.2em;
  }

  strong {
    color: #0d9488;
  }

  section.title {
    background: #18181b;
    color: #ffffff;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  section.title h1 {
    font-size: 3.6rem;
    color: #ffffff;
    border-bottom: 3px solid #0d9488;
    padding-bottom: 0.3em;
  }

  section.title p {
    color: #a1a1aa;
    font-size: 1.55rem;
    margin-top: 0.6em;
  }

  section.dark {
    background: #18181b;
    color: #ffffff;
  }

  section.dark h1 {
    color: #ffffff;
    border-bottom-color: #0d9488;
  }

  section.dark p {
    color: #d4d4d8;
  }

  pre {
    background: #1e1e2e;
    color: #cdd6f4;
    padding: 1em 1.3em;
    border-radius: 8px;
    font-size: 1.55rem;
    line-height: 1.5;
  }

  code {
    background: #f0fdf4;
    color: #0d9488;
    padding: 0.15em 0.45em;
    border-radius: 4px;
    font-size: 1.35rem;
  }

  pre code {
    background: transparent;
    color: inherit;
    padding: 0;
  }

  blockquote {
    border-left: 4px solid #0d9488;
    background: #f0fdf4;
    padding: 0.6em 1em;
    margin: 0.4em 0;
    color: #134e4a;
    font-style: normal;
    font-size: 1.7rem;
  }

  .note {
    font-size: 1.2rem;
    color: #71717a;
    margin-top: 1em;
  }

  section[data-marpit-pagination]::after {
    color: #a1a1aa;
    font-size: 0.9rem;
  }
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

