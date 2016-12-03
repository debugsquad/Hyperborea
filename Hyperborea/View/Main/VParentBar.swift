import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var labelTitle:UILabel!
    private let kTitleTop:CGFloat = 20
    private let kTitleLeft:CGFloat = 20
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.bold(size:16)
        labelTitle.textColor = UIColor.black
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.text = NSLocalizedString("Dictionary", comment:"")
        self.labelTitle = labelTitle

        addSubview(labelTitle)
        
        let layoutLabelTitleLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:kTitleLeft)
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
            constant:kTitleTop)
        let layoutLabelTitleBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutLabelTitleTop,
            layoutLabelTitleLeft,
            layoutLabelTitleRight,
            layoutLabelTitleBottom
            ])
    }
}
