//
//  LocationViewMode.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/10.
//

import CoreLocation

// 東京駅と東京スカイツリーの緯度経度
let tokyoStation = CLLocation(latitude: 35.681236, longitude: 139.767125)
let skytree = CLLocation(latitude: 35.710063, longitude: 139.8107)

// 緯度と経度の差を計算
let latDelta = skytree.coordinate.latitude - tokyoStation.coordinate.latitude
let lonDelta = skytree.coordinate.longitude - tokyoStation.coordinate.longitude

// 緯度差と経度差をメートルに変換
let latDistance = latDelta * 111000 // 緯度1度あたり約111,000m
let averageLat = (tokyoStation.coordinate.latitude + skytree.coordinate.latitude) / 2
let lonDistance = lonDelta * cos(averageLat * .pi / 180) * 111000

//print("北(または南)に\(latDistance)メートル")
//print("東(または西)に\(lonDistance)メートル")
