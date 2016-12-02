import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
