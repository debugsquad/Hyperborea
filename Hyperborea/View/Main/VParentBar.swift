import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var labelTitle:UILabel!
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        border.backgroundColor = UIColor.background
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.bold(size:20)
        labelTitle.textColor = UIColor.black
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.text = NSLocalizedString("Word search", comment:"")
        self.labelTitle = labelTitle
        
        addSubview(border)
        addSubview(labelTitle)
        
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
        
        let layoutLabelTitleLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutLabelTitleRight:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        let layoutLabelTitleTop:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:20)
        let layoutLabelTitleBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        
        let constraints:[NSLayoutConstraint] = [
            layoutBorderLeft,
            layoutBorderRight,
            layoutBorderHeight,
            layoutBorderBottom,
            layoutLabelTitleTop,
            layoutLabelTitleLeft,
            layoutLabelTitleRight,
            layoutLabelTitleBottom
        ]
        
        addConstraints(constraints)
    }
}
