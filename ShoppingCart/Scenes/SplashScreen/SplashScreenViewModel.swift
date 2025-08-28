//
//  SplashScreenViewModel.swift
//  ShoppingCart
//

import Combine
import Foundation

final class SplashScreenViewModel: ObservableObject {
    let dismissEvent = PassthroughSubject<Void, Never>()
    var animationCompleted: Bool = false {
        didSet {
            navigateToScreen()
        }
    }
    
    func navigateToScreen() {
        DispatchQueue.main.async {
            self.dismissEvent.send(())
        }
    }
    
    deinit {
        print("SplashScreenViewModel Deinitiialized")
    }
}
