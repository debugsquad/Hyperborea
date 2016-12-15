import UIKit

class RModelHomeEntriesItemOther:RModelHomeEntriesItem
{
    private let kSelectable:Bool = false
    
    required init(json:Any)
    {
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.medium(
                size:RModelHomeEntriesItem.kTitleFontSize),
            NSForegroundColorAttributeName:UIColor(
                white:RModelHomeEntriesItem.kTitleWhite,
                alpha:1)
        ]
        
        let title:String = NSLocalizedString("RModelHomeEntriesItemOther_title", comment:"")
        let senses:RModelHomeEntriesSenses = RModelHomeEntriesSenses(json:json)
        let titleString:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributes)
        let sensesString:NSAttributedString = senses.attributedString()
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(titleString)
        mutableString.append(sensesString)
        
        let reusableIdentifier:String = VHomeWordsCellEntry.reusableIdentifier
        
        super.init(
            attributedString:mutableString,
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
