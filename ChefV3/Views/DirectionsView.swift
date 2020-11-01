//
//  DirectionsView.swift
//  Chef V2
//
//  Created by Lewis Wall on 17.09.20.
//

import SwiftUI

struct DirectionsView: View {
    
    @State var show = false
    
    var subviews = [
    UIHostingController(rootView:
        Subview(imageString: "05_directions_step1")),
    UIHostingController(rootView:
        Subview(imageString: "05_directions_step2")),
    UIHostingController(rootView:
        Subview(imageString: "05_directions_step3")),
    UIHostingController(rootView:
        Subview(imageString: "05_directions_step4")),
    UIHostingController(rootView:
        Subview(imageString: "05_directions_step5")),
    UIHostingController(rootView:
        Subview(imageString: "05_directions_step6")),
    UIHostingController(rootView:
        Subview(imageString: "05_directions_step7")),
    UIHostingController(rootView:
        Subview(imageString: "05_directions_step8"))
    ]
    
    var titles =
    ["Cut open your tofu package, drain the excess water and wrap the tofu in a towel.",
     "Press out the water by hand or by placing a heavy object on top for at least 10 minutes. Be careful not to squash the tofu.",
     "Place the tofu back in its container and freeze for at least 6 hours or overnight.",
     "In a food processor, add the garlic and 1 1/2 cups (38g) of the basil leaves.",
    "Strip the mint leaves from the stem and add the leaves to the blender, then add the stem to the boiling water.",
    "Remove thyme leaves from 2 branches and add them to the food processor, throw the stems into the boiling water.",
    "Add the 3 tablespoons of nutritional yeast (15g),  2 tablespoons of breadcrumbs (25g) and 1 cup of olive oil (125 ml).",
    "With the blender on, slowly stream in 6 tablespoons of the cold water until the sauce blends smoothly."]
    
    @State var currentPageIndex = 0
    
    var body: some View {
        
        
    
        ScrollView {
        ZStack(alignment: .topTrailing) {

            
            
            PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                .frame(height: 500)
                .offset(y: -32)
                
            
            Button(action: {
                
                // dismissing the expand view...
                
                withAnimation{
                    
                    self.show.toggle()
                }
                
            }) {
                
                Image(systemName: "xmark")
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray.opacity(0.7))
                    .clipShape(Circle())
                    .offset(y: 20)
            }
            .padding(.trailing)
        }
            
            Group {
                VStack(alignment: .leading) {
                Text(titles[currentPageIndex])
                    .font(.system(size: 29, weight:.medium))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 19)
                    .padding(.trailing, 19)
                    
                    
//                    .navigationBarTitle("")
//                            .navigationBarHidden(true)

                }
                .offset(y: -50)
             }
          }
        .statusBar(hidden: true)
        .edgesIgnoringSafeArea(.all)
            
      Spacer()
                
    }
    
}




struct DirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsView()
       
    }
  }
 
