import UIKit
import PlaygroundSupport

final class SnackButton: UIButton {

    var scaleUp:UIViewPropertyAnimator?
    var scaleDown:UIViewPropertyAnimator?
    
    
//    @IBInspectable public var buttonBackgroundColor:UIColor = UIColor.systemPink {
//        didSet {
//            self.backgroundColor = buttonBackgroundColor
//            self.badgeCountLabel.textColor = buttonBackgroundColor
//        }
//    }
    
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
        configureAnimators()
    }

    func configureAnimators() {
        scaleUp = UIViewPropertyAnimator(duration: 0.3, curve: UIView.AnimationCurve.easeIn) {
            self.badgeView.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        }
        scaleDown = UIViewPropertyAnimator(duration: 0.3, curve: UIView.AnimationCurve.easeIn) {
            self.badgeView.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        }
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        
        
//        scaleUp?.startAnimation()
//        scaleDown?.startAnimation()

        print("Ended")
    }
    

    
}

let button = SnackButton(type: .custom)
let buttonSize = 100
button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
button.setTitle("🥪", for: UIControl.State.normal)
button.badgeCount = 3
button.backgroundColor = UIColor.green //backgroundColor = UIColor.systemTeal
//button.configure(title: "🥤", count: 9, backgroundColor: UIColor.systemOrange)
//button.sizeToFit()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = button
