import UIKit

class CHomeExport:CController
{
    let model:RModelHomeEntriesItem
    
    init(model:RModelHomeEntriesItem)
    {
        self.model = model
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
