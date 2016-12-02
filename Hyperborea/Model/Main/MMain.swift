import Foundation

class MMain
{
    let items:[MMainItem]
    var state:MMainState
    weak var current:MMainItem!
    weak var store:MMainItemStore!
    private weak var home:MMainItem!
    
    init()
    {
        state = MMainStateOptions()
        
        var items:[MMainItem] = []
        
        #if DEBUG
            
            let itemAdmin:MMainItemAdmin = MMainItemAdmin(index:items.count)
            items.append(itemAdmin)
            
        #endif
        
        let itemSettings:MMainItemSettings = MMainItemSettings(index:items.count)
        items.append(itemSettings)
        
        let itemHome:MMainItemHome = MMainItemHome(index:items.count)
        home = itemHome
        items.append(itemHome)
        
        let itemPhotos:MMainItemPhotos = MMainItemPhotos(index:items.count)
        items.append(itemPhotos)
        
        let itemStore:MMainItemStore = MMainItemStore(index:items.count)
        store = itemStore
        items.append(itemStore)
        
        self.items = items
    }
    
    //MARK: public
    
    func pushed()
    {
        state = MMainStatePushed()
    }
    
    func poped()
    {
        state = MMainStateOptions()
    }
    
    func restart()
    {
        current = home
    }
}
