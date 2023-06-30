//
//  OrderHistUI.swift
//  OrderAppA
//
//

import SwiftUI

struct OrderHistUI: View {
    
    @StateObject var coreVM : OrderCoreDataVM = OrderCoreDataVM()
    
    @Binding var isPresented : Bool

    
    var body: some View {
        ZStack {
            Color.theme.purple.edgesIgnoringSafeArea(.all)
            VStack(alignment:.leading) {
                
                HStack(alignment:.top) {
                    Text("Historique de commandes")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                    Spacer()
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.theme.orange)
                            .frame(width:30)
                            .shadow(radius: 10)
                    }

                }.padding()
                
                Text("Nb de commandes: \(coreVM.orders.count)")
                    .foregroundColor(.white)
                    .frame(maxWidth:.infinity)
                    .multilineTextAlignment(.center)
                    .shadow(color: Color.theme.orange, radius: 10, x: 0, y: 5)
                
                
                ScrollView {
                    ForEach(coreVM.orders) { order in
                        HStack {
                            Text("# \(order.number ?? "")")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .padding(.horizontal,20)
                            VStack(alignment:.leading) {
                                Text("Date: \(order.date?.todayFormater() ?? "")")
                                Text("Total: $\(order.total,specifier: "%.2f")")
                                
                            }.padding(.vertical,10)
                        }.foregroundColor(.white)
                    }
                }.padding(.top,30)
                
                
                Spacer()
                
            }
        }
    }
}

struct OrderHistUI_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistUI(isPresented: .constant(false))
    }
}
