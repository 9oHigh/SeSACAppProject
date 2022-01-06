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
    
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "새싹농장🌱"
        
        setConfigures()
        setUI()
        setConstraints()
        bind()
        viewModel.receivePosts{
            if self.viewModel.errorMessage != ""{
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 15), width: 200, height: 40)
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func setConfigures() {
        //Main
        view.backgroundColor = .white
        
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

        plusBtn.frame = CGRect(x: (UIScreen.main.bounds.width * 2 + 30) / 3, y:UIScreen.main.bounds.height - 220 , width: 80, height: 80)
    }
    
    override func bind() {
        viewModel.posts.bind { post in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: PUSH Write Page
    @objc func plusBtnClicked(){
        
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
        cell.createAtLabel.text = path.createdAt
        cell.commentLabel.text = path.comments.count == 0 ? "댓글쓰기" : "댓글 \(path.comments.count)개"
        cell.commentImageView.image = path.comments.count == 0 ? UIImage(systemName: "bubble.right") : UIImage(systemName: "bubble.right.fill")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: PUSH Comment Page
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        plusBtn.frame.origin.y = UIScreen.main.bounds.height - 220 + scrollView.contentOffset.y
    }
}

