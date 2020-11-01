//
//  RecipeListView.swift
//  ChefV3
//
//  Created by Maximilian Klumker on 28.10.20.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct RecipeListView: View {
    @State var recipes = recipeData
    @State var active = false
    @State var activeIndex = -1
//    @ObservedObject var recipes2 = getRecipesData()
    
    var body: some View {
//        if self.recipes2.datas.count != 0 {
            
            ZStack {
                Color.black.opacity(active ? 0.5 : 0)
                    .animation(.linear)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                ScrollView {
                    
                    VStack (spacing: 30) {
                        Text("Recipes")
                            .font(.largeTitle).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 21)
                            .padding(.top, 30)
                            .blur(radius: active ? 20 : 0)
                        
                        ForEach(recipes.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                RecipeView(
                                    show: self.$recipes[index].show,
                                    recipe: self.recipes[index],
                                    active: self.$active,
                                    index: index,
                                    activeIndex: self.$activeIndex
                                )
                                .offset(y: self.recipes[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.9 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                                
                            }
                            .frame(height: 334)
                            .frame(maxWidth: self.recipes[index].show ? .infinity : screen.width - 41)
                            .padding(.bottom, 20)
                            .zIndex(self.recipes[index].show ? 1 : 0)
                        }
                    }
                    .frame(width: screen.width)
                    .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0))
                }
            }
            .statusBar(hidden: active ? true : false)
            .animation(.linear)
        }
    }
//}



struct Recipe: Identifiable {
    var id = UUID()
    var title: String
    var image: UIImage
    var serving: String
    var time: String
    var show: Bool
}

var recipeData = [
    Recipe(title: "Pea Soup with Walnut Pesto", image: #imageLiteral(resourceName: "01_cover_pea_soup_detail_small_"), serving: "serving 2 adults ・", time: "30 min", show: false),
    Recipe(title: "Plant-Based Moussaka", image:  #imageLiteral(resourceName: "02_cover_moussaka_detail_small"), serving: "serving 2 adults ・", time: "30 min", show: false),
    Recipe(title: "Mint Basil Pesto", image: #imageLiteral(resourceName: "03_cover_basil_pesto_detail_small"), serving: "serving 2 adults ・", time: "30 min", show: false)
]


class getRecipesData : ObservableObject {
    
    @Published var datas = [Recipe2]()
    
    init() {
        
        let db = Firestore.firestore()
        db.collection("recipes").addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                let id = i.document.documentID
                let title = i.document.get("title") as! String
                let image = i.document.get("image") as! String
                //                let ingredients = i.document.get("ingredients") as! Array<Any>
                
                self.datas.append(Recipe2(title: title, image: image))
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
