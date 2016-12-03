import UIKit

class VHomeInputPlaceholder:UIView
{
    private let kLabelWidth:CGFloat = 150
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:30)
        label.textColor = UIColor(white:0.8, alpha:1)
        
        addSubview(label)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:20)
        let layoutLabelWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.width,
            multiplier:1,
            constant:kLabelWidth)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelWidth
            ])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
