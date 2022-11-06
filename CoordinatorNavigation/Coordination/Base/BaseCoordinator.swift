import UIKit

open class BaseCoordinator : NSObject, Coordinator, UINavigationControllerDelegate {
    private static var viewControllersDictionary : [UUID : BaseView] = [:]
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController

    public weak var parentCoordinator: Coordinator?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    open func start() {
        // Leave empty. Should be overridden by subclasses
    }
    
    public func registerStart(view: BaseView) {
        appendToDictionary(view: view)
    }
    
    public func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    public func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    public func navigateBackToRootClearHistory(parent: Coordinator?, child: Coordinator?) {
        self.removeCoordinatorFromParent(parent, child)
        self.navigationController.popToRootViewController(animated: true)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        // From ViewController is the ViewController that is being navigated "back" from
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }

        // If our NavigationController still has this ViewController in the list, that means we are moving forward and not backwards, thus we return
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        guard let fromViewController = fromViewController as? BaseView else { return }
        
        if let viewController = BaseCoordinator.viewControllersDictionary.removeValue(forKey: fromViewController.id) {
            childDidFinish(viewController.coordinator)
        }
    }
    
    deinit {
        print("\(String(describing: self)) was de-initialized")
    }

    private func childDidFinish(_ child: Coordinator?) {

        // Get the index of the child coordinator in its parent coordinators list of childCoordinators
        let index = child?.parentCoordinator?.childCoordinators.firstIndex { coordinator in child === coordinator }

        // Remove the child from the parent' list of childCoordinators
        if let i = index {
            child?.parentCoordinator?.childCoordinators.remove(at: i)
        }
    }

    private func removeCoordinatorFromParent(_ parent: Coordinator?, _ child: Coordinator?) {
        guard let parent = parent else { return }

        for (index, coordinator) in parent.childCoordinators.enumerated() {
            if coordinator === child {
                parent.childCoordinators.remove(at: index)
                break
            }
        }

        removeCoordinatorFromParent(parent.parentCoordinator, parent)
    }

    private func appendToDictionary(view: BaseView) {
        BaseCoordinator.viewControllersDictionary[view.id] = view
    }
}
