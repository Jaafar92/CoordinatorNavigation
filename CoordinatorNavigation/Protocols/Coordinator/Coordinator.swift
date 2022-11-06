import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    
    /**
     Child coordinator list. Whenever starting a new coordinator, the new coordinator should be stored in this list.
     */
    var childCoordinators: [Coordinator] { get set }
    
    /**
     UINavigationController that manages all the navigations.
     */
    var navigationController: UINavigationController { get set }
    
    /**
     A reference to the parent coordinator. This is used mainly to be able to clean up correctly once the coordinator is no longer used. 
     */
    var parentCoordinator: Coordinator? { get set }
    
    /**
     Create the BaseView (UIVIewController), that should be displayed. Set the coordinator to self.
     Important: Remember to register start (registerStart function), so the coordinator can be garbage collected when not used anymore.
     */
    func start()
    
    /**
     This function registers the BaseView (UIViewController) in a Dictionary. This is later used to clean up, so the coordinator can be garbage collected.
     */
    func registerStart(view: BaseView)
    
    /**
     This is the genric way of dismissing a modal of any type.
     */
    func dismiss()
    
    /**
     This is the generic way of popping the latest ViewController in UINavigationController.
     */
    func navigateBack()
    
    /**
     This navigates back to the first UIViewController in the UINavigationController stack.
     The parent and child is used to recursively remove any child-coordinators, this way de-initializing them.
     */
    func navigateBackToRootClearHistory(parent: Coordinator?, child: Coordinator?)
}
