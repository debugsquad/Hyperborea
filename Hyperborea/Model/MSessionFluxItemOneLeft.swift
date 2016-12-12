import UIKit

class MSessionFluxItemOneLeft:MSessionFluxItem
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.oneLeft
    
    override init()
    {
        super.init(
            status:kStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxOneLeft"))
    }
    
    override init(status:MSessionFlux.Status, image:UIImage)
    {
        fatalError()
    }
}
