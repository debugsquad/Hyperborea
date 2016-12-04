import UIKit

class VHomeHelper:UIView
{
    private weak var controller:CHome!
    private weak var viewSend:VHomeHelperSend!
    private weak var viewCancel:VHomeHelperCancel!
    private let kSendMarginVertical:CGFloat = 9
    private let kSendRight:CGFloat = -9
    private let kSendWidth:CGFloat = 100
    private let kCancelWidth:CGFloat = 60
    
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
        
        let viewCancel:VHomeHelperCancel = VHomeHelperCancel(controller:controller)
        self.viewCancel = viewCancel
        
        addSubview(visualEffect)
        addSubview(viewSend)
        addSubview(viewCancel)
        
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
        
        let layoutViewCancelTop:NSLayoutConstraint = NSLayoutConstraint(
            item:viewCancel,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutViewCancelBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:viewCancel,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutViewCancelLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewCancel,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutViewCancelWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:viewCancel,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kCancelWidth)
        
        addConstraints([
            layoutVisualEffectTop,
            layoutVisualEffectBottom,
            layoutVisualEffectLeft,
            layoutVisualEffectRight,
            layoutViewSendTop,
            layoutViewSendBottom,
            layoutViewSendRight,
            layoutViewSendWidth,
            layoutViewCancelTop,
            layoutViewCancelBottom,
            layoutViewCancelLeft,
            layoutViewCancelWidth])
    }
}
