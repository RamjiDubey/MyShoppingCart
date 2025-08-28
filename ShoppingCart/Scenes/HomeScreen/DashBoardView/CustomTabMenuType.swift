//
//  CustomTabMenuType.swift
//  ShoppingCart
//

import SwiftUI

enum CustomTabMenuType: CaseIterable {
    case home
    case catalog
    case cart
    case favorites
    case profile
}

extension CustomTabMenuType {
    var image: String {
        switch self {
        case .home: return "house.fill"
        case .catalog: return "magnifyingglass"
        case .cart: return "cart.fill"
        case .favorites: return "heart.fill"
        case .profile: return "person.fill"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .catalog: return "Catalog"
        case .cart: return "Cart"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }
}
