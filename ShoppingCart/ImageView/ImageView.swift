//
//  ImageView.swift
//  ShoppingCart
//

import SDWebImageSwiftUI
import SwiftUI

struct ImageView: View {
    
    @StateObject private var imageManager: ImageDownloadManager
    private let imageURL: URL?
    private let placeholder: ImageResource?
    private var image: UIImage?
    private var onSuccess: (() -> Void)? = nil
            
    init(url: URL?) {
        self.imageURL = url
        self.placeholder = .imageDownloadPlaceholder
        _imageManager = StateObject(wrappedValue: ImageDownloadManager(imageURL: url))
    }
    
    var body: some View {
        imagViewContainerView
            .onAppear() {
                imageManager.load(onCompletion: onSuccess)
            }
            .onDisappear {
                imageManager.cancel()
            }
    }
    
    @ViewBuilder
    private var imagViewContainerView: some View {
        
        if let image {
            imageView(image: image, ratio: .fill)
        } else if let image = imageManager.image {
            imageView(image: image, ratio: .fill)
        } else {
            placeHolderView
        }
    }
        
    private func imageView(image: UIImage, ratio: ContentMode) -> some View {
        Image(uiImage: image)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: ratio)
    }

    @ViewBuilder
    private var placeHolderView: some View {
        if let placeholder {
            Image(placeholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
