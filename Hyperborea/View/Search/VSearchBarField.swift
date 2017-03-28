import UIKit

class VSearchBarField:UITextField
{
    private weak var controller:CSearch!
    
    init(controller:CSearch)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.regular(size:30)
        textColor = UIColor.black
        tintColor = UIColor.black
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
