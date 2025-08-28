//
//  HomeViewModel.swift
//  ShoppingCart
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    let actionEvent = PassthroughSubject<Product, Never>()
    @Published var showErrorView: Bool = false
    @Published var products: [Product] = []
    
    init() {
        fetchProducts()
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
        actionEvent.send(product)
    }
}
