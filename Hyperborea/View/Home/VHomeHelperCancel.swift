import UIKit

class VHomeHelperCancel:UIButton
{
    private weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        setImage(
            #imageLiteral(resourceName: "assetHomeCancel"),
            for:UIControlState.normal)
        addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        self.controller = controller
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancel()
    }
}
