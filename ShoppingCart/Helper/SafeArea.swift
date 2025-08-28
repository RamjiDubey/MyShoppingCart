//
//  SafeArea.swift
//  ShoppingCart
//

import UIKit

enum SafeArea {
    static var safeAreaInsets: UIEdgeInsets? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.safeAreaInsets
    }
    static var safeAreaTop: CGFloat { safeAreaInsets?.top ?? 0 }
    static var safeAreaBottom: CGFloat { safeAreaInsets?.bottom ?? 0 }
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let screenSize = CGSize(width: screenWidth, height: screenHeight)
}
