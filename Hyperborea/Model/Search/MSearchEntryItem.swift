import UIKit

class MSearchEntryItem
{
    let attributedString:NSAttributedString
    
    required init?(json:Any)
    {
        return nil
    }
    
    init(attributedString:NSAttributedString)
    {
        self.attributedString = attributedString
    }
}
