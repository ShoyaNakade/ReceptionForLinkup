//
//  ChangeTimeView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import SwiftUI
import RealmSwift

struct ChangeUserInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var mCurrentUser: User
    
    @State private var mPersons:Int
    @State var mPass:Bool
    @State var mName:String
    @State var mInTime:Date
    
    private func currentUserReload() {
        let realm = try! Realm()
        try! realm.write {//この時点でDに反映される。
            mCurrentUser.persons = mPersons
            mCurrentUser.isPassUser = mPass
            mCurrentUser.userName = mName
            mCurrentUser.inTime = mInTime
        }
    }
    
    init(currentUser: User) {
        self.mCurrentUser = currentUser
        self._mPersons = State(initialValue: currentUser.persons)
        self._mPass = State(initialValue:currentUser.isPassUser)
        self._mName = State(initialValue:currentUser.userName)
        self._mInTime = State(initialValue:currentUser.inTime)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("-----  変更モード  -----")
                .font(.largeTitle)
                .fontWeight(.bold)
           
            List{
                Stepper("・ご利用人数: \(mPersons)") {
                    mPersons += 1
                } onDecrement: {
                    if mPersons > 1 { mPersons -= 1}
                }
                HStack {
                    Text("・マンスリーパス:")
                    Spacer()
                    Toggle(isOn: $mPass) {
                        Text( mPass ? "有り":"無し")
                            .foregroundColor(.blue)
                    }
                }
                HStack {
                    Text("・代表者名:")
                    Spacer()
                    TextField("代表", text: $mName)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(TextAlignment.trailing)
                }
                HStack {
                    DatePicker("・受付時間:", selection: $mInTime, displayedComponents: .hourAndMinute)
                }
            }
            .frame(width: 400, height: 250, alignment: .leading)
            Spacer()
            HStack {
                Spacer()
                Spacer()
                SubmitButton(text: "変更", color: .blue) {
                    currentUserReload()
                    presentationMode.wrappedValue.dismiss()
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
        .navigationTitle("管理者専用")
        .padding()
    }
        
}

struct ChangeTimeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChangeUserInfoView(currentUser: User())
        }.navigationViewStyle(.stack)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
