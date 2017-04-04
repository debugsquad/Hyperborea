import UIKit

class MSearchEntryItemPronoun:MSearchEntryItem
{
    private let kFontSize:CGFloat = 16
    
    required init?(json:Any)
    {
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.medium(size:kFontSize)]
        
        let title:String = NSLocalizedString("MSearchEntryItemPronoun_title", comment:"")
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        let titleString:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributes)
        mutableString.append(titleString)
        
        if let sensesString:NSAttributedString = MSearchEntrySenses.parse(json:json)
        {
            mutableString.append(sensesString)
        }
        
        super.init(attributedString:mutableString)
    }
}
