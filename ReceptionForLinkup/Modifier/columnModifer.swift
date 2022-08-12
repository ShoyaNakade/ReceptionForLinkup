//
//  columnModifer.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import Foundation
import SwiftUI

struct columnModifer: ViewModifier {
    var columnWidth:CGFloat
    
    init() {
        columnWidth = 150
    }
    init(width:CGFloat) {
        columnWidth = width
    }
 
    func body(content: Content) -> some View {
            content
            .frame(width:columnWidth,alignment: .center)
            .lineLimit(1)
    }
}

