import UIKit

class VFavorites:VView
{
    private weak var controller:CFavorites!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CFavorites
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
