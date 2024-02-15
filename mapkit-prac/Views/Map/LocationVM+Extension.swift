//
//  MapViewModel.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/13.
//

import MapKit
import Foundation
import CoreLocation


extension LocationViewModel {
    
    func searchRouteToTokyoStation(){
        guard let currentLocation = currentLocation else {return}
        
        
        let tokyoStationCoordinate = CLLocationCoordinate2D(latitude: 35.77755563032392, longitude:139.72112283271034)
        //        let tokyoStationCoordinate = CLLocationCoordinate2D(latitude: 35.78030260912687, longitude: 139.7245143723517)
        
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
        
        // ダグラスピューターアルゴリズムを適用して座標を単純化
        let simplifiedCoordinates = douglasPeuckerAlgorithm(points: coordinates, epsilon: 0.0001)
        
        // ViewModelの座標配列を更新
        self.coordinates = simplifiedCoordinates
    }

    func douglasPeuckerAlgorithm(points: [CLLocationCoordinate2D], epsilon: Double) -> [CLLocationCoordinate2D] {
        // ポイントが2つ以下の場合はそのまま返す
        guard points.count > 2 else {
            return points
        }
        
        var maxDistance = 0.0
        var index = 0
        for i in 1..<points.count - 1 {
            let distance = perpendicularDistance(from: points[i], toLineFormedBy: points.first!, and: points.last!)
            if distance > maxDistance {
                index = i
                maxDistance = distance
            }
        }
        
        // 最大距離がepsilonより小さい場合、ポイントを間引く
        if maxDistance < epsilon {
            return [points.first!, points.last!]
        }
        
        // 再帰的に処理
        let leftRecursiveResult = douglasPeuckerAlgorithm(points: Array(points[0...index]), epsilon: epsilon)
        let rightRecursiveResult = douglasPeuckerAlgorithm(points: Array(points[index..<points.count]), epsilon: epsilon)
        
        // 最初と最後のポイントが重複するのを避けるために、右側の結果から最初のポイントを除外して結合
        return leftRecursiveResult + rightRecursiveResult.dropFirst()
    }

    func perpendicularDistance(from point: CLLocationCoordinate2D, toLineFormedBy pointA: CLLocationCoordinate2D, and pointB: CLLocationCoordinate2D) -> Double {
        let A = pointB.latitude - pointA.latitude
        let B = pointA.longitude - pointB.longitude
        let C = pointB.longitude * pointA.latitude - pointA.longitude * pointB.latitude

        // 点 (point.latitude, point.longitude) と直線 Ax + By + C = 0 との距離
        let distance = abs(A * point.longitude + B * point.latitude + C) / sqrt(A * A + B * B)
        return distance
    }


}
