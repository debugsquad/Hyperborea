import UIKit

class MStoreItemStatusNotAvailable:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 50
    private let kRestorable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VStoreCellNotAvailable.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            restorable:kRestorable)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, restorable:Bool)
    {
        fatalError()
    }
}
