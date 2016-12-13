import UIKit

class CStore:CController
{
    private weak var viewStore:VStore!
    
    override func loadView()
    {
        let viewStore:VStore = VStore(controller:self)
        self.viewStore = viewStore
        view = viewStore
    }
}
