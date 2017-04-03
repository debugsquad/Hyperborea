import UIKit

class CSearch:CController
{
    private(set) weak var viewSearch:VSearch!
    private(set) var modelResults:MSearchResults?
    private(set) var resultItem:MSearchResultsItem?
    private(set) var selectedEntry:MSearchEntry?
    
    override func loadView()
    {
        let viewSearch:VSearch = VSearch(controller:self)
        self.viewSearch = viewSearch
        view = viewSearch
    }
    
    override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
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
            modelResults = nil
            resultItem = nil
            selectedEntry = nil
            MSearchRequestLook(controller:self, query:text)
        }
    }
    
    func resultsFound(modelResults:MSearchResults)
    {
        self.modelResults = modelResults
        viewSearch.refresh()
    }
    
    func selectResults(resultItem:MSearchResultsItem)
    {
        cancelRequests()
        
        self.resultItem = resultItem
        viewSearch.resultSelected()
        
        MSearchRequestEntity(
            controller:self,
            wordId:resultItem.wordId,
            region:resultItem.region)
    }
    
    func entryFound(selectedEntry:MSearchEntry)
    {
        self.selectedEntry = selectedEntry
        viewSearch.showEntry()
    }
}
