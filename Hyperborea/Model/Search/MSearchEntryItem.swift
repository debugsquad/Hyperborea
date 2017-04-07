import UIKit

class MSearchEntryItem
{
    let attributedString:NSAttributedString
    private let kFontSize:CGFloat = 18
    
    required init?(json:Any)
    {
        return nil
    }
    
    init(
        title:String,
        attributedString:NSAttributedString)
    {
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:kFontSize)]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributes)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(attributedString)
        
        self.attributedString = mutableString
    }
}
