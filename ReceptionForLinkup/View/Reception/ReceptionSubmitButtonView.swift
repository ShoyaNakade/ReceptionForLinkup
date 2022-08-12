//
//  ReceptionSubmitButtonView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import SwiftUI

struct ReceptionSubmitButtonView: View {
    let text:String
    var personsNum = 1
    let paddingWidth = UIScreen.main.bounds.width / 3.2
    let paddingHeight = UIScreen.main.bounds.height / 3
    let color: Color
    let onAction: () -> Void
    @Binding var disabled:Bool
    
    init(text: String, color: Color, disabled: Binding<Bool>,
         onAction: @escaping() -> Void) {
        self.text = text
        self.color = color
        self._disabled = disabled
        self.onAction = onAction
    }
    
    var body: some View {
        Button {
            onAction()
        } label: {
            Text(text)
                .fontWeight(.bold)
                .font(.system(size: 70))
                .foregroundColor(Color.white)
                .frame(width: paddingWidth, height: paddingHeight, alignment: .center)
                .background( disabled ? .gray : color)
                .cornerRadius(80)
        }.disabled(disabled)
        .compositingGroup()  // Viewの要素をグループ化
        .shadow(color: .secondary, radius: 8)
    }
}

struct ReceptionSubmitButtonView_Previews: PreviewProvider {
    @State static var disabled = true
    static var previews: some View {
        ReceptionSubmitButtonView(text: "受付送信", color: .blue, disabled: $disabled){
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
