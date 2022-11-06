import UIKit

open class BaseView : UIViewController {
    public let id = UUID()
    public weak var coordinator : Coordinator?
    
    deinit {
        print("\(String(describing: self)) was de-initialized")
    }
}
