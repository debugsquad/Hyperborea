import UIKit

class MStoreItemStatusPurchasing:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 30
    private let kRestorable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VStoreCellPurchasing.reusableIdentifier
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
