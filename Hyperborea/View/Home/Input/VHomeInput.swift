import UIKit

class VHomeInput:UIView
{
    weak var viewText:VHomeInputText!
    private weak var controller:CHome!
    private weak var viewPlaceholder:VHomeInputPlaceholder!
    private weak var layoutViewTextHeight:NSLayoutConstraint!
    let kMaxHeight:CGFloat = 150
    private let kPlaceholderHeight:CGFloat = 36
    
    convenience init(controller:CHome)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let barHeight:CGFloat = VParent.kBarHeight
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        visualEffect.isUserInteractionEnabled = false
        
        let viewText:VHomeInputText = VHomeInputText(controller:controller)
        self.viewText = viewText
        
        let viewPlaceholder:VHomeInputPlaceholder = VHomeInputPlaceholder()
        self.viewPlaceholder = viewPlaceholder
        
        addSubview(visualEffect)
        addSubview(viewPlaceholder)
        addSubview(viewText)
        
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
        
        layoutViewTextHeight = NSLayoutConstraint(
            item:viewText,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:viewText.kMaxHeight)
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
        
        let layoutViewPlaceholderTop:NSLayoutConstraint = NSLayoutConstraint(
            item:viewPlaceholder,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:barHeight)
        let layoutViewPlaceholderHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewPlaceholder,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kPlaceholderHeight)
        let layoutViewPlaceholderLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewPlaceholder,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutViewPlaceholderRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewPlaceholder,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)

        addConstraints([
            layoutVisualEffectTop,
            layoutVisualEffectBottom,
            layoutVisualEffectLeft,
            layoutVisualEffectRight,
            layoutViewTextHeight,
            layoutViewTextBottom,
            layoutViewTextLeft,
            layoutViewTextRight,
            layoutViewPlaceholderTop,
            layoutViewPlaceholderHeight,
            layoutViewPlaceholderLeft,
            layoutViewPlaceholderRight])
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.height
        let percent:CGFloat = height / kMaxHeight
        let textHeight:CGFloat = viewText.kMaxHeight * percent
        layoutViewTextHeight.constant = textHeight
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func showPlaceholder()
    {
        viewPlaceholder.isHidden = false
    }
    
    func hidePlaceholder()
    {
        viewPlaceholder.isHidden = true
    }
}
