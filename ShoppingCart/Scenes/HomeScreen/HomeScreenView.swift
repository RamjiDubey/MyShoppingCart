//
//  HomeScreenView.swift
//  ShoppingCart
//

import SwiftUI

struct HomeScreenView: View {
    @ObservedObject private(set) var viewModel: HomeViewModel
    @State private var selectedTab: CustomTabMenuType = .home
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.showErrorView {
                errorView
            } else {
                TabView(selection: $selectedTab) {
                    HomeTabView(products: $viewModel.products) { product in
                        viewModel.goToProductDetail(product)
                    }
                    .tag(CustomTabMenuType.home)
                    
                    CatalogTabView()
                        .tag(CustomTabMenuType.catalog)
                    
                    CartTabView()
                        .tag(CustomTabMenuType.cart)
                    
                    FavoritesTabView()
                        .tag(CustomTabMenuType.favorites)
                    
                    ProfileTabView()
                        .tag(CustomTabMenuType.profile)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            HeaderView(selectedTab: $selectedTab)
            BottomNavTabBar(selectedTab: $selectedTab)
        }
        .background(.white)
    }
    
    @ViewBuilder
    private var errorView: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(.warningIcon)
                .resizable()
                .frame(width: 100, height: 100)
            Text("Something went wrong. Please try again later.")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.black)
            Button {
                viewModel.fetchProducts()
            } label: {
                Text("Try Again!")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .shadow(radius: 8)
            }
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
}
