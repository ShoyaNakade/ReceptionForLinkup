//
//  ReceptionViewModel.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/13.
//

import Foundation
import RealmSwift

class ReceptionViewModel:ObservableObject {
    @Published var userRepository = UserRepository()
    @Published var persons = 1
    @Published var isPassport: Bool = false
    @Published var name: String = ""
    @Published var check = false
    @Published var disabled = true
    @Published var showingConfirm = false
    
    func checkButtonActive() {
        if check && !name.isEmpty {
            disabled = false
        } else {
            disabled = true
        }
    }
    
    func createNewUser() {
        userRepository.createUser(userName: name, persons: persons, isPassUser: isPassport)
    }
    
    func personsIncrement() {
        persons += 1
    }
    func personsDecrement() {
        if persons > 1 {persons -= 1}
    }
    
    func tapCheckBox() {
        self.check.toggle()
        self.checkButtonActive()
    }
    
}
