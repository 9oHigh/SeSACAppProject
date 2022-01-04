////
////  SignUpModel.swift
////  SesacAppProj
////
////  Created by 이경후 on 2022/01/04.
////
//
//import RxSwift
//import RxCocoa
//
//// 회원가입 에러
//enum SignUpError : Error {
//    case differentPassword // 두 비밀번호가 다른 경우
//    case incorrectEmailForm // 이메일 형식이 지켜지지 않은 경우
//    case duplicatedEmail // 이메일 중복되는 경우
//    case duplicatedNicname // 닉네임 중복되는 경우
//    
//    var message : String {
//        switch self {
//        case .differentPassword:
//            return "비밀번호가 일치 하지 않습니다 👀"
//        case .incorrectEmailForm:
//            return "이메일 형식이 일치하지 않습니다 👀"
//        case .duplicatedEmail:
//            return "이미 등록된 이메일입니다 👀"
//        case .duplicatedNicname:
//            return "이미 등록된 닉네임입니다 👀"
//        }
//    }
//}
//// 회원가입 성공여부
//enum SignStatus {
//    case success(_ user : User)
//    case failure(_ error : SignUpError)
//}
//
////이메일, 닉네임, 비밀번호, 비밀번호 확인 - SignUp
//class SignUpViewModel {
//    
//    
//    
//    
//}
