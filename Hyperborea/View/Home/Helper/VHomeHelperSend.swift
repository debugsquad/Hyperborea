import UIKit

class VHomeHelperSend:UIButton
{
    private weak var controller:CHome!
    private let kCornerRadius:CGFloat = 16
    private let kAlphaNotSelected:CGFloat = 1
    private let kAlphaSelected:CGFloat = 0.2
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(
            NSLocalizedString("VHomeHelperSend_title", comment:""),
            for:UIControlState.normal)
        titleLabel!.font = UIFont.medium(size:13)
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = 1
        addTarget(
            self,
            action:#selector(actionSend(sender:)),
            for:UIControlEvents.touchUpInside)
        self.controller = controller
        
        deactivate()
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: actions
    
    func actionSend(sender button:UIButton)
    {
        controller.search()
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func activate()
    {
        setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        setTitleColor(
            UIColor(white:0, alpha:0.8),
            for:UIControlState.highlighted)
        isUserInteractionEnabled = true
        layer.borderColor = UIColor.black.cgColor
    }
    
    func deactivate()
    {
        setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.normal)
        isUserInteractionEnabled = false
        layer.borderColor = UIColor(white:0, alpha:0.2).cgColor
    }
}
