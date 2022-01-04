//
//  SignUpViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/04.
//

import UIKit

class SignUpViewController : BaseViewController {
    
    let recruitLabel = UILabel() //모집중 라벨!
    
    let emailField = UITextField()
    let nicknameField = UITextField()
    let passwordField = UITextField()
    let checkField = UITextField()
    let signInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "새벽농장 가입하기"
        
        setConfigures()
        setUI()
        setConstraints()
        
    }
    
    override func setConfigures() {
        
        view.backgroundColor = .white
        //recruit Label Set
        recruitLabel.font = UIFont.boldSystemFont(ofSize: 25)
        recruitLabel.numberOfLines = 0
        recruitLabel.text = "바람의 나라\n문파원 모집중🎉"
        recruitLabel.textColor = .black
        recruitLabel.textAlignment = .center
        
        
        //Email TextField Set
        emailField.placeholder = "이메일 주소"
        emailField.backgroundColor = .white
        emailField.borderStyle = .roundedRect
        
        //Nickname TextField Set
        nicknameField.placeholder = "닉네임"
        nicknameField.backgroundColor = .white
        nicknameField.borderStyle = .roundedRect
        
        //Password TextField Set
        passwordField.placeholder = "비밀번호"
        passwordField.backgroundColor = .white
        passwordField.borderStyle = .roundedRect
        
        //Check TextField Set
        checkField.placeholder = "비밀번호 확인"
        checkField.backgroundColor = .white
        checkField.borderStyle = .roundedRect
        
        //SignIn Button Set
        signInButton.backgroundColor = .gray
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.setTitle("가입하기", for: .normal)
        signInButton.layer.cornerRadius = 10
        
    }
    
    override func setUI() {
        
        view.addSubview(recruitLabel)
        view.addSubview(emailField)
        view.addSubview(nicknameField)
        view.addSubview(passwordField)
        view.addSubview(checkField)
        view.addSubview(signInButton)
        
    }
    
    override func setConstraints() {
        
        recruitLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        emailField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(nicknameField.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        checkField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(checkField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(70)
        }
    }
}
