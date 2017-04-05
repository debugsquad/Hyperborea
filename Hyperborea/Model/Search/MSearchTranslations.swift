import UIKit

class MSearchTranslations
{
    let attributedString:NSAttributedString
    private let kKeyResults:String = "results"
    
    init(json:Any)
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
            
        else
        {
            attributedString = mutableString
            
            return
        }
        
        
        
        attributedString = mutableString
    }
    
    init()
    {
        attributedString = NSAttributedString()
    }
}
