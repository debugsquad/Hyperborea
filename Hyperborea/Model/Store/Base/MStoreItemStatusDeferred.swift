import UIKit

class MStoreItemStatusDeferred:MStoreItemStatus
{
    private let kCellHeight:CGFloat = 50
    private let kRestorable:Bool = false
    
    override init()
    {
        let reusableIdentifier:String = VStoreCellDeferred.reusableIdentifier
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
