//
//  CartManager.swift
//  ShoppingCart
//

import SwiftUI

final class CartManager: ObservableObject {
    static let shared = CartManager()
    
    @Published var items: [Product] = [] {
        didSet {
            saveItems()
        }
    }
    
    private init() {
        loadItems()
    }
    
    private func saveItems() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: "cart_items")
        } catch {
            print("Failed to save cart items:", error)
        }
    }
    
    private func loadItems() {
        guard let data = UserDefaults.standard.data(forKey: "cart_items") else { return }
        do {
            items = try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print("Failed to load cart items:", error)
        }
    }
    
    func handle(item: Product, shouldAdd: Bool) {
        if shouldAdd {
            items.append(item)
            print(items.count)
        }else {
            guard items.count > 0 else { return }
            items.removeAll { $0.id == item.id }
        }
    }
    
    func count(of item: Product) -> Int {
        items.filter { $0.id == item.id }.count
    }
    
    func add(_ item: Product) {
        items.append(item)
    }
    
    func remove(_ item: Product) {
        guard count(of: item) > 0 else { return }
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
    
    func toggleSelection(value: Bool) {
        for index in items.indices {
            items[index].isSelected = value
        }
    }
    
    func toggleSelection(of item: Product) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isSelected.toggle()
        }
    }
    
    func removeSelectedItems() {
        items.removeAll { $0.isSelected }
    }
    
    var selecetedItemsCount: Int {
        items.filter { $0.isSelected }.count
    }
    
    func isSelected(id: Int) -> Bool {
        return items.first(where: { $0.id == id })?.isSelected ?? true
    }
}

