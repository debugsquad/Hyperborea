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
