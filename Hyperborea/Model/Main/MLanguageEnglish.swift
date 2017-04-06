import UIKit

class MLanguageEnglish:MLanguage
{
    static let kRawValue:Int16 = 0
    private let kCode:String = "en"
    
    init()
    {
        let imageOn:UIImage = #imageLiteral(resourceName: "assetGenericEnglishOn")
        let imageOff:UIImage = #imageLiteral(resourceName: "assetGenericEnglishOff")
        
        super.init(
            rawValue:MLanguageEnglish.kRawValue,
            code:kCode,
            imageOn:imageOn,
            imageOff:imageOff)
    }
    
    override func translateOptions() -> [MLanguage]
    {
        let spanish:MLanguageSpanish = MLanguageSpanish()
        let languages:[MLanguage] = [
            spanish]
        
        return languages
    }
}