//
//  MapViewModel.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/13.
//

import SwiftUI

extension LocationViewModel {
    func searchRouteToTokyoStation(){
        guard let currentLocation = currentLocation else {return}
        
        let currentPlacemark = MKPlacemark(coordinate: currentLocation.coordinate)
        let tokyoStationPlacemark = MKPlacemark(coordinate: tokyoStationCoordinate)
    }
}
