import Foundation

class MSearchResults
{
    let items:[MSearchResultsItem]
    
    init()
    {
        let loremIpsum:String = "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        let loremArray:[String] = loremIpsum.components(separatedBy:"\n")
        var items:[MSearchResultsItem] = []
        
        for loremItem:String in loremArray
        {
            let item:MSearchResultsItem = MSearchResultsItem(name:loremItem)
            items.append(item)
        }
        
        self.items = items
    }
}
