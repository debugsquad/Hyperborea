import UIKit

class MStoreItemStatusNew:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 40
    private let kRestorable:Bool = true
    
    init()
    {
        let reusableIdentifier:String = VStoreCellNew.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            restorable:kRestorable)
    }
}
