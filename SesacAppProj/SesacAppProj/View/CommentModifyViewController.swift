//
//  CommentModifyViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/11.
//

import Foundation
import UIKit

class CommentModifyViewController : BaseViewController {
    
    let textView = UITextView()
    let viewModel = CommentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigures()
        setUI()
        setConstraints()
        bind()
    }
    
    override func setConfigures() {
        //View
        title = "댓글 수정"
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        //textView
        textView.delegate = self
        textView.backgroundColor = .white
        textView.font = .systemFont(ofSize: 18)
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 8
        
        
    }
    override func setUI() {
        
        view.addSubview(textView)
    }
    
    override func setConstraints() {
        
        textView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    override func bind() {
        
        viewModel.inputText.bind { text in
            self.textView.text = text
        }
    }
    
    @objc func saveButtonClicked(){
        
        viewModel.modifyComment(commentId: self.viewModel.commentId.value, text: self.viewModel.inputText.value) {
            
            if self.viewModel.errorMessage != "" {
                self.showToast(message: self.viewModel.errorMessage, font: .systemFont(ofSize: 17), width: 190, height: 40)
            } else {
                self.showToast(message: "수정완료!", font: .systemFont(ofSize: 17), width: 150, height: 40)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
extension CommentModifyViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        viewModel.inputText.value = textView.text ?? ""
    }
}
