//
//  CartTabView.swift
//  ShoppingCart
//

import SwiftUI

struct CartTabView: View {
    @ObservedObject var cartManager = CartManager.shared
    @State private var allSelected: Bool = true
    @State private var selectedItems: [Product] = []
    @State private var showAlert = false
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    topView
                    itemsList
                }
                .padding(.top, 43)
                .padding(.bottom, 60)
                .background(Color.gray.opacity(0.2))
            }
            checkoutButton
        }
        .onAppear {
            selectedItems = cartManager.items
        }
        .alert("Thank you for your order!", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Order Successful")
        }
    }
    
    private var topView: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()
            addressBar
            Spacer()
        }
        .background(.white)
        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
    }
    
    private var addressBar: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(.locationIcon)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(Color.gray)
                .frame(width: 20, height: 20)
            Text("92 High Street, london")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.gray)
            Spacer()
            Image(.caretLeftCopy)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(Color.gray)
                .frame(width: 20, height: 20)
                .rotationEffect(.degrees(180))
        }
        .padding(16)
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
    
    @ViewBuilder
    private var itemsList: some View {
        if cartManager.items.isEmpty {
            emptyCartView
        } else {
            VStack {
                selectAllTitleView
                rowItemView
            }
            .background(.white)
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .padding(.top, 12)
        }
    }
    
    private var emptyCartView: some View {
        VStack(alignment: .center) {
            Text("No Items in Cart \n Add some items to your cart")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
        }
    }
    
    private var selectAllTitleView: some View {
        HStack(alignment: .center, spacing: 16) {
            Button {
                allSelected.toggle()
                cartManager.toggleSelection(value: allSelected)
            } label: {
                Image(allSelected ? .agreedCheckIconCopy : .checkboxUnselectedCopy)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Text("Select all")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.black)
            Spacer()
            HStack(spacing: 12) {
                Button {
                    shareSheet(["Dummy Title"])
                    HapticGenerator.generate(.heavy)
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.black)
                }
                Button {
                    
                } label: {
                    Image(systemName: "paperclip")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.black)
                }
            }
        }
        .padding()
        .padding(.top)
    }
    
    private var uniqueItems: [Product] {
        var seen = Set<Int>()
        return CartManager.shared.items.filter { product in
            if seen.contains(product.id) {
                return false
            } else {
                seen.insert(product.id)
                return true
            }
        }
    }
    
    private var rowItemView: some View {
        VStack {
            ForEach(uniqueItems, id: \.id) { item in
                create(item)
            }
            Spacer(minLength: 100)
        }
    }
    
    private func create(_ item: Product) -> some View {
        HStack(alignment: .center, spacing: 16) {
            Button {
                cartManager.toggleSelection(of: item)
            } label: {
                Image(cartManager.isSelected(id: item.id) ? .agreedCheckIconCopy : .checkboxUnselectedCopy)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.black)
            }
            ImageView(url: URL(string: item.image))
                .frame(width: 30, height: 30)
                .padding(18)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.2))
                }
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.black)
                    .lineLimit(2)
                Spacer()
                HStack {
                    Text(String(format: "£%.2f", item.price))
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.black)
                    Spacer()
                    HStack(alignment: .center, spacing: 8) {
                        Button {
                            cartManager.remove(item)
                        } label: {
                            Image(.minusIcon)
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.black)
                                .padding(5)
                                .background(.gray.opacity(0.3))
                                .clipShape(Circle())
                        }
                        Text("\(cartManager.count(of: item))")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.black)
                        Button {
                            cartManager.add(item)
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.black)
                                .padding(5)
                                .background(.gray.opacity(0.3))
                                .clipShape(Circle())
                        }
                    }
                }
                Divider()
                    .frame(height: 1)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    private var checkoutButton: some View {
        Button {
            showAlert = true
            self.sendLocalNotification(title: "Your Order Placed Successfully",
                                       body: "We Will Notify you Once Your Order is Shipped\n 📢")
            cartManager.removeSelectedItems()
        } label: {
            Text("Checkout")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.black)
                .padding(18)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: "#CCFF00"))
                }
        }
        .padding(.bottom, 65)
        .padding(.horizontal)
        .disabled(selectedItems.isEmpty || cartManager.selecetedItemsCount == 0)
        .opacity(selectedItems.isEmpty || cartManager.selecetedItemsCount == 0 ? 0.5 : 1)
    }
}

extension CartTabView {
    func sendLocalNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .defaultRingtone
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to add notification: \(error.localizedDescription)")
            }
        }
    }
}
