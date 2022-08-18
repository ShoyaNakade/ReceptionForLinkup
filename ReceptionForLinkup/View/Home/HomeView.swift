//
//  HomeView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/10.
//

import SwiftUI

struct HomeView<Repository: UserRepositoryProtocol>: View {
    @ObservedObject var userRepository:Repository
    private let spacing = UIScreen.main.bounds.height / 10
    
    init(repository: Repository) {
        userRepository = repository
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack(alignment:.bottomTrailing) {
                    VStack(spacing:spacing) {
                        Text("test")
                            .font(.body)
                        HomeTopHeader(personNum: $userRepository.beingUsersNum)
                        HStack(alignment: .center, spacing: 100){
                            HomeViewButton(text: "受付", color: .blue) {
                                ReceptionView()
                            }
                            HomeViewButton(text: "確認・終了", color: .red) {
                                FinishListView()
                            }
                        }
                    }
                    NavigationLink {
                        HistoryListView()
                    } label: {
                        Text("管理者専用")
                    }.offset(x: 0, y: 100)
                        .padding(20)
                        .foregroundColor(.gray)
                }
                .offset(x: 0, y: -50) // NavigationView分
                Image("wideBanner")
                    .resizable()
                    .opacity(0.15)
                    .edgesIgnoringSafeArea(.all).zIndex(-1)
            }
        }
        .navigationViewStyle(.stack) //ipadの分割を阻止
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(repository: UserRepositoryStub())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
