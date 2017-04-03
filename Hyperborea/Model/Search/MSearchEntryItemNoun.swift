import UIKit

class MSearchEntryItemNoun:MSearchEntryItem
{
    private let kFontSize:CGFloat = 16
    
    required init?(json:Any)
    {
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.medium(size:kFontSize)]
        
        let title:String = NSLocalizedString("MSearchEntryItemNoun_title", comment:"")
        let titleString:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributes)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(titleString)
        
        if let numberString:NSAttributedString = MSearchEntryNumber.parse(json:json)
        {
            mutableString.append(numberString)
        }
        
        if let sensesString:NSAttributedString = MSearchEntrySenses.parse(json:json)
        {
            mutableString.append(sensesString)
        }
        
        super.init(attributedString:mutableString)
    }
}
