# dalowarhossen.github.io

Personal portfolio of **Dalowar Hossen Sabuj**, SEO Executive at Whizz People.

Live: <https://dalowarhossen.github.io/>

## What this is

A hand-written static site — no framework, no build step, no trackers, no
external requests at runtime. Fonts are self-hosted.

```
.
├── index.html              # the whole site
├── 404.html                # branded not-found page
├── site.webmanifest        # PWA metadata
├── robots.txt              # crawler + AI-bot rules
├── sitemap.xml             # one URL, kept simple
├── llms.txt                # concise facts for AI answer engines
├── assets/
│   ├── css/style.css       # design system + layout
│   ├── js/main.js          # theme, nav, reveal, copy-email
│   ├── fonts/              # Bricolage Grotesque + Manrope (woff2)
│   └── img/                # OG image, favicons, app icons
└── tools/make-images.ps1   # regenerates the OG image and icons
```

## Edit the content

Everything lives in `index.html` and is grouped with comments:

- **Hero** — name, role, one-line pitch
- **01 About** — bio and quick facts
- **02 Expertise** — six capability cards
- **03 Selected work** — four workstreams (no invented metrics)
- **04 Approach** — the four-step process
- **05 Experience** — timeline and toolbox
- **06 FAQ** — also emitted as `FAQPage` structured data
- **07 Contact** — email, LinkedIn, copy-email button

If you change facts in the visible page, update the JSON-LD block at the top of
`index.html` and `llms.txt` too, so search engines and AI assistants stay in sync.

## SEO / AI-search setup

- `Person`, `WebSite`, `ProfilePage` and `FAQPage` JSON-LD in one `@graph`
- `sameAs` links to LinkedIn and GitHub, plus `<link rel="me">`
- Open Graph + Twitter card with a generated 1200×630 image
- Canonical URL, sitemap, robots.txt
- `llms.txt` for LLM answer engines
- Semantic headings, visible quick facts, and no client-side rendering

## Regenerate images

```powershell
powershell -ExecutionPolicy Bypass -File tools/make-images.ps1
```

Requires Windows PowerShell + .NET `System.Drawing` (built in).

## Deploy

See **[DEPLOY-BN.md](DEPLOY-BN.md)** for the full Bengali walkthrough.
Short version: upload to GitHub, then Settings → Pages → Deploy from branch →
`main` / root.

## Preview locally

No Node or Python needed:

```powershell
powershell -ExecutionPolicy Bypass -File tools/serve.ps1
# open http://localhost:8080/
```

Or just double-click `index.html` — everything works from `file://` too.

## License

Content and images © Dalowar Hossen Sabuj. Code is free to learn from; please
don't republish the personal content as your own.
