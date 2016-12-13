import UIKit

class MSessionFluxOneLeft:MSessionFlux
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.oneLeft
    private let kSearchAvailable:Bool = true
    
    override init()
    {
        super.init(
            status:kStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxOneLeft"),
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
