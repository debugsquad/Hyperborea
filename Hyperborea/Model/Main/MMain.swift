import Foundation

class MMain
{
    let items:[MMainItem]
    var state:MMainState
    weak var current:MMainItem!
    private weak var home:MMainItem!
    
    init()
    {
        state = MMainStateOptions()
        
        var items:[MMainItem] = []
        
        let itemHome:MMainItemHome = MMainItemHome(index:items.count)
        home = itemHome
        items.append(itemHome)
        
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
