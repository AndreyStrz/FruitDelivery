//
//  CountableContainer.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 21.08.2024.
//

import Foundation

final class CountableContainer<Item> {
    let item: Item
    var count: Int
    
    init(item: Item, count: Int = 1) {
        self.item = item
        self.count = count
    }
} 
