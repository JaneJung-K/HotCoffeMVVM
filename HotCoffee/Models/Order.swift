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

extension Order {
    
    static var all: Resource<[Order]> = {
        
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        return Resource<[Order]>(url: url)
    }()
    
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        
        let order = Order(vm)
        
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL is incorrect!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order!")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
        
    }
    
}

extension Order {
     
    init?(_ vm: AddCoffeeOrderViewModel) {
        
        guard let name = vm.name,
              let total = vm.total,
              let selectedCoffeeName = CoffeeType(rawValue: vm.selectedCoffeeName!.lowercased()),
              let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.total = total
        self.coffeeName = selectedCoffeeName
        self.size = selectedSize
    }
    

}
    

