import UIKit

class CHome:CController, RMainDelegate
{
    weak var viewHome:VHome!
    private let kSpace:String = " "
    private let kUnderScore:String = "_"
    private let kEmpty:String = ""
    private let kStatusOk:RMain.StatusCode = 200
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    //MARK: private
    
    private func cancelRequests()
    {
        NotificationCenter.default.post(
            name:Notification.requestCancel,
            object:nil)
    }
    
    private func textEmpty()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewHome.viewInput.showPlaceholder()
            self?.viewHome.viewHelper.textEmpty()
            self?.viewHome.viewSuggestions.config(model:nil)
            self?.viewHome.viewWords.config(model:nil)
            self?.viewHome.restartScroll()
            self?.viewHome.viewWords.restartScroll()
        }
    }
    
    private func textNotEmpty()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewHome.viewInput.hidePlaceholder()
            self?.viewHome.viewHelper.textNotEmpty()
        }
    }
    
    private func wordIdProcess(rawWord:String) -> String
    {
        let unspacedWord:String = rawWord.replacingOccurrences(
            of:kSpace,
            with:kUnderScore)
        let lowercaseWordId:String = unspacedWord.lowercased()
        let escapedWordId:String
        
        if let escapedLowercaseText:String = lowercaseWordId.addingPercentEncoding(
            withAllowedCharacters:CharacterSet.urlQueryAllowed)
        {
            escapedWordId = escapedLowercaseText
        }
        else
        {
            escapedWordId = kEmpty
        }
        
        return escapedWordId
    }
    
    private func searchWordId(wordId:String)
    {
        cancelRequests()
        UIApplication.shared.keyWindow!.endEditing(true)
        viewHome.viewWords.showLoading()
        viewHome.viewWords.restartScroll()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            let settings:RSettingsHomeEntries = RSettingsHomeEntries(wordId:wordId)
            RMain.request(settings:settings, delegate:self)
        }
    }
    
    //MARK: public
    
    func startEdition()
    {
        viewHome.viewInput.viewText.becomeFirstResponder()
    }
    
    func clear()
    {
        cancelRequests()
        viewHome.viewInput.viewText.text = kEmpty
        textEmpty()
    }
    
    func cancel()
    {
        cancelRequests()
        UIApplication.shared.keyWindow!.endEditing(true)
        
        viewHome.viewInput.viewText.text = kEmpty
        textEmpty()
    }
    
    func search()
    {
        let rawWord:String = viewHome.viewInput.viewText.text
        let wordId:String = wordIdProcess(rawWord:rawWord)
        searchWordId(wordId:wordId)
    }
    
    func changedText(text:String)
    {
        cancelRequests()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            if text.isEmpty
            {
                self?.textEmpty()
            }
            else
            {
                self?.textNotEmpty()
                
                let settings:RSettingsHomeSearch = RSettingsHomeSearch(text:text)
                RMain.request(settings:settings, delegate:self)
            }
        }
    }
    
    func selectSuggestion(item:RModelHomeSearchResult)
    {
        viewHome.viewInput.viewText.text = item.word
        searchWordId(wordId:item.wordId)
    }
    
    //MARK: rMain delegate
    
    func requestFinished(
        settingsId:RSettings.SettingsId,
        model:RModel?,
        status:RMain.StatusCode?,
        error:String?)
    {
        let statusOk:RMain.StatusCode = kStatusOk
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            if settingsId == RSettings.SettingsId.homeSearch
            {
                if status == statusOk
                {
                    let modelSearch:RModelHomeSearch? = model as? RModelHomeSearch
                    self?.viewHome.viewSuggestions.config(model:modelSearch)
                }
            }
            else if settingsId == RSettings.SettingsId.homeEntries
            {
                if status == statusOk
                {
                    let modelEntries:RModelHomeEntries? = model as? RModelHomeEntries
                    self?.viewHome.viewWords.config(model:modelEntries)
                }
                else
                {
                    let errorString:String
                    
                    if let errorReceived:String = error
                    {
                        errorString = errorReceived
                    }
                    else
                    {
                        errorString = NSLocalizedString(
                            "CHome_errorUnknown", comment:"")
                    }
                    
                    VAlert.message(message:errorString)
                    self?.viewHome.viewWords.config(model:nil)
                }
            }
        }
    }
}
