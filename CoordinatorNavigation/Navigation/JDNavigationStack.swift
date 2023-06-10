#if canImport(UIKit)
import SwiftUI

public struct JDNavigationStack<Content: View>: View {
    public let content: Content
    public let viewModel: BaseViewModel
    public let scrollable: Bool
    public var action: (() -> Void)?

    public init(viewModel: BaseViewModel, content: Content, action: (() -> Void)? = nil, scrollable: Bool = true) {
        self.content = content
        self.viewModel = viewModel
        self.scrollable = scrollable
        self.action = action
    }

    public var body: some View {
        NavigationStack {
            if scrollable {
                ScrollView(showsIndicators: false) {
                    content
                    .modifier(NavigationModifier(
                        viewModel: viewModel,
                        defaultBackText: Bundle.main.localizedString(forKey: "back", value: "key does not exist", table: nil),
                        action: action))
                }
            } else {
                content
                .modifier(NavigationModifier(
                    viewModel: viewModel,
                    defaultBackText: Bundle.main.localizedString(forKey: "back", value: "key does not exist", table: nil),
                    action: action))
            }
        }
        .onDisappear {
            self.viewModel.unload()
        }
    }
}
#endif
