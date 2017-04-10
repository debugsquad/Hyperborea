import UIKit

class MSearchEntryItemNoun:MSearchEntryItem
{
    required init?(json:Any)
    {
        let title:String = NSLocalizedString("MSearchEntryItemNoun_title", comment:"")
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let numberString:NSAttributedString = MSearchEntryNumber.parse(json:json)
        {
            mutableString.append(numberString)
        }
        
        if let sensesString:NSAttributedString = MSearchEntrySenses.parse(json:json)
        {
            mutableString.append(sensesString)
        }
        
        super.init(
            title:title,
            attributedString:mutableString)
    }
}
