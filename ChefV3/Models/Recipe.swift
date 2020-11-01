//
//  RecipeModel.swift
//  ChefV3
//
//  Created by Maximilian Klumker on 29.10.20.
//

import Foundation

struct Recipe2: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let image: String
//    let ingredients: Array<Any>
}

