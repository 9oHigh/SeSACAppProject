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

