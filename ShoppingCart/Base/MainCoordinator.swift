//
//  MainCoordinator.swift
//  ShoppingCart
//

import UIKit
import Combine

final class MainCoordinator: BaseCoordinator<Void> {
    private let rootNavigationController: UINavigationController
    private var cancellable: Set<AnyCancellable> = []
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
        super.init()
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        coordinateToSplashScreen()
            .sink {[weak self] _ in
                self?.coordinateToHomeScreen()
            }
            .store(in: &cancellable)
        
        return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
    }
    
    private func coordinateToSplashScreen() -> AnyPublisher<Void, Never> {
        let splashCoordinator = SplashScreenCoordinator(navigationController: rootNavigationController)
        return coordinate(to: splashCoordinator)
    }
    
    private func coordinateToHomeScreen() {
        let coordinator = HomeCoordinator(navigationController: rootNavigationController)
        coordinate(to: coordinator)
            .sink(receiveValue: {
                
            })
            .store(in: &subscribers)
    }
}
