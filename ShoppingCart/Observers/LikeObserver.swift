//
//  LikeObserver.swift
//  ShoppingCart
//

import Combine
import Foundation

final class LikeObserver {
    private let publisher = PassthroughSubject<Product, Never>()
    
    var onChange: AnyPublisher<Product, Never> {
        publisher
            .share()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func notify(product: Product) {
        publisher.send(product)
    }
}
