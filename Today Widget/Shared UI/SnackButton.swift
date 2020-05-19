//
//  SnackButton.swift
//  Today Widget
//
//  Created by Bernd Plontsch on 08.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit

final class SnackButton: UIButton {
    
    var primaryColor:UIColor = UIColor.gray
    var hideCount = true
    public var descriptionString:String = "" {
        didSet {
            descriptionLabel.text = descriptionString
            descriptionLabel.sizeToFit()
        }
    }
    
    var editing:Bool = false {
        didSet {
            if editing {
                UIView.animate(withDuration: 0.2) {
                    self.backgroundColor = UIColor.systemGray5 //UIColor.clear
                    //self.layer.borderWidth = 2.0
                    //self.layer.borderColor = UIColor.systemGray3.cgColor
                    self.badgeView.isHidden = true
                    self.descriptionLabel.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.descriptionLabel.isHidden = true
                    self.backgroundColor = self.primaryColor
                    self.layer.borderWidth = 0
                    if self.badgeCount != 0 && self.hideCount {
                        self.badgeView.isHidden = false
                    }
                    self.badgeCountLabel.textColor = self.primaryColor
                }
            }
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            self.badgeCountLabel.textColor = backgroundColor
        }
    }
    
    var badgeView:UIView = UIView()
    var badgeCountLabel:UILabel = UILabel()
    var descriptionLabel:UILabel = UILabel()
    
    public var badgeCount:Int = 0 {
        didSet {
            badgeCountLabel.text = "\(self.badgeCount)"
            if badgeCount == 0 {
                self.badgeView.isHidden = true
            } else {
                if editing == false && hideCount{
                    self.badgeView.isHidden = false
                }
            }
        }
    }

    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.badgeView.isHidden = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.badgeView.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func configure(title:String, count:Int, backgroundColor:UIColor) {
        self.badgeCount = count
        self.setTitle(title, for: .normal)
        self.backgroundColor = primaryColor
        self.editing = true
    }
    
    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
        self.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        
        let badgeSize:CGFloat = 26.0
        let badgeInset:CGFloat = 8.0
        let badgeCornerRadius = badgeSize / 2.0
        let badgePositionX = self.bounds.width - badgeSize - badgeInset
        
        // Badge
        self.badgeView.frame = CGRect(x: badgePositionX, y: badgeInset, width: badgeSize, height: badgeSize)
        self.badgeView.backgroundColor = UIColor.white
        self.badgeView.layer.cornerRadius = badgeCornerRadius
        self.badgeView.layer.masksToBounds = true
        
        // Count
        self.badgeCountLabel.textColor = self.backgroundColor?.saturated() // satured() // self.buttonBackgroundColor
        badgeCountLabel.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)
        badgeCountLabel.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        badgeCountLabel.textAlignment = .center
        self.badgeView.addSubview(badgeCountLabel)
        
        // Description
        //descriptionLabel.text = "2311 Cal"
        descriptionLabel.isHidden = true
        descriptionLabel.font = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.medium)
        descriptionLabel.textColor = UIColor.label
        descriptionLabel.sizeToFit()
        descriptionLabel.center = CGPoint(x: self.frame.width/2.0, y: frame.height-descriptionLabel.frame.height-4.0)
        descriptionLabel.textAlignment = .center
        self.addSubview(descriptionLabel)
        
        self.addSubview(self.badgeView)
    }
        
}

extension UIColor {
    func darkened()->UIColor {
        let modifier:CGFloat = 0.8
        
        var alpha:CGFloat = 0.0
        var hue:CGFloat = 0.0
        var saturation:CGFloat = 0.0
        var brightness:CGFloat = 0.0
        
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness * modifier, alpha: alpha)
    }
    
    func saturated()->UIColor {
        let modifier:CGFloat = 2.4
        
        var alpha:CGFloat = 0.0
        var hue:CGFloat = 0.0
        var saturation:CGFloat = 0.0
        var brightness:CGFloat = 0.0
        
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation * modifier, brightness: brightness, alpha: alpha)
    }
}
