//
//  WriteViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//

import UIKit


class DetailPostViewController : BaseViewController {
    
    var tableView = UITableView(frame: CGRect(), style: .grouped)
    var commentTextField = UITextField()
    
    var headerView = PostTopView()
    var viewModel = DetailPostViewModel()
    var postId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "게시물"
        
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
    }
    override func setConfigures() {
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
