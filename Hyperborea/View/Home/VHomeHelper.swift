import UIKit

class VHomeHelper:UIView
{
    private weak var controller:CHome!
    private weak var viewSend:VHomeHelperSend!
    private let kSendMarginVertical:CGFloat = 5
    private let kSendRight:CGFloat = -5
    private let kSendWidth:CGFloat = 100
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        visualEffect.isUserInteractionEnabled = false
        
        let viewSend:VHomeHelperSend = VHomeHelperSend(controller:controller)
        self.viewSend = viewSend
        
        addSubview(visualEffect)
        addSubview(viewSend)
        
        let layoutVisualEffectTop:NSLayoutConstraint = NSLayoutConstraint(
            item:visualEffect,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutVisualEffectBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:visualEffect,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutVisualEffectLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:visualEffect,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutVisualEffectRight:NSLayoutConstraint = NSLayoutConstraint(
            item:visualEffect,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutViewSendTop:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSend,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kSendMarginVertical)
        let layoutViewSendBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSend,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:-kSendMarginVertical)
        let layoutViewSendRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSend,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:kSendRight)
        let layoutViewSendWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSend,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kSendWidth)
        
        addConstraints([
            layoutVisualEffectTop,
            layoutVisualEffectBottom,
            layoutVisualEffectLeft,
            layoutVisualEffectRight,
            layoutViewSendTop,
            layoutViewSendBottom,
            layoutViewSendRight,
            layoutViewSendWidth])
    }
}
