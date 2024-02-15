//
//  LocationManager.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/13.
//

import Foundation
import CoreLocation
import MapKit

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation?
    @Published var isUsingWorldTracking: Bool = false
    @Published var route: MKRoute? //ViewModel内でまずは結果を保持(ロジックについてはExtension)更新をViewに自動通知するように
    @Published var coordinates = [CLLocationCoordinate2D](){ //ルートの座標を保持
        didSet {
            print("デバッグ: coordinatesが更新")
            let address = Unmanaged.passUnretained(self).toOpaque()
            print("LocationViewModelのインスタンスアドレス: \(address)")
            for coordinate in coordinates {
                print("緯度: \(coordinate.latitude), 経度: \(coordinate.longitude)")
                
            }
        }
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    //ユーザーのデバイスの位置情報を更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.currentLocation = location
    }
    
    //エラーが出た時
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func toggleSessionType() {
        isUsingWorldTracking.toggle()
        print("デバック: isUsingWorldTrackingが更新")
    }
    
    
}
