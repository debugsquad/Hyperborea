import UIKit

class MSearchEntryItemParticle:MSearchEntryItem
{
    required init?(json:Any)
    {
        let title:String = NSLocalizedString("MSearchEntryItemParticle_title", comment:"")
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
