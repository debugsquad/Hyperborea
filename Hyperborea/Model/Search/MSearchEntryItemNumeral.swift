import UIKit

class MSearchEntryItemNumeral:MSearchEntryItem
{
    required init?(json:Any)
    {
        let title:String = NSLocalizedString("MSearchEntryItemNumeral_title", comment:"")
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
    
        if let numeralString:NSAttributedString = MSearchEntryNumeral.parse(json:json)
        {
            mutableString.append(numeralString)
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
