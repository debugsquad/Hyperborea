import UIKit

class MLanguage
{
    let rawValue:Int16
    let code:String
    let imageOn:UIImage
    let imageOff:UIImage
    let imageSquare:UIImage
    
    class func language(rawValue:Int16) -> MLanguage
    {
        switch rawValue
        {
        case MLanguageEnglish.kRawValue:
            
            return MLanguageEnglish()
            
        default:
            
            return MLanguageSpanish()
        }
    }
    
    init(
        rawValue:Int16,
        code:String,
        imageOn:UIImage,
        imageOff:UIImage,
        imageSquare:UIImage)
    {
        self.rawValue = rawValue
        self.code = code
        self.imageOn = imageOn
        self.imageOff = imageOff
        self.imageSquare = imageSquare
    }
    
    //MARK: public
    
    func translateOptions() -> [MLanguage]
    {
        let languages:[MLanguage] = []
        
        return languages
    }
}
