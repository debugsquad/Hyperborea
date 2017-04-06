import Foundation
import CoreData

extension DSettings
{
    //MARK: private
    
    private func asyncRecentEntry(resultsItem:MSearchResultsItem)
    {
        guard
        
            let recent:[DEntry] = self.recent?.array as? [DEntry]
        
        else
        {
            return
        }
        
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        var entry:DEntry?
        
        for recentEntry:DEntry in recent
        {
            if recentEntry.wordId == resultsItem.wordId
            {
                if recentEntry.language == resultsItem.languageRaw
                {
                    entry = recentEntry
                    removeFromRecent(recentEntry)
                    
                    break
                }
            }
        }
        
        if let entry:DEntry = entry
        {
            entry.timestamp = timestamp
            insertIntoRecent(entry, at:0)
            
            DManager.sharedInstance?.save()
        }
        else
        {
            DManager.sharedInstance?.createData(
                entityName:DEntry.entityName)
            { [weak self] (data) in
                
                guard
                
                    let entry:DEntry = data as? DEntry
                
                else
                {
                    return
                }
                
                entry.wordId = resultsItem.wordId
                entry.word = resultsItem.word
                entry.language = resultsItem.languageRaw
                entry.region = resultsItem.region
                entry.timestamp = timestamp
                
                self?.insertIntoRecent(entry, at:0)
                
                DManager.sharedInstance?.save()
            }
        }
    }
    
    //MARK: public
    
    func addTtl()
    {
        ttl += 1
        DManager.sharedInstance?.save()
    }
    
    func currentLanguage() -> MLanguage
    {
        let language:MLanguage = MLanguage.language(
            rawValue:self.language)
        
        return language
    }
    
    func changeLanguage(language:MLanguage)
    {
        self.language = language.rawValue
        DManager.sharedInstance?.save()
    }
    
    func recentEntry(resultsItem:MSearchResultsItem)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRecentEntry(resultsItem:resultsItem)
        }
    }
}
