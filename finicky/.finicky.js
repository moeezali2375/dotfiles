// ~/.finicky.js
export default {
  defaultBrowser: "Safari",

  options: {
    hideIcon: false,
  },

  rewrite: [
    {
      match: finicky.matchHostnames(["link-inbox.clickup.com"]),
      url: ({ url }) => {
        // url is now a URL object
        const segments = (url.pathname || "").split("/").filter(Boolean);
        const clIndex = segments.findIndex((s) => /^CL\d+$/.test(s));
        const encoded = clIndex >= 0 ? segments[clIndex + 1] : null;

        if (encoded) {
          let enc = encoded;

          // Fix: use .startsWith on string safely
          if (enc.startsWith("https:")) {
            enc = enc.replace(/^https:/, "https%3A");
          } else if (enc.startsWith("http:")) {
            enc = enc.replace(/^http:/, "http%3A");
          }

          try {
            const decoded = decodeURIComponent(enc);
            return decoded;
          } catch (e) {
            return url.href;
          }
        }

        return url.href;
      },
    },

    {
      match: finicky.matchHostnames(["app.clickup.com"]),
      url: ({ url }) => ({
        ...url,
        protocol: "clickup:",
        host: "",
        pathname: url.pathname.slice(1),
      }),
    },
  ],

  handlers: [
    // 💻 Open any GitHub link under github.com/bayutuae in Chrome
    {
      // --- ⬇️ UPDATED ---
      // The first argument is the URL object directly
      match: (url) =>
        url.hostname === "github.com" &&
        url.href.startsWith("https://github.com/bayutuae"),
      // --- ⬆️ UPDATED ---
      browser: "Google Chrome",
    },

    // 🧩 Open ClickUp deep links in the ClickUp app
    {
      // --- ⬇️ UPDATED ---
      // The first argument is the URL object directly
      match: (url) => url.protocol === "clickup:",
      // --- ⬆️ UPDATED ---
      browser: "ClickUp",
    },
  ],
};
