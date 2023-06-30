//
//  OrderedItemsUI.swift
//  OrderAppA
//
//

import SwiftUI

struct OrderedItemsUI: View {
    
    @EnvironmentObject var ovm : OrderItemsVM
    
    let total,taxes,totallAll:Double
    let today: Date = Date.now
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(Color.theme.orange)
                .padding()
            VStack {
                Text("A la bonne patate")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                Text(today.todayFormater())
                    .padding(.top)
                
                VStack(alignment:.leading) {
                    HStack {
                        if (ovm.menuItems.filter({ item in
                            item.isSelected
                        }).count == 0) {
                            Text("No items selected...")
                        } else {
                            orderedItemList
                        }
                        
                        Spacer()
                    }.frame(maxWidth:.infinity)
                        .padding(.horizontal,30)
                }.padding(.top,70)
                    
                Spacer()
                
                HStack {
                    
                    Spacer()
                    VStack(alignment:.trailing) {
                        Text("Total (avant taxes):")
                            .fontWeight(.bold)
                        Text("Taxes:")
                            .fontWeight(.bold)
                        Text("Montant Total:")
                            .fontWeight(.bold)
                    }
                    
                    VStack(alignment:.leading) {
                        Text("$ \(total, specifier: "%.2f")")
                        Text("$ \(taxes, specifier: "%.2f")")
                        Text("$ \(totallAll, specifier: "%.2f")")
                    }
                    

                    
                }.padding(.trailing,40)
            }.padding(.vertical,25)
            
        }
    }
}

extension OrderedItemsUI {
    private var orderedItemList :some View {
        VStack(alignment:.leading) {
            ForEach(ovm.menuItems.filter({ item in
                item.isSelected
            })) { it in
                Text("-- \(it.name) [\(it.isCombo ? "combo" : "item")] ... $\(it.isCombo ? it.priceCombo : it.priceItem, specifier: "%.2f")")
            }.padding(.vertical,8)
        }
    }
}

struct OrderedItemsUI_Previews: PreviewProvider {
    static var previews: some View {
        OrderedItemsUI(total: 0,taxes: 1.69,totallAll: 12.97)
            .environmentObject(OrderItemsVM())
    }
}

