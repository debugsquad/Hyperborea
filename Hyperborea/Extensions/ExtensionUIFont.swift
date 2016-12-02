import UIKit

extension UIFont
{
    class func regular(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Regular", size:size)!
    }
    
    class func medium(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-DemiBold", size:size)!
    }
    
    class func bold(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Bold", size:size)!
    }
    
    class func numeric(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNextCondensed-Medium", size:size)!
    }
}
