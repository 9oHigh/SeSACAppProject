//
//  WriteViewModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/10.
//

import Foundation

class CommentViewModel : BaseViewModel{
    
    let token = UserDefaults.standard.string(forKey: "token") ?? ""
    
    var commentElem : Observable<CommentElement> = Observable(CommentElement(id: 0, comment: "", user: UserClass(id: 0, username: "", email: "", confirmed: true, createdAt: "", updatedAt: ""), post: PostComment(id: 0, text: "", user: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: ""))
    
    var inputText : Observable<String> = Observable("")
    var postId = Observable("")
    var commentId = Observable(0)
    
    
    var errorMessage = ""
    
    func modifyComment(commentId: Int,text : String,completion : @escaping () -> Void){
        print("TEXT : \(text)")
        APIService.modifyComment(postId: postId.value, commentId: commentId, comment: text, token: token) { comment, error in
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
    override func unauthorizedToStart() {
        super.unauthorizedToStart()
    }
}


