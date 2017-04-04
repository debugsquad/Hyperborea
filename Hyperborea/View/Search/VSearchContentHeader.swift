import UIKit

class VSearchContentHeader:UICollectionReusableView
{
    private weak var controller:CSearch?
    
    
    //MARK: public
    
    func config(controller:CSearch)
    {
        self.controller = controller
    }
}
