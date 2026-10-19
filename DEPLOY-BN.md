# ডিপ্লয় গাইড — Dalowar Hossen Sabuj

এই ফোল্ডারটা এখনই লাইভ করার জন্য রেডি। কোনো বিল্ড লাগবে না, কোনো npm নেই।
মোট সময়: **১০–১৫ মিনিট** (Google-এ ইনডেক্স হতে ২–৬ সপ্তাহ)।

## আগে নিজের কম্পিউটারে দেখো

`portfolio` ফোল্ডারে PowerShell খুলে:

```powershell
powershell -ExecutionPolicy Bypass -File tools/serve.ps1
```

তারপর ব্রাউজারে <http://localhost:8080/> খোলো। (সরাসরি `index.html`-এ
ডাবল-ক্লিক করেও কাজ করবে।) থামাতে `Ctrl+C`।

> সাইটে এখন "Open to SEO roles & freelance projects" লেখা আছে। এখনই চাকরি
> না খুঁজলে `index.html`-এ কথাটা বদলে দিও — বাকিটা ঠিক আছে।

---

## ধাপ ১ — GitHub রিপো বানাও

1. ব্রাউজারে <https://github.com/new> খোলো (লগইন থাকতে হবে `dalowarhossen` অ্যাকাউন্টে)।
2. **Repository name:** `dalowarhossen.github.io`
   > নামটা হুবহু এটাই হতে হবে। এটাই তোমার ফ্রি ঠিকানা হবে: `https://dalowarhossen.github.io/`
3. **Visibility:** `Public` (GitHub Pages ফ্রি প্ল্যানে পাবলিক রিপো লাগে)।
4. `Create repository` ক্লিক করো।

## ধাপ ২ — ফাইল আপলোড

1. নতুন রিপোতে **Add file → Upload files** ক্লিক করো।
2. এই `portfolio` ফোল্ডারের **ভেতরের সব ফাইল ও ফোল্ডার** সিলেক্ট করে ড্র্যাগ করো:
   `index.html`, `404.html`, `robots.txt`, `sitemap.xml`, `llms.txt`,
   `site.webmanifest`, `README.md`, `DEPLOY-BN.md`, `assets/`, `extras/`, `tools/`
   > পুরো `portfolio` ফোল্ডারটা নয় — তার **ভেতরের** জিনিসগুলো।
3. নিচে `Commit changes` ক্লিক করো।

## ধাপ ৩ — Pages চালু করো

1. রিপোর **Settings** → বাম দিকে **Pages**।
2. **Source:** `Deploy from a branch`
3. **Branch:** `main` / `(root)` → **Save**
4. ১–৩ মিনিট অপেক্ষা করো, তারপর খোলো:
   <https://dalowarhossen.github.io/>

### চেকলিস্ট

- [ ] হোমপেজ লোড হচ্ছে
- [ ] <https://dalowarhossen.github.io/sitemap.xml> খুলছে
- [ ] <https://dalowarhossen.github.io/robots.txt> খুলছে
- [ ] <https://dalowarhossen.github.io/llms.txt> খুলছে
- [ ] মোবাইলে মেনু ও ডার্ক মোড কাজ করছে
- [ ] `view-source:` করে JSON-LD দেখা যাচ্ছে

## ধাপ ৪ — Google Search Console

1. <https://search.google.com/search-console> এ যাও → **Add property** →
   **URL prefix** → `https://dalowarhossen.github.io/`
2. **Verify:** `HTML tag` বেছে নাও। যে `<meta name="google-site-verification" ...>`
   ট্যাগ দিবে, সেটা `index.html`-এর `<head>`-এ
   `<!-- Google Search Console verification -->` কমেন্টের নিচে পেস্ট করো, আপলোড করো,
   তারপর **Verify** ক্লিক করো।
3. বাম মেনু → **Sitemaps** → `sitemap.xml` লিখে **Submit**।
4. **URL Inspection** → `https://dalowarhossen.github.io/` → **Request indexing**।

## ধাপ ৫ — Bing (AI সার্চের জন্য গুরুত্বপূর্ণ)

1. <https://www.bing.com/webmasters> → **Add site**।
2. `Import from Google Search Console` দিয়ে এক ক্লিকে বসিয়ে দাও।
3. Sitemap সাবমিট করো।

> ChatGPT Search ও কিছু AI assistant Bing/অন্য ইনডেক্স ব্যবহার করে, তাই Bing-টা বাদ দিও না।

## ধাপ ৬ — LinkedIn আর GitHub-কে সাইটের সাথে যুক্ত করো

এটা "নাম সার্চে LinkedIn + GitHub আসা"-র সবচেয়ে গুরুত্বপূর্ণ ধাপ। তিন জায়গায়
**একই নাম, একই রোল, একই লিংক** থাকতে হবে।

### LinkedIn

- **Edit profile → Contact info → Website:** `https://dalowarhossen.github.io/` (Label: Portfolio)
- **Headline:** `SEO Executive at Whizz People | Keyword Research, Link Building & SEO Reporting`
- **About:** `extras/linkedin-about.txt` ফাইলের টেক্সট কপি-পেস্ট করো
- **Featured:** `Add a link` → তোমার পোর্টফোলিও লিংক
- সাইটে ঢোকার পর LinkedIn-এ একটা পোস্ট দাও (লিংকসহ)। এটা প্রথম ইনডেক্সিং দ্রুত করে।

### GitHub

1. **Settings → Public profile → Website:** `https://dalowarhossen.github.io/`
2. Bio-তে সাইটের লিংক রাখো।
3. প্রোফাইল README যোগ করো: নতুন রিপো `dalowarhossen` (নাম ঠিক তোমার ইউজারনেম)
   বানিয়ে `extras/github-profile-README.md`-এর কনটেন্ট `README.md` হিসেবে দাও।
   এতে প্রোফাইলে সাইট, LinkedIn আর কী কাজ করো — সব এক জায়গায় দেখাবে।

