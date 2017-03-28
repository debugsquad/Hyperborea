import UIKit

class VSearchBarField:UITextField
{
    private weak var controller:CSearch!
    
    init(controller:CSearch)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
