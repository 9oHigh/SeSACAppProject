////
////  APIService.swift
////  SesacAppProj
////
////  Created by 이경후 on 2022/01/04.
////
//
//import Foundation
//
//enum APIError : Error {
//    case noData
//    case failed
//    case invalidResponse
//    case invalidData
//}
//
//class APIService {
//    
//    static func login(identifier: String, password: String,completion: @escaping (User?, APIError?)-> Void){
//        //let url = URL(string: "http://test.monocoding.com/auth/local")!
//        //아래처럼 바로 가능
//        var request = URLRequest(url: Endpoint.login.url)
//        
//        request.httpMethod = httpMethod.POST.rawValue
//        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8,allowLossyConversion: false)
//        
//        URLSession.request(.shared, endpoint: request,completion: completion)//한줄로 끝...Endpoint확인
//    }
//}
