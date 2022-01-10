//
//  MainViewModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//
import Foundation

class DetailPostViewModel {
    
    
    var comment : Observable<Comments> = Observable(Comments())
    //이게 맞아..? 아닌거 같은데..
    var post : Observable<PostElement> = Observable(PostElement(id: 0, text: "", user: UserInfo(id: 0, username: "", email: "", confirmed: true, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: [Comment(id: 0, comment: "", user: 0, post: 0, createdAt: "", updatedAt: "")]))
    
    var errorMessage = ""
    
    func receiveComments(postId : String,completion : @escaping () -> Void){
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        APIService.getComments(postId: postId, token: token) { comments, error in
            
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
            self.errorMessage = ""
            
            guard let comments = comments else {
                return
            }
            
            self.comment.value = comments
        }
    }
    func recievePost(postId : String,completion : @escaping () -> Void){
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        APIService.getPost(postId: postId, token: token) { post, error in
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
            
            self.errorMessage = ""
            
            guard let post = post else {
                return
            }
            
            self.post.value = post
        }
    }
}
//뷰모델에서 바로 테이블에 사용할 수 있게
extension DetailPostViewModel {
    
    var numberOfRowInSection: Int {
        return comment.value.count
        
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> CommentElement{
        return comment.value[indexPath.row]
    }
    
}

