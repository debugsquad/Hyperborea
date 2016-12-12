import UIKit

class MSessionFluxItem
{
    class func factory(status:MSessionFlux.Status) -> MSessionFluxItem
    {
        let item:MSessionFluxItem
        
        switch status
        {
            case MSessionFlux.Status.full:
            
                item = MSessionFluxItemFull()
                
                break
            
            case MSessionFlux.Status.twoLeft:
                
                item = MSessionFluxItemTwoLeft()
                
                break
            
            case MSessionFlux.Status.oneLeft:
            
                item = MSessionFluxItemOneLeft()
                
                break
            
            case MSessionFlux.Status.empty:
            
                item = MSessionFluxItemEmpty()
                
                break
        }
        
        return item
    }
    
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
