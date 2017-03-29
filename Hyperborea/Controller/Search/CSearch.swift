import UIKit

class CSearch:CController
{
    private(set) weak var viewSearch:VSearch!
    private(set) var modelResults:MSearchResults?
    
    override func loadView()
    {
        let viewSearch:VSearch = VSearch(controller:self)
        self.viewSearch = viewSearch
        view = viewSearch
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncSearch()
        }
    }
    
    override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator)
    {
        coordinator.animate(alongsideTransition:
        { (context:UIViewControllerTransitionCoordinatorContext) in
        })
        { [weak self] (context:UIViewControllerTransitionCoordinatorContext) in
            
            self?.viewSearch.viewResults.changeOrientation()
            self?.viewSearch.viewContent.changeOrientation()
        }
    }
    
    //MARK: private
    
    private func asyncSearch()
    {
        let model:MSearchResults = MSearchResults()
        searchFinished(modelResults:model)
    }
    
    private func searchFinished(modelResults:MSearchResults)
    {
        self.modelResults = modelResults
        viewSearch.refresh()
    }
}
