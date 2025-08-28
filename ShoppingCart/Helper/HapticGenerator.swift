//
//  HapticGenerator.swift
//  ShoppingCart
//


import UIKit

enum HapticEffectType {
    case heavy
}

enum HapticGenerator {
    
    static func generate(_ effectType: HapticEffectType) {
        asyncGlobal {
            switch effectType {
            case .heavy: UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            }
        }
    }
}
