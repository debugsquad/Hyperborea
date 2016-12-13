import UIKit

class VHomeFroobClock:UIView
{
    weak var timer:Timer?
    private weak var controller:CHomeFroob!
    private weak var label:UILabel!
    private let kTimeFormat:String = "00:%@:%@"
    private let kFontSize:CGFloat = 24
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
        label.textColor = UIColor.genericBlue
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
        
            let lastSearch:TimeInterval = MSession.sharedInstance.settings?.lastSearch
        
        else
        {
            return
        }
        
        let timeout:TimeInterval = lastSearch + MSession.sharedInstance.kFroobCoolTime
        let currentTime:TimeInterval = Date().timeIntervalSince1970
        let remainTime:TimeInterval = timeout - currentTime
        
        if remainTime < 0
        {
            timer.invalidate()
            controller.close()
        }
        else
        {
            let minutes:Int = Int(remainTime / kMinutesPerSecond)
            let seconds:Int = Int(remainTime) % Int(kMinutesPerSecond)
            let stringMinutes:String
            let stringSeconds:String
            let stringTime:String
            
            if minutes > 9
            {
                stringMinutes = "\(minutes)"
            }
            else
            {
                stringMinutes = "0\(minutes)"
            }
            
            if seconds > 9
            {
                stringSeconds = "\(seconds)"
            }
            else
            {
                stringSeconds = "0\(seconds)"
            }
            
            stringTime = String(
                format:kTimeFormat,
                stringMinutes,
                stringSeconds)
            
            label.text = stringTime
        }
    }
}
