import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var labelTitle:UILabel!
    private weak var imageView:UIImageView!
    private let kContentTop:CGFloat = 20
    private let kImageLeft:CGFloat = 10
    private let kImageWidth:CGFloat = 40
    private let kTitleWidth:CGFloat = 200
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "assetHomeSearch")
        self.imageView = imageView
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.bold(size:16)
        labelTitle.textColor = UIColor.black
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.text = NSLocalizedString("Dictionary", comment:"")
        self.labelTitle = labelTitle

        addSubview(labelTitle)
        addSubview(imageView)
        
        let layoutImageViewLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:kImageLeft)
        let layoutImageViewWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kImageWidth)
        let layoutImageViewTop:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kContentTop)
        let layoutImageViewBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
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
            toItem:imageView,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        let layoutLabelTitleWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kTitleWidth)
        let layoutLabelTitleTop:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kContentTop)
        let layoutLabelTitleBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutImageViewLeft,
            layoutImageViewWidth,
            layoutImageViewTop,
            layoutImageViewBottom,
            layoutLabelTitleTop,
            layoutLabelTitleLeft,
            layoutLabelTitleWidth,
            layoutLabelTitleBottom
            ])
    }
}
