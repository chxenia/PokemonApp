import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonApp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
        
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
        
    func fetchPokemonEntities() -> [PokemonEntity] {
        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        do {
            let pokemonEntities = try viewContext.fetch(fetchRequest)
            return pokemonEntities
        } catch {
            print("Failed to fetch pokemon entities: \(error.localizedDescription)")
            return []
        }
    }
        
    func updatePokemonEntity(withName name: String, url: String) {
        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        do {
            let pokemonEntities = try viewContext.fetch(fetchRequest)
            if let pokemonEntity = pokemonEntities.first {
                pokemonEntity.url = url
                saveContext()
            }
        } catch {
            print("Failed to update pokemon entity: \(error.localizedDescription)")
        }
    }
        
    func deletePokemonEntity(_ pokemonEntity: PokemonEntity) {
        viewContext.delete(pokemonEntity)
        saveContext()
    }
}
