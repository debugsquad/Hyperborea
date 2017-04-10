import Foundation

class MFavorites
{
    let items:[MFavoritesItem]

    init(entries:[DEntry])
    {
        var items:[MFavoritesItem] = []
        
        for entry:DEntry in entries
        {
            guard
            
                let item:MFavoritesItem = MFavoritesItem(entry:entry)
            
            else
            {
                continue
            }
            
            items.append(item)
        }
        
        items.sort
        { (itemA, itemB) -> Bool in
            
            let comparisonResult:ComparisonResult = itemA.word.compare(
                itemB.word)
            
            switch comparisonResult
            {
            case ComparisonResult.orderedSame,
                 ComparisonResult.orderedAscending:
                
                return true
                
            case ComparisonResult.orderedDescending:
                
                return false
            }
        }
        
        self.items = items
    }
}
