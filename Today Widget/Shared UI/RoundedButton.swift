//
//  MiniButton.swift
//  Drip
//
//  Created by Bernd Plontsch on 28.04.19.
//  Copyright © 2019 Bernd Plontsch. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.backgroundColor = tintColor.cgColor
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        setTitleColor(UIColor.black, for:.normal)
        setBackgroundImage(UIImage.imageWithColor(color: tintColor), for: UIControl.State.normal)
    }
    
    func setActive(isActive:Bool) {
        if isActive {
            setBackgroundImage(UIImage.imageWithColor(color: UIColor(named: "colorInactive")!), for: UIControl.State.normal)
        } else {
            setBackgroundImage(UIImage.imageWithColor(color: tintColor), for: UIControl.State.normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2.0
    }
    
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 1.0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIColor {
    var inverted: UIColor {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        UIColor.red.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a) // Assuming you want the same alpha value.
    }
}
