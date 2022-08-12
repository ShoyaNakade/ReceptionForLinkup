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
