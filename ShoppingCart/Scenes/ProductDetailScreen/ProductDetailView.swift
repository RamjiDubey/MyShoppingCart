//
//  ProductDetailView.swift
//  ShoppingCart
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject private(set) var viewModel: ProductDetailViewModel
    var body: some View {
        ZStack {
            productDetailView
            headerView
            bottomView
        }
        .background(.gray.opacity(0.4))
    }
    
    private var headerView: some View {
        HStack(alignment: .center) {
            Button {
                viewModel.backButtonTapped()
                HapticGenerator.generate(.heavy)
            } label: {
                Image(.caretLeftCopy)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.black)
                    .padding(10)
                    .background(.white)
                    .clipShape(Circle())
            }
            
            Spacer()
            Button {
                viewModel.likeButtonTapped()
            } label: {
                Image(viewModel.isLiked ? .likedicon : .likeicon)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(10)
                    .background(.white)
                    .clipShape(Circle())
            }
            
            Button {
                shareSheet([viewModel.product.title])
                HapticGenerator.generate(.heavy)
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.black)
                    .padding(10)
                    .background(.white)
                    .clipShape(Circle())
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var productDetailView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ImageView(url: URL(string: viewModel.product.image))
                .aspectRatio(contentMode: .fit)
                .frame(height: SafeArea.screenHeight / 2)
            PageIndicator(currentPage: $viewModel.currentPage, numPages: 5,
                          dotIndicatorProps: DotIndicatorProps())
            VStack(alignment: .leading, spacing: 24) {
                Text(viewModel.product.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black)
                ratingView
                priceBar
                Text(viewModel.product.description)
                    .font(.system(size: 14, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.gray)
                    Spacer(minLength: 100)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.top)
            .background(.white)
            .cornerRadius(14, corners: [.topLeft, .topRight])
        }
    }
    
    private var priceBar: some View {
        VStack {
            HStack(alignment: .center) {
                Text(String(format: "£%.3f", viewModel.product.price))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.black)
                Text("from £14 per month")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.gray.opacity(0.4))
                Spacer()
                Image(systemName: "info.circle")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(.gray)
                    .frame(width: 18, height: 18)
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.2))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
            }
        }
    }
    
    private var ratingView: some View {
        HStack(alignment: .center, spacing: 8) {
            HStack(spacing: 5) {
                Image(.starIcon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color(hex: "#CCFF00"))
                    .frame(width: 20, height: 20)
                Text(String(format: "%.1f", viewModel.product.rating.rate))
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black)
                Text("\(viewModel.product.rating.count) reviews")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(.gray.opacity(0.6))
            }
            .padding(EdgeInsets(top: 5, leading: 12, bottom: 5, trailing: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
            }
            HStack(spacing: 5) {
                Image(.likehandiconfill)
                    .resizable()
                //.renderingMode(.template)
                    .foregroundStyle(Color(hex: "#CCFF00"))
                    .frame(width: 20, height: 20)
                Text("94%")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(.black)
            }
            .padding(EdgeInsets(top: 5, leading: 12, bottom: 5, trailing: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
            }
            HStack(spacing: 5) {
                Image(.msgIcon)
                    .resizable()
                //.renderingMode(.template)
                    .foregroundStyle(.gray)
                    .frame(width: 20, height: 20)
                Text("8")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(.black)
            }
            .padding(EdgeInsets(top: 5, leading: 12, bottom: 5, trailing: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
            }
        }
    }
    
    private var bottomView: some View {
        VStack(alignment: .center, spacing: 8) {
            Button {
                CartManager.shared.handle(item: viewModel.product, shouldAdd: true)
            } label: {
                Text("Add to Cart")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.black)
                    .padding(18)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "#CCFF00"))
                    }
            }
            Text("Delivery on 26 October")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.black)
        }
        .padding(.horizontal)
        .background(.white)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
