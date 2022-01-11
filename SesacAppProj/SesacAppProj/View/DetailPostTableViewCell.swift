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
    
    var menuButtonAction : (()->())?
    var userNickname = UILabel()
    var userComment = UILabel()
   
    var menuButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "menu.png"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.isUserInteractionEnabled = true
        self.menuButton.addTarget(self, action: #selector(menuButtonClicked), for: .touchUpInside)
        
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
    @objc func menuButtonClicked(){
        menuButtonAction?()
    }
}
