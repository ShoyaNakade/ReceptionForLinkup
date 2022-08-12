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
    @ObservedObject var viewModel: ChangeUserInfoViewModel
    
    init(currentUser: User) {
        viewModel = ChangeUserInfoViewModel(currentUser: currentUser)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("-----  変更モード  -----")
                .font(.largeTitle)
                .fontWeight(.bold)
           
            List{
                Stepper("・ご利用人数: \(viewModel.mPersons)") {
                    viewModel.personsIncrement()
                } onDecrement: {
                    viewModel.personsDecrement()
                }
                HStack {
                    Text("・マンスリーパス:")
                    Spacer()
                    Toggle(isOn: $viewModel.mPass) {
                        Text( viewModel.mPass ? "有り":"無し")
                            .foregroundColor(.blue)
                    }
                }
                HStack {
                    Text("・代表者名:")
                    Spacer()
                    TextField("代表", text: $viewModel.mName)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(TextAlignment.trailing)
                }
                HStack {
                    DatePicker("・受付時間:", selection: $viewModel.mInTime, displayedComponents: .hourAndMinute)
                }
            }
            .frame(width: 400, height: 250, alignment: .leading)
            Spacer()
            HStack {
                Spacer()
                Spacer()
                SubmitButton(text: "変更", color: .blue) {
                    viewModel.currentUserReload()
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
