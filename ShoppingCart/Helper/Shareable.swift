//
//  Shareable.swift
//  ShoppingCart
//

import SwiftUI
import UIKit

protocol Shareable {
    func shareSheet(with items: [Any], completion: (() -> Void)?)
}


extension Shareable where Self: UIViewController {
    func shareSheet(with items: [Any], completion: (() -> Void)? = nil) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            completion?()
        }
        
        present(activityViewController, animated: true)
    }
}
