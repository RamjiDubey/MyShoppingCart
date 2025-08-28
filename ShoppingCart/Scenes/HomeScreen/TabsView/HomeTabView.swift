//
//  HomeTabView.swift
//  ShoppingCart
//

import SwiftUI

struct HomeTabView: View {
    @State private var categoryItems: [CategoryCardModel] = [.init(image: .camera, title: "Cameras"),
                                                             .init(image: .computers, title: "Computers"),
                                                             .init(image: .console, title: "Consoles"),
                                                             .init(image: .headphones, title: "HeadPhones"),
                                                             .init(image: .laptops, title: "Laptops"),
                                                             .init(image: .phones, title: "Phones")]
    @Binding var products: [Product]
    let action: (Product) -> Void
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                topView
                categoriesView
            }
            .padding(.top, 43)
            .padding(.bottom, 60)
            .background(Color.gray.opacity(0.2))
        }
    }
    
    private var topView: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()
            searchButton
            DeliveryView
            Spacer()
        }
        .background(.white)
        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
    }
    
    private var searchButton: some View {
        HStack(alignment: .center, spacing: 10) {
            Spacer()
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(Color.gray)
                .frame(width: 20, height: 20)
            Text("Search the entire shop")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.gray)
            Spacer()
        }
        .padding(.vertical, 16)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
        }
        .padding(.horizontal, 18)
    }
    
    private var DeliveryView: some View {
        HStack(alignment: .center) {
            Text("Delivery is")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
            Text("50%")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                }
            Text("cheaper")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
            Spacer()
        }
        .padding(.vertical, 16)
        .padding(.leading, 16)
        .background {
            LinearGradient(colors: [Color(hex: "#dde3e1"),
                                    Color(hex: "#d2e7e5")],
                           startPoint: .leading,
                           endPoint: .trailing)
        }
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
        }
        .padding(.horizontal, 18)
    }
    
    private var categoriesView: some View {
        VStack {
            categoryTitleView
            flashSaleView
        }
        .background(.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .padding(.top, 12)
    }
    
    private var categoryTitleView: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Categories")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.black)
                Spacer()
                HStack {
                    Text("See all")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black.opacity(0.6))
                        .frame(width: 24, height: 24)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 24) {
                    ForEach(categoryItems, id: \.title) { item in
                        CategoryCardView(model: item)
                    }
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
    }
    
    private var flashSaleView: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Flash Sale")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.black)
                Text("2:59:05")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.black)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "#CCFF00"))
                    }
                Spacer()
                HStack {
                    Text("See all")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black.opacity(0.6))
                        .frame(width: 24, height: 24)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            VerticalGridView(width: SafeArea.screenWidth - 32, itemPerRow: 2, spacing: 16) {
                ForEach(products, id: \.id) { item in
                    create(item)
                        .onTapGesture {
                            action(item)
                        }
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func create(_ product: Product) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            imageCardView(product)
                .aspectRatio(1.6, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .contentShape(Rectangle())
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                }
            Text(product.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            
            Text(String(format: "£%.3f", product.price))
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.gray)
        }
    }
    
    private func imageCardView(_ product: Product) -> some View {
        GeometryReader { reader in
            ZStack(alignment: .topTrailing) {
                ImageView(url: URL(string: product.image))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: reader.size.width, height: reader.size.height)
                Button {
                    HapticGenerator.generate(.heavy)
                    if let index = products.firstIndex(where: { $0.id == product.id }) {
                        products[index].isLiked.toggle()
                        CartManager.shared.handle(item: product, shouldAdd: products[index].isLiked)
                    }
                } label: {
                    Image(product.isLiked ? .likedicon : .likeicon)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(6)
                        .background(.white)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
                        .padding(.top, -24)
                }
            }
        }
    }
}
