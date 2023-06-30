//
//  LocationModel.swift
//  OrderAppA
//
//

import Foundation
import CoreLocation

struct LocationModel : Identifiable , Equatable{
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        return true
    }
    
    let id = UUID()
    let type,name,description : String
    let coords : CLLocationCoordinate2D
}
