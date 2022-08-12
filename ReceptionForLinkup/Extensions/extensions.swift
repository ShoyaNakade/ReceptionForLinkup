//
//  Array+Extension.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/12.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
