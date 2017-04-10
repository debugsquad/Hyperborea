import Foundation

class MRecentDay
{
    let days:Int
    let title:String
    var items:[MRecentEntry]
    
    init(days:Int, title:String)
    {
        self.days = days
        self.title = title
        items = []
    }
}
