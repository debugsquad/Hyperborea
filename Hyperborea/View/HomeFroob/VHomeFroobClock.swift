import UIKit

class VHomeFroobClock:UIView
{
    private weak var controller:CHomeFroob!
    private let kFontSize:CGFloat = 40
    
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
    }
}
