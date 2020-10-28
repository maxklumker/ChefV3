//
//  ContentView.swift
//  ChefV3
//
//  Created by Maximilian Klumker on 28.10.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RecipeListView()
    }
}

let screen = UIScreen.main.bounds

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
