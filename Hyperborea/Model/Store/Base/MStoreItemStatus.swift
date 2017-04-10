import UIKit

class MStoreItemStatus
{
    let reusableIdentifier:String
    let cellHeight:CGFloat
    let restorable:Bool
    
    init(reusableIdentifier:String, cellHeight:CGFloat, restorable:Bool)
    {
        self.reusableIdentifier = reusableIdentifier
        self.cellHeight = cellHeight
        self.restorable = restorable
    }
}
