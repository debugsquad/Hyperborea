import UIKit

class VSearchCellResults:VSearchCell
{
    private(set) weak var viewResults:VSearchResults!
    
    override func config(controller:CSearch)
    {
        let viewResults:VSearchResults = VSearchResults(controller:controller)
        self.viewResults = viewResults
        
        addSubview(viewResults)
        
        NSLayoutConstraint.equals(
            view:viewResults,
            toView:self)
    }
}
