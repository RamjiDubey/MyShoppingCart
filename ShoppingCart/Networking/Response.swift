//
//  Response.swift
//  ShoppingCart
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    enum CodingKeys: String, CodingKey {
            case id, title, price, description, category, image, rating
        }
    
    var isLiked: Bool = false
    var isSelected: Bool = true
    var selectedItemCount: Int = 1
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}

