import Foundation

class MSearchEntryFactory
{
    static let sharedInstance:MSearchEntryFactory? = MSearchEntryFactory()
    private let lexicalMap:[String:String]?
    private let bundleName:String
    private let kBundleIdentifier:String = "CFBundleExecutable"
    private let kResourceName:String = "ResourceLexicalCategory"
    private let kResourceExtension:String = "plist"
    private let kEmpty:String = ""
    private let kFullNameFormat:String = "%@.%@"
    
    private init?()
    {
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let lexicalDictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl),
            let lexicalMap:[String:String] = lexicalDictionary as? [String:String],
            let bundleName:String = Bundle.main.infoDictionary?[
                kBundleIdentifier] as? String
            
        else
        {
            return nil
        }
        
        self.lexicalMap = lexicalMap
        self.bundleName = bundleName
    }
    
    //MARK: public
    
    func itemWithLexical(category:String) -> MSearchEntryItem.Type?
    {
        guard
            
            let className:String = lexicalMap?[category]
            
        else
        {
            return nil
        }
        
        let classFullName:String = String(
            format:kFullNameFormat,
            bundleName,
            className)
        
        guard
            
            let classType:AnyObject.Type = NSClassFromString(classFullName)
            
        else
        {
            return nil
        }
        
        let itemType:MSearchEntryItem.Type? = classType as? MSearchEntryItem.Type
        
        return itemType
    }
}
