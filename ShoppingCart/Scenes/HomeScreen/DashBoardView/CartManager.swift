//
//  CartManager.swift
//  ShoppingCart
//

import SwiftUI

final class CartManager: ObservableObject {
    static let shared = CartManager()
    @Published var count: Int = 0
    
    var items: [Product] = []
    
    func handle(item: Product, shouldAdd: Bool) {
        if shouldAdd {
            items.append(item)
            count = items.count
            print(items.count)
        }else {
            guard items.count > 0 else { return }
            items.removeAll { $0.id == item.id }
            count = items.count
        }
    }
}

