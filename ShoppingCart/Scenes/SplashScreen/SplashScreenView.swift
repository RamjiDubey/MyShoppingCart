//
//  SplashScreenView.swift
//  ShoppingCart
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject private(set) var viewModel: SplashScreenViewModel
    
    var body: some View {
        ZStack {
            LottieView(animationFile: LottieType.splashScreen.rawValue) { _ in
                viewModel.animationCompleted = true
            }
        }
    }
}
