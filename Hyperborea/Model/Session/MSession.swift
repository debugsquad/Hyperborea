import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    private(set) var flux:MSessionFlux?
    private(set) var language:MSessionLanguage?
    private(set) var settings:DObjectSettings?
    private weak var timer:Timer?
    let kFroobCoolTime:TimeInterval = 900
    
    private init()
    {
    }
    
    @objc func timeOut(sender timer:Timer)
    {
        timer.invalidate()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let _:Bool = self.froobValidate()
        }
    }
    
    //MARK: private
    
    private func asyncLoadSettings()
    {
        DManager.sharedInstance.fetchManagedObjects(
            modelType:DObjectSettings.self,
            limit:1)
        { (settingsList:[DObjectSettings]?) in
            
            guard
            
                let settings:DObjectSettings = settingsList?.first
            
            else
            {
                self.createSettings()
                
                return
            }
            
            self.settings = settings
            self.settingsLoaded()
        }
    }
    
    private func createSettings()
    {
        DManager.sharedInstance.createManagedObject(
            modelType:DObjectSettings.self)
        { (newSettings:DObjectSettings) in
            
            self.settings = newSettings
            self.settingsLoaded()
        }
    }
    
    private func settingsLoaded()
    {
        guard
            
            let plus:Bool = settings?.hyperboreaPlus,
            let languageIdInt:Int16 = settings?.language,
            let fluxStatusInt:Int16 = settings?.fluxStatus,
            let languageId:MSessionLanguage.LanguageId = MSessionLanguage.LanguageId(
                rawValue:languageIdInt),
            var fluxStatus:MSessionFlux.Status = MSessionFlux.Status(
                rawValue:fluxStatusInt)
        
        else
        {
            return
        }
        
        if plus
        {
            fluxStatus = MSessionFlux.Status.plus
        }
        
        flux = MSessionFlux.factory(status:fluxStatus)
        
        if !flux!.searchAvailable
        {
            let _:Bool = froobValidate()
        }
        
        language = MSessionLanguage.factory(languageId:languageId)
        
        NotificationCenter.default.post(
            name:Notification.sessionLoaded,
            object:nil)
        
        DManager.sharedInstance.save()
    }
    
    private func nextStatusFroob()
    {
        guard
            
            let plus:Bool = settings?.hyperboreaPlus,
            var nextStatus:MSessionFlux.Status = flux?.nextStatus
            
        else
        {
            return
        }
        
        if plus
        {
            nextStatus = MSessionFlux.Status.plus
        }
        
        flux = MSessionFlux.factory(status:nextStatus)
        settings?.fluxStatus = nextStatus.rawValue
        DManager.sharedInstance.save()
        
        NotificationCenter.default.post(
            name:Notification.fluxUpdate,
            object:nil)
    }
    
    private func startTimer(waitingTime:TimeInterval)
    {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval:waitingTime,
            target:self,
            selector:#selector(self.timeOut(sender:)),
            userInfo:self,
            repeats:false)
    }
    
    //MARK: public
    
    func loadSession()
    {
        if settings == nil
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.asyncLoadSettings()
            }
        }
    }
    
    func changeLanguage(language:MSessionLanguage)
    {
        if language.languageId != self.language?.languageId
        {
            self.language = language
            settings?.language = language.languageId.rawValue
            
            NotificationCenter.default.post(
                name:Notification.languageChanged,
                object:nil)
            
            DManager.sharedInstance.save()
        }
    }
    
    func froobValidate() -> Bool
    {
        timer?.invalidate()
        
        guard
        
            let lastSearch:TimeInterval = settings?.lastSearch
        
        else
        {
            return false
        }
        
        let valid:Bool
        let currentTime:TimeInterval = NSDate().timeIntervalSince1970
        let expirationTime:TimeInterval = lastSearch + kFroobCoolTime
        let deltaTime:TimeInterval = currentTime - expirationTime
        
        if deltaTime > 0
        {
            nextStatusFroob()
            
            valid = true
        }
        else
        {
            DispatchQueue.main.async
            {
                self.startTimer(waitingTime:deltaTime)
            }
            
            valid = false
        }
        
        return valid
    }
    
    func addSearch(query:String, wordId:String, region:String?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let timestamp:TimeInterval = Date().timeIntervalSince1970
            
            self.settings?.lastSearch = timestamp
            
            DManager.sharedInstance.createManagedObject(
                modelType:DObjectSearch.self)
            { (objectSearch:DObjectSearch) in
             
                objectSearch.timestamp = timestamp
                objectSearch.query = query
                objectSearch.wordId = wordId
                objectSearch.region = region
                
                DManager.sharedInstance.save()
                self.nextStatusFroob()
            }
        }
    }
}
