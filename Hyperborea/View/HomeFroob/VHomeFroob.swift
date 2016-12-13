import UIKit

class VHomeFroob:VView
{
    private weak var controller:CHomeFroob!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CHomeFroob
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
