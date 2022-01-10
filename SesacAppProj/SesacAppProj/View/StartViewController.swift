//
//  LoginViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/04.
//

import UIKit

//MARK: 회원가입
class StartViewController : BaseViewController {
    
    //중앙
    let sesacImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    //하단
    let startButton = UIButton()
    let informLabel = UILabel()
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
        sesacImageView.image = UIImage(named: "logo_ssac_clear.png")
        
        //TitleLabel Set
        titleLabel.text = "당신 근처의 새벽농장"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        
        //SubTitle Set
        subtitleLabel.text = "iOS 지식부터 바람의 나라까지\n지금 SeSAC에서 함께해요."
        subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        //MARK: 하단 Configures
        
        //Start Button Set
        startButton.layer.cornerRadius = 15
        startButton.backgroundColor = .black
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.setTitle("시작하기", for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        //Inform Label Set
        informLabel.text = "이미 계정이 있으신가요?"
        informLabel.textColor = .gray
        informLabel.textAlignment = .center
        informLabel.font = .boldSystemFont(ofSize: 16)
        
        //Login Button Set
        loginButton.backgroundColor = .white
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    override func setUI() {
        
        view.addSubview(sesacImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(startButton)
        view.addSubview(informLabel)
        view.addSubview(loginButton)
    }
    
    override func setConstraints() {
        
        sesacImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.65)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacImageView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        informLabel.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom)
            make.leading.equalTo(20)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(informLabel.snp.top).offset(-20)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(20)
            make.trailing.equalTo(-20)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    // 회원가입 화면
    @objc func startButtonClicked(){
       
        let viewController = SignUpViewController()
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButton
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // 로그인 화면
    @objc func loginButtonClicked(){
        
        let viewController = SignInViewController()
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButton
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
}
