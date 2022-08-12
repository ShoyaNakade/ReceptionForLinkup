//
//  CSVCreator.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/12.
//

import Foundation

struct CSVCreator {
    var repository = UserRepository()
    
    func createCSV() {
        let fileManager = FileManager.default
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        
        dateFormatter.dateFormat = "YY-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        
        let textHeader = "date,\(dateString),\n\r No.,Name,persons,MonthlyPass,inTime,outTime,usetTime[min],Payment[Yen]\n"
        
        var contents = ""
        var outputLine = 1
        var totalPersons = 0
        var totalYen = 0
        
        for user in repository.finishUsers {
                // isAllの時はdailyDetails分だけ追加し続ける = 全データ出力
            totalPersons += user.persons
            totalYen += user.payment()
            
            contents += "\(outputLine),\(user.userName),\(user.persons),\(user.isPassUser),\(user.inTimeToString()),\(user.outimeToString()),\(user.useTime()),\(user.payment())\n"  // 基本情報
            outputLine += 1
        }
        contents += "total,,\(totalPersons),,,,,\(totalYen)\n"  // 基本情報
       
        /// ①DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
        
        /// ②対象のファイルURL取得
        let directory = dirURL.appendingPathComponent("CSVデータ", isDirectory: true) //フォルダ作成
        do {
            try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("フォルダ作成に失敗した")
        }
        var fileURL = dirURL.appendingPathComponent("CSVデータ/\(dateString).csv")
        
        /// ③ファイルの書き込み
        do {
            try (textHeader + contents).write(to: fileURL, atomically: true, encoding: .utf8)
            print(fileURL)
        } catch {
            print("Error: \(error)")
        }
        
    }
}


