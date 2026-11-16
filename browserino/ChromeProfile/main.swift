import Cocoa

// Opens URLs in a specific Google Chrome profile. The profile directory
// (e.g. "Default", "Profile 1") is read from the `ChromeProfileDirectory`
// key of the app bundle's Info.plist, so one source builds every launcher.

let chromeBinary = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

let profileDirectory = Bundle.main.object(forInfoDictionaryKey: "ChromeProfileDirectory") as? String ?? "Default"

/// Hands all URLs to Chrome in a single spawn. When Chrome is already running,
/// the spawned binary relays the URLs to it and exits; otherwise it becomes the
/// browser. Either way we don't wait for it. With no URLs, Chrome opens a new
/// window in the profile.
func openInChrome(_ urls: [String]) {
    let args = [chromeBinary, "--profile-directory=\(profileDirectory)"] + urls
    let argv: [UnsafeMutablePointer<CChar>?] = args.map { strdup($0) } + [nil]
    defer { argv.forEach { free($0) } }

    var attr = posix_spawnattr_t(nil as OpaquePointer?)
    posix_spawnattr_init(&attr)
    defer { posix_spawnattr_destroy(&attr) }
    // Detach Chrome into its own session so it outlives this launcher.
    posix_spawnattr_setflags(&attr, Int16(POSIX_SPAWN_SETSID))

    var pid: pid_t = 0
    posix_spawn(&pid, chromeBinary, nil, &attr, argv, environ)
}

class AppDelegate: NSObject, NSApplicationDelegate {
    private var handledURLs = false

    func application(_ application: NSApplication, open urls: [URL]) {
        handledURLs = true
        openInChrome(urls.map(\.absoluteString))
        NSApp.terminate(nil)
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        let args = Array(CommandLine.arguments.dropFirst()).filter { URL(string: $0)?.scheme != nil }
        if !args.isEmpty {
            openInChrome(args)
            NSApp.terminate(nil)
            return
        }
        // AppKit delivers launch-time URLs before this callback; give it one
        // more run-loop turn, then treat it as a plain launch (Spotlight, Dock).
        DispatchQueue.main.async { [self] in
            guard !handledURLs else { return }
            openInChrome([])
            NSApp.terminate(nil)
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
