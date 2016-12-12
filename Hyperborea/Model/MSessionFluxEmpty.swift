import UIKit

class MSessionFluxEmpty:MSessionFlux
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.empty
    
    override init()
    {
        super.init(
            status:kStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxEmpty"))
    }
    
    override init(status:MSessionFlux.Status, image:UIImage)
    {
        fatalError()
    }
}
