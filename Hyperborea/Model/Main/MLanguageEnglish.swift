import UIKit

class MLanguageEnglish:MLanguage
{
    static let kRawValue:Int16 = 0
    private let kCode:String = "en"
    
    init()
    {
        let imageOn:UIImage = #imageLiteral(resourceName: "assetGenericEnglishOn")
        let imageOff:UIImage = #imageLiteral(resourceName: "assetGenericEnglishOff")
        let imageSquare:UIImage = #imageLiteral(resourceName: "assetGenericEnglishSquare")
        
        super.init(
            rawValue:MLanguageEnglish.kRawValue,
            code:kCode,
            imageOn:imageOn,
            imageOff:imageOff,
            imageSquare:imageSquare)
    }
    
    override func translateOptions() -> [MLanguage]
    {
        let spanish:MLanguageSpanish = MLanguageSpanish()
        let languages:[MLanguage] = [
            spanish]
        
        return languages
    }
}
