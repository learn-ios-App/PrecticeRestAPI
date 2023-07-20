//
//  MemoData.swift
//  PrecticeRestAPI
//
//  Created by 渡邊魁優 on 2023/07/20.
//

import Foundation

class MemoData: ObservableObject {
    @Published var memoList: [Memo] = [
        Memo(id: "", title: "AAA", description: "SASASA"),
        Memo(id: "", title: "AAA", description: "SASASA")
    ]
    let memoAPIClient = MemoAPIClient()
    
    @MainActor public func fetchMemos(user: User) {
        Task {
            do {
                let memoData = try await memoAPIClient.fetchMemos(user: user)
                for item in memoData {
                    let memo = Memo(id: item.mid, title: item.title, description: item.description)
                    memoList.append(memo)
                }
            } catch {
                let error = error as? CustomError ?? CustomError.other
                print(error.title)
            }
        }
    }
    
    @MainActor public func createMemo(user: User, title: String, description: String) {
        Task {
            do {
                let response = try await memoAPIClient.createMemo(user: user, title: title, description: description)
                let memo = Memo(id: response.mid, title: response.title, description: response.description)
                memoList.append(memo)
            } catch {
                let error = error as? CustomError ?? CustomError.other
                print(error.title)
            }
        }
    }
    
    @MainActor public func deleteMemo(user: User, memo: Memo) {
        Task {
            do {
                guard memoList.firstIndex(where: { $0.id == memo.id  }) != nil else {
                    throw CustomError.other
                }
                try await memoAPIClient.deleteMemo(user: user, memo: memo)
            } catch {
                let error = error as? CustomError ?? CustomError.other
                print(error.title)
            }
        }
    }
}
