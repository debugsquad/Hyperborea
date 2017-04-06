import UIKit

class VRecentBar:UIView
{
    private weak var controller:CRecent!
    private let kBorderHeight:CGFloat = 1
    private let kImageWidth:CGFloat = 50
    private let kLabelWidth:CGFloat = 100
    private let kCornerRadius:CGFloat = 5
    private let kCancelMarginVertical:CGFloat = 14
    private let kCancelRight:CGFloat = -10
    private let kCancelWidth:CGFloat = 100
    
    init(controller:CRecent)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericRecent")
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:16)
        label.textColor = UIColor.black
        label.text = NSLocalizedString("VRecentBar_label", comment:"")
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.clipsToBounds = true
        buttonCancel.backgroundColor = UIColor.hyperOrange
        buttonCancel.layer.cornerRadius = kCornerRadius
        buttonCancel.setTitle(
            NSLocalizedString("VRecentBar_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonCancel.titleLabel!.font = UIFont.bold(size:14)
        
        addSubview(border)
        addSubview(imageView)
        addSubview(label)
        addSubview(buttonCancel)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:label,
            toView:imageView)
        NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonCancel,
            toView:self,
            margin:kCancelMarginVertical)
        NSLayoutConstraint.rightToRight(
            view:buttonCancel,
            toView:self,
            constant:kCancelRight)
        NSLayoutConstraint.width(
            view:buttonCancel,
            constant:kCancelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.viewRecent.animateHide()
    }
}
