//
//  PostTopView.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//


import UIKit
import SnapKit

//Section Header View
class PostTopView : UIView {
    
    var topView = UIView()
    var middleView = UIView()
    var bottomView = UIView()
    //topView
    var userImageView = UIImageView()
    var nicknameLabel = UILabel()
    var createAtLabel = UILabel()
    //middleView
    var contentLabel = UILabel()
    //bottomView
    var commentImageView = UIImageView()
    var commentCntLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConfigure()
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setConfigure(){
        //Top,Middle,Bottom View
        topView.backgroundColor = .white
        middleView.backgroundColor = .white
        bottomView.backgroundColor = .white
        
        //TopView
        //username
        nicknameLabel.backgroundColor = .white
        nicknameLabel.textColor = .black
        nicknameLabel.font = .systemFont(ofSize: 14)
        //create date
        createAtLabel.backgroundColor = .white
        createAtLabel.textColor = .darkGray
        createAtLabel.font = .systemFont(ofSize: 14)
        //userImageView
        userImageView.image = UIImage(systemName: "person")
        
        //MiddleView
        //content
        contentLabel.numberOfLines = 0
        contentLabel.backgroundColor = .white
        contentLabel.textColor = .black
        contentLabel.font = .systemFont(ofSize: 17)

        //Bottom View
        //comment image
        commentImageView.tintColor = .darkGray
        commentImageView.contentMode = .scaleAspectFit
        
        //comment
        commentCntLabel.backgroundColor = .white
        commentCntLabel.textColor = .darkGray
        commentCntLabel.font = .systemFont(ofSize: 14)
    }
    
    func setUI(){
        //Core
        addSubview(topView)
        addSubview(middleView)
        addSubview(bottomView)
        
        //top
        topView.addSubview(userImageView)
        topView.addSubview(nicknameLabel)
        topView.addSubview(createAtLabel)
        
        //middel
        middleView.addSubview(contentLabel)
        
        //bottom
        bottomView.addSubview(commentImageView)
        bottomView.addSubview(commentCntLabel)
    
    }
    
    func setConstraints(){
        
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(middleView.snp.top).offset(-1)
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top).offset(-1)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
        
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(nicknameLabel.snp.leading)
            make.bottom.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(userImageView.snp.trailing)
            make.bottom.equalTo(createAtLabel.snp.top)
        }
        
        createAtLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom)
            make.leading.equalTo(userImageView.snp.trailing)
            make.bottom.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        commentImageView.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(commentCntLabel.snp.leading).offset(-5)
        }
        
        commentCntLabel.snp.makeConstraints { make in
            make.leading.equalTo(commentImageView.snp.trailing)
            make.top.bottom.equalToSuperview()
        }
    }
    
}
