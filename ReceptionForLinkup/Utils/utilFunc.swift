//
//  utilFunc.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/12.
//

import Foundation

func removeComma( _ str :String) -> String {
    var numString: String = ""
    let result = str.components(separatedBy: CharacterSet(charactersIn: ","))
    for strIndex in 0 ..< result.count {
        numString += result[strIndex]
    }
   return numString
}

func nowTimeToString() -> String {
    let dateFormatter = DateFormatter()
    /// カレンダー、ロケール、タイムゾーンの設定（未指定時は端末の設定が採用される）
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.locale = Locale(identifier: "ja_JP")
    dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
    
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.string(from: Date())
}

func showMinToHour(min: Int) -> String {
    let useHour = Int(floor(Double(min / 60) ))
    let useMin = min % 60
    if (useHour == 0) {
        return "\(useMin)分"
    } else {
        return "\(useHour)時間\(useMin)分"
    }
}
