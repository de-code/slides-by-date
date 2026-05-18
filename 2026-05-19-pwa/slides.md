---
marp: true
theme: slides
html: true
paginate: true
---

<!-- _class: title -->

# PWA:<br>web pages the browser can install

Daniel Ecer &nbsp;·&nbsp; 19 May 2026

---

# You have seen this before.

<!-- Insert screenshot: Chrome "Install Sciety Labs" prompt in the address bar -->

Chrome, Edge, and mobile browsers show an install prompt when a site provides a web manifest with a name and `start_url`.

The browser handles distribution. No app store account, no review process.

<!-- The prompt appears automatically. The user clicks once, and the site gets a home screen icon and its own window. -->

---

# Why home screen presence matters.

Rakuten 24 tracked users who installed their PWA against those who did not, over one month:

- **310%** more visit frequency
- **450%** higher retention rate
- **150%** more sales per customer

The mechanism: a home screen icon is a passive re-engagement nudge on every device unlock. Users no longer need to recall a URL.

<!-- Source: web.dev/case-studies/rakuten-24 — e-commerce context, so the absolute numbers won't transfer directly, but the direction is consistent across published case studies. -->

---

# One file triggers the install prompt.

**`site.webmanifest`**

```json
{
  "name": "Sciety Labs",
  "short_name": "Sciety Labs",
  "start_url": "/",
  "display": "standalone"
}
```

`display: standalone` removes the browser address bar. The app opens in its own window.

<!-- No service worker required for this step. -->

---

# What you get.

- Install prompt in Chrome, Edge, and mobile browsers
- Standalone window: no address bar, no browser tabs
- Theme colour in the OS title bar and Android task switcher
- App icon on the home screen or taskbar
- Works with an existing site, no changes to routing or templates

<!-- demo: show the installed Sciety Labs window, or show a screenshot side by side with the browser version -->

---

# Offline support: a separate step.

The strategy per resource type is a choice.

| Resource | Strategy | Behaviour |
|---|---|---|
| Static assets | Stale-while-revalidate | Serve from cache, update in background |
| Navigation | Network-first | Try network, fall back to `/offline` |

<!-- In Sciety Labs: sw.js handles static asset caching and a /offline fallback. The offline.html is eight lines. The two FastAPI routes are eight lines. -->

---

# What else the platform offers.

**Push notifications**: notify users when new content appears, without an app store or native build.

**Badging API**: show an unread count on the installed app icon, the way a native app would.

**Share target**: the installed app appears in the OS share sheet alongside native apps.

<!-- Each of these is a separate API with its own browser support profile. Push notifications have broad support; the Badging API and Share Target are primarily Chrome and Edge on desktop and Android. -->

---

# Going further.

**Custom install prompt**: the browser's passive mini-infobar has very low engagement. Handling the `beforeinstallprompt` event in JavaScript lets you show a prompt at the right moment.

**iOS**: Safari does not fire `beforeinstallprompt`. A separate instruction banner is needed: "tap Share, then Add to Home Screen."

**Richer manifest**: adding `description` and `screenshots` upgrades the Chrome Android dialog from a mini-infobar to a fuller install sheet.

<!-- Sources: web.dev/articles/promote-install, WebKit/standards-positions issue 619 (WebKit's own data: "browser-initiated UI has very low engagement"). -->

---

# Where this is worth adding.

**elifesciences.org**: readers who return regularly can install the site and read cached articles offline.

**sciety.org**: users tracking paper lists benefit from an install shortcut and an offline fallback.

The install prompt alone requires no backend changes.

---

<!-- _class: dark -->

# The manifest is the starting point.

- Add `site.webmanifest` with a name and `start_url`
- The install prompt appears automatically
- Add a service worker when you want offline support
