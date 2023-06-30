//
//  MenuItem.swift
//  OrderAppA
//
//

import Foundation


struct MenuItem: Decodable,Identifiable {
    let id: String
    var name :String
    let type :String
    var isCombo :Bool
    var isSelected:Bool
    let priceItem:Double
    let priceCombo:Double
}


class MenuItemLoader: Decodable {
    var menuItems : [MenuItem] = []
    
     func loadJSON (completion :@escaping () -> Void) {
        print("Loading json...")
        if let url = Bundle.main.url(forResource: "menuItem", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode([MenuItem].self, from: data) {
                self.menuItems = jsonData
                completion()
                print("json file loaded!")
            } else {
                print("error loading json file")
            }
        }
    }
}
