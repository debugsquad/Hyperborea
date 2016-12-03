import UIKit

class CHome:CController
{
    private weak var viewHome:VHome!
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
}
