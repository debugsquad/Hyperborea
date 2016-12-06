import Foundation

class RModelHomeEntries:RModel
{
    let items:[RModelHomeEntriesItem]
    
    required init(json:Any)
    {
        items = [
        ]
        
        super.init()
    }
    
    override init()
    {
        fatalError()
    }
}
