//
//  Menu.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/10.
//

import Foundation
import UIKit

struct Menu {
    var menuItems: [UIAction] {
        return [
            UIAction(title: "수정하기", image: UIImage(systemName: "pencil"), handler: { _ in
                
            }),
            UIAction(title: "삭제하기", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
                
            })
        ]
    }
    var menu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
    }
}
