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
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
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
    
    //MARK: public
    
    func activate()
    {
        setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        setTitleColor(
            UIColor(white:0, alpha:0.2),
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
