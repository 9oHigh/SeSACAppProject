////
////  MainViewModel.swift
////  SesacAppProj
////
////  Created by 이경후 on 2022/01/06.
////
//import Foundation
//
//class DetailPostViewModel {
//    
//    var comment : Observable<Comment> = Observable(Comment(id: 0, comment: "", user: 0, post: 0, createdAt: "", updatedAt: ""))
//    var errorMessage = ""
//
//    func receivePosts(completion : @escaping () -> Void){
//        let token = UserDefaults.standard.string(forKey: "token") ?? ""
//        APIService.getPosts(token: token) { post, error in
//
//            if let error = error {
//                self.errorMessage = "오류가 발생했습니다.\(error)"
//                print(self.errorMessage)
//            }
//            
//            guard let post = post else {
//                return
//            }
//
//            self.posts.value = post
//        }
//        completion()
//    }
//}
////뷰모델에서 바로 테이블에 사용할 수 있게
//extension DetailPostViewModel {
//    
//    var numberOfRowInSection: Int {
//        
//        return posts.value.count
//    }
//    
//    func cellForRowAt(at indexPath: IndexPath) -> Comm{
//        return posts.value[indexPath.row]
//    }
//    
//}
//
