import UIKit

class RModelHomeEntriesItemOrigin:RModelHomeEntriesItem
{
    private let kSelectable:Bool = false
    
    init(etymologies:RModelHomeEntriesEtymologies)
    {
        let reusableIdentifier:String = VHomeWordsCellFull.reusableIdentifier
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
}
