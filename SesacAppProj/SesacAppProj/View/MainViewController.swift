//
//  ViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/04.
//

import UIKit

class MainViewController: BaseViewController {
    
    var tableView = UITableView()
    var plusBtn = UIButton()
    let refreshControl = UIRefreshControl()
    
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigures()
        setUI()
        setConstraints()
        bind()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //fetchdata
        fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }
    
    override func setConfigures() {
        
        //Main + 왼쪽 타이틀
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "비밀번호 변경", style: .plain, target: self, action: #selector(passwordChangeBtnClicked))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        let titleLabel = UILabel()
        titleLabel.text = "새싹농장🌱"
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        //refreshControl
        initRefresh()
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        tableView.rowHeight = 200
        
        //Plus Button
        plusBtn.backgroundColor = .black
        plusBtn.tintColor = .white
        plusBtn.imageView?.contentMode = .scaleAspectFit
        plusBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        
        //Shadow
        plusBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        plusBtn.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        plusBtn.layer.shadowOpacity = 1.0
        plusBtn.layer.shadowRadius = 0.0
        plusBtn.layer.masksToBounds = false
        plusBtn.layer.cornerRadius = 40
        
        plusBtn.addTarget(self, action: #selector(plusBtnClicked), for: .touchUpInside)
        
    }
    
    override func setUI() {
        
        tableView.addSubview(plusBtn)
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        //Frame
        plusBtn.frame = CGRect(x: (UIScreen.main.bounds.width * 2 + 30) / 3, y:UIScreen.main.bounds.height - 220 , width: 80, height: 80)
    }
    
    override func bind() {
        viewModel.posts.bind { post in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @objc func plusBtnClicked(){
        
        let viewController = WriteViewController()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)

        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func passwordChangeBtnClicked(){
        let viewController = PasswordChangeViewController()
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func updateUI(refresh: UIRefreshControl){
        refresh.endRefreshing()
        fetch()
        self.tableView.reloadData()
    }
    
    func initRefresh(){
        
        let refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "새로고침")
        tableView.refreshControl = refresh
    }
    
    func fetch(){
        viewModel.receivePosts{
            if self.viewModel.errorMessage != ""{
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 15), width: 200, height: 40)
            } 
        }
    }
}

extension MainViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier,for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let path = viewModel.cellForRowAt(at: indexPath)
        
        cell.nicknameLabel.text = path.user.username
        cell.contentLabel.text = path.text
        
        let newDate = path.createdAt.toDate()?.toString()
        cell.createAtLabel.text = newDate
        
        cell.commentLabel.text = path.comments.count == 0 ? "댓글쓰기" : "댓글 \(path.comments.count)개"
        cell.commentImageView.image = path.comments.count == 0 ? UIImage(systemName: "bubble.right") : UIImage(systemName: "bubble.right.fill")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = DetailPostViewController()
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        //어떤 포스트인가 - postId
        let path = viewModel.cellForRowAt(at: indexPath)
        viewController.postId = String(path.id)
        //유저아이디가 같으면 메뉴를 보여주고 같지 않다면 제거
        viewController.userId = path.user.id
        
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    //스크롤시에도 버튼 고정
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        plusBtn.frame.origin.y = UIScreen.main.bounds.height - 220 + scrollView.contentOffset.y
    }
}
