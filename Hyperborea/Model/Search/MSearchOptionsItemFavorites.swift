import UIKit

class MSearchOptionsItemFavorites:MSearchOptionsItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericSettings"))
    }
    
    override func selected(controller:CSearch)
    {
        controller.openFavorites()
    }
}
