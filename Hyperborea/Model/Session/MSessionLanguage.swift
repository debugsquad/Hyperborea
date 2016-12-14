import UIKit

class MSessionLanguage
{
    enum LanguageId:Int16
    {
        case english
        case spanish
    }
    
    class func factory(languageId:LanguageId) -> MSessionLanguage
    {
        let language:MSessionLanguage
        
        switch languageId
        {
            case LanguageId.english:
                
                language = MSessionLanguageEnglish()
            
                break
            
            case LanguageId.spanish:
            
                language = MSessionLanguageSpanish()
                
                break
        }
        
        return language
    }
    
    let languageId:LanguageId
    let code:String
    let image:UIImage
    let name:String
    
    init(
        languageId:LanguageId,
        code:String,
        image:UIImage,
        name:String)
    {
        self.languageId = languageId
        self.code = code
        self.image = image
        self.name = name
    }
    
    init()
    {
        fatalError()
    }
}