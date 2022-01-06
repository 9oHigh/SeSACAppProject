//
//  MainViewModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//

import Foundation


class MainViewModel {
    
    var posts : Observable<Post> = Observable(Post())
    var errorMessage = ""

    func receivePosts(completion : @escaping () -> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.getPosts(token: token) { post, error in

            if let error = error {
                self.errorMessage = "오류가 발생했습니다.\(error)"
            }
            
            guard let post = post else {
                return
            }

            self.posts.value = post
        }
        completion()
    }
}
//뷰모델에서 바로 테이블에 사용할 수 있게
extension MainViewModel {
    
    var numberOfRowInSection: Int {
        return posts.value.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PostElement{
        return posts.value[indexPath.row]
    }
    
}

