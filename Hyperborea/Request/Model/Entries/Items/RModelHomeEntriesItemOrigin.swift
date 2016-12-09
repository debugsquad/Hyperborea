import UIKit

class RModelHomeEntriesItemOrigin:RModelHomeEntriesItem
{
    private let kSelectable:Bool = false
    private let kExtraHeight:CGFloat = 16
    
    init(etymologies:RModelHomeEntriesEtymologies)
    {
        let reusableIdentifier:String = VHomeWordsCellOrigin.reusableIdentifier
        let etymologiesString:NSAttributedString = etymologies.attributedString()
        
        super.init(
            attributedString:etymologiesString,
            reusableIdentifier:reusableIdentifier,
            selectable:kSelectable)
    }
    
    required init(json:Any)
    {
        fatalError()
    }
    
    override init(
        attributedString:NSAttributedString,
        reusableIdentifier:String,
        selectable:Bool)
    {
        fatalError()
    }
    
    override func cellHeight(cellWidth:CGFloat) -> CGFloat
    {
        let originalHeight:CGFloat = super.cellHeight(cellWidth:cellWidth)
        
        return originalHeight + kExtraHeight
    }
}
