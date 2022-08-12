//
//  ReceptionConfirmModalView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import SwiftUI

struct ReceptionConfirmModalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let currentUser: User
    let onSubmit:() -> Void
    
    init(currentUser: User,onSubmit: @escaping ()-> Void) {
        self.currentUser = currentUser
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("-----  受付確認  -----")
                .font(.largeTitle)
                .fontWeight(.bold)
           
            List{
                HStack {
                    Text("・ご利用人数:")
                    Spacer()
                    Text("\(currentUser.persons)")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("・マンスリーパス:")
                    Spacer()
                    Text(currentUser.isPassUser ? "有り" : "無し")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("・代表者名:")
                    Spacer()
                    Text(currentUser.userName)
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("・受付時間:")
                    Spacer()
                    Text(currentUser.inTimeToString())
                        .foregroundColor(.blue)
                }
            }
            .frame(width: 400, height: 250, alignment: .leading)
            Spacer()
            HStack {
                Spacer()
                Spacer()
                SubmitButton(text: "送信", color: .blue) {
                    presentationMode.wrappedValue.dismiss()
                    playSound(sound: "chimeup", type: "mp3")
                    onSubmit()
                }
                Spacer()
                SubmitButton(text: "キャンセル", color: .red) {
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

struct ReceptionConfirmModalView_Previews: PreviewProvider {
    static var previews: some View {
        ReceptionConfirmModalView(currentUser: User()){}
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
