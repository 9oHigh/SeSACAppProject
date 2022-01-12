//
//  BaseViewModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/12.
//

import Foundation
import UIKit

class BaseViewModel {
    
    func unauthorizedToStart(){
        //reset Token
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.set(0, forKey: "userId")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
            
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: StartViewController())
            
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
}
