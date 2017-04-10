import Foundation

class MRecent
{
    let sections:[MRecentDay]
    private static let secondsInDay:TimeInterval = 86400
    
    private class func secondsToDays(deltaSeconds:TimeInterval) -> Int
    {
        let days:Int = Int(floor(deltaSeconds / secondsInDay))
        
        return days
    }
    
    private class func daysToString(days:Int) -> String
    {
        let string:String
        
        if days < 1
        {
            string = NSLocalizedString("MRecent_today", comment:"")
        }
        else if days == 1
        {
            string = NSLocalizedString("MRecent_yesterday", comment:"")
        }
        else
        {
            let daysNumber:NSNumber = days as NSNumber
            
            string = String(
                format:NSLocalizedString("MRecent_daysAgo", comment:""),
                daysNumber)
        }
        
        return string
    }
    
    init(entries:[DEntry])
    {
        let now:TimeInterval = Date().timeIntervalSince1970
        var sections:[MRecentDay] = []
        var currentDay:MRecentDay?
        
        for entry:DEntry in entries
        {
            let deltaSeconds:TimeInterval = now - entry.timestamp
            let days:Int = MRecent.secondsToDays(deltaSeconds:deltaSeconds)
            
            if let previousDay:MRecentDay = currentDay
            {
                if days != previousDay.days
                {
                    currentDay = nil
                }
            }
            
            if currentDay == nil
            {
                let title:String = MRecent.daysToString(days:days)
                let newDay:MRecentDay = MRecentDay(days:days, title:title)
                currentDay = newDay
                sections.append(newDay)
            }
            
            guard
                
                let item:MRecentEntry = MRecentEntry(entry:entry)
            
            else
            {
                continue
            }
            
            currentDay?.items.append(item)
        }
        
        self.sections = sections
    }
}
