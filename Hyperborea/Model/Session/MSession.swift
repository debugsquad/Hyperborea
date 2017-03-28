import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    private(set) var settings:DSettings?
    
    private init()
    {
    }
    
    //MARK: private
    
    private func asyncLoadSession()
    {
        DManager.sharedInstance?.fetchData(
            entityName:DSettings.entityName,
            limit:1)
        { (data) in
            
            guard
            
                let settings:DSettings = data?.first as? DSettings
            
            else
            {
                self.createSession()
                
                return
            }
            
            settings.becameActive()
            self.settings = settings
            self.sessionLoaded()
        }
    }
    
    private func createSession()
    {
        DManager.sharedInstance?.createData(
            entityName:DSettings.entityName)
        { (data) in
            
            guard
            
                let settings:DSettings = data as? DSettings
            
            else
            {
                return
            }
            
            self.settings = settings
            self.sessionLoaded()
        }
    }
    
    private func sessionLoaded()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            if let userId:String = self.settings?.userId
            {
                self.loadFirebaseUser(userId:userId)
            }
            else
            {
                self.createFirebaseUser()
            }
        }
    }
    
    private func createFirebaseUser()
    {
        let nodeUser:String = FDatabase.Node.user.rawValue
        
        guard
            
            let modelUserItem:FDatabaseModelUserItem = FDatabaseModelUserItem(),
            let userJson:Any = modelUserItem.modelJson()
            
        else
        {
            return
        }
        
        let userId:String = FMain.sharedInstance.database.createChild(
            path:nodeUser,
            json:userJson)
        settings?.userId = userId
        DManager.sharedInstance?.save()
        
        fireBaseUserLoaded(modelUserItem:modelUserItem)
    }
    
    private func loadFirebaseUser(userId:String)
    {
        let nodeUser:String = FDatabase.Node.user.rawValue
        let path:String = "\(nodeUser)/\(userId)"
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FDatabaseModelUserItem.self)
        { (dataUser:FDatabaseModelUserItem?) in
            
            guard
            
                let modelUserItem:FDatabaseModelUserItem = dataUser
            
            else
            {
                return
            }
            
            self.fireBaseUserLoaded(modelUserItem:modelUserItem)
        }
    }
    
    private func fireBaseUserLoaded(modelUserItem:FDatabaseModelUserItem)
    {
        settings?.shouldPost = modelUserItem.shouldPost
        DManager.sharedInstance?.save()
    }
    
    //MARK: public
    
    func loadSession()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadSession()
        }
    }
}
