import UIKit

class CSearch:CController
{
    private(set) weak var viewSearch:VSearch!
    private(set) weak var modelResults:MSearchResults?
    private(set) weak var modelResultItem:MSearchResultsItem?
    private(set) weak var modelEntry:MSearchEntry?
    private var mapResults:[String:MSearchResults]
    private var mapEntry:[String:MSearchEntry]
    
    override init()
    {
        mapResults = [:]
        mapEntry = [:]
        
        super.init()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedClearCache(sender:)),
            name:Notification.clearCache,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }

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
    
    //MARK: notified
    
    func notifiedClearCache(sender notification:Notification)
    {
        mapResults = [:]
        mapEntry = [:]
    }
    
    //MARK: private
    
    private func cancelRequests()
    {
        NotificationCenter.default.post(
            name:Notification.cancelRequests,
            object:nil)
    }
    
    private func cleanQuery(rawQuery:String) -> String?
    {
        let queryLowerCase:String = rawQuery.lowercased()
        let queryEscaped:String? = queryLowerCase.addingPercentEncoding(
            withAllowedCharacters:CharacterSet.urlHostAllowed)
        
        return queryEscaped
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
    
    func openRecent()
    {
        let controllerRecent:CRecent = CRecent()
        parentController.animateOver(controller:controllerRecent)
    }
    
    func editedText(text:String)
    {
        cancelRequests()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            if !text.isEmpty
            {
                guard
                
                    let strongSelf:CSearch = self,
                    let cleanedQuery:String = strongSelf.cleanQuery(rawQuery:text)
                    
                else
                {
                    return
                }
                
                if let cachedResults:MSearchResults = strongSelf.mapResults[cleanedQuery]
                {
                    strongSelf.modelResults = cachedResults
                    strongSelf.viewSearch.refresh()
                }
                else
                {
                    strongSelf.modelResults = nil
                    
                    MSearchRequestLook(
                        controller:strongSelf,
                        query:cleanedQuery)
                }
            }
        }
    }
    
    func resultsFound(
        query:String,
        modelResults:MSearchResults)
    {
        mapResults[query] = modelResults
        self.modelResults = modelResults
        viewSearch.refresh()
    }
    
    func selectResults(modelResultItem:MSearchResultsItem)
    {
        cancelRequests()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
                
                let strongSelf:CSearch = self
            
            else
            {
                return
            }
            
            MSession.sharedInstance.settings?.recentEntry(
                resultsItem:modelResultItem)
            
            strongSelf.modelResultItem = modelResultItem
            let wordId:String = modelResultItem.wordId
            
            strongSelf.modelEntry = strongSelf.mapEntry[wordId]
            strongSelf.viewSearch.showContent(restartMode:true)
            
            if strongSelf.modelEntry == nil
            {
                MSearchRequestEntity(
                    controller:strongSelf,
                    wordId:wordId,
                    region:modelResultItem.region)
            }
        }
    }
    
    func showContent(modelEntry:MSearchEntry)
    {
        mapEntry[modelEntry.wordId] = modelEntry
        self.modelEntry = modelEntry
        viewSearch.showContent(restartMode:false)
    }
    
    func fetchSynonyms()
    {
        guard
            
            let modelEntry:MSearchEntry = self.modelEntry
        
        else
        {
            return
        }
        
        viewSearch.showContent(restartMode:false)
        
        if modelEntry.synonyms == nil
        {
            MSearchRequestSynonyms(
                controller:self,
                model:modelEntry)
        }
    }
    
    func fetchAntonyms()
    {
        guard
        
            let modelEntry:MSearchEntry = self.modelEntry
        
        else
        {
            return
        }
        
        viewSearch.showContent(restartMode:false)
        
        if modelEntry.antonyms == nil
        {
            MSearchRequestAntonyms(
                controller:self,
                model:modelEntry)
        }
    }
    
    func fetchTranslations()
    {
        guard
        
            let modelEntry:MSearchEntry = self.modelEntry
        
        else
        {
            return
        }
        
        viewSearch.showContent(restartMode:false)
        
        if modelEntry.translations == nil
        {
            MSearchRequestTranslations(
                controller:self,
                model:modelEntry)
        }
    }
}
