import UIKit

class MSessionFluxItem
{
    let status:MSessionFlux.Status
    let image:UIImage

    init(status:MSessionFlux.Status, image:UIImage)
    {
        self.status = status
        self.image = image
    }
    
    init()
    {
        fatalError()
    }
}
