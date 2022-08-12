//
//  HistoryCSVConfirmView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/13.
//

import SwiftUI

struct HistoryCSVConfirmView: View {
    let displayName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as? String ?? "アプリ名"
    @Binding var showCSVNotification:Bool
    
    var body: some View {
        VStack(spacing:50) {
            Text("ファイルアプリに保存されました。 保存先は, \n'\(displayName)/CSVデータ/日付.csv' です。\n 文字化けする場合は、文字コードをutf-8にして読み込んでください。")
                .font(.title3)
            Button {
                showCSVNotification.toggle()
            } label: {
                Text("閉じる")
                    .font(.largeTitle)
            }
        }
    }
}

struct HistoryCSVConfirmView_Previews: PreviewProvider {
    @State static var isOn = false
    static var previews: some View {
        HistoryCSVConfirmView(showCSVNotification: $isOn)
    }
}
