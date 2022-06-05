import Cocoa
import FlutterMacOS
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
