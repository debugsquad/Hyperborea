import UIKit

class VHomeInput:UIView
{
    private weak var controller:CHome!
    private weak var viewText:VHomeInputText!
    
    convenience init(controller:CHome)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let barHeight:CGFloat = VParent.kBarHeight
        let viewText:VHomeInputText = VHomeInputText(controller:controller)
        self.viewText = viewText
        
        addSubview(viewText)
        
        let layoutViewTextTop:NSLayoutConstraint = NSLayoutConstraint(
            item:viewText,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:barHeight)
        let layoutViewTextBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:viewText,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutViewTextLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewText,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutViewTextRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewText,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)

        addConstraints([
            layoutViewTextTop,
            layoutViewTextBottom,
            layoutViewTextLeft,
            layoutViewTextRight
                ])
    }
}
