//
//  User.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/07.
//

import FirebaseFirestore

struct User {
    var id: String
    var email: String
    var createdAt: Timestamp
}

struct Post {
    var postId: String
    var userId: DocumentReference // ユーザーへのリファレンス
    var createdAt: Timestamp
    var content: String
    var latitude : Double
    var longitude : Double
}

