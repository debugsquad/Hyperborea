import UIKit

class MStoreItemStatusPurchasing:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 30
    private let kRestorable:Bool = false
    
    init()
    {
        let reusableIdentifier:String = VStoreCellPurchasing.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            restorable:kRestorable)
    }
}
