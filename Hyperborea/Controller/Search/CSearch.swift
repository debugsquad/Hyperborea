import UIKit

class CSearch:CController
{
    private(set) weak var viewSearch:VSearch!
    
    override func loadView()
    {
        let viewSearch:VSearch = VSearch(controller:self)
        self.viewSearch = viewSearch
        view = viewSearch
    }
}
