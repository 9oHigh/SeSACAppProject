//
//  WriteViewModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/10.
//

import Foundation

class WriteViewModel{
    
    var addPost : Observable<PostElement> = Observable(PostElement(id: 0, text: "", user: UserInfo(id: 0, username: "", email: "", confirmed: true, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: [Comment(id: 0, comment: "", user: 0, post: 0, createdAt: "", updatedAt: "")]))
    
    var inputText : Observable<String> = Observable("")
    var postId = Observable("")
    
    var errorMessage = ""
    
    func uploadPost(completion : @escaping () -> Void){
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.uploadPost(token: token, text: inputText.value) { post, error in
            
            if let error = error {
                switch error {
                case .failed:
                    self.errorMessage = "데이터 로드 실패"
                case .noData:
                    self.errorMessage = "데이터가 없음"
                case .invalidResponse:
                    self.errorMessage = "잘못된 응답"
                case .invalidData:
                    self.errorMessage = "잘못된 데이터"
                case .badRequest:
                    self.errorMessage = "잘못된 요청입니다."
                case .unAuthorized:
                    self.errorMessage  = "만료된 계정입니다."
                case .notFound:
                    self.errorMessage = "찾을 수 없습니다."
                case .timeout:
                    self.errorMessage = "시간이 초과되었습니다."
                }
            }
            
            guard let post = post else {
                return
            }
            
            self.addPost.value = post
        }
        completion()
    }
    func modifyPost(completion : @escaping () -> Void) {
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        APIService.modifyPost(postId: postId.value, text: inputText.value, token: token) { post, error in
            
            print(self.postId.value)
            print(self.inputText.value)

            if let error = error {
                switch error {
                case .failed:
                    self.errorMessage = "데이터 로드 실패"
                case .noData:
                    self.errorMessage = "데이터가 없음"
                case .invalidResponse:
                    self.errorMessage = "잘못된 응답"
                case .invalidData:
                    self.errorMessage = "잘못된 데이터"
                case .badRequest:
                    self.errorMessage = "잘못된 요청입니다."
                case .unAuthorized:
                    self.errorMessage  = "만료된 계정입니다."
                case .notFound:
                    self.errorMessage = "찾을 수 없습니다."
                case .timeout:
                    self.errorMessage = "시간이 초과되었습니다."
                }
            }
            
            guard let post = post else {
                return
            }
            
            self.addPost.value = post
        }
        completion()
    }
}


