//
//  HistoryListView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/10.
//

import SwiftUI

struct HistoryListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var userRepository = UserRepository()
    
    @State var showDeleteConfirm:Bool = false
    @State var showCSVNotification: Bool = false
    @State var isDeleteing = false // Alldeleteするときに,一旦viewから消す用
    
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
            .listRowBackground(Color.red)
            .padding()

            if !isDeleteing { //消すアクションの前に、UIから消す
                ForEach(userRepository.finishUsers) { user in
                    HStack {
                        HStack {
                            if user.isPassUser {
                                Image(systemName: "person.fill.checkmark").foregroundColor(.blue)
                            }
                            Text(user.userName)
                                .fontWeight(.bold)
                        }.modifier(columnModifer(width:230))
                        Spacer()
                        Text("\(user.persons)")
                            .modifier(columnModifer())
                        Spacer()
                        Text("\(user.inTimeToString())")
                            .modifier(columnModifer())
                        Spacer()
                        Text("\(user.useTime())分") 
                            .modifier(columnModifer())
                        Spacer()
                        Text("¥\(user.payment())")
                            .modifier(columnModifer())
                    }.padding(.vertical).foregroundColor(.primary)
                }
                .onDelete(perform: { indexset in
                    userRepository.deleteUserWithIndexset(indexset: indexset)
                })
            }else {
                Text("削除モード中...")
                    .foregroundColor(.gray)
                    .padding(.vertical)
            }
        }
        .onAppear{ isDeleteing = false  } //念の為
        .navigationBarTitle("精算済み利用者: \(userRepository.finishUsersNum)",displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Button {
                    CSVCreator().createCSV()
                    showCSVNotification.toggle()
                } label: {
                    Text("CSV出力")
                }
                Button {
                    isDeleteing = true
                    showDeleteConfirm.toggle()
                } label: {
                    Text("全削除")
                        .foregroundColor(.red)
                }
                EditButton()
            }
        )
        .sheet(isPresented: $showDeleteConfirm,
               onDismiss: { isDeleteing = false}) {
            HistoryDeleteModalView {
                userRepository.deleteAllUsers()
            }
        }
        .sheet(isPresented: $showCSVNotification){
            HistoryCSVConfirmView(showCSVNotification: $showCSVNotification)
        }
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryListView()
        }.navigationViewStyle(.stack)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
