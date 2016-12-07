import UIKit

class RModelHomeEntriesItemNoun:RModelHomeEntriesItem
{
    private let kSelectable:Bool = false
    
    required init(json:Any)
    {
        let title:String = NSLocalizedString("RModelHomeEntriesItemNoun_title", comment:"")
        let
        
        let reusableIdentifier:String = VHomeWordsCellFull.reusableIdentifier
        let attributedString:NSAttributedString = NSAttributedString(
            string:"",
            attributes:nil)
        
        super.init(
            attributedString:attributedString,
            reusableIdentifier:reusableIdentifier,
            selectable:kSelectable)
    }
    
    override init(
        attributedString:NSAttributedString,
        reusableIdentifier:String,
        selectable:Bool)
    {
        fatalError()
    }
}
