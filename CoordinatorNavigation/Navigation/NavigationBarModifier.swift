import Foundation
import SwiftUI

public struct NavigationModifier: ViewModifier {
    @ObservedObject public var viewModel: BaseViewModel
    public let defaultBackText: String
    public var action: (() -> Void)?

    public init(viewModel: BaseViewModel, defaultBackText: String, action: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.defaultBackText = defaultBackText
        self.action = action
    }

    public func body(content: Content) -> some View {

        let hasTitle = viewModel.pageTitle != nil
        let hasChildrenViews = viewModel.coordinator?.navigationController.viewControllers.count ?? 0 > 1

        if hasTitle && hasChildrenViews {
            return AnyView(
                content
                    .navigationBarTitle(viewModel.pageTitle ?? "", displayMode: .automatic)
                    .navigationBarItems(leading: Button(action: {
                        if let action = action {
                            action()
                            return
                        } else {
                            viewModel.coordinator?.navigateBack()
                            return
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text(viewModel.previousPageTitle ?? defaultBackText)
                        }
                    }))
            )
        }

        if hasTitle {
            return AnyView(content.navigationBarTitle(viewModel.pageTitle ?? "", displayMode: .automatic))
        }

        return AnyView(content)
    }
}
