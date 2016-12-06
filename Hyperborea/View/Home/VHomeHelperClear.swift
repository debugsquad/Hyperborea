import UIKit

class VHomeHelperClear:UIButton
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
            action:#selector(actionClear(sender:)),
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
    
    func actionClear(sender button:UIButton)
    {
        controller.clear()
    }
    
    //MARK: public
    
    func activate()
    {
        setImage(
            #imageLiteral(resourceName: "assetHomeClear").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
    }
    
    func deactivate()
    {
        setImage(
            #imageLiteral(resourceName: "assetHomeClear").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
    }
}
