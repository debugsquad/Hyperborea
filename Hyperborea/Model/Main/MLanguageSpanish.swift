import UIKit

class MLanguageSpanish:MLanguage
{
    static let kRawValue:Int16 = 1
    private let kCode:String = "es"
    
    init()
    {
        let imageOn:UIImage = #imageLiteral(resourceName: "assetGenericSpanishOn")
        let imageOff:UIImage = #imageLiteral(resourceName: "assetGenericSpanishOff")
        let imageSquare:UIImage = #imageLiteral(resourceName: "assetGenericSpanishSquare")
        
        super.init(
            rawValue:MLanguageSpanish.kRawValue,
            code:kCode,
            imageOn:imageOn,
            imageOff:imageOff,
            imageSquare:imageSquare)
    }
    
    override func translateOptions() -> [MLanguage]
    {
        let english:MLanguageEnglish = MLanguageEnglish()
        let languages:[MLanguage] = [
            english]
        
        return languages
    }
}
