import UIKit

class VHomeWordsCellEntry:VHomeWordsCell
{
    private weak var labelEntity:UILabel!
    private let kLabelEntityTop:CGFloat = 2
    private let kLabelEntityBottom:CGFloat = -2
    private let kLabelEntityMarginHorizontal:CGFloat = 10
    private let kButtonShareWidth:CGFloat = 90
    private let kButtonShareHeight:CGFloat = 60
    private let kButtonShareRight:CGFloat = 56
    private let kButtonShareBottom:CGFloat = 35
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let buttonShare:UIButton = UIButton()
        buttonShare.translatesAutoresizingMaskIntoConstraints = false
        buttonShare.backgroundColor = UIColor.clear
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetHomeShare").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetHomeShare").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonShare.imageView!.contentMode = UIViewContentMode.center
        buttonShare.imageView!.clipsToBounds = true
        buttonShare.imageView!.tintColor = UIColor.genericBlue
        buttonShare.imageEdgeInsets = UIEdgeInsets(
            top:0,
            left:0,
            bottom:kButtonShareBottom,
            right:kButtonShareRight)
        buttonShare.addTarget(
            self,
            action:#selector(self.actionShare(sender:)),
            for:UIControlEvents.touchUpInside)
        
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
        
        let layoutButtonShareTop:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonShare,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
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
            layoutButtonShareTop,
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
        
        labelEntity.attributedText = model.attributedString
    }
    
    //MARK: actions
    
    func actionShare(sender button:UIButton)
    {
        guard
        
            let model:RModelHomeEntriesItem = self.model
        
        else
        {
            return
        }
        
        controller?.share(model:model)
    }
}
