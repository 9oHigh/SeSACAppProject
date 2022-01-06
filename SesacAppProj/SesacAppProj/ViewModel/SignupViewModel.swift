//
//  SignupViewModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/05.
//

import Foundation

class SignupViewModel {
    
    var email : Observable<String> = Observable("")
    var password : Observable<String> = Observable("")
    var checkPassword : Observable<String> = Observable("")
    var username : Observable<String> = Observable("")
    var enableBtn : Observable<Bool> = Observable(false)
    
    var errorMessage : String = ""
    
    //회원가입이 완료될 시에 MainViewController로 이동 클로저
    func signupToMain(completion: @escaping () -> Void){
        //유효성검사 완료
        if validEmail().0 == true && validPassword().0 == true {
            self.errorMessage = ""
            APIService.signup(username: username.value, email: email.value, password: password.value) { user, error in
            }
        } else if validEmail().0 == false {
            self.errorMessage = validEmail().1
        } else if validPassword().0 == false {
            self.errorMessage = validPassword().1
        } else {
            self.errorMessage = "이메일, 비밀번호를 확인하세요."
        }
        completion()
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
    //패스워드 일치여부 검사
    func validPassword() -> (Bool,String) {
        
        if password.value != checkPassword.value {
            self.errorMessage = "두 비밀번호가 일치하지 않습니다."
            return (false,self.errorMessage)
        } else {
            return (true,"SUCCESS")
        }
    }
    //모든 칸이 채워져있는지 검사
    func checkFullText() -> Bool {
        
        if email.value.count > 0 && username.value.count > 0 && password.value.count > 0 && checkPassword.value.count > 0{
            return true
        } else {
            return false
        }
    }
}
