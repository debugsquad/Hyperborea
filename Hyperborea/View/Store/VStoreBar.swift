import UIKit

class VStoreBar:UIView
{
    private weak var controller:CStore!
    
    convenience init(controller:CStore)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        self.controller = controller
    }
}
