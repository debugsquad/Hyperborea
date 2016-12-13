import UIKit

class MSessionFluxEmpty:MSessionFlux
{
    private let kStatus:MSessionFlux.Status = MSessionFlux.Status.empty
    private let kSearchAvailable:Bool = false
    
    override init()
    {
        super.init(
            status:kStatus,
            image:#imageLiteral(resourceName: "assetHomeFluxEmpty"),
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
