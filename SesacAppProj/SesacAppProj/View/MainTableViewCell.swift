//
//  MainTableViewCell.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {

    static let identifier = "MainTableViewCell"
    
    var topView = UIView()
    var nicknameLabel = UILabel()
    var contentLabel = UILabel()
    var createAtLabel = UILabel()
    
    var bottomView = UIView()
    var commentImageView = UIImageView()
    var commentLabel = UILabel()
    
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
        backgroundColor = .systemGray5
        
        //Top View
        topView.backgroundColor = .white
        
        //TopView elements
        //username
        nicknameLabel.backgroundColor = .systemGray5
        nicknameLabel.textColor = .darkGray
        nicknameLabel.font = .systemFont(ofSize: 14)
        
        //content
        contentLabel.numberOfLines = 2
        contentLabel.backgroundColor = .white
        contentLabel.textColor = .black
        contentLabel.font = .systemFont(ofSize: 17)
        
        //create date
        createAtLabel.backgroundColor = .white
        createAtLabel.textColor = .darkGray
        createAtLabel.font = .systemFont(ofSize: 14)
        
        //Bottom View
        bottomView.backgroundColor = .white
        
        //comment image
        commentImageView.tintColor = .darkGray
        commentImageView.contentMode = .scaleAspectFit
        
        //comment
        commentLabel.backgroundColor = .white
        commentLabel.textColor = .darkGray
        commentLabel.font = .systemFont(ofSize: 14)

    }
    
    func setUI(){
        //Cell
        addSubview(topView)
        addSubview(bottomView)
        
        //Top View
        topView.addSubview(nicknameLabel)
        topView.addSubview(contentLabel)
        topView.addSubview(createAtLabel)
        
        //Bottom View
        bottomView.addSubview(commentImageView)
        bottomView.addSubview(commentLabel)
        
    }
    
    func setConstraints(){
        
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.bottom.equalTo(bottomView.snp.top).offset(-1)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.35)
            make.leading.equalTo(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.leading.equalTo(10)
            make.trailing.equalTo(10)
            make.bottom.equalTo(createAtLabel.snp.top)
        }
        
        createAtLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
            make.leading.equalTo(10)
            make.bottom.equalTo(0).offset(-10)
        }
        
        commentImageView.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.bottom.equalTo(0)
            make.trailing.equalTo(commentLabel.snp.leading).offset(-5)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(commentImageView.snp.trailing)
            make.top.bottom.equalTo(0)
        }
    }
    
}
