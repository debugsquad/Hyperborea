import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    let flux:MSessionFlux
    private(set) var language:MSessionLanguage?
    private var settings:DObjectSettings?
    
    private init()
    {
        flux = MSessionFlux()
    }
    
    //MARK: private
    
    private func asyncLoadSettings()
    {
        
    }
    
    private func createSettings()
    {
        
    }
    
    private func settingsLoaded()
    {
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
