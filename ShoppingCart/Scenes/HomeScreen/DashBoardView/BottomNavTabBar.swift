//
//  BottomNavTabBar.swift
//  ShoppingCart
//

import SwiftUI

struct BottomNavTabBar: View {
    @ObservedObject private var cartManager = CartManager.shared
    @Binding var selectedTab: CustomTabMenuType
    @State private var cartItems: Int = 0
    
    let menuTypes: [CustomTabMenuType] = CustomTabMenuType.allCases
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(menuTypes, id: \.self) { menu in
                    Button {
                        HapticGenerator.generate(.heavy)
                        selectedTab = menu
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: menu.image)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == menu ? Color(hex: "#CCFF00") : .black.opacity(0.6))
                                .overlay(alignment: .topTrailing) {
                                    HStack {
                                        Text("\(cartItems)")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    .padding(6)
                                    .background(Color(.black))
                                    .clipShape(Circle())
                                    .offset(x: 15, y: -8)
                                    .opacity(menu == .cart && cartItems > 0  ? 1 : 0)
                                }
                            Text(menu.title)
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(selectedTab == menu ? Color.black : Color.gray)
                        }
                    }
                    if menuTypes.last != menu {
                        Spacer()
                    }
                }
            }
            .frame(maxHeight: 62, alignment: .center)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
        .background(.white)
        .onChange(of: cartManager.items.count) { newValue in
            withAnimation {
                cartItems = newValue
            }
        }
    }
}
