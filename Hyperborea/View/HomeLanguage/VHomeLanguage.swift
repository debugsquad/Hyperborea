import UIKit

class VHomeLanguage:VView
{
    private weak var controller:CHomeLanguage!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0, alpha:0.5)
        self.controller = controller as? CHomeLanguage
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
