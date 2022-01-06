//
//  DetailPostTableViewCell.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//

import UIKit

class DetailPostTableViewCell: UITableViewCell {

    static let identifier = "DetailPostTableViewCell"
    
    //content
    var userNickname = UILabel()
    var userComment = UILabel()
    var menuButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setConfigure()
        setUI()
        setConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfigure(){
        
        //Cell BackgroundColor
        backgroundColor = .white
        
        //User Commnet
        userNickname.backgroundColor = .white
        userNickname.textColor = .black
        userNickname.textAlignment = .left
        userNickname.font = .boldSystemFont(ofSize: 14)
        
        userComment.backgroundColor = .white
        userNickname.textColor = .black
        userComment.numberOfLines = 0
        userComment.font = .systemFont(ofSize: 14)
        
        //Button -> ViewController에서 메뉴달기
        menuButton.backgroundColor = .white
        menuButton.tintColor = .gray
        menuButton.setImage(UIImage(systemName: "scissors.badge.ellipsis"), for: .normal)
    }
    
    func setUI(){
        //Cell
        addSubview(userNickname)
        addSubview(userComment)
        addSubview(menuButton)
    }
    
    func setConstraints(){
     
        userNickname.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(menuButton.snp.leading)
            make.bottom.equalTo(userComment.snp.top)
        }
        
        menuButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(userNickname.snp.trailing)
            make.height.equalTo(20)
        }
        
        userComment.snp.makeConstraints { make in
            make.top.equalTo(userNickname.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
    
}
