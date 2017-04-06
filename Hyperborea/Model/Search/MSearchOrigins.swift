import UIKit

class MSearchOrigins
{
    let attributedString:NSAttributedString
    private let kNotFoundFontSize:CGFloat = 18
    
    init(json:Any)
    {
        attributedString = NSAttributedString()
    }
    
    init()
    {
        let string:String = NSLocalizedString("MSearchOrigins_notFound", comment:"")
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kNotFoundFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.4, alpha:1)]
        attributedString = NSAttributedString(
            string:string,
            attributes:attributes)
    }
}
