//
//  HomeTopHeader.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/10.
//

import SwiftUI

struct HomeTopHeader: View {
    @Binding var personsNum:Int
    init(personNum:Binding<Int>) {
        self._personsNum = personNum
    }
    var body: some View {
        HStack (alignment:.bottom){
            Text("現在の利用者数:")
                .font(.system(size: 45))
            Text("\(personsNum)")
                .font(.system(size: 80))
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.bottom, -10) // 調整
            Text("人")
                .font(.system(size: 45))
        }
    }
}


struct HomeTopHeader_Previews: PreviewProvider {
    @State static var num:Int = 0
    static var previews: some View {
        HomeTopHeader(personNum: $num)
    }
}
