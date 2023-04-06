import Foundation
import Combine

open class BaseViewModel: ObservableObject {
    public weak var coordinator: Coordinator?

    public var showBackOptions: Bool = true

    @Published public var pageTitle: String?
    
    @Published public var isLoading: Bool = false
    
    @Published public var loadingMessage: String = ""

    public var previousPageTitle: String?

    public var cancellables = Set<AnyCancellable>()
    
    public init() {
    }
        
    deinit {
        print("\(String(describing: self)) was de-initialized")
    }
    
    public func updateLoadingState(loading: Bool, message: String? = nil) {
        DispatchQueue.main.async {
            self.isLoading = loading
            self.loadingMessage = message ?? ""
        }
    }

    public func unload() {
        for cancellable in cancellables {
            cancellable.cancel()
        }

        self.cancellables.removeAll()
    }
}
