import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    private(set) var flux:MSessionFlux?
    private(set) var language:MSessionLanguage?
    private var settings:DObjectSettings?
    
    private init()
    {
    }
    
    //MARK: private
    
    private func asyncLoadSettings()
    {
        DManager.sharedInstance.fetchManagedObjects(
            modelType:DObjectSettings.self)
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
            
            let languageIdInt:Int16 = settings?.language,
            let fluxStatusInt:Int16 = settings?.fluxStatus,
            let languageId:MSessionLanguage.LanguageId = MSessionLanguage.LanguageId(
                rawValue:languageIdInt),
            let fluxStatus:MSessionFlux.Status = MSessionFlux.Status(
                rawValue:fluxStatusInt)
        
        else
        {
            return
        }
        
        flux = MSessionFlux.factory(status:fluxStatus)
        language = MSessionLanguage.factory(languageId:languageId)
        
        NotificationCenter.default.post(
            name:Notification.sessionLoaded,
            object:nil)
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
            
            NotificationCenter.default.post(
                name:Notification.languageChanged,
                object:nil)
        }
    }
}
