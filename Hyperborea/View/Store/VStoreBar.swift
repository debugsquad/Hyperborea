import UIKit

class VStoreBar:UIView
{
    private weak var controller:CStore!
    private let kButtonWidth:CGFloat = 65
    private let kContentTop:CGFloat = 20
    
    convenience init(controller:CStore)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.clear
        button.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        button.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        button.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        button.imageView!.contentMode = UIViewContentMode.center
        button.imageView!.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(
            top:0,
            left:0,
            bottom:0,
            right:32)
        button.addTarget(
            self,
            action:#selector(self.actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericStore")
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor.genericBorder
        border.clipsToBounds = true
        
        addSubview(button)
        addSubview(imageView)
        addSubview(border)
        
        let layoutButtonTop:NSLayoutConstraint = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kContentTop)
        let layoutButtonBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutButtonLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutButtonWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kButtonWidth)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kContentTop)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:border,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:1)
        let layoutBorderBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:border,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutBorderLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:border,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutBorderRight:NSLayoutConstraint = NSLayoutConstraint(
            item:border,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutButtonTop,
            layoutButtonBottom,
            layoutButtonLeft,
            layoutButtonWidth,
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageRight,
            layoutBorderHeight,
            layoutBorderBottom,
            layoutBorderLeft,
            layoutBorderRight])
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
}
