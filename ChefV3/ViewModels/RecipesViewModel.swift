//
//  RecipesViewModel.swift
//  ChefV3
//
//  Created by Maximilian Klumker on 29.10.20.
//

import Foundation
import FirebaseFirestore

class RecipesViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("recipes").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.recipes = documents.map { (queryDocumentSnapshot) -> Recipe in
                let data = queryDocumentSnapshot.data()
                
                let title = data["title"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let ingredients = data["ingredients"] as? Array<Any> ?? ""
                
                return Recipe(title: title, image: image, ingredients: ingredients)
            }
        }
    }
}

