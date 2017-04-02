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
    
    override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator)
    {
        coordinator.animate(alongsideTransition:
        { (context:UIViewControllerTransitionCoordinatorContext) in
        })
        { [weak self] (context:UIViewControllerTransitionCoordinatorContext) in
            
            self?.viewSearch.changeOrientation()
        }
    }
    
    //MARK: private
    
    private func cancelRequests()
    {
        NotificationCenter.default.post(
            name:Notification.cancelRequests,
            object:nil)
    }
    
    //MARK: public
    
    func openSettings()
    {
        let controllerSettings:CSettings = CSettings()
        parentController.push(
            controller:controllerSettings,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func openFavorites()
    {
        let controllerFavorites:CFavorites = CFavorites()
        parentController.push(
            controller:controllerFavorites,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func editedText(text:String)
    {
        cancelRequests()
        
        if !text.isEmpty
        {
            MSearchRequestLook(controller:self, query:text)
        }
    }
    
    func resultsFound(modelResults:MSearchResults)
    {
        self.modelResults = modelResults
        viewSearch.refresh()
    }
}
