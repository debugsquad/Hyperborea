import UIKit

class MSearchEntryItemOther:MSearchEntryItem
{
    private let kFontSize:CGFloat = 20
    
    required init?(json:Any)
    {
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.medium(size:kFontSize)]
        
        let title:String = NSLocalizedString("MSearchEntryItemOther_title", comment:"")
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
