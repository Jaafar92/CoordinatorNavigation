import UIKit
import SwiftUI

open class BaseUIHostingController<T: View> : BaseView {

    var swiftUIView : UIHostingController<T>
    
    public static func createHostingController(view: T) -> BaseUIHostingController {
        let viewController = BaseUIHostingController(view: view)
        return viewController
    }
    
    public init(view: T) {
        swiftUIView = UIHostingController(rootView: view)
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(swiftUIView)
        self.view.addSubview(swiftUIView.view)

        if let navController = navigationController {
            navController.interactivePopGestureRecognizer?.delegate = nil
            navController.interactivePopGestureRecognizer?.isEnabled = true
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        swiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
        swiftUIView.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        swiftUIView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        swiftUIView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        swiftUIView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
}
