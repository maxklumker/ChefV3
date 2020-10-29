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
//    @State var recipes = recipeData
    @State var active = false
    @State var activeIndex = -1
    
    var body: some View {
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


struct RecipeView: View {
    @Binding var show: Bool
    var recipe: Recipe
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    
    var body: some View {
        ZStack (alignment: .top) {
            VStack (alignment: .leading, spacing: 30) {
                HStack {
                    VStack (alignment: .leading) {
                        
                        Text("Ingredients").font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color.black)
                        
                        HStack {
                            Text("serving 2 adults")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(Color.black)
                            Text("30 min")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(Color.black)
                                .offset(x: -5)
                        }
                    }
                    Spacer()
                    
                    //Go Button
                    ZStack {
                        Circle()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.blue)
                            .clipShape(Circle())
                        Text("GO")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.white)
                            .padding()
                    }
                }
                ForEach(0 ..< 5) { item in
                    VStack (alignment: .leading) {
                        HStack (spacing: 12) {
                            
                            //Ingredient Circle
                            Circle()
                                .frame(width: 58, height: 58)
                                .foregroundColor(.clear)
                                .overlay(Circle()
                                            .stroke(Color(.black).opacity(0.15), lineWidth: 2))
                                .padding(.leading)
                            
                            VStack (alignment: .leading, spacing: 1) {
                                Text("Ingredient name")
                                    .font(.system(size: 24, weight : .bold))
                                    .foregroundColor(.black)
                                
                                HStack {
                                    Text("1 medium")
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundColor(.black)
                                    Text("300 gramm")
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundColor(Color(.black).opacity(0.15))
                                }
                                .padding(.trailing)
                            }
                        }
                        .padding(.horizontal, -20)
                    }
                }
            }
            .padding(.horizontal, 7)
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 41, maxHeight: show ? .infinity : 334, alignment: .top)
            .offset(y: show ? 400 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            
            ZStack {
                VStack {
                    HStack (alignment: .top) {
                        Text(recipe.title)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 280, alignment: .leading)
                            .foregroundColor(.white)
                        
                        Spacer()
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black.opacity(0.4))
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                        .offset(x: 10, y: -40)
                        .onTapGesture{
                            self.show.toggle()
                        }
                    }
                    .padding(.leading, show ? 0 : 25)
                    Spacer()
                }
                .padding(.top, show ? 60 : 20)
                .padding(.horizontal, show ? 30 : 16)
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(1)]), startPoint: .bottom, endPoint: .top))
                    .frame(width: show ? .infinity : screen.width - 41, height: show ? 400 : 334)
                    .offset(y: -216)
                    .cornerRadius(show ? 0 : 10)
                
                Spacer()
            }
            .frame(maxWidth: show ? .infinity : screen.width - 41, maxHeight: show ? 400 : 334)
            .background(url: URL(string: recipe.image)!
                            .resizable()
                            .offset(y: 30)
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity))
            .clipShape(RoundedRectangle(cornerRadius: show ? 0 : 10, style: .continuous))
            .shadow(color: show ? Color(.black).opacity(0.001) : Color(.black).opacity(0.15), radius: 20, x: 0, y: 20)
            .contentShape(Rectangle())
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
        }
        .frame(height: show ? screen.height : 334)
        .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

//struct Recipe: Identifiable {
//    var id = UUID()
//    var title: String
//    var image: URL
//    var serving: String
//    var time: String
//    var show: Bool
//}
//
//var recipeData = [
//    Recipe(title: "pea soup with walnut pesto", image: URL(string: "https://dl.dropbox.com/s/x0cpo32qwroxjf8/01_cover_pea_soup_detail_large.jpg?dl=0")!, serving: "serving 2 adults ・", time: "30 min", show: false),
//    Recipe(title: "plant-based Moussaka", image: URL(string: "https://dl.dropbox.com/s/2vrhqpapqqpmii2/02_cover_moussaka_large.jpg?dl=0")!, serving: "serving 2 adults ・", time: "30 min", show: false),
//    Recipe(title: "mint basil pesto", image: URL(string: "https://dl.dropbox.com/s/ap3buf4qkxin7wn/03_cover_mint_basil_pesto_detail_large.png?dl=0")!, serving: "serving 2 adults ・", time: "30 min", show: false)
//]


class getRecipesData : ObservableObject{
    
    @Published var datas = [Recipe]()

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
                let ingredients = i.document.get("ingredients") as! Array<Any>
                
                self.datas.append(Recipe(id: id, title: title, image: image, ingredients: ingredients))
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
