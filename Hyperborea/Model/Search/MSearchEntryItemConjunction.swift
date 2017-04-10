import UIKit

class MSearchEntryItemConjunction:MSearchEntryItem
{
    required init?(json:Any)
    {
        let title:String = NSLocalizedString("MSearchEntryItemConjunction_title", comment:"")
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
