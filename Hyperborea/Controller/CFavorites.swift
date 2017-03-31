import UIKit

class CFavorites:CController
{
    private weak var viewFavorites:VFavorites!
    
    override func loadView()
    {
        let viewFavorites:VFavorites = VFavorites(controller:self)
        self.viewFavorites = viewFavorites
        view = viewFavorites
    }
}
