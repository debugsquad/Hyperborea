import UIKit

class VHomeInput:UIView
{
    private weak var controller:CHome!
    private weak var layoutBottom:NSLayoutConstraint!
    private weak var layoutHeight:NSLayoutConstraint!
    private let kStandbyHeight:CGFloat = 100
    
    convenience init(controller:CHome)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.background
    }
    
    //MARK: public
    
    func initConstraints()
    {
        layoutBottom = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        layoutHeight = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kStandbyHeight)
        let layoutLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutRight:NSLayoutConstraint = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let constraints:[NSLayoutConstraint] = [
            layoutBottom,
            layoutHeight,
            layoutLeft,
            layoutRight
        ]
        
        superview?.addConstraints(constraints)
    }
}
