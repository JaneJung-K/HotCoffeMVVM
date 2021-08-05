//
//  Order.swift
//  HotCoffee
//
//  Created by Mingeun Yang on 2021/07/29.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {

    let name: String
    let coffeeName: CoffeeType
    let total: Double
    let size: CoffeeSize

}


