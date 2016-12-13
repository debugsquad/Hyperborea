import UIKit

class VStore:VView
{
    private weak var controller:CStore!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CStore
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
