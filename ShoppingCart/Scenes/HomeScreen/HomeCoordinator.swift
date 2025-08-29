//
//  HomeCoordinator.swift
//  ShoppingCart
//

import UIKit
import Combine

final class HomeCoordinator: BaseCoordinator<Void> {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let viewModel = HomeViewModel()
        let view = HomeScreenView(viewModel: viewModel)
        let controller = HostingController(rootView: view)
        navigationController.setViewControllers([controller], animated: true)
        
        viewModel.actionEvent.sink {[weak self] product, likeObserver in
            self?.coordinateToProductDetail(product, likeObserver: likeObserver)
        }
        .store(in: &subscribers)
        
        return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
    }
    
    private func coordinateToProductDetail(_ product: Product, likeObserver: LikeObserver) {
        let coordinator = ProductDetailCoordinator(navigationController: navigationController, product: product, likeObserver: likeObserver)
        coordinate(to: coordinator)
            .sink(receiveValue: {})
            .store(in: &subscribers)
    }
}
