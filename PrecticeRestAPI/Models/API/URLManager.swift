//
//  URLManager.swift
//  PrecticeRestAPI
//
//  Created by 渡邊魁優 on 2023/07/19.
//

import Foundation

class URLManager {
    private init() {}
    public static let shared = URLManager()
    
    public func createUserURL() -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
        components.path = "/user"
        return components
    }
    
    public func loginURL() -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
        components.path = "/user/login"
        return components
    }
    
    public func userDataURL(uid: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
        components.path = "/user/\(uid)"
        return components
    }
    
    public func userMemoDataURL(uid: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
        components.path = "/user/\(uid)/memo"
        return components
    }
    
    public func deleteMemoURL(uid: String, mid: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
        components.path = "/user/\(uid)/memo/\(mid)"
        return components
    }
}
