import UIKit

class MStoreItemStatusPurchased:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 40
    private let kRestorable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VStoreCellPurchased.reusableIdentifier
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
