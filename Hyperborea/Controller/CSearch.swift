import UIKit

class CSearch:CController
{
    private(set) weak var viewSearch:VSearch!
    private(set) weak var modelResults:MSearchResults?
    private(set) weak var modelResultItem:MSearchResultsItem?
    private(set) weak var modelEntry:MSearchEntry?
    private var mapResults:[String:MSearchResults]
    private var mapEntry:[String:MSearchEntry]
    private let drawingOptions:NSStringDrawingOptions
    private let shareMaxSize:CGSize
    private let stringOrigin:CGPoint
    private let shareMargin2:CGFloat
    private let kShareMaxWidth:CGFloat = 600
    private let kShareCompareHeight:CGFloat = 15999
    private let kShareMargin:CGFloat = 20
    
    override init()
    {
        mapResults = [:]
        mapEntry = [:]
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        shareMaxSize = CGSize(
            width:kShareMaxWidth,
            height:kShareCompareHeight)
        stringOrigin = CGPoint(x:kShareMargin, y:kShareMargin)
        shareMargin2 = kShareMargin + kShareMargin
        
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
    
    private func hasFroobShot() -> Bool
    {
        guard
        
            let settings:DSettings = MSession.sharedInstance.settings
        
        else
        {
            return false
        }
        
        if !settings.purchasePlus
        {
            if settings.froobShots < 1
            {
                let timeSinceLast:TimeInterval = settings.timeFromLastSearch()
                
                if timeSinceLast > DSettings.kWaitingTime
                {
                    settings.froobShots = DSettings.kMaxFroobShots - 1
                    
                    DManager.sharedInstance?.save()
                }
                else
                {
                    return false
                }
            }
            else
            {
                settings.froobShots -= 1
                DManager.sharedInstance?.save()
            }
        }
        
        return true
    }
    
    private func asyncShowDefinition(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        var addEntry:Bool = true
        modelEntry = mapEntry[wordId]
        viewSearch.showContent(restartMode:true)
        
        if modelEntry == nil
        {
            if hasFroobShot()
            {
                MSearchRequestEntity(
                    controller:self,
                    wordId:wordId,
                    word:word,
                    languageRaw:languageRaw,
                    region:region)
            }
            else
            {
                addEntry = false
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    self?.viewSearch.showFroob()
                    
                    let controllerFroob:CFroobPlus = CFroobPlus()
                    self?.parentController.animateOver(controller:controllerFroob)
                }
            }
        }
        
        if addEntry
        {
            MSession.sharedInstance.settings?.recentEntry(
                wordId:wordId,
                word:word,
                languageRaw:languageRaw,
                region:region)
        }
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
        let controllerFavorites:CFavorites = CFavorites(controllerSearch:self)
        parentController.animateOver(controller:controllerFavorites)
    }
    
    func openRecent()
    {
        let controllerRecent:CRecent = CRecent(controllerSearch:self)
        parentController.animateOver(controller:controllerRecent)
    }
    
    func openStore()
    {
        let controllerStore:CStore = CStore()
        parentController.push(
            controller:controllerStore,
            horizontal:CParent.TransitionHorizontal.fromRight)
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
        self.modelResultItem = modelResultItem
        showDefinition(
            wordId:modelResultItem.wordId,
            word:modelResultItem.word,
            languageRaw:modelResultItem.languageRaw,
            region:modelResultItem.region)
    }
    
    func showDefinition(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        cancelRequests()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncShowDefinition(
                wordId:wordId,
                word:word,
                languageRaw:languageRaw,
                region:region)
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
    
    func share(string:NSAttributedString)
    {
        let stringRealRect:CGRect = string.boundingRect(
            with:shareMaxSize,
            options:drawingOptions,
            context:nil)
        let stringHeight:CGFloat = ceil(stringRealRect.size.height)
        let stringSize:CGSize = CGSize(
            width:kShareMaxWidth,
            height:stringHeight)
        let totalRect:CGRect = CGRect(
            x:0,
            y:0,
            width:kShareMaxWidth + shareMargin2,
            height:stringHeight + shareMargin2)
        let stringRect:CGRect = CGRect(
            origin:stringOrigin,
            size:stringSize)
        
        let retina:CGFloat
        
        if let shareRatina:Bool = MSession.sharedInstance.settings?.shareRetina
        {
            if shareRatina
            {
                retina = 0
            }
            else
            {
                retina = 1
            }
        }
        else
        {
            retina = 1
        }
        
        UIGraphicsBeginImageContextWithOptions(totalRect.size, true, retina)
        
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
            
        else
        {
            return
        }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(totalRect)
        string.draw(in:stringRect)
        
        guard
            
            let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
        else
        {
            UIGraphicsEndImageContext()
            return
        }
        
        UIGraphicsEndImageContext()
        
        DispatchQueue.main.async
        { [weak self] in
            
            let activity:UIActivityViewController = UIActivityViewController(
                activityItems:[image],
                applicationActivities:nil)
            
            if activity.popoverPresentationController != nil
            {
                activity.popoverPresentationController!.sourceView = self?.viewSearch
                activity.popoverPresentationController!.sourceRect = CGRect.zero
                activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
            }
            
            self?.present(activity, animated:true)
        }
    }
}
