//
//  PaymentsUI.swift
//  OrderAppA
//
//

import SwiftUI



struct PaymentsUI: View {
    
    @EnvironmentObject var ovm : OrderItemsVM
    @State private var isPresented:Bool = false
    @StateObject var coreVM: OrderCoreDataVM = OrderCoreDataVM()
    
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                
                if ovm.menuItems.filter({ item in
                    item.isSelected
                }).count == 0 {
                    Text("No items selected!")
                }
                
                if !ovm.isAddressSet {
                    Text("No address selected!")
                }
                
            }.foregroundColor(.red)
                .alert("La commande est envoyee avec succes!!", isPresented: $isPresented) {
                    Text("La commande a ete creee avec succes.")
                }
            Button {
                if isButtonEnabled() {
                    isPresented.toggle()
                    
                    var total:Double = 0
                    let number:String = "\(coreVM.orders.count + 1)"
                    
                    ovm.menuItems.filter { item in
                        item.isSelected
                    }.forEach { item in
                        total += item.isCombo ? item.priceCombo : item.priceItem
                    }
                    
                    coreVM.addOrder(number: number, total: total + (total * 0.15))
                }
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.green)
                    .frame(height:100)
                    .frame(maxWidth:.infinity)
                    .padding(.vertical)
                    .padding(.horizontal,30)
                    .overlay(
                        Text("Commander!!!")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                    )
            }

        }
    }
}

extension PaymentsUI {
    private func isButtonEnabled() -> Bool {
        if !ovm.isAddressSet || ovm.menuItems.filter({ item in
            item.isSelected
        }).count == 0 {
            return false
        }
        
        return true
    }
}

struct PaymentsUI_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsUI()
            .environmentObject(OrderItemsVM())
    }
}
