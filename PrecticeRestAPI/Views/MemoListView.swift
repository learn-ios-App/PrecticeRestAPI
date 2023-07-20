//
//  MemoListView.swift
//  PrecticeRestAPI
//
//  Created by 渡邊魁優 on 2023/07/20.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject var userData: UserData
    @ObservedObject var memoData = MemoData()
    var body: some View {
        List {
            ForEach(memoData.memoList) { memo in
                ListRow(memo: memo)
            }
        }
        .listStyle(InsetListStyle())
        .onAppear { memoData.fetchMemos(user: userData.user) }
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
            .environmentObject(UserData())
    }
}
