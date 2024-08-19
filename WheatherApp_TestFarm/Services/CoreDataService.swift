//
//  CoreDataService.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import CoreData


protocol CoreDataStorageServicing {
    
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void, completion: @escaping (Result<Void, Error>) -> Void)
    

    func save(_ city: CityModel, context: NSManagedObjectContext)
    
 
    func fetchObjects() throws -> [Cities]
  
    func fetchObject(withName name: String, context: NSManagedObjectContext) throws -> Cities?
    

    func fetchObject(withId name: String) throws -> Cities?
    
    func fetchResultController(
        entityName: String,
        keyForSort: String,
        sortAscending: Bool
    ) -> NSFetchedResultsController<NSFetchRequestResult>

    func deleteObject(withName name: String, context: NSManagedObjectContext) throws
}
 
final class CoreDataStorageService {
    static let shared = CoreDataStorageService()
    
    // MARK: - Core Data stack
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WheatherApp_TestFarm")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
               //
            } else {
               //
            }
        }
        return container
    }()
    
    private lazy var readContext: NSManagedObjectContext = {
        let context = container.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    private lazy var writeContext: NSManagedObjectContext = {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }()
    
    private init() {}
}

// MARK: - CRUD

extension CoreDataStorageService: CoreDataStorageServicing {
    
    func save(_ city: CityModel, context: NSManagedObjectContext) {
        let managedObject = NSEntityDescription.insertNewObject(
            forEntityName: String(describing: Cities.self),
            into: context
        )
        
        guard let dbObject = managedObject as? Cities else {
          
            return
        }
        
        dbObject.city = city.city
        
    }
    
    func fetchObjects() throws -> [Cities] {
        let fetchRequest: NSFetchRequest<Cities> = Cities.fetchRequest()
        let dbObjects = try readContext.fetch(fetchRequest)
        return dbObjects
    }
    
    func fetchObject(withName name: String, context: NSManagedObjectContext) throws -> Cities? {
        let fetchRequest: NSFetchRequest<Cities> = Cities.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "city == %@", name)
        
        let results = try context.fetch(fetchRequest)
        return results.first
    }
    
    func fetchObject(withId name: String) throws -> Cities? {
        let fetchRequest: NSFetchRequest<Cities> = Cities.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let results = try readContext.fetch(fetchRequest)
        return results.first
    }
    
    func fetchResultController(
        entityName: String,
        keyForSort: String,
        sortAscending: Bool
    ) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let descriptor = NSSortDescriptor(key: keyForSort, ascending: sortAscending)
        
        fetchRequest.sortDescriptors = [descriptor]
        fetchRequest.fetchBatchSize = 15
        
        let fetchResultController = NSFetchedResultsController<NSFetchRequestResult>(
            fetchRequest: fetchRequest,
            managedObjectContext: readContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        do {
            try fetchResultController.performFetch()
        } catch {
          //error
        }
        
        return fetchResultController
    }
    
    
    func deleteObject(withName name: String, context: NSManagedObjectContext) throws {
        if let object = try fetchObject(withName: name, context: context) {
            context.delete(object)
        } else {
           
        }
    }
    
    
    // MARK: - Save context
    
    func performSave(
        _ block: @escaping (NSManagedObjectContext) -> Void,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let context = writeContext
        context.perform { [weak self] in
            block(context)
           
            if context.hasChanges {
               
                do {
                    try self?.performSave(in: context) {
                       
                        completion(.success(()))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
               
                completion(.success(()))
            }
        
        }
    }
    
    private func performSave(in context: NSManagedObjectContext, completion: () -> Void) throws {
        try context.save()
        completion()
    }
}

