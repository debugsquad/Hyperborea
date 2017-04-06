import UIKit

class CRecent:CController
{
    private weak var viewRecent:VRecent!
    
    override func loadView()
    {
        let viewRecent:VRecent = VRecent(controller:self)
        self.viewRecent = viewRecent
        view = viewRecent
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewRecent.animateShow()
    }
}
