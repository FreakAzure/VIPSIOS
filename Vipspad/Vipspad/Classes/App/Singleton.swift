
import Foundation

class Singleton: NSObject {

    // MARK: Lifecycle

    override private init() {}

    // MARK: Internal

    static let shared = Singleton()
    
    var authToken = ""
}
