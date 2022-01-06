//
//  APIService.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/04.
//

import Foundation

enum APIError : Error {
    case failed
    case noData
    case invalidResponse
    case invalidData
    case badRequest     //400
    case unAuthorized   //401
    case notFount       //404
    case timeout        //408
}

public class APIService {
    
    static func signup(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        let url = Endpoint.signup.url
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func signin(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        let url = Endpoint.signin.url
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func getPosts(token: String, completion: @escaping (Post?, APIError?) -> Void) {
        
        let url = Endpoint.posts.url
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.GET.rawValue
        request.setValue("bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func getComments(token: String, completion: @escaping (Post?, APIError?) -> Void) {
        
        let url = Endpoint.posts.url
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.GET.rawValue
        request.setValue("bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func writePost(token: String, text: String, completion: @escaping (Post?, APIError?) -> Void){
        
        let url = Endpoint.uploadPosts.url
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.POST.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
}
