import UIKit

class VRecent:VView
{
    private weak var controller:CRecent!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CRecent
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
