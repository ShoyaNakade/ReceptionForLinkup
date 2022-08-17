//
//  User.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/10.
//

import Foundation
import RealmSwift

class User: Object, Identifiable{
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var userName: String = ""
    @objc dynamic var persons: Int = 0
    @objc dynamic var isPassUser: Bool = false
    @objc dynamic var inTime: Date = Date()
    @objc dynamic var outTime: Date?
    
    convenience init(userName:String, persons:Int, isPassUser: Bool) {
        self.init()
        self.userName = userName
        self.persons = persons
        self.isPassUser = isPassUser
    }
    
    //Primary Keyの設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func inTimeToString() -> String {
        let dateFormatter = DateFormatter()
        /// カレンダー、ロケール、タイムゾーンの設定（未指定時は端末の設定が採用される）
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: self.inTime)
    }
    
    func outimeToString() -> String {
        let dateFormatter = DateFormatter()
        /// カレンダー、ロケール、タイムゾーンの設定（未指定時は端末の設定が採用される）
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: self.outTime ?? Date())
    }
    
    
    // calc
    func estimatedUseTime(now:Date) -> Int {
        let spanMin = now.timeIntervalSince(self.inTime) / 60 // 1209600秒差
        return Int(spanMin)
    }
    
    func useTime() -> Int {
        if outTime == nil {
            print("Error! outtime is nil and cant to calc useTime")
            return -1 //ありえない値を入れて、エラーにする。
        } else {
            return estimatedUseTime(now: outTime!)
        }
    }
    

    
    
    func estimatedPayment(now:Date) -> Int {
        var cost = 500
        let spanMin = Int(now.timeIntervalSince(self.inTime) / 60) // 1209600秒差
        if spanMin < 60 {
            cost = 500
        } else if spanMin < 120 {
            cost = 800
        } else if spanMin < 240 {
            cost = 1000
        } else {
            cost = 1300
        }
        
        if isPassUser { cost = 0 }
        return cost * self.persons
    }
    
    func payment() -> Int {
        if outTime == nil {
            print("Error! outtime is nil and cant to calc payment")
            return -1 //ありえない値を入れて、エラーにする。
        } else {
            return estimatedPayment(now: outTime!)
        }
    }
    
    
}
