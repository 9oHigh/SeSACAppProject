//
//  MainViewModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//
import Foundation

class DetailPostViewModel : BaseViewModel {
    
    let token = UserDefaults.standard.string(forKey: "token") ?? ""
    
    //아니! 이렇게 하는거 맞냐!
    var comment : Observable<String> = Observable("")
    
    var comments : Observable<Comments> = Observable(Comments())

    var commentElem : Observable<CommentElement> = Observable(CommentElement(id: 0, comment: "", user: UserClass(id: 0, username: "", email: "", confirmed: true, createdAt: "", updatedAt: ""), post: PostComment(id: 0, text: "", user: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: ""))
    
    var post : Observable<PostElement> = Observable(PostElement(id: 0, text: "", user: UserInfo(id: 0, username: "", email: "", confirmed: true, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: [Comment(id: 0, comment: "", user: 0, post: 0, createdAt: "", updatedAt: "")]))
    
    
    var errorMessage = ""
    
    func receiveComments(postId : String,completion : @escaping () -> Void){
        
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.unauthorizedToStart()
                    }
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
            
            self.comments.value = comments
        }
    }
    
    func uploadComment(postId : String,comment: String,completion : @escaping () -> Void){
        
        APIService.uploadComment(postId: postId, comment: comment, token: token) { comment, error in
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.unauthorizedToStart()
                    }
                case .notFound:
                    self.errorMessage = "찾을 수 없습니다."
                case .timeout:
                    self.errorMessage = "시간이 초과되었습니다."
                }
            }
            self.errorMessage = ""
            completion()
        }
    }
    func deleteComment(commentId : Int,completion : @escaping () -> Void){
        APIService.deleteComment(commentId: commentId, token: token) { comment, error in
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.unauthorizedToStart()
                    }
                case .notFound:
                    self.errorMessage = "찾을 수 없습니다."
                case .timeout:
                    self.errorMessage = "시간이 초과되었습니다."
                }
            }
            
            self.errorMessage = ""
            
            guard let comment = comment else {
                return
            }
            self.commentElem.value = comment
        }
        completion()
    }
    
    func recievePost(postId : String,completion : @escaping () -> Void){

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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.unauthorizedToStart()
                    }
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
        completion()
    }
    
    func deletePost(postId : String,completion : @escaping () -> Void){
        
        APIService.deletePost(postId: postId, token: token) { post, error in
            
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.unauthorizedToStart()
                    }
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
        completion()
    }
    override func unauthorizedToStart() {
        super.unauthorizedToStart()
    }
}
//뷰모델에서 바로 테이블에 사용할 수 있게
extension DetailPostViewModel {
    
    var numberOfRowInSection: Int {
        return comments.value.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> CommentElement{
        return comments.value[indexPath.row]
    }
}

