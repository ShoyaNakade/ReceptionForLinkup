//
//  ReceptionView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/10.
//

import SwiftUI

struct ReceptionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = ReceptionViewModel()
    @State var showingConfirm = false
    private let formWidth = UIScreen.main.bounds.width / 2
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack{
                    VStack {
                        Section("入力フォーム") {
                            Stepper("・ご利用人数: \(viewModel.persons)") {
                                viewModel.personsIncrement()
                            } onDecrement: {
                                viewModel.personsDecrement()
                            }.font(.system(size: 32))
                            Divider()
                            Toggle(isOn: $viewModel.isPassport) {
                                Text("・マンスリーパス:")
                                Text( viewModel.isPassport ? "有り":"無し")
                                    .foregroundColor(viewModel.isPassport ? .blue : .primary)
                            }.font(.system(size: 32))
                            Divider()
                            HStack(spacing:10) {
                                Text("・代表者名:")
                                TextField("15文字以内", text: $viewModel.name)
                                    .foregroundColor(.blue)
                                    .padding(5)
                                Spacer()
                            }.font(.system(size: 32))
                                .onChange(of: viewModel.name) { _ in
                                    viewModel.checkButtonActive()
                                }
                            Divider()
                            HStack(spacing:20) {
                                Image(systemName: viewModel.check ? "checkmark.square" : "square")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .leading)
                                    .foregroundColor(.blue)
                                    .opacity(viewModel.check ? 1 : 0.3)
                                Text("利用規約を確認し、同意しました。")
                                    .foregroundColor(.blue)
                            }
                            .padding(.vertical)
                            .font(.system(size: 25))
                            .onTapGesture {
                                viewModel.tapCheckBox()
                            }
                        }
                    }
                    .padding()
                    .frame(width: formWidth, alignment: .leading)
                    .border(Color.gray, width: 1)
                }
                Spacer()
                ReceptionSubmitButtonView(text: "受付送信",color:.green ,
                                          disabled: $viewModel.disabled) {
                    showingConfirm.toggle()
                }
                Spacer()
            }
            VStack {}.frame(height: 10) // for spacer
            ReceptionTermView()
        }
        .sheet(isPresented:$showingConfirm, onDismiss: {}){
            ReceptionConfirmView(persons: viewModel.persons, isPassPort: viewModel.isPassport, name: viewModel.name) {
                viewModel.createNewUser()
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
