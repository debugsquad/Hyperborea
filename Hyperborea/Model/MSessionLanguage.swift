import UIKit

class MSessionLanguage
{
    enum LanguageId:Int16
    {
        case english
        case spanish
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
