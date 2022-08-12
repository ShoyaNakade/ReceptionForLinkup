//
//  FinishListView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/10.
//

import SwiftUI

struct FinishListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var userRepository = UserRepository()
    @State var showingConfirm: Bool = false
    @State var isEditTimeMode: Bool = false
    @State var tapUser = User()
    @State var currentDate = Date()
    @State var timer :Timer?

    var body: some View {
        List {
            HStack {
                Text("名前")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .modifier(columnModifer(width:230))
                Spacer()
                Text("人数")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .modifier(columnModifer())
                Spacer()
                Text("受付時間")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .modifier(columnModifer())
                Spacer()
                Text("ご利用時間")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .modifier(columnModifer())
                Spacer()
                Text("　料金")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .modifier(columnModifer())
            }
            .listRowBackground(Color.blue)
            .padding()
            ForEach(userRepository.beingUsers, id:\.self) { user in
                HStack {
                    Button {
                        // todo
                        showingConfirm.toggle()
                        tapUser = user
                    } label: {
                        HStack {
                            HStack {
                                if user.isPassUser {
                                    Image(systemName: "person.fill.checkmark").foregroundColor(.blue)
                                }
                                Text(user.userName)
                                    .fontWeight(.bold)           
                            }.modifier(columnModifer(width:230))
                            Spacer()
                            Text("\(user.persons)人")
                                .modifier(columnModifer())
                            Spacer()
                            Text(user.inTimeToString())
                                .modifier(columnModifer())
                            Spacer()
                            Text("\(user.estimatedUseTime(now: currentDate))分")
                                .modifier(columnModifer())
                            Spacer()
                            Text("¥\(user.estimatedPayment(now: currentDate))")
                                .modifier(columnModifer())
                        }
                    }
//                    .buttonStyle(BorderlessButtonStyle())
                    .disabled(isEditTimeMode)
                    .padding(.vertical)
                    .foregroundColor(.primary)
                    if isEditTimeMode {
                        Spacer()
                        NavigationLink {
                            ChangeUserInfoView(currentUser: user)
                        } label: {
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundColor(.red)
                                .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
        }
        .navigationBarTitle("只今の利用者数 \(userRepository.beingUsersNum)",displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Image(systemName: "pencil.circle")
                Text("変更モード(長押し)")
            }.foregroundColor(.red).onLongPressGesture {
                isEditTimeMode.toggle()
            }
        )
        .sheet(isPresented:$showingConfirm, onDismiss: {}){
            FinishConfirmModalView(currentUser: self.tapUser,
                                   backToHome: { presentationMode.wrappedValue.dismiss()}) { outTime in
                userRepository.writeOutTime(user: self.tapUser, outTime: outTime)
            }
        }
        .onAppear(perform: {
            isEditTimeMode = false
            self.timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { _ in
                self.currentDate = Date()
                print(currentDate)
            }
        })
    }
}

struct FinishListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FinishConfirmModalView(currentUser: User(),backToHome: {}){outTime in }
        }.navigationViewStyle(.stack)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
