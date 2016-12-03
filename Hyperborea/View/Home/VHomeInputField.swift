import UIKit

class VHomeInputField:UIView
{
    private weak var controller:CHome!
    private let kMarginVertical:CGFloat = 10
    
    convenience init(controller:CHome)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.white
        self.controller = controller
    }
    
    //MARK: public
    
    func initConstraints(left:CGFloat, right:CGFloat)
    {
        let layoutBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:kMarginVertical)
        let layoutTop:NSLayoutConstraint = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kMarginVertical)
        let layoutLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:right)
        let layoutRight:NSLayoutConstraint = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:right)
        
        let constraints:[NSLayoutConstraint] = [
            layoutBottom,
            layoutTop,
            layoutLeft,
            layoutRight
        ]
        
        superview?.addConstraints(constraints)
    }
}
