import Foundation

class MSearchRequestLookResult
{
    let results:[MSearchRequestLookResultItem]
    private let kKeyResults:String = "results"
    
    init(json:Any)
    {
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
        
        else
        {
            self.results = []
            
            return
        }
        
        var results:[MSearchRequestLookResultItem] = []
        
        for jsonResult:Any in jsonResults
        {
            guard
                
                let result:MSearchRequestLookResultItem = MSearchRequestLookResultItem(
                    json:jsonResult)
                
            else
            {
                continue
            }
            
            results.append(result)
        }
        
        self.results = results
    }
}
