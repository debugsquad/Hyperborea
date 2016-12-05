import UIKit

class VHomeHelperCancel:UIButton
{
    private weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        imageView!.tintColor = UIColor.background
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        self.controller = controller
        
        deactivate()
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
