import UIKit

class MSettingsItemLanguage:MSettingsItem
{
    private let kCellHeight:CGFloat = 110
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellLanguage.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
