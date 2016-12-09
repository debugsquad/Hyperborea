import UIKit

class VHomeLanguage:VView
{
    private weak var controller:CHomeLanguage!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CHomeLanguage
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
