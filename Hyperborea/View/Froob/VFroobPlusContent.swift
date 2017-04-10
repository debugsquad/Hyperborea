import UIKit

class VFroobPlusContent:UIView
{
    private weak var controller:CFroobPlus!
    private weak var labelTimer:UILabel!
    private weak var layoutBaseLeft:NSLayoutConstraint!
    private weak var layoutCircleLeft:NSLayoutConstraint!
    private let kBaseWidth:CGFloat = 299
    private let kBaseHeight:CGFloat = 260
    private let kBaseBottom:CGFloat = -2
    private let kCornerRadius:CGFloat = 20
    private let kCircleTop:CGFloat = 2
    private let kCircleSize:CGFloat = 90
    private let kLabelTimerTop:CGFloat = 100
    private let kLabelTimerHeight:CGFloat = 50
    private let kSubtitleMargin:CGFloat = 10
    private let kSubtitleHeight:CGFloat = 80
    private let kButtonsHeight:CGFloat = 62
    private let kSecondsInMinutes:TimeInterval = 60
    
    init(controller:CFroobPlus)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bolder(size:18),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:17),
            NSForegroundColorAttributeName:UIColor.black]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VFroobPlusContent_labelTitle", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VFroobPlusContent_labelSubtitle", comment:""),
            attributes:attributesSubtitle)
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        
        let baseView:UIView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.backgroundColor = UIColor.white
        baseView.layer.cornerRadius = kCornerRadius
        
        let circle:UIView = UIView()
        circle.isUserInteractionEnabled = false
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.clipsToBounds = true
        circle.backgroundColor = UIColor.white
        circle.layer.cornerRadius = kCircleSize / 2.0
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericFroobPlus")
        
        let labelTimer:UILabel = UILabel()
        labelTimer.isUserInteractionEnabled = false
        labelTimer.translatesAutoresizingMaskIntoConstraints = false
        labelTimer.textAlignment = NSTextAlignment.center
        labelTimer.backgroundColor = UIColor.clear
        labelTimer.font = UIFont.numeric(size:35)
        labelTimer.textColor = UIColor.black
        self.labelTimer = labelTimer
        
        let labelSubtitle:UILabel = UILabel()
        labelSubtitle.isUserInteractionEnabled = false
        labelSubtitle.backgroundColor = UIColor.clear
        labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
        labelSubtitle.textAlignment = NSTextAlignment.center
        labelSubtitle.numberOfLines = 0
        labelSubtitle.attributedText = mutableString
        
        let viewButtons:VFroobPlusContentButtons = VFroobPlusContentButtons(
            controller:controller)
        
        circle.addSubview(imageView)
        baseView.addSubview(viewButtons)
        addSubview(baseView)
        addSubview(circle)
        addSubview(labelTimer)
        addSubview(labelSubtitle)
        
        NSLayoutConstraint.bottomToBottom(
            view:baseView,
            toView:self)
        NSLayoutConstraint.height(
            view:baseView,
            constant:kBaseHeight)
        layoutBaseLeft = NSLayoutConstraint.leftToLeft(
            view:baseView,
            toView:self)
        NSLayoutConstraint.width(
            view:baseView,
            constant:kBaseWidth)
        
        NSLayoutConstraint.topToTop(
            view:circle,
            toView:self,
            constant:kCircleTop)
        layoutCircleLeft = NSLayoutConstraint.leftToLeft(
            view:circle,
            toView:self)
        NSLayoutConstraint.size(
            view:circle,
            constant:kCircleSize)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:circle)
        
        NSLayoutConstraint.topToTop(
            view:labelTimer,
            toView:self,
            constant:kLabelTimerTop)
        NSLayoutConstraint.height(
            view:labelTimer,
            constant:kLabelTimerHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTimer,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:labelSubtitle,
            toView:labelTimer)
        NSLayoutConstraint.height(
            view:labelSubtitle,
            constant:kSubtitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelSubtitle,
            toView:baseView,
            margin:kSubtitleMargin)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewButtons,
            toView:baseView)
        NSLayoutConstraint.height(
            view:viewButtons,
            constant:kButtonsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewButtons,
            toView:baseView)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainBase:CGFloat = width - kBaseWidth
        let baseLeft:CGFloat = remainBase / 2.0
        let remainCircle:CGFloat = width - kCircleSize
        let circleLeft:CGFloat = remainCircle / 2.0
        
        layoutBaseLeft.constant = baseLeft
        layoutCircleLeft.constant = circleLeft
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func updateTimer(time:TimeInterval)
    {
        let minutes:Int = Int(time / kSecondsInMinutes)
        let seconds:Int = Int(time.truncatingRemainder(dividingBy:kSecondsInMinutes))
        let secondsString:String
        
        if seconds > 9
        {
            secondsString = "\(seconds)"
        }
        else
        {
            secondsString = "0\(seconds)"
        }
        
        let timeString:String = "\(minutes):\(secondsString)"
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.labelTimer.text = timeString
        }
    }
}
