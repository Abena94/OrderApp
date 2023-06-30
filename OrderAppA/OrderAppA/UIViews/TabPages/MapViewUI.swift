//
//  MapViewUI.swift
//  OrderAppA
//

//

import SwiftUI
import MapKit

struct MapViewUI: View {
    @EnvironmentObject var ovm : OrderItemsVM
    @State var address:String = ""
    @State var city:String = ""
    @Binding var isAddressSet : Bool
    
    @StateObject var mapVM = MapVM()
    
    
    var body: some View {
        ZStack {
            
            Map(coordinateRegion: $mapVM.region, annotationItems: mapVM.locations) { mapItem in
                MapAnnotation(coordinate: mapItem.coords) {
                    VStack {
                        if mapItem.type == "placemark" {
                            selfPin
                        } else {
                            restPin
                        }
                        
                        Text(mapItem.name)
                    }
                }
            }.edgesIgnoringSafeArea(.top)
                .onChange(of: mapVM.locations) { _ in
                    isAddressSet.toggle()
                }
            
            
            searcher
        }
    }
}

extension MapViewUI {
    private var selfPin :some View {
        Image(systemName: "person.circle")
            .resizable()
            .scaledToFit()
            .frame(height:30)
            .foregroundColor(.blue)
            .background(
                Circle()
                    .fill(.white)
            )
    }
    private var restPin :some View {
        Image(systemName: "star.circle")
            .resizable()
            .scaledToFit()
            .frame(height:30)
            .foregroundColor(.red)
            .background(
                Circle()
                    .fill(.white)
            )
    }
    private var searcher:some View {
        VStack(spacing:30) {
            TextField("Adresse", text: $address)
                .padding(.leading)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .frame(height:50)
                )
                .padding(.horizontal)
            
            
            TextField("City", text: $city)
                .padding(.leading)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .frame(height:50)
                )
                .padding(.horizontal)
            
            HStack {
                Spacer()
                Button {
                    mapVM.applyLocations(address: address, city: city)
                    
                    
                } label: {
                    HStack {
                        
                        Text("Soumettre")
                            .foregroundColor(.white)
                        
                        
                        Image(systemName: "return")
                            .resizable()
                            .scaledToFit()
                            .frame(height:15)
                            .foregroundColor(.white)
                        
                    }.padding(.all,5)
                        .background(
                            Capsule()
                        )
                }.disabled(city.isEmpty || address.isEmpty)
            }.padding(.trailing)
            
            Spacer()
        }.padding(.top)
    }
}

struct MapViewUI_Previews: PreviewProvider {
    static var previews: some View {
        MapViewUI( isAddressSet: .constant(false))
            .environmentObject(OrderItemsVM())
    }
}
