import UIKit

class VView:UIView
{
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    
    init(controller:CController)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func constraints(
        initialLeft:CGFloat,
        initialRight:CGFloat,
        initialTop:CGFloat,
        initialBottom:CGFloat)
    {
        layoutLeft = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:initialLeft)
        layoutRight = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:initialRight)
        layoutTop = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:initialTop)
        layoutBottom = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:superview,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:initialBottom)
        
        let constraints:[NSLayoutConstraint] = [
            layoutLeft,
            layoutRight,
            layoutTop,
            layoutBottom
        ]
        
        superview?.addConstraints(constraints)
    }
}
