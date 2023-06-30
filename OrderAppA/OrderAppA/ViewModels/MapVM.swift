//
//  MapVM.swift
//  OrderAppA
//
//

import Foundation
import MapKit

class MapVM : ObservableObject {
    @Published var region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.422,
                                                                                                   longitude: -75.693),
                                                                    latitudinalMeters: 20000,
                                                                    longitudinalMeters: 20000)
    
    @Published var locations : [LocationModel] = [
        LocationModel(type: "restaurant", name: "Resto 1", description: "Restaurant de Hull",coords: CLLocationCoordinate2D(latitude: 45.42378, longitude: -75.73201)),
        LocationModel(type: "restaurant", name: "Resto 2", description: "Restaurant Otawa",coords: CLLocationCoordinate2D(latitude: 45.37436, longitude: -75.77303))
    ]
    
     private var pinnedLocation: LocationModel?
    
    
    func isMyAddressSet() -> Bool {
        if pinnedLocation != nil {
            return true
        }
        
        return false
    }
    
    
    
    
    
    func applyLocations(address: String ,city: String) {
        checkerAdresse(address: address, city: city) {
            if let pinnedLocation = self.pinnedLocation {
                self.locations.append(pinnedLocation)
            }
            
            
        }
        
        
    
    }
    
    
    
    private func checkerAdresse(address: String ,city:String,completion: @escaping () -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "\(address), \(city)"
        let search = MKLocalSearch(request: searchRequest)
        searchRequest.region = self.region
            search.start { response, error in
                guard let response = response else{
                    print("Error in function",#function)
                    return
                }
                
                let myAdressLocation = LocationModel(type: "placemark",
                                                     name: response.mapItems[0].name ?? "My Address",
                                                     description: "",
                                                     coords: response.mapItems[0].placemark.coordinate)
                
                

                    
                
                    self.pinnedLocation = (myAdressLocation)
                    completion()
            }
        
    }
}
