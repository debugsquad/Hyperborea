import UIKit

class MSessionFluxPlus:MSessionFlux
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.plus
    private let kNextStatus:MSessionFlux.Status = MSessionFlux.Status.plus
    private let kSearchAvailable:Bool = true
    
    override init()
    {
        super.init(
            status:kStatus,
            nextStatus:kNextStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxPlus"),
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
