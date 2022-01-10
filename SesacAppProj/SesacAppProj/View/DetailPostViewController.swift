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
    
    var headerView = PostTopView()
    var viewModel = DetailPostViewModel()
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "수정하기", image: UIImage(systemName: "pencil"), handler: { _ in
                let viewController = WriteViewController()
                viewController.viewModel.postId.value = self.postId
                viewController.viewModel.inputText.value = self.viewModel.post.value.text
                self.navigationController?.pushViewController(viewController, animated: true)
            }),
            UIAction(title: "삭제하기", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
                //삭제 구현
                self.viewModel.deletePost(postId: self.postId) {
                    print("FUNCTION")
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
        //자신의 게시물일 경우에만 메뉴바 사용가능
        if userId != UserDefaults.standard.object(forKey: "id") as? Int{
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "menuSmall.png"), primaryAction: nil, menu: menu )
        }
    }
    override func setConfigures() {
        title = "게시물"
        view.backgroundColor = .systemGray4
        
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func setUI() {
        view.addSubview(tableView)
        view.addSubview(commentTextField)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        
        viewModel.comment.bind { comment in
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
        //셀의 버튼 메뉴 다시
        //cell.menuButton.menu = menuObject.menu
        cell.userComment.text = path.comment
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //Comment가 없을 때 레이아웃이 깨짐.. 이유가 뭘까👀
        if viewModel.comment.value.count == 0{
            return 150
        } else {
            return UITableView.automaticDimension
        }
    }
    
}


