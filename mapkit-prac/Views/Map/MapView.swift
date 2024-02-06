//
//  MapView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/05.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion

    //このメソッドは、UIViewRepresentableプロトコルが要求するメソッドの一つで
    //SwiftUIによって呼び出され、表示するUIKitビュー(今回はMKMapView)のインスタンスを作成して返す
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        //地図上にユーザーの現在地を示す青い点を表示する
        mapView.showsUserLocation = true
        //地図上にユーザーの現在地を中心に表示する
        mapView.userTrackingMode = .follow
        return mapView
    }

    //SwiftUIビュー状態が変わり、その変更をUIKitビューに適応する必要がある時に呼び出される
    //
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
    }
}
