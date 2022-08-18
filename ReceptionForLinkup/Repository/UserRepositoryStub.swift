//
//  UserRepositoryStub.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/18.
//

import Foundation

class UserRepositoryStub: UserRepositoryProtocol {
    @Published var allUsers:[User] = []
    @Published var beingUsers:[User] = []
    @Published var beingUsersNum:Int = 0
    @Published var finishUsers:[User] = []
    @Published var finishUsersNum:Int = 0
    
    func createUser(userName: String, persons: Int, isPassUser: Bool){}
    func writeOutTime(user:User,outTime:Date){}
    
    func updateUser(user:User){}
    func deleteUser(user:User){}
    func deleteUserWithIndexset(indexset:IndexSet){}
    func deleteAllUsers(){}
}
