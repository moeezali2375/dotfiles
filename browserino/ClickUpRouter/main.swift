import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    func application(_ application: NSApplication, open urls: [URL]) {
        for url in urls {
            handle(url: url)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            NSApp.terminate(nil)
        }
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        for arg in CommandLine.arguments.dropFirst() {
            if let url = URL(string: arg) {
                handle(url: url)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NSApp.terminate(nil)
        }
    }

    func handle(url: URL) {
        var targetUrlString = url.absoluteString

        // Decode link-inbox.clickup.com redirects
        if let host = url.host, host.contains("link-inbox.clickup.com") {
            let segments = url.pathComponents.filter { !$0.isEmpty && $0 != "/" }
            if let clIndex = segments.firstIndex(where: { $0.range(of: #"^CL\d+$"#, options: .regularExpression) != nil }),
               clIndex + 1 < segments.count {
                var encoded = segments[clIndex + 1]
                if encoded.hasPrefix("https:") {
                    encoded = "https%3A" + encoded.dropFirst(6)
                } else if encoded.hasPrefix("http:") {
                    encoded = "http%3A" + encoded.dropFirst(5)
                }
                if let decoded = encoded.removingPercentEncoding {
                    targetUrlString = decoded
                }
            }
        }

        // Convert https://app.clickup.com/... to clickup://...
        if let parsed = URL(string: targetUrlString) {
            let host = parsed.host?.lowercased() ?? ""
            if host == "app.clickup.com" || host.hasSuffix(".clickup.com") || host == "clickup.com" {
                var path = parsed.path
                if path.hasPrefix("/") {
                    path = String(path.dropFirst())
                }
                var newUrlStr = "clickup://" + path
                if let query = parsed.query {
                    newUrlStr += "?" + query
                }
                if let fragment = parsed.fragment {
                    newUrlStr += "#" + fragment
                }
                if let clickupUrl = URL(string: newUrlStr) {
                    NSWorkspace.shared.open(clickupUrl)
                    return
                }
            }
        }

        if let finalUrl = URL(string: targetUrlString) {
            NSWorkspace.shared.open(finalUrl)
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
