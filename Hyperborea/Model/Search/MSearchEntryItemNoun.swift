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
        let titleString:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributes)
        let numberString:NSAttributedString = number.attributedString()
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(titleString)
        mutableString.append(numberString)
        
        if let sensesString:NSAttributedString = MSearchEntrySenses.parse(json:json)
        {
            mutableString.append(sensesString)
        }
        
        let reusableIdentifier:String = VHomeWordsCellEntry.reusableIdentifier
        
        super.init(
            attributedString:mutableString,
            reusableIdentifier:reusableIdentifier,
            selectable:kSelectable)
    }
}
