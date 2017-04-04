import UIKit

class MSearchEntryItemInterjection:MSearchEntryItem
{
    required init?(json:Any)
    {
        let title:String = NSLocalizedString("MSearchEntryItemInterjection_title", comment:"")
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
    
        if let sensesString:NSAttributedString = MSearchEntrySenses.parse(json:json)
        {
            mutableString.append(sensesString)
        }
        
        super.init(
            title:title,
            attributedString:mutableString)
    }
}
