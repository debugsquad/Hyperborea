import UIKit

class VHomeWordsCellOrigin:VHomeWordsCell
{
    private weak var labelOrigin:UILabel!
    private let kLabelEntityTop:CGFloat = 10
    private let kLabelEntityBottom:CGFloat = -10
    private let kLabelEntityMarginHorizontal:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelOrigin:UILabel = UILabel()
        labelOrigin.translatesAutoresizingMaskIntoConstraints = false
        labelOrigin.numberOfLines = 0
        labelOrigin.backgroundColor = UIColor.clear
        labelOrigin.isUserInteractionEnabled = false
        self.labelOrigin = labelOrigin
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        border.backgroundColor = UIColor.genericBorder
        
        addSubview(border)
        addSubview(labelOrigin)
        
        let layoutLabelOriginTop:NSLayoutConstraint = NSLayoutConstraint(
            item:labelOrigin,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kLabelEntityTop)
        let layoutLabelOriginBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:labelOrigin,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:kLabelEntityBottom)
        let layoutLabelOriginLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:labelOrigin,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:kLabelEntityMarginHorizontal)
        let layoutLabelOriginRight:NSLayoutConstraint = NSLayoutConstraint(
            item:labelOrigin,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:-kLabelEntityMarginHorizontal)
        
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:border,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:1)
        let layoutBorderTop:NSLayoutConstraint = NSLayoutConstraint(
            item:border,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
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
            layoutLabelOriginTop,
            layoutLabelOriginBottom,
            layoutLabelOriginLeft,
            layoutLabelOriginRight,
            layoutBorderHeight,
            layoutBorderTop,
            layoutBorderLeft,
            layoutBorderRight
            ])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CHome, model:RModelHomeEntriesItem)
    {
        super.config(controller:controller, model:model)
        
        labelOrigin.attributedText = model.attributedString
    }
}
