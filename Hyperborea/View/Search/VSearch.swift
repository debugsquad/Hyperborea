import UIKit

class VSearch:VView
{
    private weak var controller:CSearch!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(red:0.9, green:0.92, blue:0.94, alpha:1)
        self.controller = controller as? CSearch
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
