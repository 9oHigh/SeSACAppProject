//
//  SignInViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/04.
//

import UIKit


class SignInViewController : BaseViewController {
    
    let imageView = UIImageView()
    let signInLabel = UILabel()
    let subLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigures()
        setUI()
        setConstraints()
        
    }
    
    override func setConfigures() {
        view.backgroundColor = .white
        
        //ImageView Set
        imageView.image = UIImage(named: "logo_ssac_clear.png")
        
        //Sign Label Set
        signInLabel.font = .boldSystemFont(ofSize: 20)
        signInLabel.text = "오늘도 꿈을 펼쳐보세요🧑🏻‍💻"
        signInLabel.numberOfLines = 0
        signInLabel.textColor = .black
        signInLabel.textAlignment = .center
        
        //Sub Label Set
        subLabel.font = .boldSystemFont(ofSize: 18)
        subLabel.text = "with SeSAC"
        subLabel.numberOfLines = 0
        subLabel.textColor = .gray
        subLabel.textAlignment = .center
        
        //Email TextField Set
        emailTextField.placeholder = "이메일"
        emailTextField.borderStyle = .roundedRect
        emailTextField.textColor = .black
        
        //Password TextField Set
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textColor = .black
        
        //Login Button Set
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 10

    }
    
    override func setUI() {
        
        view.addSubview(imageView)
        view.addSubview(signInLabel)
        view.addSubview(subLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
    }
    
    override func setConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.55)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(subLabel.snp.top).offset(-10)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(emailTextField.snp.top).offset(-20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        
    }
    
}
