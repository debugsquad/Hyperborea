import UIKit

class MSearchEntryItemVerb:MSearchEntryItem
{
    required init?(json:Any)
    {
        let title:String = NSLocalizedString("MSearchEntryItemVerb_title", comment:"")
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let tenseString:NSAttributedString = MSearchEntryTense.parse(json:json)
        {
            mutableString.append(tenseString)
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
