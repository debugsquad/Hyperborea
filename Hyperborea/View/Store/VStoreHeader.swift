import UIKit

class VStoreHeader:UICollectionReusableView
{
    private let attrTitle:[String:Any]
    private let attrDescr:[String:Any]
    private let labelMargins:CGFloat
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let kLabelTop:CGFloat = 16
    private let kLabelLeft:CGFloat = 10
    private let kLabelRight:CGFloat = -10
    private let kImageViewSize:CGFloat = 72
    
    override init(frame:CGRect)
    {
        attrTitle = [
            NSFontAttributeName:UIFont.medium(size:18),
            NSForegroundColorAttributeName:UIColor.genericBlue
        ]
        
        attrDescr = [
            NSFontAttributeName:UIFont.regular(size:18),
            NSForegroundColorAttributeName:UIColor.black
        ]
        
        labelMargins = kLabelRight + kImageViewSize
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.label = label
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(label)
        addSubview(imageView)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kLabelTop)
        layoutLabelHeight = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:imageView,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:kLabelLeft)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:kLabelRight)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
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
        let layoutImageWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kImageViewSize)
        let layoutImageHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kImageViewSize)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelHeight,
            layoutLabelLeft,
            layoutLabelRight,
            layoutImageTop,
            layoutImageLeft,
            layoutImageWidth,
            layoutImageHeight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        guard
            
            let attributedText:NSAttributedString = label.attributedText
            
        else
        {
            return
        }
        
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let usableWidth:CGFloat = width - labelMargins
        let usableSize:CGSize = CGSize(width:usableWidth, height:height)
        let boundingRect:CGRect = attributedText.boundingRect(
            with:usableSize,
            options:NSStringDrawingOptions([
                NSStringDrawingOptions.usesLineFragmentOrigin,
                NSStringDrawingOptions.usesFontLeading
                ]),
            context:nil)
        layoutLabelHeight.constant = ceil(boundingRect.size.height)
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(model:MStoreItem)
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringTitle:NSAttributedString = NSAttributedString(
            string:model.title,
            attributes:attrTitle)
        let stringDescr:NSAttributedString = NSAttributedString(
            string:model.descr,
            attributes:attrDescr)
        mutableString.append(stringTitle)
        mutableString.append(stringDescr)
        
        label.attributedText = mutableString
        imageView.image = model.image
        
        setNeedsLayout()
    }
}
