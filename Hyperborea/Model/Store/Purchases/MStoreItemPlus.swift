import UIKit

class MStoreItemPlus:MStoreItem
{
    private let kStorePurchaseId:MStore.PurchaseId = "iturbide.Hyperborea.plus"
    
    init()
    {
        let title:String = NSLocalizedString("MStoreItemPlus_title", comment:"")
        let descr:String = NSLocalizedString("MStoreItemPlus_descr", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetGenericStorePlus")
        
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr,
            image:image)
    }
    
    override func purchaseAction()
    {
        MSession.sharedInstance.settings?.purchasePlus = true
        DManager.sharedInstance?.save()
    }
    
    override func validatePurchase() -> Bool
    {
        guard
            
            let purchased:Bool = MSession.sharedInstance.settings?.purchasePlus
            
        else
        {
            return false
        }
        
        return purchased
    }
}
