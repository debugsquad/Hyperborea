import UIKit

class VSettingsBar:UIView
{
    private weak var controller:CSettings!
    private let kVersionKey:String = "CFBundleShortVersionString"
    private let kLabelTitleHeight:CGFloat = 22
    private let kLabelTitleBottom:CGFloat = -25
    private let kLabelVersionHeight:CGFloat = 18
    private let kLabelVersionBottom:CGFloat = -8
    private let kImageBottom:CGFloat = -55
    private let kImageHeightMultiplier:CGFloat = 0.45
    
    init(controller:CSettings)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.image = #imageLiteral(resourceName: "assetGenericLogoWhite")
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.bolder(size:18)
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.white
        labelTitle.text = NSLocalizedString("VSettingsBar_labelTitle", comment:"")
        
        let labelVersion:UILabel = UILabel()
        labelVersion.translatesAutoresizingMaskIntoConstraints = false
        labelVersion.backgroundColor = UIColor.clear
        labelVersion.isUserInteractionEnabled = false
        labelVersion.font = UIFont.numeric(size:14)
        labelVersion.textAlignment = NSTextAlignment.center
        labelVersion.textColor = UIColor.white
        
        addSubview(imageView)
        addSubview(labelTitle)
        addSubview(labelVersion)
        
        NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self,
            constant:kImageBottom)
        NSLayoutConstraint.height(
            view:imageView,
            toView:self,
            multiplier:kImageHeightMultiplier)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self,
            constant:kLabelTitleBottom)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kLabelTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelVersion,
            toView:self,
            constant:kLabelVersionBottom)
        NSLayoutConstraint.height(
            view:labelVersion,
            constant:kLabelVersionHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelVersion,
            toView:self)
        
        guard
            
            let bundleDictionary:[String:Any] = Bundle.main.infoDictionary
            
        else
        {
            return
        }
        
        let versionString:String? = bundleDictionary[kVersionKey] as? String
        labelVersion.text = versionString
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
