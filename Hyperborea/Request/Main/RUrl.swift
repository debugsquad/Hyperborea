import Foundation

class RUrl
{
    enum UrlKey:String
    {
        case oxfordApi = "oxfordApi"
        case entries = "entries"
    }
    
    static let sharedInstance:RUrl = RUrl()
    private let urlMap:[UrlKey.RawValue:String]?
    private let kResourceName:String = "ResourceUrl"
    private let kResourceExtension:String = "plist"
    private let kEmpty:String = ""
    
    private init()
    {
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension)
        
        else
        {
            urlMap = nil
            
            return
        }
        
        guard
            
            let urlDictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl)
        
        else
        {
            urlMap = nil
            
            return
        }
        
        urlMap = urlDictionary as? [UrlKey.RawValue:String]
    }
    
    //MARK: public
    
    func urlFor(urlKey:UrlKey) -> String
    {
        guard
        
            let urlString:String = urlMap?[urlKey.rawValue]
        
        else
        {
            return kEmpty
        }
        
        return urlString
    }
}
