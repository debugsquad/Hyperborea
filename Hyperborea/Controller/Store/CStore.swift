import UIKit
import StoreKit

class CStore:CController, SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate
{
    private weak var viewStore:VStore!
    
    override func loadView()
    {
        let viewStore:VStore = VStore(controller:self)
        self.viewStore = viewStore
        view = viewStore
    }
    
    //MARK: public
    
    func back()
    {
        parentController.dismissPush(completion:nil)
    }
}
