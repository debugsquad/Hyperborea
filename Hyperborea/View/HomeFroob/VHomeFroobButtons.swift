import UIKit

class VHomeFroobButtons:UIView
{
    private weak var controller:CHomeFroob!
    
    convenience init(controller:CHomeFroob)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.genericBorder
        self.controller = controller
    }
}
