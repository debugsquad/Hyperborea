import UIKit

class VSearch:VView
{
    private weak var controller:CSearch!
    private weak var viewBar:VSearchBar!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(red:0.84, green:0.86, blue:0.9, alpha:1)
        self.controller = controller as? CSearch
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
