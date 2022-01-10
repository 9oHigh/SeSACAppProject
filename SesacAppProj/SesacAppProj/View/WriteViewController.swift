//
//  WriteViewController.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/06.
//

import UIKit


class WriteViewController : BaseViewController {
    
    let textView = UITextView()
    var viewModel = WriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigures()
        setUI()
        setConstraints()
        bind()
        
    }
    //나가기 + 완료 버튼 (left/rigth)
    override func setConfigures() {
        //View
        view.backgroundColor = .white
        title = "새싹심기🔥"
        
        //완료
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        //TextView
        textView.delegate = self
        textView.backgroundColor = .white
        textView.font = .systemFont(ofSize: 20)
    }
    
    override func setUI() {
        view.addSubview(textView)
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    override func bind() {
        viewModel.inputText.bind { text in
            self.textView.text = text
        }
    }
    
    @objc func saveButtonClicked(){
        
        if viewModel.inputText.value.count == 0 {
            
            self.showToast(message: "최소 한글자 이상 입력하세요.", font: .systemFont(ofSize: 17), width: 250, height: 45)
            
        } else {
            
            if viewModel.postId.value == "" {
                
                viewModel.uploadPost {
                    self.showToast(message: "저장완료!", font: .systemFont(ofSize: 17), width: 150, height: 40)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                
                viewModel.modifyPost {
                    self.showToast(message: "수정완료!", font: .systemFont(ofSize: 17), width: 150, height: 40)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        }
    }
}

extension WriteViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.inputText.value = textView.text ?? ""
    }
}
