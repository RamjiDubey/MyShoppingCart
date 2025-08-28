//
//  VerticalGridView.swift
//  ShoppingCart
//

import SwiftUI

struct VerticalGridView<Content> : View where Content : View {
    
    var width: CGFloat = SafeArea.screenWidth
    var itemPerRow: CGFloat = 3
    var spacing: CGFloat = 5
    var columns: [GridItem]
    @ViewBuilder let content: () -> Content
    
    init(width: CGFloat = SafeArea.screenWidth,
         itemPerRow: CGFloat = 2,
         spacing: CGFloat = 5,
         columns: [GridItem]? = nil,
         @ViewBuilder content: @escaping () -> Content) {
        self.width = width
        self.itemPerRow = itemPerRow
        self.spacing = spacing
        self.columns = columns ?? [
            GridItem(.adaptive(minimum: (width/itemPerRow) - (spacing * (itemPerRow - 1))))
        ]
        self.content = content
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            content()
        }
    }
}
