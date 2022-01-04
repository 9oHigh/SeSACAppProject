////
////  URLSession + Extension.swift
////  SesacAppProj
////
////  Created by 이경후 on 2022/01/04.
////
//
//import Foundation
//
//enum httpMethod : String{
//    case GET
//    case POST
//    case PUT
//    case DELETE
//}
//
//enum Endpoint {
//    case signup
//    case login
//    case boards
//    case boardDetail(id: Int)
//}
//
//extension Endpoint {
//    
//    var url: URL {
//        
//        switch self {
//        case .signup: return .makeEndpoint("auth/local/register")
//        case .login: return .makeEndpoint("auth/local")
//        case .boards: return .makeEndpoint("boards")
//        case .boardDetail(id: let id): return .makeEndpoint("board/\(id)")
//            
//        }
//    }
//}
//
//extension URL {
//    
//    static let baseURL = "http://test.monocoing.com/"
//    
//    static func makeEndpoint(_ endpoint: String) -> URL {
//        URL(string: baseURL + endpoint)!
//    }
//}
//
//extension URLSession {
//    
//    typealias Handler = (Data?, URLResponse?, Error? ) -> Void
//    
//    //외부
//    @discardableResult//내부반환필요없어서
//    func dataTask(_ endpoint: URLRequest, handler : @escaping Handler) -> URLSessionDataTask {
//        let tasks = dataTask(with: endpoint, completionHandler: handler)
//        tasks.resume()
//        return tasks
//    }
//    
//    //내부
//    //T: Decodable 제약조건 주면 하단에 decoder에서 에러가 발생하지 않음
//    static func request<T : Decodable>(_ session: URLSession = .shared,endpoint: URLRequest,completion : @escaping  (T?, APIError?) -> Void){
//        session.dataTask(endpoint) { data, response, error in
//            guard error == nil else {
//                completion(nil, .failed)
//                return
//            }
//            
//            guard let data = data else {
//                completion(nil, .noData)
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse else {
//                completion(nil, .invalidResponse)
//                return
//            }
//            
//            guard response.statusCode == 200 else {
//                completion(nil,.failed)
//                print(response.statusCode)
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let decoded = try decoder.decode(T.self, from: data)
//                completion(decoded, nil)
//            } catch {
//                completion(nil,.invalidData)
//            }
//        }
//    }
//}
