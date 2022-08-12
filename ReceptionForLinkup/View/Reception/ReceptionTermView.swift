//
//  ReceptionTermView.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/11.
//

import SwiftUI

struct ReceptionTermView: View {
    private let termsWidth = UIScreen.main.bounds.width / 1.2
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            Text("ご利用規約")
                .font(.system(size: 35, design: .monospaced))
                .fontWeight(.bold).underline()
                .padding(.bottom,20)
            Text("""
            私（以下「利用者」といいます。）は、LINKUPが設置・管理するスケートパーク（所在地：石川県能美市来丸町カ20-2）（以下「本施設」といいます。）を利用するにあたり、以下に同意します。
            
            ・利用者は、自らの意思に基づき、本施設を利用するものであることを確認します。
            
            ・利用者は、スケートボードが危険なスポーツであることを充分に理解したうえで本施設を利用し、いかなる理由であれ本施設の利用中に、利用者のスケートボードその他の携行品に生じた一切の損害、並びに、当該利用者が負った怪我、後遺障害及び死亡その他一切の損害に関し、LINKUPに対して、訴えの提起、調停の申立その他一切の請求（裁判上及び裁判外を問いません。）（以下「請求等」といいます。）を行わないものとします。
            
            ・利用者は、利用者のスケートボードその他の携行品を自己の責任において管理するものとし、当該携行品について滅失、毀損、破壊、盗難、紛失、改ざんその他の事故が発生した場合、理由の如何を問わず、当該事故に関して、LINKUPに対して、請求等を行わないものとします。
            
            ・利用者は、本施設の利用中に、他人のスケートボードその他の携行品に何らかの損害を生じさせ、又は、他人に怪我、後遺障害及び死亡その他何らかの損害を負わせた場合には、当事者間で誠意をもって対応し解決するものとし、LINKUPは、一切の責任を負わず、当事者間の示談、交渉、訴訟等に関与する義務を負わないものとします。
            
            ・利用者は、本施設を利用中、本施設及び本施設に設置された器物等を破損、損傷等した場合には、LINKUPに対して、その損害の全額をLINKUPの請求に従い賠償するものとします。
            
            ・利用者が本施設を利用している状況を写真撮影、ビデオ撮影その他の方法により記録し、利用者が記録された画像及び映像並びに下記に記載した利用者の氏名その他の利用者に関する情報の全部又は一部をテレビ、インターネットサイトその他の媒体により公表、公開、放送又は放映（以下「公表等」といいます。）をする可能性があることを理解し、承諾します。また、利用者は、肖像権侵害、プライバシー権侵害その他理由の如何を問わず、かかる記録並びに記録された画像及び映像の公表等に関して、LINKUPに対して、請求等を行わないものとします。
            
            ・利用者は、上記の記載内容の全てについて説明を受け、その内容を完全に理解しましたので、上記に署名します。
            """).frame(maxWidth: .infinity, alignment: .leading)
            
        }
            .frame(width: termsWidth)
            .padding(20)
            .background(Color(.secondarySystemFill))
            .cornerRadius(15)
    }
}

struct ReceptionTermView_Previews: PreviewProvider {
    static var previews: some View {
        ReceptionTermView()
    }
}
