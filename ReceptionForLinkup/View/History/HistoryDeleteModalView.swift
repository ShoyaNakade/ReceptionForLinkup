//
//  HistoryDeleteModalView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import SwiftUI

struct HistoryDeleteModalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let onDelete:() -> Void
    
    init(onDelete: @escaping ()-> Void) {
        self.onDelete = onDelete
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("現在利用中のユーザーも含めた履歴全て削除されます。？\nよろしいですか？")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack {
                Spacer()
                Spacer()
                SubmitButton(text: "削除する", color: .red) {
                    onDelete()
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                SubmitButton(text: "キャンセル", color: .blue) {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct HistoryDeleteModalView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDeleteModalView(){}
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
