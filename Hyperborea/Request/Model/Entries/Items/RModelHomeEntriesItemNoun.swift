import UIKit

class RModelHomeEntriesItemNoun:RModelHomeEntriesItem
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
        let title:String = NSLocalizedString("RModelHomeEntriesItemNoun_title", comment:"")
        let senses:RModelHomeEntriesSenses = RModelHomeEntriesSenses(json:json)
        let etymologies:RModelHomeEntriesEtymologies = RModelHomeEntriesEtymologies(json:json)
        let titleString:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributes)
        let sensesString:NSAttributedString = senses.attributedString()
        let etymologiesString:NSAttributedString = etymologies.attributedString()
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(titleString)
        mutableString.append(sensesString)
        mutableString.append(etymologiesString)
        
        let reusableIdentifier:String = VHomeWordsCellFull.reusableIdentifier
        
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
