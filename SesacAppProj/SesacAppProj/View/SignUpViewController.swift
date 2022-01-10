//
//  SignUpViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/04.
//

import UIKit

class SignUpViewController : BaseViewController {
    
    var viewModel = SignupViewModel()
    
    let recruitLabel = UILabel()
    let emailField = UITextField()
    let nicknameField = UITextField()
    let passwordField = UITextField()
    let checkField = UITextField()
    let signupButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "새벽농장 가입하기"
        
        setConfigures()
        setUI()
        setConstraints()
        bind()
        
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
        emailField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        
        //Nickname TextField Set
        nicknameField.placeholder = "닉네임"
        nicknameField.backgroundColor = .white
        nicknameField.borderStyle = .roundedRect
        nicknameField.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
        
        //Password TextField Set
        passwordField.placeholder = "비밀번호"
        passwordField.backgroundColor = .white
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        passwordField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        //Check TextField Set
        checkField.placeholder = "비밀번호 확인"
        checkField.backgroundColor = .white
        checkField.borderStyle = .roundedRect
        checkField.isSecureTextEntry = true
        checkField.addTarget(self, action: #selector(checkTextFieldDidChange(_:)), for: .editingChanged)
        
        //SignIn Button Set
        signupButton.backgroundColor = .black
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.setTitle("가입하기", for: .normal)
        signupButton.layer.cornerRadius = 10
        signupButton.alpha = 0.5
        signupButton.isEnabled = false
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        
    }
    
    override func setUI() {
        
        view.addSubview(recruitLabel)
        view.addSubview(emailField)
        view.addSubview(nicknameField)
        view.addSubview(passwordField)
        view.addSubview(checkField)
        view.addSubview(signupButton)
        
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
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(checkField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(70)
        }
    }
    override func bind() {
        
        viewModel.email.bind { text in
            self.emailField.text = text
        }
        
        viewModel.username.bind { text in
            self.nicknameField.text = text
        }
        
        viewModel.password.bind { text in
            self.passwordField.text = text
        }
        
        viewModel.checkPassword.bind { text in
            self.checkField.text = text
        }
        
        viewModel.enableBtn.bind { bool in
            self.signupButton.isEnabled = bool
            if bool { self.signupButton.alpha = 1 }
            else {self.signupButton.alpha = 0.5}
        }
        
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField){
        viewModel.email.value = textField.text ?? ""
        if viewModel.checkFullText() {
            viewModel.enableBtn.value = true
        } else {
            viewModel.enableBtn.value = false
        }
    }
    
    @objc func nicknameTextFieldDidChange(_ textField: UITextField){
        viewModel.username.value = textField.text ?? ""
        if viewModel.checkFullText() {
            viewModel.enableBtn.value = true
        } else {
            viewModel.enableBtn.value = false
        }
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField){
        viewModel.password.value = textField.text ?? ""
        if viewModel.checkFullText() {
            viewModel.enableBtn.value = true
        } else {
            viewModel.enableBtn.value = false
        }
    }
    
    @objc func checkTextFieldDidChange(_ textField: UITextField){
        viewModel.checkPassword.value = textField.text ?? ""
        if viewModel.checkFullText() {
            viewModel.enableBtn.value = true
        } else {
            viewModel.enableBtn.value = false
        }
    }
    
    @objc func signupButtonClicked(){
        //MARK: 위와 마찬가지로 ViewModel의 역할을 다시 고민해봐야함
        viewModel.signup {
            if self.viewModel.errorMessage == "" {
                self.showToast(message: "회원가입 완료!", font: .systemFont(ofSize: 15), width: 150, height: 40)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 15), width: 250, height: 40)
            }
            
        }
    }
}
