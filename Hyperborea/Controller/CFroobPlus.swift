import UIKit

class CFroobPlus:CController
{
    private weak var viewFroob:VFroobPlus!
    
    override func loadView()
    {
        let viewFroob:VFroobPlus = VFroobPlus(controller:self)
        self.viewFroob = viewFroob
        view = viewFroob
    }
    
    //MARK: public
    
    func back()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func openStore()
    {
        
    }
}
