import UIKit

class RModelHomeSearch:RModel
{
    let results:[RModelHomeSearchResult]
    private let kKeyResults:String = "results"
    private let kFontSize:CGFloat = 13
    
    required init(json:Any)
    {
        var results:[RModelHomeSearchResult] = []
        
        let jsonMap:[String:Any]? = json as? [String:Any]
        
        if let jsonResults:[Any] = jsonMap?[kKeyResults] as? [Any]
        {
            let attributes:[String:Any] = [
                NSFontAttributeName:UIFont.regular(
                    size:kFontSize)
            ]
            
            for jsonResult:Any in jsonResults
            {
                let result:RModelHomeSearchResult = RModelHomeSearchResult(
                    json:jsonResult,
                    attributes:attributes)
                results.append(result)
            }
        }
        
        self.results = results
        
        super.init()
    }
}
