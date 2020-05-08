//
//  SnackButton.swift
//  Today Widget
//
//  Created by Bernd Plontsch on 08.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit

final class SnackButton: UIButton {
    
    override var backgroundColor: UIColor? {
        didSet {
            self.badgeCountLabel.textColor = backgroundColor
        }
    }
    
    var badgeView:UIView = UIView()
    var badgeCountLabel:UILabel = UILabel()
    @IBInspectable public var badgeCount:Int = 8 {
        didSet {
            badgeCountLabel.text = "\(self.badgeCount)"
            if badgeCount == 0 {
                self.badgeView.isHidden = true
            } else {
                self.badgeView.isHidden = false
            }
        }
    }

    
    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func configure(title:String, count:Int, backgroundColor:UIColor) {
        self.badgeCount = count
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
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
        self.badgeCountLabel.textColor = self.backgroundColor // self.buttonBackgroundColor
        badgeCountLabel.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)
        badgeCountLabel.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        badgeCountLabel.textAlignment = .center
        self.badgeView.addSubview(badgeCountLabel)
        
        self.addSubview(self.badgeView)
    }
    
}
