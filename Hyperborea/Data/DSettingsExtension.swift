import Foundation
import CoreData

extension DSettings
{
    enum Language:Int16
    {
        case english = 0
        case spanish
    }
    
    //MARK: public
    
    func addTtl()
    {
        ttl += 1
        DManager.sharedInstance?.save()
    }
    
    func languageCode() -> String
    {
        switch language
        {
        case Language.spanish.rawValue:
            
            return "es"
            
        default:
            
            return "en"
        }
    }
    
    func currentLanguage() -> Language
    {
        let current:Language = Language(rawValue:language)!
        
        return current
    }
    
    func changeLanguage(language:Language)
    {
        self.language = language.rawValue
        DManager.sharedInstance?.save()
    }
}
