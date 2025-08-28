//
//  HeaderView.swift
//  ShoppingCart
//

import SwiftUI

struct HeaderView: View {
    @Binding var selectedTab: CustomTabMenuType
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            appIcon
            Spacer()
            address
            Spacer()
            button
        }
        .padding(.horizontal)
        .background(.white)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    private var appIcon: some View {
        if selectedTab != .cart {
            Button {
                HapticGenerator.generate(.heavy)
            } label: {
                Image(systemName: "checkmark.seal.fill")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.black)
                    .frame(width: 20, height: 20)
                    .padding(12)
                    .background(Color(hex: "#CCFF00"))
                    .clipShape(.circle)
            }
        } else {
            Text("Cart")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.black)
        }
    }
    
    @ViewBuilder
    private var address: some View {
        if selectedTab != .cart {
            VStack(alignment: .center, spacing: 0) {
                Text("Delivery address")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.gray)
                Text("92 High Street, London")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.black)
            }
        }
    }
    
    @ViewBuilder
    private var button: some View {
        Button {
            HapticGenerator.generate(.heavy)
            guard selectedTab != .cart else { return }
            self.sendLocalNotification(title: "HI USER",
                                       body: "This is a sample notification\n 📢")
        } label: {
            Image(selectedTab != .cart ? .bellIcon : .ellipsis)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.black)
                .scaledToFill()
                .frame(width: 20, height: 20)
                .padding(12)
                .background(Color.gray.opacity(0.3))
                .clipShape(.circle)
        }
    }
    
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
