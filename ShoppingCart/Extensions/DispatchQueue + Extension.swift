//
//  DispatchQueue + Extension.swift
//  ShoppingCart
//

import Foundation

typealias VoidClosure = (() -> Void)

func asyncGlobal(_ completion: @escaping VoidClosure) {
    DispatchQueue.global().async {
        completion()
    }
}
