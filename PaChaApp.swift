import SwiftUI

@main
struct PaChaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GlobalState.shared)
        }
    }
}
