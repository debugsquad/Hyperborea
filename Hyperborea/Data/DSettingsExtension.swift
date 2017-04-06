import Foundation
import CoreData

extension DSettings
{
    //MARK: public
    
    func addTtl()
    {
        ttl += 1
        DManager.sharedInstance?.save()
    }
    
    func currentLanguage() -> MLanguage
    {
        let language:MLanguage = MLanguage.language(
            rawValue:self.language)
        
        return language
    }
    
    func changeLanguage(language:MLanguage)
    {
        self.language = language.rawValue
        DManager.sharedInstance?.save()
    }
}
