import Foundation
import CoreData

class DManager
{
    static let sharedInstance:DManager = DManager()
    private let managedObjectContext:NSManagedObjectContext
    private let kModelName:String = "DHyperborea"
    private let kModelExtension:String = "momd"
    private let kSQLiteExtension:String = "%@.sqlite"
    
    private init()
    {
        let modelURL:URL = Bundle.main.url(
            forResource:kModelName,
            withExtension:kModelExtension)!
        let sqliteFile:String = String(
            format:kSQLiteExtension,
            kModelName)
        let storeCoordinatorURL:URL = FileManager.appDirectory.appendingPathComponent(
            sqliteFile)
        let managedObjectModel:NSManagedObjectModel = NSManagedObjectModel(
            contentsOf:modelURL)!
        let persistentStoreCoordinator:NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(
            managedObjectModel:managedObjectModel)
        
        do
        {
            try persistentStoreCoordinator.addPersistentStore(
                ofType:NSSQLiteStoreType,
                configurationName:nil,
                at:storeCoordinatorURL,
                options:nil)
        }
        catch
        {
        }
        
        managedObjectContext = NSManagedObjectContext(
            concurrencyType:
            NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    }
    
    //MARK: public
    
    func save()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            if self.managedObjectContext.hasChanges
            {
                self.managedObjectContext.perform
                {
                    do
                    {
                        try self.managedObjectContext.save()
                    }
                    catch let error
                    {
                        #if DEBUG
                            
                            print("coredata: \(error)")
                            
                        #endif
                    }
                }
            }
        }
    }
    
    func createManagedObject<ModelType:NSManagedObject>(
        modelType:ModelType.Type,
        completion:@escaping((ModelType) -> ()))
    {
        managedObjectContext.perform
        {
            let entityDescription:NSEntityDescription = NSEntityDescription.entity(
                forEntityName:modelType.entityName,
                in:self.managedObjectContext)!
            let managedObject:NSManagedObject = NSManagedObject(
                entity:entityDescription,
                insertInto:self.managedObjectContext)
            let managedGeneric:ModelType = managedObject as! ModelType
            completion(managedGeneric)
        }
    }
    
    func fetchManagedObjects<ModelType:NSManagedObject>(
        modelType:ModelType.Type,
        limit:Int = 0,
        predicate:NSPredicate? = nil,
        sorters:[NSSortDescriptor]? = nil,
        completion:@escaping(([ModelType]?) -> ()))
    {
        let fetchRequest:NSFetchRequest<ModelType> = NSFetchRequest(
            entityName:modelType.entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sorters
        fetchRequest.fetchLimit = limit
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.includesPropertyValues = true
        fetchRequest.includesSubentities = true
        
        managedObjectContext.perform
        {
            let results:[ModelType]?
            
            do
            {
                results = try self.managedObjectContext.fetch(fetchRequest)
            }
            catch
            {
                results = nil
            }
            
            completion(results)
        }
    }
    
    func delete(object:NSManagedObject, completion:(() -> ())? = nil)
    {
        managedObjectContext.perform
        {
            self.managedObjectContext.delete(object)
            completion?()
        }
    }
    
    func untracked<ModelType:NSManagedObject>(modelType:ModelType.Type) -> ModelType
    {
        let entity:NSEntityDescription = NSEntityDescription.entity(
            forEntityName:modelType.entityName,
            in:managedObjectContext)!
        let managedObject:NSManagedObject = NSManagedObject(
            entity:entity,
            insertInto:nil)
        let model:ModelType = managedObject as! ModelType
        
        return model
    }
}
