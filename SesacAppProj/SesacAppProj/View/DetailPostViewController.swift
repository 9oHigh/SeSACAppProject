//
//  WriteViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//

import UIKit


class DetailPostViewController : BaseViewController {
    
    var tableView = UITableView()
    var headerView = PostTopView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigures()
        setUI()
        setConstraints()
        bind()
        
    }
    
    override func setConfigures() {
        view.backgroundColor = .white
    }
    
    override func setUI() {
        
    }
    
    override func setConstraints() {
        
    }
    
    override func bind() {
        
    }
}

//extension DetailPostViewController : UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        
////        let modifyAction = UIAction(title: "수정",image: UIImage(systemName: "applepencil")) { action in
////
////        }
////
////        let deleteAction = UIAction(title: "삭제",image: UIImage(systemName: "trash.circle"), attributes: .destructive) { action in
////
////        }
//    }
//    
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return headerView
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 250
//    }
//}
