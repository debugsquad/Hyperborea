import UIKit

class RModelHomeEntriesEtymologies
{
    private let titles:[String]?
    private let kKeyEntries:String = "entries"
    private let kKeyEtymologies:String = "etymologies"
    private let kEtymologieSeparator:String = "\n"
    
    init(json:Any)
    {
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonEntries:[Any] = jsonMap[kKeyEntries] as? [Any],
            let jsonEntriesFirst:[String:Any] = jsonEntries.first as? [String:Any]
            
        else
        {
            titles = nil
            
            return
        }
        
        self.titles = jsonEntriesFirst[kKeyEtymologies] as? [String]
    }
    
    //MARK: public
    
    func attributedString() -> NSAttributedString
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let titles:[String] = self.titles
        {
            if !titles.isEmpty
            {
                let attributesSection:[String:Any] = [
                    NSFontAttributeName:UIFont.medium(
                        size:RModelHomeEntriesItem.kDefinitionFontSize),
                    NSForegroundColorAttributeName:UIColor(
                        white:RModelHomeEntriesItem.kDefinitionWhite,
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
                    let attributes:[String:Any] = [
                        NSFontAttributeName:UIFont.regular(
                            size:RModelHomeEntriesItem.kDefinitionFontSize),
                        NSForegroundColorAttributeName:UIColor(
                            white:RModelHomeEntriesItem.kDefinitionWhite,
                            alpha:1)
                    ]
                    
                    let titleSeparator:String = "\(kEtymologieSeparator)\(title)"
                    let titleString:NSAttributedString = NSAttributedString(
                        string:titleSeparator,
                        attributes:attributes)
                    
                    mutableString.append(titleString)
                }
            }
        }
        
        return mutableString
    }
}
