import UIKit

class VHomeWordsCellFull:VHomeWordsCell
{
    private weak var labelEntity:UILabel!
    private let kLabelEntityTop:CGFloat = 10
    private let kLabelEntityBottom:CGFloat = -10
    private let kLabelEntityMarginHorizontal:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelEntity:UILabel = UILabel()
        labelEntity.translatesAutoresizingMaskIntoConstraints = false
        labelEntity.numberOfLines = 0
        labelEntity.backgroundColor = UIColor.clear
        labelEntity.isUserInteractionEnabled = true
        self.labelEntity = labelEntity
        
        addSubview(labelEntity)
        
        let layoutLabelEntityTop:NSLayoutConstraint = NSLayoutConstraint(
            item:labelEntity,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kLabelEntityTop)
        let layoutLabelEntityBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:labelEntity,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:kLabelEntityBottom)
        let layoutLabelEntityLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:labelEntity,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:kLabelEntityMarginHorizontal)
        let layoutLabelEntityRight:NSLayoutConstraint = NSLayoutConstraint(
            item:labelEntity,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:-kLabelEntityMarginHorizontal)
        
        addConstraints([
            layoutLabelEntityTop,
            layoutLabelEntityBottom,
            layoutLabelEntityLeft,
            layoutLabelEntityRight
            ])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:RModelHomeEntriesItem)
    {
        labelEntity.attributedText = model.attributedString
    }
}
