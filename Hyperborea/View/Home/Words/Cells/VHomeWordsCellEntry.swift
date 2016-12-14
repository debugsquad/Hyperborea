import UIKit

class VHomeWordsCellEntry:VHomeWordsCell
{
    private weak var labelEntity:UILabel!
    private weak var buttonShare:VHomeWordsShare!
    private let kLabelEntityTop:CGFloat = 8
    private let kLabelEntityMarginHorizontal:CGFloat = 10
    private let kButtonShareWidth:CGFloat = 150
    private let kButtonShareHeight:CGFloat = 60
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let buttonShare:VHomeWordsShare = VHomeWordsShare()
        self.buttonShare = buttonShare
        
        let labelEntity:UILabel = UILabel()
        labelEntity.translatesAutoresizingMaskIntoConstraints = false
        labelEntity.numberOfLines = 0
        labelEntity.backgroundColor = UIColor.clear
        labelEntity.isUserInteractionEnabled = false
        self.labelEntity = labelEntity
        
        addSubview(labelEntity)
        addSubview(buttonShare)
        
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
            toItem:buttonShare,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
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
        
        let layoutButtonShareBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonShare,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutButtonShareLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonShare,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutButtonShareWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonShare,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kButtonShareWidth)
        let layoutButtonShareHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonShare,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kButtonShareHeight)
        
        addConstraints([
            layoutLabelEntityTop,
            layoutLabelEntityBottom,
            layoutLabelEntityLeft,
            layoutLabelEntityRight,
            layoutButtonShareBottom,
            layoutButtonShareLeft,
            layoutButtonShareWidth,
            layoutButtonShareHeight
            ])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CHome, model:RModelHomeEntriesItem)
    {
        super.config(controller:controller, model:model)
        buttonShare.config(controller:controller, model:model)
        labelEntity.attributedText = model.attributedString
    }
}
