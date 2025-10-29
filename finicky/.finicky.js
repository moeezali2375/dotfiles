// ~/.finicky.js
export default {
  // Possible options: ["Google Chrome", "Safari", "Firefox", ...]
  defaultBrowser: "Safari",
  options: {
    // Hide the finicky icon from the top bar
    hideIcon: false,
  },
  rewrite: [
    {
      match: finicky.matchHostnames(["link-inbox.clickup.com"]),
      url: ({ url }) => {
        const segments = (url.pathname || "").split("/").filter(Boolean);
        const clIndex = segments.findIndex((s) => /^CL\d+$/.test(s));
        const encoded = clIndex >= 0 ? segments[clIndex + 1] : null;
        if (encoded) {
          let enc = encoded;
          if (enc.startsWith("https:")) {
            enc = enc.replace(/^https:/, "https%3A");
          } else if (enc.startsWith("http:")) {
            enc = enc.replace(/^http:/, "http%3A");
          }
          try {
            const decoded = decodeURIComponent(enc);
            return decoded;
          } catch (e) {
            return url;
          }
        }
        return url;
      },
    },
    {
      match: finicky.matchHostnames(["app.clickup.com"]),
      url: (url) => ({
        ...url,
        host: "",
        protocol: "clickup",
        pathname: url.pathname.slice(1),
      }),
    },
  ],

  handlers: [
    // 💻 Open any GitHub link under github.com/bayutuae in Chrome
    {
      match: (url) =>
        url.hostname === "github.com" &&
        url.href.startsWith("https://github.com/bayutuae"),
      browser: "Google Chrome",
    },

    // 🧩 Open ClickUp deep links in the ClickUp app
    {
      match: (url) => url.protocol === "clickup:",
      browser: "ClickUp",
    },
  ],
};
