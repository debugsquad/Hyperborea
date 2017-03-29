import UIKit

class VSettings:VView
{
    private weak var controller:CSettings!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CSettings
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
