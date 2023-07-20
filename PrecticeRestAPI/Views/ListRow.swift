//
//  ListRow.swift
//  PrecticeRestAPI
//
//  Created by 渡邊魁優 on 2023/07/21.
//

import SwiftUI

struct ListRow: View {
    @State var memo: Memo
    var body: some View {
        VStack {
            Text(memo.title)
                .padding(.bottom)
            Text(memo.description)
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(memo: Memo(id: "aa", title: "テスト勉強", description: "27日の数学のテスト勉強"))
    }
}
