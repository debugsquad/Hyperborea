import UIKit

class CHomeFroob:CController
{
    private weak var viewFroob:VHomeFroob!
    
    override func loadView()
    {
        let viewFroob:VHomeFroob = VHomeFroob(controller:self)
        self.viewFroob = viewFroob
        view = viewFroob
    }
    
    //MARK: public
    
    func close()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func openStore()
    {
        let store:CStore = CStore()
        
        let parentController:CParent = self.parentController
        
        parentController.dismissAnimateOver
        {
            parentController.push(controller:store)
        }
    }
}
