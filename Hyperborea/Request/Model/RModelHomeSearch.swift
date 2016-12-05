import Foundation

class RModelHomeSearch:RModel
{
    let results:[RModelHomeSearchResult]
    private let kKeyResults:String = "results"
    
    required init(json:Any)
    {
        var results:[RModelHomeSearchResult] = []
        
        let jsonMap:[String:Any]? = json as? [String:Any]
        
        if let jsonResults:[Any] = jsonMap?[kKeyResults] as? [Any]
        {
            for jsonResult:Any in jsonResults
            {
                let result:RModelHomeSearchResult = RModelHomeSearchResult(
                    json:jsonResult)
                results.append(result)
            }
        }
        
        self.results = results
        
        super.init()
    }
}
