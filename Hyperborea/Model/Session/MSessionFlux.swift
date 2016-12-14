import UIKit

class MSessionFlux
{
    enum Status:Int16
    {
        case full
        case twoLeft
        case oneLeft
        case empty
    }
    
    class func factory(status:MSessionFlux.Status) -> MSessionFlux
    {
        let item:MSessionFlux
        
        switch status
        {
            case MSessionFlux.Status.full:
            
                item = MSessionFluxFull()
                
                break
            
            case MSessionFlux.Status.twoLeft:
                
                item = MSessionFluxTwoLeft()
                
                break
            
            case MSessionFlux.Status.oneLeft:
            
                item = MSessionFluxOneLeft()
                
                break
            
            case MSessionFlux.Status.empty:
            
                item = MSessionFluxEmpty()
                
                break
        }
        
        return item
    }
    
    let status:MSessionFlux.Status
    let nextStatus:MSessionFlux.Status
    let image:UIImage
    let searchAvailable:Bool
    
    init(
        status:MSessionFlux.Status,
        nextStatus:MSessionFlux.Status,
        image:UIImage,
        searchAvailable:Bool)
    {
        self.status = status
        self.nextStatus = nextStatus
        self.image = image
        self.searchAvailable = searchAvailable
    }
    
    init()
    {
        fatalError()
    }
}
