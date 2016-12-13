import UIKit

class MSessionFluxFull:MSessionFlux
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.full
    private let kSearchAvailable:Bool = true
    
    override init()
    {
        super.init(
            status:kStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxFull"),
            searchAvailable:kSearchAvailable)
    }
    
    override init(
        status:MSessionFlux.Status,
        image:UIImage,
        searchAvailable:Bool)
    {
        fatalError()
    }
}
