import UIKit

extension UIColor
{
    open class var main:UIColor //#FF5B3A
    {
        get
        {
            return UIColor(red:1, green:0.356862745098039, blue:0.227450980392157, alpha:1)
        }
    }
    
    open class var complement:UIColor //#0B99C4
    {
        get
        {
            return UIColor(red:0.043137254901961, green:0.6, blue:0.768627450980392, alpha:1)
        }
    }
    
    open class var background:UIColor
    {
        get
        {
            return UIColor(red:0.97, green:0.98, blue:0.99, alpha:1)
        }
    }
}
