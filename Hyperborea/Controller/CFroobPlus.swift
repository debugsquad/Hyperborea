import UIKit

class CFroobPlus:CController
{
    private(set) weak var viewFroob:VFroobPlus!
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewFroob.animateShow()
    }
    
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
