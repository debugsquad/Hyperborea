import UIKit

class VFavorites:VView
{
    private weak var controller:CFavorites!
    private weak var spinner:VSpinner?
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CFavorites
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
