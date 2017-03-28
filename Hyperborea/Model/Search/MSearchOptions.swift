import Foundation

class MSearchOptions
{
    let items:[MSearchOptionsItem]
    
    init()
    {
        let itemSettings:MSearchOptionsItemSettings = MSearchOptionsItemSettings()
        
        items = [
            itemSettings]
    }
}
