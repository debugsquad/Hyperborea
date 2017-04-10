import UIKit

class MSettingsItemLanguage:MSettingsItem
{
    private let kCellHeight:CGFloat = 110
    private let kSelectable:Bool = false
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellLanguage.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
}
