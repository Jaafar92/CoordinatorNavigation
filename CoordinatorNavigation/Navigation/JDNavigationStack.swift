import SwiftUI

public struct JDNavigationStack<Content: View>: View {
    public let content: Content
    public let viewModel: BaseViewModel
    public var action: (() -> Void)?

    public init(viewModel: BaseViewModel, content: Content, action: (() -> Void)? = nil) {
        self.content = content
        self.viewModel = viewModel
        self.action = action
    }

    public var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                content
                .modifier(NavigationModifier(
                    viewModel: viewModel,
                    defaultBackText: Bundle.main.localizedString(forKey: "back", value: "key does not exist", table: nil),
                    action: action))
            }
        }
    }
}
