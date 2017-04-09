import UIKit

class VFroobPlus:VView
{
    private weak var controller:CFroobPlus!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CFroobPlus
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
