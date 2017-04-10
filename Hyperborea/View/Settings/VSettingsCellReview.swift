import UIKit

class VSettingsCellReview:VSettingsCell
{
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 200
    private let kImageWidth:CGFloat = 180
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:18)
        labelTitle.textColor = UIColor.white
        labelTitle.numberOfLines = 2
        labelTitle.text = NSLocalizedString("VSettingsCellReview_labelTitle", comment:"")
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        imageView.image = #imageLiteral(resourceName: "assetGenericReview")
        
        addSubview(labelTitle)
        addSubview(imageView)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kTitleLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
