import UIKit

class MSearchEntryItemResidual:MSearchEntryItem
{
    private let kFontSize:CGFloat = 23
    
    required init?(json:Any)
    {
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.medium(size:kFontSize)]
        
        let title:String = NSLocalizedString("MSearchEntryItemResidual_title", comment:"")
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
