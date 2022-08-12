//
//  FinishConfirmModalView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import SwiftUI

struct FinishConfirmView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showThank: Bool = false
    let currentUser: User
    let currentOutDate = Date()
    let backToHome: () -> Void
    let onChange: (_ outTime:Date) -> Void
    
    
    init(currentUser: User, backToHome: @escaping() -> Void, onChange: @escaping (_ outTime:Date)-> Void){
        self.currentUser = currentUser
        self.backToHome = backToHome
        self.onChange = onChange
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(currentUser.userName)さんご利用ありがとうございました！\nご確認の上、精算をお願いいたします。")
                .font(.largeTitle)

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
                HStack {
                    Text("・ご利用時間")
                    Spacer()
                    Text("\(currentUser.estimatedUseTime(now: currentOutDate))分")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("・ご利用料金")
                    Spacer()
                    Text("¥\(currentUser.estimatedPayment(now: currentOutDate))")
                        .foregroundColor(.blue)
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                }
            }
            .frame(width: 400, height: 350, alignment: .leading)
            Spacer()
            HStack {
                Spacer()
                Spacer()
                SubmitButton(text: "精算", color: .blue) {
                    onChange(currentOutDate) // listviewからhomへ
                    showThank.toggle()
                    playSound(sound: "success", type: "m4a")
                    print("ok paid! \(currentOutDate) ")
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
        .sheet(isPresented: $showThank) {
            ThankYouView {
                while presentationMode.wrappedValue.isPresented {
                    presentationMode.wrappedValue.dismiss() //Finish confirmmodalの削除
                }
                backToHome()
            }
        }
    }
}

struct FinishConfirmModalView_Previews: PreviewProvider {
    static var previews: some View {
        FinishConfirmView(currentUser: User(),backToHome: {}){outTime in }
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
