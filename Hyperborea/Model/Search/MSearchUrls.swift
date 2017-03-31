import Foundation

class MSearchUrls
{
    enum Host:String
    {
        case hostOxford = "hostOxford"
    }
    
    enum EndPoint:String
    {
        case oxfordSearch = "oxfordSearch"
        case oxfordEntries = "oxfordEntries"
    }
    
    private let urlMap:[String:String]
    private let kResourceName:String = "ResourceUrl"
    private let kResourceExtension:String = "plist"
    
    init()
    {
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let urlDictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl),
            let urlMap:[String:String] = urlDictionary as? [String:String]
        
        else
        {
            self.urlMap = [:]
            
            return
        }
        
        self.urlMap = urlMap
    }
    
    //MARK: public
    
    func urlHost(host:Host) -> String?
    {
        return urlMap[host.rawValue]
    }
    
    func urlEnpoint(endPoint:EndPoint) -> String?
    {
        return urlMap[endPoint.rawValue]
    }
}
