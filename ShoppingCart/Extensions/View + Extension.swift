//
//  View + Extension.swift
//  ShoppingCart
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornersShape(corners: corners, radius: radius) )
    }
    
    func shareSheet(_ items: [Any]) {
        guard let root = UIApplication.shared.windows.first?.rootViewController else { return }
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        root.present(activityViewController, animated: true)
    }
}

struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
