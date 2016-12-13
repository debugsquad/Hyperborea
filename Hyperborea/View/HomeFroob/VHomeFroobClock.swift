import UIKit

class VHomeFroobClock:UIView
{
    private weak var controller:CHomeFroob!
    private weak var label:UILabel!
    private weak var timer:Timer?
    private let kTimeFormat:String = "%@:%@"
    private let kFontSize:CGFloat = 40
    private let kTimerInterval:TimeInterval = 0.5
    private let kMinutesPerSecond:TimeInterval = 60
    
    convenience init(controller:CHomeFroob)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:kFontSize)
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        addSubview(label)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelRight])
        
        timer = Timer.scheduledTimer(
            timeInterval:kTimerInterval,
            target:self,
            selector:#selector(tick(sender:)),
            userInfo:nil,
            repeats:true)
    }
    
    func tick(sender timer:Timer)
    {
        guard
        
            let timeout:TimeInterval = MSession.sharedInstance.settings?.lastSearch
        
        else
        {
            return
        }
        
        let currentTime:TimeInterval = Date().timeIntervalSince1970
        let remainTime:TimeInterval = currentTime - timeout
        
        if remainTime < 0
        {
            timer.invalidate()
        }
        else
        {
            let minutes:TimeInterval = floor(remainTime / kMinutesPerSecond)
            let seconds:Int = Int(remainTime) % Int(kMinutesPerSecond)
            let stringMinutes:String
            let stringSeconds:String
            let stringTime:String
            
            if minutes > 9
            {
                stringMinutes = "0\(minutes)"
            }
            else
            {
                stringMinutes = "\(minutes)"
            }
            
            if seconds > 9
            {
                stringSeconds = "0\(seconds)"
            }
            else
            {
                stringSeconds = "\(seconds)"
            }
            
            stringTime = String(
                format:kTimeFormat,
                stringMinutes,
                stringSeconds)
            
            label.text = stringTime
        }
    }
}
