//
//  ChangeUserInfoViewModelProtocol.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/18.
//

import Foundation

protocol ChangeUserInfoViewModelProtocol: ObservableObject {
    var mCurrentUser: User { get set }
    var mPersons: Int { get set }
    var mPass: Bool { get set }
    var mName: String { get set }
    var mInTime: Date { get set }
    
    func personsIncrement()
    func personsDecrement()
    func currentUserReload()
}
