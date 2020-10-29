//
//  RecipeModel.swift
//  ChefV3
//
//  Created by Maximilian Klumker on 29.10.20.
//

import Foundation

struct Recipe: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let image: String
    let ingredients: Array<Any>
}
    
//    init(title: String, image: URL, ingredients: Array) {
//        self.ref = nil
//        self.key = key
//        self.title = title
//        self.image = image
//        self.ingredients = ingredients
//        self.id = key
//    }
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let title = value["title"] as? String,
//            let image = value["image"] as? URL,
//            let ingredients = value["ingredients"] as? Array
//        else {
//            return nil
//        }
//        self.ref = snapshot.ref
//        self.key = snapshot.key
//        self.title = title
//        self.image = image
//        self.ingredients = ingredients
//        self.id = snapshot.key
//    }
//
//    func toAnyObject() -> Any {
//        return [
//            "title": title,
//            "image": image,
//            "ingredients": ingredients,
//        ]
//    }
//}
//
//
//func listen() {
//
//}
