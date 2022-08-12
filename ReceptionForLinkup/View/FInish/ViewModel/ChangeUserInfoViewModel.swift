//
//  ChangeUserInfoViewModel.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/13.
//

import Foundation
import RealmSwift

class ChangeUserInfoViewModel: ObservableObject {
    @Published var mCurrentUser: User
    @Published var mPersons:Int
    @Published var mPass:Bool
    @Published var mName:String
    @Published var mInTime:Date
    
    init(currentUser: User) {
        self.mCurrentUser = currentUser
        self.mPersons = currentUser.persons
        self.mPass = currentUser.isPassUser
        self.mName = currentUser.userName
        self.mInTime = currentUser.inTime
    }
    
    func personsIncrement() {
        mPersons += 1
    }
    func personsDecrement() {
        if mPersons > 1 {mPersons -= 1}
    }
    
    func currentUserReload() {
        let realm = try! Realm()
        try! realm.write {//この時点でDBに反映される。
            mCurrentUser.persons = mPersons
            mCurrentUser.isPassUser = mPass
            mCurrentUser.userName = mName
            mCurrentUser.inTime = mInTime
        }
    }
    
}
