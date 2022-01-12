//
//  SignupViewModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/05.
//

import Foundation

class SignupViewModel {
    
    let token = UserDefaults.standard.string(forKey: "token") ?? ""
    //SignupView
    //텍스트필드, 이메일,패스워드, 패스워드 확인, 닉네임 그리고 버튼 연결
    var email : Observable<String> = Observable("")
    var password : Observable<String> = Observable("")
    var checkPassword : Observable<String> = Observable("")
    var username : Observable<String> = Observable("")
    var enableBtn : Observable<Bool> = Observable(false)
    
    var current : Observable<String> = Observable("")
    
    //API 서비스의 에러 메세지
    var errorMessage : String = ""
    
    func signup(completion: @escaping () -> Void){
        //유효성검사 완료
        if validEmail().0 == true && validPassword().0 == true {
            self.errorMessage = "" // 모두 True를 반환시에 에러내용 없음
            APIService.signup(username: username.value, email: email.value, password: password.value) { user, error in
                if let error = error {
                    switch error {
                    case .failed:
                        self.errorMessage = "회원가입에 실패"
                    case .noData:
                        self.errorMessage = "데이터를 가지고 올 수 없음"
                    case .invalidResponse:
                        self.errorMessage = "잘못된 응답"
                    case .invalidData:
                        self.errorMessage = "유효하지 않은 값"
                    case .badRequest:
                        self.errorMessage = "잘못된 요청"
                    case .timeout:
                        self.errorMessage = "시간초과"
                    default :
                        self.errorMessage = "알수없는 오류"
                    }
                }
            }
        }
        //이메일 유효성 검사 실패
        else if validEmail().0 == false {
            self.errorMessage = validEmail().1
            //패스워드/패스워드 확인 일치하지 않을 경우
        } else if validPassword().0 == false {
            self.errorMessage = validPassword().1
            //두가지 모두 잘못적었을 경우
        } else {
            self.errorMessage = "이메일, 비밀번호를 확인하세요."
        }
        completion() // 로그인 성공 및 실패 보두를 확인하기 위해 바깥에
    }
    
    func changePassword(completion: @escaping () -> Void){
        if validPassword().0 {
            APIService.passwordChange(token: token, current: current.value, new: password.value, oneMore: checkPassword.value) { user, error in
                if let error = error {
                    switch error {
                    case .failed:
                        self.errorMessage = "변경실패"
                    case .noData:
                        self.errorMessage = "데이터를 가지고 올 수 없음"
                    case .invalidResponse:
                        self.errorMessage = "잘못된 응답"
                    case .invalidData:
                        self.errorMessage = "유효하지 않은 값"
                    case .badRequest:
                        self.errorMessage = "잘못된 요청"
                    case .timeout:
                        self.errorMessage = "시간초과"
                    default :
                        self.errorMessage = "만료된 계정"
                    }
                }
                self.errorMessage = ""
            }
        }
        completion()
    }
    
    
    //이메일 유효성 검사
    func validEmail() -> (Bool,String) {
        
        //정규식
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
    func checkFullTextByChange() -> Bool {
        
        if current.value.count > 0 && password.value.count > 0 && checkPassword.value.count > 0 {
            return true
        } else {
            return false
        }
    }
}
