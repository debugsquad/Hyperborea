import UIKit

class MSearchEntryItemNoun:MSearchEntryItem
{
    private let kSelectable:Bool = false
    private let kFontSize:CGFloat = 16
    
    required init?(json:Any)
    {
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.medium(size:kFontSize)]
        
        let title:String = NSLocalizedString("RModelHomeEntriesItemNoun_title", comment:"")
        let senses:RModelHomeEntriesSenses = RModelHomeEntriesSenses(json:json)
        let number:RModelHomeEntriesNumber = RModelHomeEntriesNumber(json:json)
        let titleString:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributes)
        let sensesString:NSAttributedString = senses.attributedString()
        let numberString:NSAttributedString = number.attributedString()
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(titleString)
        mutableString.append(numberString)
        mutableString.append(sensesString)
        
        let reusableIdentifier:String = VHomeWordsCellEntry.reusableIdentifier
        
        super.init(
            attributedString:mutableString,
            reusableIdentifier:reusableIdentifier,
            selectable:kSelectable)
    }
}