## ধাপ ৭ — নিজের ডোমেইন (পরে, ঐচ্ছিক)

ফ্রি সাবডোমেইন দিয়েই শুরু করো। পরে `.com` নিলে ( বছরে ~$১০–১২):

1. ডোমেইনের DNS-এ:
   - `A` রেকর্ড `@` → `185.199.108.153`
   - `A` রেকর্ড `@` → `185.199.109.153`
   - `A` রেকর্ড `@` → `185.199.110.153`
   - `A` রেকর্ড `@` → `185.199.111.153`
   - `CNAME` রেকর্ড `www` → `dalowarhossen.github.io`
2. রিপোতে `CNAME` নামে ফাইল বানিয়ে ভেতরে শুধু তোমার ডোমেইন লেখো (যেমন `dalowarhossen.com`)।
3. GitHub → Settings → Pages → **Custom domain** বসাও → **Enforce HTTPS** টিক দাও।
4. এই ফাইলগুলোতে পুরনো URL খুঁজে নতুন ডোমেইন বসাও:
   `index.html`, `404.html`, `robots.txt`, `sitemap.xml`, `llms.txt`, `README.md`, `DEPLOY-BN.md`
   (খোঁজো: `dalowarhossen.github.io`)
5. Search Console-এ নতুন প্রোপার্টি যোগ করে sitemap আবার সাবমিট করো।

---

## নাম সার্চে LinkedIn + GitHub আসবে কীভাবে?

সৎ উত্তর: **কেউ গ্যারান্টি দিতে পারে না** — Google-এর র‍্যাংকিং বা AI Overview
কোনো টুল দিয়ে জোর করে আনা যায় না। তবে যেগুলো দরকার, তার সবটাই এই সাইটে বসানো আছে:

| সিগন্যাল | স্ট্যাটাস |
| --- | --- |
| `Person` schema + `sameAs` (LinkedIn, GitHub) | ✅ |
| `<link rel="me">` দিয়ে প্রোফাইল ভেরিফিকেশন | ✅ |
| একই নাম/রোল/লোকেশন সব জায়গায় | ✅ (তুমি LinkedIn/GitHub-এও মিলিয়ে নাও) |
| ক্রলেবল, ফাস্ট, সার্ভার-রেন্ডারড কনটেন্ট | ✅ |
| `sitemap.xml` + `robots.txt` | ✅ |
| `llms.txt` (AI answer engine-এর জন্য) | ✅ |
| FAQ + স্পষ্ট "কে, কী করে, কোথায়" | ✅ |
| ইনডেক্সিং + ব্যাকলিংক | ⏳ ধাপ ৪–৬ করার পর |

**টাইমলাইন:** ইনডেক্স ২–৭ দিন, ব্র্যান্ড-নেম সার্চে প্রথম পেজে আসতে ২–৬ সপ্তাহ,
AI Overview-এ সাইট cite হতে সাধারণত আরও কিছু সময় + একটু অথরিটি লাগে।

**নিজে চেক করার উপায় (২ সপ্তাহ পর):**

```text
site:dalowarhossen.github.io
"Dalowar Hossen Sabuj"
Dalowar Hossen Sabuj SEO Executive
```

প্রথমটা দিয়ে বোঝবে ইনডেক্স হয়েছে কি না, বাকিগুলো দিয়ে র‍্যাংকিং।

**ধৈর্য ধরার আগে যেটা করবে:** LinkedIn প্রোফাইলে সাইটের লিংক, GitHub-এ ওয়েবসাইট,
আর ২–৩টা জায়গায় (LinkedIn পোস্ট, GitHub README, কোনো কমিউনিটি প্রোফাইল) সাইটের লিংক।
একই নামে যত বেশি জায়গায় সাইটের লিংক থাকবে, Google-এর কাছে entity-টা তত পরিষ্কার হবে।

---

## ভবিষ্যতে কনটেন্ট বদলাতে

সব কনটেন্ট `index.html`-এ, আর সেকশনগুলো কমেন্ট দিয়ে আলাদা করা
(`HERO`, `01 — ABOUT`, `02 — EXPERTISE` ...)। বদলানোর পর:

- JSON-LD ব্লকেও (ফাইলের একদম উপরে) একই তথ্য আপডেট করো
- `llms.txt`-এও নাম/রোল/লিংক মিলিয়ে নাও

ছবি বদলাতে চাইলে: `powershell -ExecutionPolicy Bypass -File tools/make-images.ps1`
(নাম বা রোল বদলালে স্ক্রিপ্টের ভেতরের টেক্সটও বদলাও)।

---

## ট্রাবলশুটিং

| সমস্যা | সমাধান |
| --- | --- |
| 404 দেখাচ্ছে | Settings → Pages-এ branch `main` / root সিলেক্ট করা আছে কি না দেখো; ২ মিনিট অপেক্ষা করো |
| CSS লোড হচ্ছে না | ফোল্ডার স্ট্রাকচার ঠিক আছে কি না দেখো: `assets/css/style.css` |
| ছবি ভাঙছে | `assets/img/` ফোল্ডার আপলোড হয়েছে কি না দেখো |
| Search Console verify হচ্ছে না | মেটা ট্যাগ `<head>`-এর ভেতরে আছে কি না, লাইভ সাইটে `view-source` করে দেখো |
| সাইট আপডেট হচ্ছে না | ১–২ মিনিট + `Ctrl+F5`; GitHub Actions-এ শেষ ডিপ্লয় সফল কি না দেখো |
