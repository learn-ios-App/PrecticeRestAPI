//
//  UserData.swift
//  PrecticeRestAPI
//
//  Created by 渡邊魁優 on 2023/07/19.
//

import Foundation

class UserData: ObservableObject {
    @Published var user: User = User(id: "", name: "", pw: "")
    
    
}
