import Foundation

open class BaseViewModel {
    public weak var coordinator: Coordinator?
    
    public init() {
    }
        
    deinit {
        print("\(String(describing: self)) was de-initialized")
    }
}
