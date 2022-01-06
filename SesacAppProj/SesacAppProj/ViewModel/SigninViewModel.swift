//
//  SignupViewModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//

import Foundation

class SigninViewModel {
    
    var email : Observable<String> = Observable("")
    var password : Observable<String> = Observable("")
    
    var errorMessage : String = ""
    
    func signinToMain(completion: @escaping () -> Void){
        
        APIService.signin(identifier: email.value, password: password.value) { user, error in
            
            if let error = error {
                switch error {
                case .badRequest:
                    self.errorMessage = "옳바르지 않은 계정정보"
                case .unAuthorized:
                    self.errorMessage = "만료된 계정입니다."
                case .notFount:
                    self.errorMessage = "알수없음"
                case .timeout:
                    self.errorMessage = "시간초과"
                case .failed:
                    self.errorMessage = "연결 실패"
                case .noData:
                    self.errorMessage = "데이터가 없습니다."
                case .invalidResponse:
                    self.errorMessage = "잘못된 응답입니다."
                case .invalidData:
                    self.errorMessage = "잘못된 데이터입니다."
                }
                return
            }
            
            guard let user = user else {
                return
            }
            self.errorMessage = ""
            //해당 로그인 정보를 가지고 올 수 있었을 경우 토큰을 저장하기
            UserDefaults.standard.set(user.jwt,forKey: "token")
            UserDefaults.standard.set(user.user.username,forKey: "nickname")
            UserDefaults.standard.set(user.user.id,forKey: "id")
            UserDefaults.standard.set(user.user.email,forKey: "email")
            
            print("성공했음")
            completion()
        }
    }
    
    //모든 칸이 채워져있는지 검사
    func checkFullText() -> Bool {
        
        if email.value.count > 0 && password.value.count > 0 {
            return true
        } else {
            return false
        }
    }
}
