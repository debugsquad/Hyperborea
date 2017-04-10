import UIKit

class VStoreCellNew:VStoreCell
{
    private weak var labelPrice:UILabel!
    private let kButtonPurchaseWidth:CGFloat = 100
    private let kLabelPriceWidth:CGFloat = 200
    private let kLabelButtonSeparation:CGFloat = -10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let buttonPurchase:UIButton = UIButton()
        buttonPurchase.translatesAutoresizingMaskIntoConstraints = false
        buttonPurchase.backgroundColor = UIColor.cartesianBlue
        buttonPurchase.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonPurchase.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        buttonPurchase.setTitle(
            NSLocalizedString("VStoreCellNew_buttonPurchase", comment:""),
            for:UIControlState.normal)
        buttonPurchase.titleLabel!.font = UIFont.bold(size:15)
        buttonPurchase.addTarget(
            self,
            action:#selector(actionPurchase(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let labelPrice:UILabel = UILabel()
        labelPrice.isUserInteractionEnabled = false
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.backgroundColor = UIColor.clear
        labelPrice.font = UIFont.bold(size:16)
        labelPrice.textColor = UIColor.black
        labelPrice.textAlignment = NSTextAlignment.right
        self.labelPrice = labelPrice
        
        addSubview(buttonPurchase)
        addSubview(labelPrice)
        
        NSLayoutConstraint.equalsVertical(
            view:labelPrice,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelPrice,
            toView:buttonPurchase,
            constant:kLabelButtonSeparation)
        NSLayoutConstraint.width(
            view:labelPrice,
            constant:kLabelPriceWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonPurchase,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonPurchase,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonPurchase,
            constant:kButtonPurchaseWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CStore, model:MStoreItem)
    {
        super.config(controller:controller, model:model)
        labelPrice.text = model.price
    }
    
    //MARK: actions
    
    func actionPurchase(sender button:UIButton)
    {
        controller?.purchase(skProduct:model?.skProduct)
    }
}
