import UIKit

class VHomeHelperCancel:UIButton
{
    private weak var controller:CHome!
    private let kAlphaNotSelected:CGFloat = 1
    private let kAlphaSelected:CGFloat = 0.2
    
    convenience init(controller:CHome)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        imageView!.tintColor = UIColor(white:0, alpha:0.2)
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        addTarget(
            self,
            action:#selector(actionCancel(sender:)),
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
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancel()
    }
    
    //MARK: public
    
    func activate()
    {
        setImage(
            #imageLiteral(resourceName: "assetHomeCancel").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
    }
    
    func deactivate()
    {
        setImage(
            #imageLiteral(resourceName: "assetHomeCancel").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
    }
}
