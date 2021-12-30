//
//  UIVIewExtension.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 28/12/21.
//

import Foundation
import UIKit

extension UIView {
    func setCornerRadous(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setBorderWidth(_ width: CGFloat, color: UIColor) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    func setBorder(radius:CGFloat, borderWidth: CGFloat, color:UIColor = UIColor.clear){
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
}

func getAlert(_ title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alert
}
