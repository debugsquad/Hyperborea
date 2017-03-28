import Foundation

class MSearchResults
{
    let items:[MSearchResultItem]
    
    init()
    {
        let loremIpsum:String = "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        let loremArray:[String] = loremIpsum.components(separatedBy:"\n")
        var items:[MSearchResultItem] = []
        
        for loremItem:String in loremArray
        {
            let item:MSearchResultItem = MSearchResultItem(name:loremItem)
            items.append(item)
        }
        
        self.items = items
    }
}
