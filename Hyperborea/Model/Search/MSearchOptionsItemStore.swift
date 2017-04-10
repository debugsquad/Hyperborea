import UIKit

class MSearchOptionsItemStore:MSearchOptionsItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericStore"))
    }
    
    override func selected(controller:CSearch)
    {
        controller.openStore()
    }
}
