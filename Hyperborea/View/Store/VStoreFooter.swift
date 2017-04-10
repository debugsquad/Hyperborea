import UIKit

class VStoreFooter:UICollectionReusableView
{
    private weak var controller:CStore?
    private let kButtonHeight:CGFloat = 32
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(
            UIColor(white:0.5, alpha:1),
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.highlighted)
        button.setTitle(
            NSLocalizedString("VStoreFooter_buttonRestore", comment:""),
            for:UIControlState.normal)
        button.titleLabel!.font = UIFont.bold(size:15)
        button.addTarget(
            self,
            action:#selector(actionRestore(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        NSLayoutConstraint.equalsHorizontal(
            view:button,
            toView:self)
        NSLayoutConstraint.topToTop(
            view:button,
            toView:self)
        NSLayoutConstraint.height(
            view:button,
            constant:kButtonHeight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionRestore(sender button:UIButton)
    {
        controller?.restorePurchases()
    }
    
    //MARK: public
    
    func config(controller:CStore)
    {
        self.controller = controller
    }
}
