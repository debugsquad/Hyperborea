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
        AMain.sharedInstance?.trackFroob(action:AMain.FroobAction.searchClose)
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func openStore()
    {
        let store:CStore = CStore()
        let parentController:CParent = self.parentController
        
        AMain.sharedInstance?.trackFroob(action:AMain.FroobAction.searchStore)
        
        parentController.dismissAnimateOver
        {
            parentController.push(controller:store)
        }
    }
}
