import UIKit

class VHomeInput:UIView
{
    weak var viewText:VHomeInputText!
    private weak var controller:CHome!
    private weak var viewPlaceholder:VHomeInputPlaceholder!
    private let kPlaceholderHeight:CGFloat = 36
    
    convenience init(controller:CHome)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let barHeight:CGFloat = VParent.kBarHeight
        
        let viewText:VHomeInputText = VHomeInputText(controller:controller)
        self.viewText = viewText
        
        let viewPlaceholder:VHomeInputPlaceholder = VHomeInputPlaceholder()
        self.viewPlaceholder = viewPlaceholder
        
        addSubview(viewPlaceholder)
        addSubview(viewText)
        
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

        addConstraints([
            layoutViewTextTop,
            layoutViewTextBottom,
            layoutViewTextLeft,
            layoutViewTextRight,
            layoutViewPlaceholderTop,
            layoutViewPlaceholderHeight,
            layoutViewPlaceholderLeft,
            layoutViewPlaceholderRight])
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
