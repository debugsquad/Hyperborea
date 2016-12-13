import UIKit

class MSessionFluxTwoLeft:MSessionFlux
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.twoLeft
    private let kNextStatus:MSessionFlux.Status = MSessionFlux.Status.oneLeft
    private let kSearchAvailable:Bool = true
    
    override init()
    {
        super.init(
            status:kStatus,
            nextStatus:kNextStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxTwoLeft"),
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
