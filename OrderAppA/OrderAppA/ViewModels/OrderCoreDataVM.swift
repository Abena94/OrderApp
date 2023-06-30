//
//  OrderCoreDataVM.swift
//  OrderAppA
//

//

import Foundation
import CoreData

class OrderCoreDataVM :ObservableObject{
    @Published var orders : [OrderEntity] = []
    
    private let container : NSPersistentContainer
    
    init () {
        container = NSPersistentContainer(name: "OrderDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading container \(error)")
            } else {
                print("Success loading container")
            }
        }
        
        fetchData()
    }
    
    
    func fetchData() {
        let request = NSFetchRequest<OrderEntity>(entityName: "OrderEntity")
        
        do {
            orders = try container.viewContext.fetch(request)
        }
        catch let error {
            print("Error fetching data \(error)")
        }
    }
    
    func addOrder ( number:String,total:Double) {
        let id = UUID()
        let date = Date.now
        
        let order = OrderEntity(context: container.viewContext)
        order.id = id
        order.date = date
        order.total = total
        order.number = number
        
        saveOrder()
        fetchData()
    }
    
    private func saveOrder() {
        do {
            try container.viewContext.save()
        }
        catch let error {
            print("error saving the order \(error)")
        }
        
    }
}
