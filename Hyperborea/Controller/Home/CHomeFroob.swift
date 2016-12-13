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
        parentController.dismissAnimateOver()
    }
    
    func openStore()
    {
        
    }
}
