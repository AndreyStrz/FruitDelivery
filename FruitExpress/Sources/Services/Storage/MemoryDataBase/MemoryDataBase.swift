//
//  MemoryDataBase.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 21.08.2024.
//

import Foundation

final class MemoryDataBase {
    static var shared: MemoryDataBase = .init()
    
    var productsInBasket: [CountableContainer<ProductDomainModel>] = []
    
    private init() { /*singleton*/ }
    
    func appendToBasket(product: ProductDomainModel) {
        if productsInBasket.contains(where: { $0.item.id == product.id }) {
            addCount(for: product, delta: 1)
        } else {
            productsInBasket.append(.init(item: product))
        }
    }
    
    func removeFromBasketOneItem(product: ProductDomainModel) {
        if productsInBasket.contains(where: { $0.item.id == product.id }) {
            removeCount(for: product, delta: 1)
        }
    }
    
    func removeFromBasket(product: ProductDomainModel) {
        productsInBasket.removeAll(where: { $0.item.id == product.id })
    }
    
    func addCount(for product: ProductDomainModel, delta: Int) {
        guard let container = productsInBasket.first(where: { $0.item.id == product.id }) else {
            return
        }
        
        container.count += delta
    }
    
    func removeCount(for product: ProductDomainModel, delta: Int) {
        guard let container = productsInBasket.first(where: { $0.item.id == product.id }) else {
            return
        }
        
        if container.count <= 1 {
            removeFromBasket(product: product)
        } else {
            container.count -= delta
        }
    }
}
