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
        
        viewModel.actionEvent.sink {[weak self] product in
            self?.coordinateToProductDetail(product)
        }
        .store(in: &subscribers)
        
        return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
    }
    
    private func coordinateToProductDetail(_ product: Product) {
        let coordinator = ProductDetailCoordinator(navigationController: navigationController, product: product)
        coordinate(to: coordinator)
            .sink(receiveValue: {})
            .store(in: &subscribers)
    }
}
