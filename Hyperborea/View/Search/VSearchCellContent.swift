import UIKit

class VSearchCellContent:VSearchCell
{
    private(set) weak var viewContent:VSearchContent!
    
    override func config(controller:CSearch)
    {
        let viewContent:VSearchContent = VSearchContent(controller:controller)
        self.viewContent = viewContent
        
        addSubview(viewContent)
        
        NSLayoutConstraint.equals(
            view:viewContent,
            toView:self)
    }
}
