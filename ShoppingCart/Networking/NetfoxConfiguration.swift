//
//  NetfoxConfiguration.swift
//  ShoppingCart
//

import Foundation
import netfox

private enum IgnoreNetfoxUrl: String, CaseIterable {
    case picture = "picture"
}

struct NetfoxConfiguration {
    
    static func configure() {
        // Track API calls request and response
        NFX.sharedInstance().start()
        
        // To ignore tracking any specific URLs.
        NFX.sharedInstance().ignoreURLsWithRegexes(IgnoreNetfoxUrl.allCases.map({ $0.rawValue }))
    }
}

