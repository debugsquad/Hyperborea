import UIKit

class MSessionFluxItemTwoLeft:MSessionFluxItem
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.twoLeft
    
    override init()
    {
        super.init(
            status:kStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxTwoLeft"))
    }
    
    override init(status:MSessionFlux.Status, image:UIImage)
    {
        fatalError()
    }
}
