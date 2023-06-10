#if canImport(UIKit)
import UIKit
import Combine

open class BaseUIViewController: BaseView {

    open func setUpBindings() {
    }

    public var bindings = Set<AnyCancellable>()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        bindings.forEach { $0.cancel() }
        bindings.removeAll()
    }
}
#endif
