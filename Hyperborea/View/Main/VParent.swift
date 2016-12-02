import UIKit

class VParent:UIView
{
    static let kBarHeight:CGFloat = 64
    
    convenience init(parent:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.main
    }
}
