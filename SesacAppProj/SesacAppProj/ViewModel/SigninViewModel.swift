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
        
        if validEmail().0 {
            
            APIService.signin(identifier: email.value, password: password.value) { user, error in
                
                if let error = error {
                    switch error {
                    case .badRequest:
                        self.errorMessage = "없는 이메일 입니다."
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
                
                
                //해당 로그인 정보를 가지고 올 수 있었을 경우 토큰을 저장하기
                UserDefaults.standard.set(user.jwt,forKey: "token")
                UserDefaults.standard.set(user.user.username,forKey: "nickname")
                UserDefaults.standard.set(user.user.id,forKey: "id")
                UserDefaults.standard.set(user.user.email,forKey: "email")
                print(UserDefaults.standard.string(forKey: "token") ?? "")
                print("성공했음")
                completion()//user가 제대로 들어왔을 경우만
            }
            
        } else {
            self.errorMessage = validEmail().1
        }
    }
    //이메일 유효성 검사
    func validEmail() -> (Bool,String) {
        
        //정규식으로 검사하기
        let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        if let _ = regex?.firstMatch(in: email.value, options: [], range: NSRange(location: 0, length: email.value.count)) {
            return (true,"SUCCESS")
        } else {
            self.errorMessage = "이메일 형식이 잘못되었습니다."
            return (false,self.errorMessage)
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
