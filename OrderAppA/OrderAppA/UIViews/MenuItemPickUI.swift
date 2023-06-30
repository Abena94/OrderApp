//
//  MenuItemPickUI.swift
//  OrderAppA
//
//

import SwiftUI

struct MenuItemPickUI: View {
    @StateObject var ovm : OrderItemsVM = OrderItemsVM()
    @Binding var isDone:Bool
    @GestureState var press = false
    @State var showOrderHistory:Bool = false
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.orange.edgesIgnoringSafeArea(.all)
                VStack(spacing:10) {
                    HStack {
                        Button {
                            showOrderHistory.toggle()
                        } label: {
                            Text("Historique")
                                .foregroundColor(Color.theme.purple)
                                
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                            TabItemViewUI()
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarBackButtonHidden(true)
                                .environmentObject(ovm)
                                .edgesIgnoringSafeArea(.top)
                                
                               
                
                        } label: {
                            payButton
                        }

                        
                    }.padding([.horizontal,.top])
                        .sheet(isPresented: $showOrderHistory) {
                            OrderHistUI(isPresented : $showOrderHistory)
                        }
                    List {
                        
                        principalList
                        
                        cotesList
                        
                    }.listStyle(.grouped)
                        
                    
                    quitButton
                    
                    
                }
            }.navigationBarHidden(true)
        }
    }
}

extension MenuItemPickUI {
    
    private var payButton:some View {
        HStack {
            Image(systemName: "cart")
            Text("PAYER")
                .font(.subheadline)
        }
        .foregroundColor(.black)
        .padding(.all,5)
        .background(
            Capsule()
                .fill(.green)
                
        )
    }
    
    
    private var cotesList :some View {
        Section("A COTES"){
            ForEach(ovm.menuItems.filter({ mn in
                mn.type != "main"
            })) { item in
                HStack {
                    Text(item.name)
                        .foregroundColor(item.isSelected ? Color.theme.orange : .black)
                   Spacer()
                
                }
                .contentShape(Rectangle())
                .listRowBackground(
                    item.isSelected ? Color.theme.purple : .none
                )
                .onTapGesture(count:2) {
                    ovm.updateMenuItem(item: item, isSelected: !item.isSelected)
                    print(item.isSelected)
                }
                
            }
        }
    }
    
    private var principalList :some View {
        Section("REPAS PRINCIPAL") {
            ForEach(ovm.menuItems.filter({ mn in
                mn.type == "main"
            })) { item in
                HStack {
                    Text(item.name)
                        .foregroundColor(item.isSelected ? Color.theme.orange : .black)
                    Spacer()
                    if (item.isCombo) {
                        Image(systemName: "bag.badge.plus")
                    }
                }
                .contentShape(Rectangle())
                .listRowBackground(
                    item.isSelected ? Color.theme.purple : .none
                )
                .onTapGesture(count:2) {
                    ovm.updateMenuItem(item: item, isSelected: !item.isSelected)
                    print(item.isSelected)
                }
                .contextMenu {
                    Button {
                        ovm.updateMenuItem(item: item, isCombo: true)
                    } label: {
                        HStack {
                            Text("EN COMBO")
                            Spacer()
                            Image(systemName: "bag.badge.plus")
                        }
                        
                    }
                    
                    Button {
                        ovm.updateMenuItem(item: item, isCombo: false)
                    } label: {
                        HStack {
                            Text("ITEM UNIQUEMENT")
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    private var quitButton:some View {
            
        Button {
            
        } label: {
            ZStack {
                Capsule()
                    .fill(.green)
                    .frame(height:90)
                    .padding(.horizontal,30)
                Text("Quitter")
                    .textCase(.uppercase)
                    .foregroundColor(.black)
            }

        }.simultaneousGesture(
            LongPressGesture(minimumDuration: 2)
                    .updating($press) { currentState, gestureState, transaction in
                        gestureState = currentState
                    }.onEnded({ prs in
                        withAnimation(.easeOut) {
                            isDone.toggle()
                        }
                        
                    })
        )

            
    }
    
    
    
}

struct MenuItemPickUI_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemPickUI( isDone: .constant(false))
    }
}
