//
//  MapViewModel.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/13.
//

import MapKit



extension LocationViewModel {
    
    func searchRouteToTokyoStation(){
        guard let currentLocation = currentLocation else {return}
        
        let tokyoStationCoordinate = CLLocationCoordinate2D(latitude: 35.777672, longitude: 139.724575)
        
        let currentPlacemark = MKPlacemark(coordinate: currentLocation.coordinate)
        let tokyoStationPlacemark = MKPlacemark(coordinate: tokyoStationCoordinate)
        
        let Request = MKDirections.Request() //ルート検索のリクエスト(始点と終点)
        Request.source = MKMapItem(placemark: currentPlacemark)
        Request.destination = MKMapItem(placemark: tokyoStationPlacemark)
        Request.transportType = .walking  //交通手段
        
        let directions = MKDirections(request: Request)
        
        directions.calculate{ [weak self] (response,error) in //非同期処理
            //ルート検索の結果が得られたら実行(非同期処理の後のクロージャ)
            guard let self = self, let route = response?.routes.first else {return}
            self.handleRoute(route: route)
        }
    }
    
    func handleRoute(route: MKRoute){
        self.route = route //ルート検索の結果が得られたら情報を更新
        updateCoordinates(from: route.polyline) // 座標の更新をfromというラベルでupdateCoordinatesに委託
    }
    
    func updateCoordinates(from polyline: MKPolyline) { //ラベルの型を指定
        let pointCount = polyline.pointCount
        var coordinates = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        polyline.getCoordinates(&coordinates, range: NSRange(location: 0, length: pointCount)) //ポリラインを形成するすべての点の座標をこの配列にコピーする
        
        self.coordinates = coordinates // ViewModelの座標配列を更新
        print("座標: \(coordinates)")
    }
}
