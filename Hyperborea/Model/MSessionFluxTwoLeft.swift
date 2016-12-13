import UIKit

class MSessionFluxTwoLeft:MSessionFlux
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.twoLeft
    private let kSearchAvailable:Bool = true
    
    override init()
    {
        super.init(
            status:kStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxTwoLeft"),
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
