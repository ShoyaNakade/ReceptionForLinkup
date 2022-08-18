//
//  UserRepository.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//
import RealmSwift
import Foundation
import SwiftUI

class UserRepository:UserRepositoryProtocol  {
    private let realm = try! Realm()
    @Published var allUsers:[User] = []
    @Published var beingUsers:[User] = []
    @Published var beingUsersNum:Int = 0
    @Published var finishUsers:[User] = []
    @Published var finishUsersNum:Int = 0

    @Published private var currentResult: Results<User> // view更新通知に必須
    private var notificationTokens: [NotificationToken] = []
    
    init() {
//        Realm.Configuration.defaultConfiguration = Realm.Configuration(
//            schemaVersion: 2,
//            migrationBlock: { migration, oldSchemaVersion in
//                if(oldSchemaVersion < 2) {
//                    migration.enumerateObjects(ofType: User.className()) { _, _ in
//                        // pass: 何もいらない
//                    }
//                }
//            }
//        )
        
        
        print("repository init start")
        self.currentResult = realm.objects(User.self) //bindingされる
        self.fetchAllUsers()
        self.fetchBeingUser()
        self.getBeingUserNum()
        self.fetchBeingUser()
        self.getBeingUserNum()
        self.fetchFinishUser()
        self.getFinishUserNum()
        
        //MARK: -  notification
        notificationTokens.append(currentResult.observe { change in
            switch change {
            case let .initial(results):
                break
            case let .update(results, _, _, _):
                print("change the result!!!")
                self.fetchAllUsers()
                self.fetchBeingUser()
                self.getBeingUserNum()
                self.fetchBeingUser()
                self.getBeingUserNum()
                self.fetchFinishUser()
                self.getFinishUserNum()
            case let .error(error):
                print(error.localizedDescription)
            }
        })
    }
    
    deinit {
        notificationTokens.forEach { $0.invalidate() } //削除の時のために必要。
    }

    private func fetchAllUsers() {
        self.allUsers = Array(realm.objects(User.self))
    }
    
    private func fetchBeingUser() {
        let predicate = NSPredicate(format: " outTime == nil")
        self.beingUsers = Array(realm.objects(User.self).filter(predicate))
    }
    
    private func getBeingUserNum() {
        var num = 0
        self.beingUsers.forEach { user in
            num += user.persons
        }
        self.beingUsersNum = num
    }
    
    private func fetchFinishUser()  {
        let predicate = NSPredicate(format: " outTime != nil")
        self.finishUsers = Array(realm.objects(User.self).filter(predicate))
    }
    private func getFinishUserNum() {
        var num = 0
        self.finishUsers.forEach { user in
            num += user.persons
        }
        self.finishUsersNum = num
    }
    
    func createUser(userName: String, persons: Int, isPassUser: Bool) {
        try! realm.write {
          realm.add(User(userName: userName, persons: persons, isPassUser: isPassUser))
        }
    }
    func writeOutTime(user:User,outTime:Date) {
        try! realm.write {
          user.outTime = outTime
          realm.add(user, update: .modified)
        }
    }
    
    func updateUser(user:User) {
        try! realm.write {
          realm.add(user, update: .modified)
        }
    }
    
    func deleteUser(user:User) {
        try! realm.write {
          realm.delete(user)
        }
    }
    
    func deleteUserWithIndexset(indexset:IndexSet) {
        let index = (indexset.last!) // 昇順に順番を変える場合はよう変更
        let deleteUser = self.finishUsers[safe: index]
        try! realm.write {
            if deleteUser != nil {
                realm.delete(deleteUser!)
            }
        }
    }
    
    func deleteAllUsers() {
        try! realm.write {
            realm.deleteAll()
        }
        fetchAllUsers()
        fetchBeingUser()
        fetchFinishUser()
    }
    
}


