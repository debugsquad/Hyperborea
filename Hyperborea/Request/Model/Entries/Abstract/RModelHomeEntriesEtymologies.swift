import UIKit

class RModelHomeEntriesEtymologies
{
    private(set) var titles:[String]
    private let kKeyEntries:String = "entries"
    private let kKeyEtymologies:String = "etymologies"
    private let kEtymologieSeparator:String = "\n"
    
    init(json:[Any])
    {
        titles = []
        
        for jsonItem:Any in json
        {
            guard
                
                let jsonMap:[String:Any] = jsonItem as? [String:Any],
                let jsonEntries:[Any] = jsonMap[kKeyEntries] as? [Any]
                
            else
            {
                continue
            }
            
            for jsonEntry:Any in jsonEntries
            {
                guard
                
                    let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                    let jsonTitles:[String] = jsonEntryMap[kKeyEtymologies] as? [String]
                
                else
                {
                    continue
                }
                
                titles.append(contentsOf:jsonTitles)
            }
        }
    }
    
    //MARK: public
    
    func attributedString() -> NSAttributedString
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        let attributesSection:[String:Any] = [
            NSFontAttributeName:UIFont.regular(
                size:RModelHomeEntriesItem.kTitleFontSize),
            NSForegroundColorAttributeName:UIColor(
                white:RModelHomeEntriesItem.kTitleWhite,
                alpha:1)
        ]
        
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.regular(
                size:RModelHomeEntriesItem.kDefinitionFontSize),
            NSForegroundColorAttributeName:UIColor(
                white:RModelHomeEntriesItem.kExampleWhite,
                alpha:1)
        ]
        
        let sectionTitle:String = NSLocalizedString(
            "RModelHomeEntriesEtymologies_title",
            comment:"")
        let sectionTitleString:NSAttributedString = NSAttributedString(
            string:sectionTitle,
            attributes:attributesSection)
        
        mutableString.append(sectionTitleString)
        
        for title:String in titles
        {
            let titleSeparator:String = "\(kEtymologieSeparator)\(title)"
            let titleString:NSAttributedString = NSAttributedString(
                string:titleSeparator,
                attributes:attributes)
            
            mutableString.append(titleString)
        }
        
        return mutableString
    }
}
