import Foundation
import CoreData

extension DSettings
{
    //MARK: private
    
    private func asyncRecentEntry(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
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
            if recentEntry.wordId == wordId
            {
                if recentEntry.language == languageRaw
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
                
                entry.wordId = wordId
                entry.word = word
                entry.language = languageRaw
                entry.region = region
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
    
    func recentEntry(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRecentEntry(
            wordId:wordId,
            word:word,
            languageRaw:languageRaw,
            region:region)
        }
    }
    
    func isFavorited(wordId:String, languageRaw:Int16) -> Bool
    {
        guard
        
            let favorites:[DEntry] = self.favorites?.array as? [DEntry]
        
        else
        {
            return false
        }
        
        for favorite:DEntry in favorites
        {
            if favorite.wordId == wordId
            {
                if favorite.language == languageRaw
                {
                    return true
                }
            }
        }
        
        return false
    }
}
