//
//  DetailPostTableViewCell.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//

import UIKit
import SnapKit

class DetailPostTableViewCell: UITableViewCell {

    static let identifier = "DetailPostTableViewCell"
    
    //content
    var userNickname = UILabel()
    var userComment = UILabel()
    var menuButton = UIButton()
    //var menuObject = Menu()
    
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
        userNickname.font = .boldSystemFont(ofSize: 16)
        
        userComment.backgroundColor = .white
        userComment.textColor = .black
        userComment.numberOfLines = 0
        userComment.font = .systemFont(ofSize: 15)
        
        //Button -> ViewController에서 메뉴달기
        menuButton.backgroundColor = .white
        menuButton.tintColor = .lightGray
        //MARK: 버튼의 메뉴 다시
        //menuButton.menu = menuObject.menu
        menuButton.setImage(UIImage(named: "menu.png"), for: .normal)
    }
    
    func setUI(){
        //Cell
        addSubview(userNickname)
        addSubview(userComment)
        addSubview(menuButton)
    }
    
    func setConstraints(){
     
        userNickname.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(15)
            make.trailing.equalTo(menuButton.snp.leading)
            make.bottom.equalTo(userComment.snp.top)
        }
        
        menuButton.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.trailing.equalTo(-15)
            make.leading.equalTo(userNickname.snp.trailing)
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        
        userComment.snp.makeConstraints { make in
            make.top.equalTo(userNickname.snp.bottom)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
            make.bottom.equalTo(-10)
        }
    }
}
