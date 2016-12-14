import UIKit

class MStoreItemPlus:MStoreItem
{
    private let kStorePurchaseId:MStore.PurchaseId = "iturbide.nubecero.nubeceroplus"
    
    override init()
    {
        let title:String = NSLocalizedString("MStoreItemPlus_title", comment:"")
        let descr:String = NSLocalizedString("MStoreItemPlus_descr", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetPurchasePlus")
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr,
            image:image)
    }
    
    override init(purchaseId:MStore.PurchaseId, title:String, descr:String, image:UIImage)
    {
        fatalError()
    }
    
    override func purchaseAction()
    {
        MSession.sharedInstance.settings.current?.nubeceroPlus = true
        DManager.sharedInstance.save()
    }
    
    override func validatePurchase() -> Bool
    {
        var isPurchased:Bool = false
        
        guard
            
            let plus:Bool = MSession.sharedInstance.settings.current?.nubeceroPlus
            
        else
        {
            return isPurchased
        }
        
        isPurchased = plus
        
        return isPurchased
    }
}
