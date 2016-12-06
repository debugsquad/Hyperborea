import UIKit

class RModelHomeSearch:RModel
{
    let results:[RModelHomeSearchResult]
    private let kKeyResults:String = "results"
    private let kFontSize:CGFloat = 14
    private let kMaxWidth:CGFloat = 700
    private let kMaxHeight:CGFloat = 20
    
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
            
            let size:CGSize = CGSize(width:kMaxWidth, height:kMaxHeight)
            let options:NSStringDrawingOptions = NSStringDrawingOptions([
                NSStringDrawingOptions.usesFontLeading,
                NSStringDrawingOptions.usesLineFragmentOrigin
                ])
            
            for jsonResult:Any in jsonResults
            {
                guard
                    
                    let result:RModelHomeSearchResult = RModelHomeSearchResult(
                        json:jsonResult,
                        attributes:attributes,
                        size:size,
                        options:options)
                
                else
                {
                    continue
                }
                
                results.append(result)
            }
        }
        
        self.results = results
        
        super.init()
    }
}
