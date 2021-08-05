//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by Mingeun Yang on 2021/08/05.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    
    var coffeName: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var total: Double?
    
    var size: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
        }
    
    var selectedCoffeeName: String?
    var selectedSize: String?
    
}
