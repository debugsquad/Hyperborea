import UIKit

class VRecentBar:UIView
{
    private weak var controller:CRecent!
    
    init(controller:CRecent)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
