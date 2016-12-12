import UIKit

class VHomeHelper:UIView
{
    weak var viewCancel:VHomeHelperCancel!
    private weak var controller:CHome!
    private weak var viewSend:VHomeHelperSend!
    private weak var viewClear:VHomeHelperClear!
    private weak var viewFlux:VHomeHelperFlux!
    private weak var layoutViewFluxLeft:NSLayoutConstraint!
    private let kSendMarginVertical:CGFloat = 9
    private let kSendRight:CGFloat = -9
    private let kSendWidth:CGFloat = 100
    private let kCancelWidth:CGFloat = 50
    private let kClearWidth:CGFloat = 50
    private let kFluxWidth:CGFloat = 80
    
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
        
        let viewFlux:VHomeHelperFlux = VHomeHelperFlux(controller:controller)
        self.viewFlux = viewFlux
        
        addSubview(visualEffect)
        addSubview(viewSend)
        addSubview(viewClear)
        addSubview(viewCancel)
        addSubview(viewFlux)
        
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
            toItem:viewCancel,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
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
        
        let layoutViewFluxTop:NSLayoutConstraint = NSLayoutConstraint(
            item:viewFlux,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutViewFluxBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:viewFlux,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        layoutViewFluxLeft = NSLayoutConstraint(
            item:viewFlux,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutViewFluxWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:viewFlux,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kFluxWidth)
        
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
            layoutViewCancelWidth,
            layoutViewFluxTop,
            layoutViewFluxBottom,
            layoutViewFluxLeft,
            layoutViewFluxWidth])
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainFlux:CGFloat = width - kFluxWidth
        let marginFlux:CGFloat = remainFlux / 2.0
        layoutViewFluxLeft.constant = marginFlux
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func textNotEmpty()
    {
        viewSend.activate()
        viewClear.activate()
    }
    
    func textEmpty()
    {
        viewSend.deactivate()
        viewClear.deactivate()
    }
}
