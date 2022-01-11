//
//  WriteViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//

import UIKit


class DetailPostViewController : BaseViewController {
    
    var tableView = UITableView(frame: CGRect(), style: .grouped)
    var commentTextField = UITextField() // 하단에 넣기
    var commentPushButton = UIButton() // 하단에 넣기
    var commentView = UIView()
    var headerView = PostTopView()
    var viewModel = DetailPostViewModel()
    
    //이게 맞는건가..
    //MARK: Require Code Refactoring
    var menuItems: [UIAction] {
        return [
            UIAction(title: "수정하기", image: UIImage(systemName: "pencil"), handler: { _ in
                //수정시 값전달
                let viewController = WriteViewController()
                viewController.viewModel.postId.value = self.postId
                viewController.viewModel.inputText.value = self.viewModel.post.value.text
                self.navigationController?.pushViewController(viewController, animated: true)
            }),
            UIAction(title: "삭제하기", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
                //삭제 구현
                self.viewModel.deletePost(postId: self.postId) {
                    self.showToast(message: "삭제완료!", font: .systemFont(ofSize: 17), width: 150, height: 40)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            })
        ]
    }
    var menu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
    }
    var postId = ""
    var userId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigures()
        setUI()
        setConstraints()
        bind()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DetailPostTableViewCell.self, forCellReuseIdentifier: DetailPostTableViewCell.identifier)
        
        viewModel.recievePost(postId: self.postId) {
            if self.viewModel.errorMessage != ""{
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 15), width: 200, height: 40)
            }
        }
        viewModel.receiveComments(postId: self.postId) {
            if self.viewModel.errorMessage != ""{
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 15), width: 200, height: 40)
            }
        }
        //자신의 게시물일 경우에만 메뉴바 사용가능
        if userId != UserDefaults.standard.object(forKey: "id") as? Int{
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "menuSmall.png"), primaryAction: nil, menu: menu )
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.recievePost(postId: self.postId) {
            if self.viewModel.errorMessage != ""{
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 15), width: 200, height: 40)
            }
        }
        viewModel.receiveComments(postId: self.postId) {
            if self.viewModel.errorMessage != ""{
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 15), width: 200, height: 40)
            }
        }
    }
    override func setConfigures() {
        
        //View
        title = "게시물"
        view.backgroundColor = .systemGray4
        //TableView
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        
        //TextField view
        commentView.backgroundColor = .white
        //TextField
        commentTextField.layer.cornerRadius = 5
        commentTextField.backgroundColor = .systemGray5
        commentTextField.placeholder = "댓글을 입력해보세요"
        commentTextField.addTarget(self, action: #selector(commentTextFieldDidChange), for: .editingChanged)
        //앞쪽 여백주기
        commentTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        //Push Button
        commentPushButton.backgroundColor = .white
        commentPushButton.layer.borderWidth = 0.5
        commentPushButton.layer.borderColor = UIColor.black.cgColor
        commentPushButton.layer.cornerRadius = 5
        commentPushButton.setTitle("✏️", for: .normal)
        commentPushButton.addTarget(self, action: #selector(pushButtonClicked), for: .touchUpInside)
        
    }
    
    override func setUI() {
        
        view.addSubview(tableView)
        view.addSubview(commentView)
        commentView.addSubview(commentTextField)
        commentView.addSubview(commentPushButton)
    }
    
    override func setConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        commentView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.trailing.equalTo(commentPushButton.snp.leading).offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        commentPushButton.snp.makeConstraints { make in
            make.centerY.equalTo(commentTextField.snp.centerY)
            make.trailing.equalTo(-10)
            make.leading.equalTo(commentTextField.snp.trailing)
            make.height.equalTo(40)
            make.width.equalTo(45)
        }
    }
    
    override func bind() {
        
        viewModel.comment.bind { comment in
            self.commentTextField.text = comment
        }
        
        viewModel.comments.bind { comment in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.post.bind { post in
            DispatchQueue.main.async {
                self.headerView.nicknameLabel.text = post.user.username
                let newDate = post.createdAt.toDate()?.toString()
                self.headerView.createAtLabel.text = newDate
                self.headerView.contentLabel.text = post.text
                self.headerView.commentCntLabel.text = "댓글 \(post.comments.count)개"
                self.headerView.commentImageView.image = post.comments.count == 0 ? UIImage(systemName: "bubble.right") : UIImage(systemName: "bubble.right.fill")
            }
        }
        
    }
    
    @objc func pushButtonClicked(){
        viewModel.uploadComment(postId: postId, comment: self.viewModel.comment.value) {
            
            if self.viewModel.errorMessage != "" {
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 17), width: 180, height: 40)
                
            } else {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.viewModel.recievePost(postId: self.postId) {
                        if self.viewModel.errorMessage != ""{
                            self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 15), width: 200, height: 40)
                        }
                    }
                    self.viewModel.receiveComments(postId: self.postId) {
                        if self.viewModel.errorMessage != ""{
                            self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 15), width: 200, height: 40)
                        }
                    }
                    self.commentTextField.text = ""
                    self.showToast(message: "댓글을 저장했습니다.", font: .systemFont(ofSize: 17), width: 180, height: 40)
                })
            }
        }
    }
    
    @objc func commentTextFieldDidChange(_ textField: UITextField){
        viewModel.comment.value = textField.text ?? ""
    }
}

extension DetailPostViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPostTableViewCell.identifier, for: indexPath) as? DetailPostTableViewCell else {
            return UITableViewCell()
        }
        
        let path  = viewModel.cellForRowAt(at: indexPath)
        
        cell.userNickname.text = path.user.username
        cell.userComment.text = path.comment
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        //Comment가 없을 때 레이아웃이 깨짐.. 이유가 뭘까👀
        if viewModel.comments.value.count == 0 {
            return 150
        } else {
            return UITableView.automaticDimension
        }
    }
}


