import UIKit

class MSessionFluxFull:MSessionFlux
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.full
    private let kNextStatus:MSessionFlux.Status = MSessionFlux.Status.twoLeft
    private let kSearchAvailable:Bool = true
    
    override init()
    {
        super.init(
            status:kStatus,
            nextStatus:kNextStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxFull"),
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
