//
//  LottieView.swift
//  ShoppingCart
//

import SwiftUI
import Lottie

struct LottieView: View {
    let animationFile: String
    let completion: ((Bool) -> Void)?
    
    var body: some View {
        Lottie.LottieView(animation: .named(animationFile))
            .resizable()
            .playing(loopMode: .playOnce)
            .configure { animationView in
                animationView.contentMode = .scaleAspectFill
            }
            .animationDidFinish { completed in
                completion?(completed)
            }
    }
}
