//
//  TabItemViewUI.swift
//  OrderAppA
//
//

import SwiftUI

struct TabItemViewUI: View {
    
    @EnvironmentObject var ovm : OrderItemsVM
    @Environment(\.presentationMode) var presentation
    @State var totals: (Double,Double,Double) = (0,0,0)
    
    
    
    
    
    var body: some View {
        
        VStack(spacing:0) {
                ZStack {
                    Rectangle()
                        .fill(Color.theme.orange)
                    
                        
                        
                    VStack {
                        Spacer()
                        HStack(alignment:.bottom) {
                            
                            Spacer()
                            
                        }
                    }
                }.edgesIgnoringSafeArea(.top)
                    .frame(height:100)
                TabView {
                    OrderedItemsUI(total: totals.0,taxes: totals.1,totallAll: totals.2)
                        .environmentObject(ovm)
                        .tabItem {
                            Label("Facture", systemImage: "creditcard.fill")
                            
                        }
                        
                        
                    
                    MapViewUI( isAddressSet: $ovm.isAddressSet)
                        .environmentObject(ovm)
                        .tabItem {
                            Label("Livraison", systemImage: "map.fill")
                            
                        }
                    
                    PaymentsUI()
                        .environmentObject(ovm)
                        .tabItem {
                            Label("Paiement", systemImage: "dollarsign.square.fill")
                            
                        }
                }
                
                .accentColor(Color.theme.orange)

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentation.wrappedValue.dismiss()
                        ovm.isAddressSet = false
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Retour")
                                .font(.subheadline)
                        }
                        .foregroundColor(.black)
                        .padding(.all,5)
                        .background(
                            Capsule()
                                .fill(.green)
                            
                        )
                    }
                }
            }.onAppear {
                self.totals = ovm.calculateSelected()
            }
        
    }
    
}

struct TabItemViewUI_Previews: PreviewProvider {
    static var previews: some View {
        TabItemViewUI()
            .environmentObject(OrderItemsVM())
    }
}
