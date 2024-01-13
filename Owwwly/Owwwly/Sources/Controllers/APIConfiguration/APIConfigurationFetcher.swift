import Foundation

class APIConfigurationFetcher {
    
    enum FetcherError: Error, LocalizedError {
        case couldNotFindConfigurationPlist(named: String)
        case couldNotParseData
        
        var errorDescription: String? {
            switch self {
            case .couldNotFindConfigurationPlist(let name):
                return "Could not find \(name).plist file"
            case .couldNotParseData:
                return "Could not parse APIConfigurationModel from provided .plist file"
            }
        }
    }
}

