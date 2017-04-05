import Foundation

class MSearchContentModeItemAntonyms:MSearchContentModeItem
{
    init()
    {
        let title:String = NSLocalizedString("MSearchContentModeItemAntonyms_title", comment:"")
        let symbol:String = NSLocalizedString("MSearchContentModeItemAntonyms_symbol", comment:"")
        let reusableIdentifier:String = VSearchContentCellAntonyms.reusableIdentifier
        
        super.init(
            title:title,
            symbol:symbol,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CSearch)
    {
        controller.fetchAntonyms()
    }
    
    override func contentString(controller:CSearch) -> NSAttributedString?
    {
        return controller.modelEntry?.antonyms?.attributedString
    }
}
