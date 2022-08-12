//
//  ReceptionView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/10.
//

import SwiftUI

struct ReceptionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var userRepository = UserRepository()
    @State var persons = 1
    @State var isPassport: Bool = false
    @State var name: String = ""
    @State var check = false
    @State var showingConfirm = false
    @State var disabled = true
    
    let formWidth = UIScreen.main.bounds.width / 2
//    let termHeight = UIScreen.main.bounds.height / 2.6
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack{
                    VStack {
                        Section("入力フォーム") {
//                            Stepper("・ご利用人数: \(persons)") {
                            Stepper("・ご利用人数: \(persons)") {
                                persons += 1
                            } onDecrement: {
                                if persons > 1 {persons -= 1}
                            }.font(.system(size: 32))
                            Divider()
                            Toggle(isOn: $isPassport) {
                                Text("・マンスリーパス:")
                                Text( isPassport ? "有り":"無し")
                                    .foregroundColor(isPassport ? .blue : .primary)
                            }.font(.system(size: 32))
                            Divider()
                            HStack(spacing:10) {
                                Text("・代表者名:")
                                TextField("15文字以内", text: $name)
                                    .foregroundColor(.blue)
                                    .padding(5)
                                Spacer()
                            }.font(.system(size: 32))
                                .onChange(of: name) { _ in
                                    if check && !name.isEmpty {
                                        disabled = false
                                    } else {
                                        disabled = true
                                    }
                                }
                            Divider()
                            
                            HStack(spacing:20) {
                                Image(systemName: check
                                      ? "checkmark.square"
                                      : "square")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .leading)
                                .foregroundColor(.blue)
                                .opacity(check ? 1 : 0.3)
                                Text("利用規約を確認し、同意しました。")
                                    .foregroundColor(.blue)
                            }
                            .padding(.vertical)
                            .font(.system(size: 25))
                            .onTapGesture {
                                check.toggle()
                                if check && !name.isEmpty {
                                    disabled = false
                                } else {
                                    disabled = true
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(width: formWidth, alignment: .leading)
                    .border(Color.gray, width: 1)

                }
                Spacer()
                ReceptionSubmitButtonView(text: "受付送信",color:.green ,disabled: $disabled) {
                    showingConfirm.toggle()
                }
                Spacer()
            }
            VStack {}.frame(height: 10) // for spacer
            ReceptionTermView()
        }
        .sheet(isPresented:$showingConfirm, onDismiss: {}){
            ReceptionConfirmModalView(currentUser: User(userName: name, persons: persons, isPassUser: isPassport)) {
                userRepository.createUser(userName: name, persons: persons, isPassUser: isPassport)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ReceptionView_Previews: PreviewProvider {
    static var previews: some View {
        ReceptionView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
