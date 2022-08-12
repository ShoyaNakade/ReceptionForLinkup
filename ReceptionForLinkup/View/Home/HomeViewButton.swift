//
//  HomeViewButton.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/10.
//

import SwiftUI

struct HomeViewButton<Content: View>: View {
    let text:String
    var personsNum = 1
    let paddingWidth = UIScreen.main.bounds.width / 2.4
    let paddingHeight = UIScreen.main.bounds.height / 2.5
    let color: Color
    let destination: Content
    
    init(text: String, color: Color,
        @ViewBuilder destination: () -> Content) {
        self.text = text
        self.color = color
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text(text)
                .fontWeight(.bold)
                .font(.system(size: 70))
                .foregroundColor(Color.white)
                .frame(width: paddingWidth, height: paddingHeight, alignment: .center)
                .background(color)
                .cornerRadius(80)
        }
        .compositingGroup()  // Viewの要素をグループ化
        .shadow(color: .secondary, radius: 8)
    }
}



struct HomeVIewButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewButton(text: "test", color: .red) {
            HomeView()
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
