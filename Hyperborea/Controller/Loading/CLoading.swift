import UIKit

class CLoading:CController
{
    private weak var viewLoading:VLoading!
    
    override func loadView()
    {
        let viewLoading:VLoading = VLoading(controller:self)
        self.viewLoading = viewLoading
        view = viewLoading
    }
}
