import UIKit

class MStoreItemStatusNotAvailable:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 50
    private let kRestorable:Bool = false
    
    init()
    {
        let reusableIdentifier:String = VStoreCellNotAvailable.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            restorable:kRestorable)
    }
}
