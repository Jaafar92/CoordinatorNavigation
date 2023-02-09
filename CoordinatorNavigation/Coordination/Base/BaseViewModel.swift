import Foundation

open class BaseViewModel: ObservableObject {
    public weak var coordinator: Coordinator?

    public var showBackOptions: Bool = true

    public var pageTitle: String?

    public var previousPageTitle: String?
    
    public init() {
    }
        
    deinit {
        print("\(String(describing: self)) was de-initialized")
    }
}
