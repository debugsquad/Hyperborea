import UIKit

class VHomeInput:UIView
{
    private weak var controller:CHome!
    private weak var viewText:VHomeInputText!
    private weak var viewPlaceholder:VHomeInputPlaceholder!
    private weak var viewHelper:VHomeInputHelper!
    private weak var layoutViewHelperBottom:NSLayoutConstraint!
    private let kPlaceholderHeight:CGFloat = 36
    private let kHelperHeight:CGFloat = 60
    
    convenience init(controller:CHome)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let barHeight:CGFloat = VParent.kBarHeight
        
        let viewText:VHomeInputText = VHomeInputText(controller:controller)
        self.viewText = viewText
        
        let viewHelper:VHomeInputHelper = VHomeInputHelper(controller:controller)
        self.viewHelper = viewHelper
        
        let viewPlaceholder:VHomeInputPlaceholder = VHomeInputPlaceholder()
        self.viewPlaceholder = viewPlaceholder
        
        addSubview(viewPlaceholder)
        addSubview(viewText)
        addSubview(viewHelper)
        
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
        
        layoutViewHelperBottom = NSLayoutConstraint(
            item:viewHelper,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutViewHelperHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewHelper,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kHelperHeight)
        let layoutViewHelperLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewHelper,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutViewHelperRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewHelper,
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
            layoutViewTextRight,
            layoutViewPlaceholderTop,
            layoutViewPlaceholderHeight,
            layoutViewPlaceholderLeft,
            layoutViewPlaceholderRight,
            layoutViewHelperBottom,
            layoutViewHelperHeight,
            layoutViewHelperLeft,
            layoutViewHelperRight])
    }
}
