//
//  SubmitButton.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import SwiftUI

struct SubmitButton: View {
    let text:String
    let paddingWidth:CGFloat
    let paddingHeight:CGFloat
    let color: Color
    let onAction: () -> Void

    init(text: String, color: Color,
         onAction: @escaping() -> Void) {
        self.text = text
        self.color = color
        self.paddingWidth = 50
        self.paddingHeight = 30
        self.onAction = onAction
    }
    init(text: String, color: Color, width: CGFloat, height: CGFloat,
         onAction: @escaping() -> Void) {
        self.text = text
        self.color = color
        self.paddingWidth = width
        self.paddingHeight = height
        self.onAction = onAction
    }
    
    var body: some View {
        Button {
            onAction()
        } label: {
            Text(text)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: paddingHeight, leading: paddingWidth, bottom: paddingHeight, trailing: paddingWidth))
                .background(color)
                .cornerRadius(20)
        }
        .compositingGroup()  // Viewの要素をグループ化
        .shadow(color: .secondary, radius: 3)
    }
}

struct SubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButton(text:"送信", color: .blue) {
            
        }
    }
}
