//
//  MapView.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/05.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @Binding var route: MKRoute? //Viewでユーザーが選択権を持つために一応Binding
//    @ObservedObject var locationManager = LocationViewModel()
    
    //このメソッドは、UIViewRepresentableプロトコルが要求するメソッドの一つで
    //SwiftUIによって呼び出され、表示するUIKitビュー(今回はMKMapView)のインスタンスを作成して返す
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        //地図上にユーザーの現在地を示す青い点を表示する
        mapView.showsUserLocation = true
        //地図上にユーザーの現在地を中心に表示する
        mapView.userTrackingMode = .follow
        return mapView
    }

    //SwiftUIビュー状態が変わり、その変更をUIKitビューに適応する必要がある時に呼び出される
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if let route = route{
            mapView.addOverlay(route.polyline) //経路のポリラインをマップに追加
            mapView.setVisibleMapRect(route.polyline.boundingMapRect,animated:true) //経路が収まるようにマップビューの表示範囲を調整
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView){
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = .blue //経路の色
                renderer.lineWidth = 4.0 //経路の線の太さ
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

#Preview {
    MapView(route: .constant(nil))
}
