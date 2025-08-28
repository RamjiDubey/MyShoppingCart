//
//  PageIndicator.swift
//  ShoppingCart
//

import SwiftUI

enum IndicatorShapeType {
    case circle, roundedRectangle
}

struct DotIndicatorProps {
    var dotSize: CGFloat = 8
    var selectedColor: Color = .gray
    var unselectedColor: Color = .gray.opacity(0.3)
    var type: IndicatorShapeType = .circle
}

struct PageIndicator: View {
    @Binding var currentPage: Int
    let numPages: Int
    var spacing: CGFloat = 10
    var dotIndicatorProps: DotIndicatorProps = DotIndicatorProps()
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: spacing) {
                ForEach(0 ..< numPages, id: \.self) {index in
                    DotIndicator(pageIndex: index,
                                 dotIndicatorProps: dotIndicatorProps,
                                 isOn: $currentPage)
                    .frame(width: self.dotIndicatorProps.dotSize, height: self.dotIndicatorProps.dotSize)
                }
            }
        }
    }
}

struct DotIndicator: View {
    let pageIndex: Int
    var dotIndicatorProps: DotIndicatorProps
    
    @Binding var isOn: Int
    
    var isSelected: Bool {
        isOn == pageIndex
    }
    
    var radius: CGFloat {
        isSelected && isRoundedRectangle ? 16 : dotIndicatorProps.dotSize/2
    }
    
    var color: Color {
        isSelected ? dotIndicatorProps.selectedColor : dotIndicatorProps.unselectedColor
    }
    
    var isRoundedRectangle: Bool {
        dotIndicatorProps.type == .roundedRectangle
    }
    
    var width: CGFloat { isSelected && isRoundedRectangle ? 20 : dotIndicatorProps.dotSize }
    var height: CGFloat { dotIndicatorProps.dotSize }
    
    var scaleEffectValue: CGFloat {
        isRoundedRectangle ? 0.7 : 1.0
    }
    
    var body: some View {
        Button(action: {
            self.isOn = pageIndex
        }) {
            color
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: radius))
                .scaleEffect(isSelected ? scaleEffectValue : 0.7)
                .animation(.spring, value: isSelected)
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
        }
    }
}
