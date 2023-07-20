//
//  UserAPIClient.swift
//  PrecticeRestAPI
//
//  Created by 渡邊魁優 on 2023/07/19.
//

import Foundation

class UserAPIClient {
    let urlManager = URLManager.shared
    
    public func signUp(id: String, name: String, pw: String) async throws -> UserResponse {
        guard let url = urlManager.createUserURL().url else {
            throw CustomError.badURL
        }
        guard let body = try? JSONEncoder().encode(UserRequest(id: id, name: name, pw: pw)) else {
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
        
        guard let userResponse = try? JSONDecoder().decode(UserResponse.self, from: data) else {
            throw CustomError.decordError
        }
        return userResponse
    }
    
    public func login(id: String, pw: String) async throws -> UserResponse {
        guard let url = urlManager.loginURL().url else {
            throw CustomError.badURL
        }
        guard let body = try? JSONEncoder().encode(LoginRequest(id: id, pw: pw)) else {
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
        
        guard let userResponse = try? JSONDecoder().decode(UserResponse.self, from: data) else {
            throw CustomError.decordError
        }
        return userResponse
    }
    
    public func updateUserData(user: User, newName: String) async throws -> UserResponse {
        guard let url = urlManager.userDataURL(uid: user.id).url else {
            throw CustomError.badURL
        }
        guard let body = try? JSONEncoder().encode(UserRequest(id: user.id, name: newName, pw: user.pw)) else {
            throw CustomError.encodeError
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw CustomError.urlSessionError
        }
        guard let res = response as? HTTPURLResponse,
              res.statusCode == 200 else { throw CustomError.responseError }
        
        guard let userResponse = try? JSONDecoder().decode(UserResponse.self, from: data) else {
            throw CustomError.decordError
        }
        return userResponse
    }
    
    public func deleteUser(user: User) async throws {
        guard let url = urlManager.userDataURL(uid: user.id).url else {
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
    
    struct UserRequest: Encodable {
        let id: String
        let name: String
        let pw: String
    }
    struct LoginRequest: Encodable {
        let id: String
        let pw: String
    }
    struct UserResponse: Decodable {
        let id: String
        let name: String
    }
}
