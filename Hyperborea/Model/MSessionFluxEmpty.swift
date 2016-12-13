import UIKit

class MSessionFluxEmpty:MSessionFlux
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.empty
    private let kNextStatus:MSessionFlux.Status = MSessionFlux.Status.full
    private let kSearchAvailable:Bool = false
    
    override init()
    {
        super.init(
            status:kStatus,
            nextStatus:kNextStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxEmpty"),
            searchAvailable:kSearchAvailable)
    }
    
    override init(
        status:MSessionFlux.Status,
        nextStatus:MSessionFlux.Status,
        image:UIImage,
        searchAvailable:Bool)
    {
        fatalError()
    }
}
