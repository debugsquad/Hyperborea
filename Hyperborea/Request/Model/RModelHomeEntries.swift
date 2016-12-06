import Foundation

class RModelHomeEntries:RModel
{
    let items:[RModelHomeEntriesItem]
    
    required init(json:Any)
    {
        print(json)
        
        items = [
        ]
        
        super.init()
    }
    
    override init()
    {
        fatalError()
    }
}
