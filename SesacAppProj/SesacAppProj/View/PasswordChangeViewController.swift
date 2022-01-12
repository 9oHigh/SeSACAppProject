//
//  WriteViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/11.
//

import UIKit


class PasswordChangeViewController : BaseViewController {
    
    let passwordLabel = UILabel()
    let currentPassword = UITextField()
    let newPassword = UITextField()
    let checkPassword = UITextField()
    let confirmButton = UIButton()
    
    let viewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "비밀번호 변경하기"
        
        setConfigures()
        setUI()
        setConstraints()
        bind()
    }
    
    override func setConfigures() {
        
        view.backgroundColor = .white
        
        //main label set
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 25)
        passwordLabel.numberOfLines = 0
        passwordLabel.text = "소중한 비밀번호!\n자주 변경해주기👊🏻"
        passwordLabel.textColor = .black
        passwordLabel.textAlignment = .center
        
        //current password
        currentPassword.placeholder = "현재 비밀번호"
        currentPassword.backgroundColor = .white
        currentPassword.borderStyle = .roundedRect
        currentPassword.isSecureTextEntry = true
        currentPassword.addTarget(self, action: #selector(currentTextFieldDidChange(_:)), for: .editingChanged)
        
        //Password TextField Set
        newPassword.placeholder = "새로운 비밀번호"
        newPassword.backgroundColor = .white
        newPassword.borderStyle = .roundedRect
        newPassword.isSecureTextEntry = true
        newPassword.addTarget(self, action: #selector(newPasswordTextFieldDidChange(_:)), for: .editingChanged)
        
        //Check TextField Set
        checkPassword.placeholder = "새로운 비밀번호 확인"
        checkPassword.backgroundColor = .white
        checkPassword.borderStyle = .roundedRect
        checkPassword.isSecureTextEntry = true
        checkPassword.addTarget(self, action: #selector(checkPasswordTextFieldDidChange(_:)), for: .editingChanged)
        
        //SignIn Button Set
        confirmButton.backgroundColor = .black
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        confirmButton.setTitle("변경하기", for: .normal)
        confirmButton.layer.cornerRadius = 10
        confirmButton.alpha = 0.5
        confirmButton.isEnabled = false
        confirmButton.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
    }
    
    override func setUI() {
        
        view.addSubview(passwordLabel)
        view.addSubview(currentPassword)
        view.addSubview(newPassword)
        view.addSubview(checkPassword)
        view.addSubview(confirmButton)
    }
    
    override func setConstraints() {
        
        passwordLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        currentPassword.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        newPassword.snp.makeConstraints { make in
            make.top.equalTo(currentPassword.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        checkPassword.snp.makeConstraints { make in
            make.top.equalTo(newPassword.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(checkPassword.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
    }
    override func bind() {
        
        viewModel.current.bind { text in
            self.currentPassword.text = text
        }
        
        viewModel.password.bind { text in
            self.newPassword.text = text
        }
        
        viewModel.checkPassword.bind { text in
            self.checkPassword.text = text
        }
        
        viewModel.enableBtn.bind { bool in
            self.confirmButton.isEnabled = bool
            if bool { self.confirmButton.alpha = 1 }
            else {self.confirmButton.alpha = 0.5}
        }
        
    }
    
    @objc func currentTextFieldDidChange(_ textField: UITextField){
        viewModel.current.value = textField.text ?? ""
        if viewModel.checkFullTextByChange() {
            viewModel.enableBtn.value = true
        } else {
            viewModel.enableBtn.value = false
        }
    }
    
    @objc func newPasswordTextFieldDidChange(_ textField: UITextField){
        viewModel.password.value = textField.text ?? ""
        if viewModel.checkFullTextByChange() {
            viewModel.enableBtn.value = true
        } else {
            viewModel.enableBtn.value = false
        }
    }
    
    @objc func checkPasswordTextFieldDidChange(_ textField: UITextField){
        viewModel.checkPassword.value = textField.text ?? ""
        if viewModel.checkFullTextByChange() {
            viewModel.enableBtn.value = true
        } else {
            viewModel.enableBtn.value = false
        }
    }
    
    @objc func changeButtonClicked(){
        
        viewModel.changePassword {
            if self.viewModel.errorMessage != "" {
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 17), width: 240, height: 40)
            } else {
                self.showToast(message: "시작화면으로 이동합니다.", font: .systemFont(ofSize: 17), width: 250, height: 40)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
                    
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: StartViewController())
                    
                    windowScene.windows.first?.makeKeyAndVisible()
                }
            }
        }
    }
}
