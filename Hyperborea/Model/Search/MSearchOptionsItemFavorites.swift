import UIKit

class MSearchOptionsItemFavorites:MSearchOptionsItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericFavorites"))
    }
    
    override func selected(controller:CSearch)
    {
        controller.openFavorites()
    }
}
