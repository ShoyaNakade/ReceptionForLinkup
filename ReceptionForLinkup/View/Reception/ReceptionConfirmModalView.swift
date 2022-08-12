//
//  ReceptionConfirmView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import SwiftUI

struct ReceptionConfirmView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private let mPersons:Int
    private let mPassport: Bool
    private let mName: String
    let onSubmit:() -> Void
    
    init(persons: Int, isPassPort: Bool, name: String ,onSubmit: @escaping ()-> Void) {
        self.mPersons = persons
        self.mPassport = isPassPort
        self.mName = name
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
                    Text("\(mPersons)")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("・マンスリーパス:")
                    Spacer()
                    Text(mPassport ? "有り" : "無し")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("・代表者名:")
                    Spacer()
                    Text(mName)
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("・受付時間:")
                    Spacer()
                    Text(nowTimeToString())
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

struct ReceptionConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ReceptionConfirmView(persons: 1, isPassPort: false, name: "testuser"){}
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
