import UIKit

class MSearchOptionsItemRecent:MSearchOptionsItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericRecent"))
    }
    
    override func selected(controller:CSearch)
    {
        controller.openRecent()
    }
}
