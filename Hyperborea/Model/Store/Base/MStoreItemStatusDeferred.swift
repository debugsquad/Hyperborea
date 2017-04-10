import UIKit

class MStoreItemStatusDeferred:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 50
    private let kRestorable:Bool = false
    
    init()
    {
        let reusableIdentifier:String = VStoreCellDeferred.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            restorable:kRestorable)
    }
}
