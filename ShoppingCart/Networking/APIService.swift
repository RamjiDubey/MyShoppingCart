//
//  APIService.swift
//  ShoppingCart
//

import Foundation

final class APIService {
    static let shared = APIService()
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Request error:", error)
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch {
                completion(.failure(error))
                print("Decoding error:", error)
            }
        }.resume()
    }
}
