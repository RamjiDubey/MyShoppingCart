//
//  SplashScreenCoordinator.swift
//  ShoppingCart
//

import UIKit
import Combine

final class SplashScreenCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    private let dismissEvent = PassthroughSubject<Void, Never>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let viewModel = SplashScreenViewModel()
        let view = SplashScreenView(viewModel: viewModel)
        let controller = HostingController(rootView: view)
        navigationController.setViewControllers([controller], animated: true)
        
        return viewModel.dismissEvent
            .eraseToAnyPublisher()
    }
}
