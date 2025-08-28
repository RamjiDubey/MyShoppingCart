//
//  CategoryCard.swift
//  ShoppingCart
//

import SwiftUI

struct CategoryCardView: View {
    let model: CategoryCardModel
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(model.image)
                .resizable()
                .frame(width: 30, height: 30)
                .padding(16)
                .background(Color.gray.opacity(0.2))
                .clipShape(Circle())
            Text(model.title)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.black)
        }
    }
}

struct CategoryCardModel {
    let image: ImageResource
    let title: String
}
