//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by Mingeun Yang on 2021/08/05.
//

import Foundation

class OrderListViewModel {
    
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
    
}

extension OrderListViewModel {
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
    
}

struct OrderViewModel {
    let order: Order
}

extension OrderViewModel {
    
    var name: String {
        return self.order.name
    }
    
    var coffeName: String {
        return self.order.coffeeName.rawValue.capitalized
    }
    
    var total: Double {
        return self.order.total
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
}
