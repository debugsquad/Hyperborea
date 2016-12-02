import UIKit

class VView:UIView
{
    init(controller:CController)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
