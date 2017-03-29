import UIKit

class MSearchOptionsItemSettings:MSearchOptionsItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericSettings"))
    }
    
    override func selected(controller:CSearch)
    {
        controller.openSettings()
    }
}
