import UIKit

class MSessionFluxItemFull:MSessionFluxItem
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.full
    
    override init()
    {
        super.init(
            status:kStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxFull"))
    }
    
    override init(status:MSessionFlux.Status, image:UIImage)
    {
        fatalError()
    }
}
