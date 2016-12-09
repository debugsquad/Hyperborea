import UIKit

class VParent:UIView
{
    static let kBarHeight:CGFloat = 64
    
    private weak var viewBar:VParentBar!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.3
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let viewBar:VParentBar = VParentBar(
            controller:controller)
        self.viewBar = viewBar
        addSubview(viewBar)
        
        layoutBarTop = NSLayoutConstraint(
            item:viewBar,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutBarHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewBar,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:VParent.kBarHeight)
        let layoutBarLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewBar,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutBarRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewBar,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutBarTop,
            layoutBarHeight,
            layoutBarLeft,
            layoutBarRight
            ])
    }
    
    //MARK: public
    
    func mainView(view:VView)
    {
        insertSubview(view, belowSubview:viewBar)
        view.constraints(
            initialLeft:0,
            initialRight:0,
            initialTop:0,
            initialBottom:0)
    }
    
    func animateOver(view:VView, completion:@escaping(() -> ()))
    {
        view.alpha = 0
        addSubview(view)
        view.constraints(
            initialLeft:0,
            initialRight:0,
            initialTop:0,
            initialBottom:0)
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak view] in
            
            view?.alpha = 1
        })
        { (done:Bool) in
        
            completion()
        }
    }
    
    func scrollDidScroll(offsetY:CGFloat)
    {
        if offsetY > 0
        {
            layoutBarTop.constant = 0
        }
        else
        {
            layoutBarTop.constant = offsetY
        }
    }
    
    func restartScroll()
    {
        layoutBarTop.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration)
        {
            self.layoutIfNeeded()
        }
    }
}
