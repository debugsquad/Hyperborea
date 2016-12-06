import UIKit

class VHomeHelper:UIView
{
    private weak var controller:CHome!
    private weak var viewSend:VHomeHelperSend!
    private weak var viewClear:VHomeHelperClear!
    private weak var viewCancel:VHomeHelperCancel!
    private let kSendMarginVertical:CGFloat = 9
    private let kSendRight:CGFloat = -9
    private let kSendWidth:CGFloat = 100
    private let kCancelWidth:CGFloat = 50
    private let kClearLeft:CGFloat = 10
    private let kClearWidth:CGFloat = 50
    
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
        
        let viewClear:VHomeHelperClear = VHomeHelperClear(controller:controller)
        self.viewClear = viewClear
        
        let viewCancel:VHomeHelperCancel = VHomeHelperCancel(controller:controller)
        self.viewCancel = viewCancel
        
        addSubview(visualEffect)
        addSubview(viewSend)
        addSubview(viewClear)
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
        
        let layoutViewClearTop:NSLayoutConstraint = NSLayoutConstraint(
            item:viewClear,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutViewClearBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:viewClear,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutViewClearLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewClear,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:kClearLeft)
        let layoutViewClearWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:viewClear,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kClearWidth)
        
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
            layoutViewClearTop,
            layoutViewClearBottom,
            layoutViewClearLeft,
            layoutViewClearWidth,
            layoutViewCancelTop,
            layoutViewCancelBottom,
            layoutViewCancelLeft,
            layoutViewCancelWidth])
    }
    
    //MARK: public
    
    func textNotEmpty()
    {
        viewSend.activate()
        viewCancel.activate()
    }
    
    func textEmpty()
    {
        viewSend.deactivate()
        viewCancel.deactivate()
    }
}
