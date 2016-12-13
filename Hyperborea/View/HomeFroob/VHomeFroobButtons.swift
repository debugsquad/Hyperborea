import UIKit

class VHomeFroobButtons:UIView
{
    private weak var controller:CHomeFroob!
    private let kButtonMargin:CGFloat = 1
    private let kButtonWidth:CGFloat = 148
    
    convenience init(controller:CHomeFroob)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.genericBorder
        self.controller = controller
        
        let buttonStore:UIButton = UIButton()
        buttonStore.translatesAutoresizingMaskIntoConstraints = false
        buttonStore.clipsToBounds = true
        buttonStore.backgroundColor = UIColor.white
        buttonStore.setTitle(
            NSLocalizedString("VHomeFroobButtons_buttonStore", comment:""),
            for:UIControlState.normal)
        buttonStore.setTitleColor(
            UIColor.genericBlue,
            for:UIControlState.normal)
        buttonStore.setTitleColor(
            UIColor(white:0, alpha:0.1),
            for:UIControlState.highlighted)
        buttonStore.titleLabel!.font = UIFont.medium(size:15)
        buttonStore.addTarget(
            self,
            action:#selector(actionStore(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.clipsToBounds = true
        buttonCancel.backgroundColor = UIColor.white
        buttonCancel.setTitle(
            NSLocalizedString("VHomeFroobButtons_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0.6, alpha:1),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0, alpha:0.1),
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.medium(size:15)
        buttonCancel.addTarget(
            self,
            action:#selector(self.actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonStore)
        addSubview(buttonCancel)
        
        let layoutButtonCancelTop:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonCancel,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kButtonMargin)
        let layoutButtonCancelBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonCancel,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutButtonCancelLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonCancel,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:kButtonMargin)
        let layoutButtonCancelWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonCancel,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kButtonWidth)
        
        let layoutButtonStoreTop:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonStore,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kButtonMargin)
        let layoutButtonStoreBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonStore,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutButtonStoreRight:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonStore,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:-kButtonMargin)
        let layoutButtonStoreWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonStore,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kButtonWidth)
        
        addConstraints([
            layoutButtonCancelTop,
            layoutButtonCancelBottom,
            layoutButtonCancelLeft,
            layoutButtonCancelWidth,
            layoutButtonStoreTop,
            layoutButtonStoreBottom,
            layoutButtonStoreRight,
            layoutButtonStoreWidth])
    }
    
    //MARK: actions
    
    func actionStore(sender button:UIButton)
    {
        controller.openStore()
    }
    
    func actionCancel(sender button:UIButton)
    {
        controller.close()
    }
}
