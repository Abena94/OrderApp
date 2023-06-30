//
//  OrderItemsVM.swift
//  OrderAppA
//

//

import Foundation

class OrderItemsVM : ObservableObject {
    @Published var menuItems : [MenuItem] = []
    @Published var isAddressSet: Bool = false
    
    
    func calculateSelected() -> (Double,Double,Double){
        var result:(Double,Double,Double) = (0,0,0)
            
        self.menuItems.filter { mn in
            mn.isSelected
        }.forEach { item in
            result.0 = result.0 + (item.isCombo ? item.priceCombo : item.priceItem)
        }
        
        result.1 = result.0 * 0.15
        result.2 = result.0 + result.1
        
        return result
    }
    
    func updateMenuItem(item :MenuItem, isCombo:Bool) {
        if let index = self.menuItems.firstIndex(where: { $0.id == item.id
        })
        {
            self.menuItems[index].isCombo = isCombo
        }
    }
    
    func updateMenuItem(item :MenuItem, isSelected:Bool) {
        for i in 1 ..< self.menuItems.count {
            if self.menuItems[i].type != "main" && item.type != "main"{
                self.menuItems[i].isSelected = false
            }
        }
        
        if let index = self.menuItems.firstIndex(where: { $0.id == item.id
        })
        {
            self.menuItems[index].isSelected = isSelected
        }
    }
    
    
    init() {
        let loader = MenuItemLoader()
        loader.loadJSON {
            self.menuItems = loader.menuItems
            print("VM loaded")
        }
    }
}
