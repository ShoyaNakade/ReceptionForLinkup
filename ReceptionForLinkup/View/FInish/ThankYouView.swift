//
//  ThankYouView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import SwiftUI

struct ThankYouView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let onConfirm: () -> Void
    
    init(onConfirm: @escaping () -> Void) {
        self.onConfirm = onConfirm
    }
    
    var body: some View {
        VStack(spacing:50) {
            Text("ありがとうございました！\nまたのご利用をお待ちしています")
                .font(.largeTitle)
                .id("thank_text")
            SubmitButton(text: "完了", color: .green) {
                presentationMode.wrappedValue.dismiss()
                onConfirm()
            }
        }.padding(30)
    }
}

struct ThankYouView_Previews: PreviewProvider {
    static var previews: some View {
        ThankYouView(){}.previewInterfaceOrientation(.landscapeLeft)
    }
}
