/* ==========================================================================
   Portfolio interactions — vanilla JS, no dependencies.
   Everything degrades gracefully if JS is disabled.
   ========================================================================== */
(function () {
  "use strict";

  const root = document.documentElement;
  const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  /* ---------- Theme ---------- */
  const themeToggle = document.querySelector("[data-theme-toggle]");
  const themeMeta = document.querySelector('meta[name="theme-color"]');

  function syncThemeUI(theme) {
    if (themeMeta) {
      themeMeta.setAttribute("content", theme === "dark" ? "#100f0d" : "#f6f3ec");
    }
    if (themeToggle) {
      themeToggle.setAttribute(
        "aria-label",
        theme === "dark" ? "Switch to light theme" : "Switch to dark theme"
      );
      themeToggle.setAttribute("aria-pressed", String(theme === "dark"));
    }
  }

  function applyTheme(theme) {
    root.dataset.theme = theme;
    try {
      localStorage.setItem("theme", theme);
    } catch (_) {}
    syncThemeUI(theme);
  }

  syncThemeUI(root.dataset.theme || "light");

  if (themeToggle) {
    themeToggle.addEventListener("click", function () {
      applyTheme(root.dataset.theme === "dark" ? "light" : "dark");
    });
  }

  /* ---------- Mobile nav ---------- */
  const menuToggle = document.querySelector("[data-menu-toggle]");
  const nav = document.getElementById("primary-nav");

  function closeNav() {
    if (!nav || !menuToggle) return;
    nav.classList.remove("is-open");
    menuToggle.setAttribute("aria-expanded", "false");
  }

  if (menuToggle && nav) {
    menuToggle.addEventListener("click", function () {
      const open = nav.classList.toggle("is-open");
      menuToggle.setAttribute("aria-expanded", String(open));
    });

    nav.addEventListener("click", function (e) {
      if (e.target.closest("a")) closeNav();
    });

    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape") closeNav();
    });

    document.addEventListener("click", function (e) {
      if (
        nav.classList.contains("is-open") &&
        !nav.contains(e.target) &&
        !menuToggle.contains(e.target)
      ) {
        closeNav();
      }
    });

    window.addEventListener("resize", function () {
      if (window.innerWidth > 720) closeNav();
    });
  }

  /* ---------- Sticky header ---------- */
  const header = document.querySelector("[data-header]");
  let ticking = false;

  function onScroll() {
    const y = window.scrollY;
    if (header) header.classList.toggle("is-stuck", y > 8);

    const bar = document.querySelector("[data-progress]");
    if (bar) {
      const max = document.documentElement.scrollHeight - window.innerHeight;
      const pct = max > 0 ? Math.min(100, (y / max) * 100) : 0;
      bar.style.transform = "scaleX(" + pct / 100 + ")";
    }
    ticking = false;
  }

  window.addEventListener(
    "scroll",
    function () {
      if (!ticking) {
        window.requestAnimationFrame(onScroll);
        ticking = true;
      }
    },
    { passive: true }
  );
  onScroll();

  /* ---------- Scroll reveal ---------- */
  const revealEls = document.querySelectorAll(".reveal");

  if (!("IntersectionObserver" in window) || reduceMotion) {
    revealEls.forEach(function (el) {
      el.classList.add("is-in");
    });
  } else {
    const revealObserver = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-in");
            revealObserver.unobserve(entry.target);
          }
        });
      },
      { rootMargin: "0px 0px -8% 0px", threshold: 0.08 }
    );
    revealEls.forEach(function (el) {
      revealObserver.observe(el);
    });
  }

  /* ---------- Active nav link ---------- */
  const sections = Array.from(document.querySelectorAll("main section[id]"));
  const navLinks = Array.from(document.querySelectorAll('#primary-nav a[href^="#"]'));

  if ("IntersectionObserver" in window && sections.length && navLinks.length) {
    const visible = new Set();

    const navObserver = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) visible.add(entry.target.id);
          else visible.delete(entry.target.id);
        });

        let current = null;
        sections.forEach(function (section) {
          if (visible.has(section.id)) current = section.id;
        });

        navLinks.forEach(function (link) {
          const isCurrent = link.getAttribute("href") === "#" + current;
          if (isCurrent) link.setAttribute("aria-current", "true");
          else link.removeAttribute("aria-current");
        });
      },
      { rootMargin: "-45% 0px -50% 0px" }
    );

    sections.forEach(function (section) {
      navObserver.observe(section);
    });
  }

  /* ---------- Copy email ---------- */
  function toast(message) {
    let el = document.querySelector(".toast");
    if (!el) {
      el = document.createElement("div");
      el.className = "toast";
      el.setAttribute("role", "status");
      el.setAttribute("aria-live", "polite");
      document.body.appendChild(el);
    }
    el.textContent = message;
    el.classList.add("is-visible");
    clearTimeout(el._t);
    el._t = setTimeout(function () {
      el.classList.remove("is-visible");
    }, 2200);
  }

  document.querySelectorAll("[data-copy]").forEach(function (btn) {
    btn.addEventListener("click", async function () {
      const value = btn.getAttribute("data-copy");
      if (!value) return;
      try {
        await navigator.clipboard.writeText(value);
        toast("Email copied — " + value);
      } catch (_) {
        window.location.href = "mailto:" + value;
      }
    });
  });

  /* ---------- Year ---------- */
  document.querySelectorAll("[data-year]").forEach(function (el) {
    el.textContent = String(new Date().getFullYear());
  });

  /* ---------- External links: new tab + privacy ---------- */
  document.querySelectorAll('a[href^="http"]').forEach(function (a) {
    if (a.hostname && a.hostname !== window.location.hostname) {
      a.setAttribute("target", "_blank");
      var rel = (a.getAttribute("rel") || "").split(/\s+/).filter(Boolean);
      ["noopener", "noreferrer"].forEach(function (v) {
        if (rel.indexOf(v) === -1) rel.push(v);
      });
      a.setAttribute("rel", rel.join(" "));
    }
  });
})();
