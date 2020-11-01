//
//  RecipesViewModel.swift
//  ChefV3
//
//  Created by Maximilian Klumker on 29.10.20.
//

import Foundation
import FirebaseFirestore

class RecipesViewModel: ObservableObject {
    @Published var recipes2 = [Recipe2]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("recipes").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.recipes2 = documents.map { (queryDocumentSnapshot) -> Recipe2 in
                let data = queryDocumentSnapshot.data()
                
                let title = data["title"] as? String ?? ""
                let image = data["image"] as? String ?? ""
//                let ingredients = data["ingredients"] as? Array<Any> ?? ""
                
                return Recipe2(title: title, image: image)
            }
        }
    }
}

