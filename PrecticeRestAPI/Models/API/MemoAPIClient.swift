//
//  MemoAPIClient.swift
//  PrecticeRestAPI
//
//  Created by 渡邊魁優 on 2023/07/19.
//

import Foundation

class MemoAPIClient {
    let urlManager = URLManager.shared
    
    public func fetchMemos(user: User) async throws -> [MemoResponse] {
        guard let url = urlManager.userMemoDataURL(uid: user.id).url else {
            throw CustomError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw CustomError.urlSessionError
        }
        guard let res = response as? HTTPURLResponse,
              res.statusCode == 200 else { throw CustomError.responseError }
        
        guard let memoResponse = try? JSONDecoder().decode([MemoResponse].self, from: data) else {
            throw CustomError.decordError
        }
        return memoResponse
    }
    
    public func createMemo(user: User, title: String, description: String) async throws -> MemoResponse {
        guard let url = urlManager.userMemoDataURL(uid: user.id).url else {
            throw CustomError.badURL
        }
        guard let body = try? JSONEncoder().encode(MemoRequest(title: title, description: description)) else {
            throw CustomError.encodeError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw CustomError.urlSessionError
        }
        guard let res = response as? HTTPURLResponse,
              res.statusCode == 200 else { throw CustomError.responseError }
        
        guard let memoResponse = try? JSONDecoder().decode(MemoResponse.self, from: data) else {
            throw CustomError.decordError
        }
        return memoResponse
    }
    
    public func deleteMemo(user: User, memo: Memo) async throws {
        guard let url = urlManager.deleteMemoURL(uid: user.id, mid: memo.id).url else {
            throw CustomError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        guard let (_, response) = try? await URLSession.shared.data(for: request) else {
            throw CustomError.urlSessionError
        }
        guard let res = response as? HTTPURLResponse,
              res.statusCode == 200 else { throw CustomError.responseError }
    }
    
    struct MemoResponse: Decodable {
        let mid: String
        let title: String
        let description: String
    }
    struct MemoRequest: Encodable {
        let title: String
        let description: String
    }
}
