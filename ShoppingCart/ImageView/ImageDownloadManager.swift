//
//  ImageDownloadManager.swift
//  ShoppingCart
//

import SDWebImageSwiftUI
import SwiftUI
import Combine

final class ImageDownloadManager : ObservableObject {
    
    private var disposable: Set<AnyCancellable> = []
    private let imageManager = ImageManager()
    @Published var image: PlatformImage? = nil
    private let imageURL: URL?
    private var onCompletion: (() -> Void)?

    init(imageURL: URL?) {
        self.imageURL = imageURL
        self.setupLoadObserver()
        self.load(onCompletion: onCompletion)
    }
    
    private func setupLoadObserver() {
        imageManager.setOnSuccess {[weak self] image, _, _ in
            guard let self else { return }
            DispatchQueue.main.async {
                withAnimation(.easeIn(duration: 0.1)) {
                    self.image = image
                    self.onCompletion?()
                }
            }
        }
    }
    
    func load(onCompletion: (() -> Void)?) {
        imageManager.load(url: imageURL)
        self.onCompletion = onCompletion
    }
        
    func cancel() {
        guard imageURL != nil else { return }
        imageManager.cancel()
    }
}
