import Foundation

class MFavoritesItem
{
    let wordId:String
    let word:String
    let languageRaw:Int16
    let region:String?
    
    init?(entry:DEntry)
    {
        guard
            
            let wordId:String = entry.wordId,
            let word:String = entry.word
            
            else
        {
            return nil
        }
        
        self.wordId = wordId
        self.word = word
        languageRaw = entry.language
        region = entry.region
    }
}
