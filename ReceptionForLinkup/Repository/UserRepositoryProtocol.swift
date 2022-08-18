//
//  UserRepositoryProtocol.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/18.
//

import Foundation
import SwiftUI
import RealmSwift

protocol UserRepositoryProtocol: ObservableObject {
    var allUsers: [User] { get set }
    var beingUsers: [User] { get set }
    var beingUsersNum: Int { get set }
    var finishUsers: [User] { get set }
    var finishUsersNum: Int { get set }
    
    func createUser(userName: String, persons: Int, isPassUser: Bool)
    func writeOutTime(user:User,outTime:Date)
    
    func updateUser(user:User)
    func deleteUser(user:User)
    func deleteUserWithIndexset(indexset:IndexSet)
    func deleteAllUsers()
}

