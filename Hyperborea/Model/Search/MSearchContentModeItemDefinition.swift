import Foundation

class MSearchContentModeItemDefinition:MSearchContentModeItem
{
    init()
    {
        let title:String = NSLocalizedString("MSearchContentModeItemDefinition_title", comment:"")
        let symbol:String = NSLocalizedString("MSearchContentModeItemDefinition_symbol", comment:"")
        let reusableIdentifier:String = VSearchContentCellDefinition.reusableIdentifier
        
        super.init(
            title:title,
            symbol:symbol,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CSearch)
    {
        if let modelEntry:MSearchEntry = controller.modelEntry
        {
            controller.showContent(modelEntry:modelEntry)
        }
    }
    
    override func contentString(controller:CSearch) -> NSAttributedString?
    {
        return controller.modelEntry?.attributedString
    }
}
