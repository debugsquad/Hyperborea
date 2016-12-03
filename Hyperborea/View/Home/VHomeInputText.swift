import UIKit

class VHomeInputText:UITextView
{
    private weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        font = UIFont.regular(size:30)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
