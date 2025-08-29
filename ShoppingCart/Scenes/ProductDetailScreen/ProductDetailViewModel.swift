//
//  ProductDetailViewModel.swift
//  ShoppingCart
//

import Combine

final class ProductDetailViewModel: ObservableObject {
    let dismissEvent = PassthroughSubject<Void, Never>()
    private let likeObserver: LikeObserver
    @Published var currentPage: Int = 0
    @Published var isLiked: Bool
    var product: Product
    
    init(product: Product, likeObserver: LikeObserver) {
        self.product = product
        self.isLiked = product.isLiked
        self.likeObserver = likeObserver
    }
    
    func backButtonTapped() {
        dismissEvent.send()
    }
    
    func likeButtonTapped() {
        isLiked.toggle()
        product.isLiked = isLiked
        HapticGenerator.generate(.heavy)
        likeObserver.notify(product: product)
    }
}
