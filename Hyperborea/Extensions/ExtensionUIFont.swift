import UIKit

extension UIFont
{
    class func regular(size:CGFloat) -> UIFont
    {
        return UIFont(name:"PingFangHK-Light", size:size)!
    }
    
    class func italic(size:CGFloat) -> UIFont
    {
        return UIFont(name:"Avenir-LightOblique", size:size)!
    }
    
    class func medium(size:CGFloat) -> UIFont
    {
        return UIFont(name:"PingFangHK-Regular", size:size)!
    }
    
    class func bold(size:CGFloat) -> UIFont
    {
        return UIFont(name:"PingFangHK-Medium", size:size)!
    }
}
