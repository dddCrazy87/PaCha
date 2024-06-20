
import Foundation
import Combine
import SwiftUI

class GlobalState: ObservableObject {
    static let shared = GlobalState()
    @Published var viewController = "AssistantView"
    private init() {}
}
