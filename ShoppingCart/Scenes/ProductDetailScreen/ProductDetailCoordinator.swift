//
//  ProductDetailCoordinator.swift
//  ShoppingCart
//

import UIKit
import Combine

final class ProductDetailCoordinator: BaseCoordinator<Void> {
    private let navigationController: UINavigationController
    let product: Product
    init(navigationController: UINavigationController, product: Product) {
        self.product = product
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let viewModel = ProductDetailViewModel(product: product)
        let view = ProductDetailView(viewModel: viewModel)
        let controller = HostingController(rootView: view)
        navigationController.pushViewController(controller, animated: true)
        
        viewModel.dismissEvent
            .sink {[weak self] _ in
                self?.navigationController.popViewController(animated: true)
            }
            .store(in: &subscribers)
        
        return viewModel.dismissEvent.eraseToAnyPublisher()
    }
}
