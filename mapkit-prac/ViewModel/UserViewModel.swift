//
//  UserViewModel.swift
//  mapkit-prac
//
//  Created by 金澤帆高 on 2024/02/07.
//

import Firebase
import FirebaseFirestore

class UserViewModel: ObservableObject {
    private var db = Firestore.firestore()

    func saveUser(name: String, completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("users").document()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let email = Auth.auth().currentUser?.email else {return}
        let user = User(id: uid, email: email, createdAt: Timestamp())
        
        docRef.setData([
            "id": user.id,
            "name": user.email,
            "createdAt": user.createdAt
        ]) { error in
            completion(error)
        }
    }
}
