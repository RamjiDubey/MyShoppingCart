//
//  HomeViewModel.swift
//  ShoppingCart
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let likeObserver: LikeObserver = LikeObserver()
    let actionEvent = PassthroughSubject<(Product, LikeObserver), Never>()
    @Published var showErrorView: Bool = false
    @Published var products: [Product] = []
    
    init() {
        setUpLikeObserver()
        fetchProducts()
    }
    
    private func setUpLikeObserver() {
        likeObserver.onChange
            .sink { [weak self] product in
                guard let self else { return }
                if let index = self.products.firstIndex(where: { $0.id == product.id }) {
                    self.products[index] = product
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchProducts() {
        APIService.shared.fetchProducts {[weak self] response in
            withAnimation(.easeInOut(duration: 2)) {
                DispatchQueue.main.async {
                    switch response {
                    case .success(let products):
                        self?.products = products
                        self?.showErrorView = false
                    case .failure(let error):
                        self?.showErrorView = true
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
    
    func goToProductDetail(_ product: Product) {
        actionEvent.send((product, likeObserver))
    }
}
