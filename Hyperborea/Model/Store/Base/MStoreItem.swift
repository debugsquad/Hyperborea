import UIKit
import StoreKit

class MStoreItem
{
    let purchaseId:MStore.PurchaseId
    let title:String
    let descr:String
    let image:UIImage
    var skProduct:SKProduct?
    private(set) var price:String?
    private(set) var status:MStoreItemStatus?
    
    init(
        purchaseId:MStore.PurchaseId,
        title:String,
        descr:String,
        image:UIImage)
    {
        self.purchaseId = purchaseId
        self.title = title
        self.descr = descr
        self.image = image
        status = MStoreItemStatusNotAvailable()
    }
    
    //MARK: public
    
    func purchaseAction()
    {
    }
    
    func validatePurchase() -> Bool
    {
        return false
    }
    
    func foundPurchase(price:String)
    {
        self.price = price
        
        let isPurchased:Bool = validatePurchase()
        
        if isPurchased
        {
            statusPurchased(callAction:false)
        }
        else
        {
            statusNew()
        }
    }
    
    func statusNew()
    {
        status = MStoreItemStatusNew()
    }
    
    func statusDeferred()
    {
        status = MStoreItemStatusDeferred()
    }
    
    func statusPurchasing()
    {
        status = MStoreItemStatusPurchasing()
    }
    
    func statusPurchased(callAction:Bool)
    {
        status = MStoreItemStatusPurchased()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            if callAction
            {
                self?.purchaseAction()
            }
        }
    }
}
