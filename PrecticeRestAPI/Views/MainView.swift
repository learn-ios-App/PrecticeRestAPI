//
//  ContentView.swift
//  PrecticeRestAPI
//
//  Created by 渡邊魁優 on 2023/07/19.
//

import SwiftUI

struct MainView: View {
    
    enum Tabs: String, CaseIterable, Identifiable {
        case home = "ホーム"
        case memo = "メモ"
        case setting = "設定"
        
        var id: Self { self }
    }
    
    @State private var navigationTitle: String = Tabs.home.rawValue
    @State private var selectionTab: Tabs = .home
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectionTab) {
                MyPageView()
                    .tabItem({
                        VStack {
                            Image(systemName: "circle")
                            Text("ホーム")
                        }
                    })
                    .tag(Tabs.home)
                
                MemoListView()
                    .tabItem({
                        VStack {
                            Image(systemName: "circle")
                            Text("メモ")
                        }
                    })
                    .tag(Tabs.memo)
                
                SettingView()
                    .tabItem({
                        VStack {
                            Image(systemName: "circle")
                            Text("設定")
                        }
                    })
                    .tag(Tabs.setting)
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: selectionTab) { _ in
                navigationTitle = selectionTab.rawValue
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserData())
    }
}
