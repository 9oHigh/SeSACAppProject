//
//  String + Date + Extension.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/10.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
extension Date {
    
    func toString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"
        
        return dateFormatter.string(from: self)
    }
}


