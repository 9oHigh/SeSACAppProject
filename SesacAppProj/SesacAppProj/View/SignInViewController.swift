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
    
    var viewModel = SigninViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "새싹농장 로그인하기"
        
        setConfigures()
        setUI()
        setConstraints()
        bind()
        
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
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        
        //Password TextField Set
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textColor = .black
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        //Login Button Set
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        
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
    
    override func bind() {
        
        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }
        
    }
    
    @objc func emailTextFieldDidChange(_ textField : UITextField){
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField : UITextField){
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func loginBtnClicked(){
        
        self.showToast(message: "로그인 완료!", font: .systemFont(ofSize: 15), width: 250, height: 40)
        
        viewModel.signinToMain {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
                //로그인 성공후 화면전환
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
                
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                
                windowScene.windows.first?.makeKeyAndVisible()
            })
        }
        
    }
}
