//
//  HostingController.swift
//  ShoppingCart
//

import SwiftUI
import Combine

class HostingController<RootView: View>: UIHostingController<RootView> {

    override init(rootView: RootView) {
        super.init(rootView: rootView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
}
