//
//  ProductDetailViewModel.swift
//  ShoppingCart
//

import Combine

final class ProductDetailViewModel: ObservableObject {
    let dismissEvent = PassthroughSubject<Void, Never>()
    @Published var currentPage: Int = 0
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    func backButtonTapped() {
        dismissEvent.send()
    }
}
