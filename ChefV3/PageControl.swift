//
//  PageControl.swift
//  Chef V2
//
//  Created by Lewis Wall on 17.09.20.
//

import Foundation
import UIKit
import SwiftUI

struct PageControl: UIViewRepresentable {

var numberOfPages: Int
    
    @Binding var currentPageIndex: Int
    
    func makeUIView(context: Context) -> UIPageControl {
           let control = UIPageControl()
               control.numberOfPages = numberOfPages
               control.currentPageIndicatorTintColor = UIColor.orange
               control.pageIndicatorTintColor = UIColor.gray

        return control }
        
        func updateUIView(_ uiView: UIPageControl, context: Context) {
                uiView.currentPage = currentPageIndex
            
            
        }

    }


