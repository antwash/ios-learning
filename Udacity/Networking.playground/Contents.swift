import Foundation
let urlString = "https://itunes.apple.com/us/app/udacity/id819700933?mt=8"

let url = URL(string: urlString)
if let url = url {
    print("URL: ", url)
    print("PATH: ", url.path)
    print("USER: ", url.user ?? "")
    print("HOST: ", url.host ?? "")
    print("PORT: ", url.port ?? "")
    print("QUERY: ", url.query ?? "")
    print("SCHEME: ", url.scheme ?? "")
    print("FRAGMENT: ", url.fragment ?? "")
    print("PASSWORD: ", url.password ?? "")
}

print("----------------------------------")

let baseURL = "https://itunes.apple.com"
var simpleURL = URL(string: baseURL)
simpleURL?.appendPathComponent("us")
simpleURL?.appendPathComponent("app")
simpleURL?.appendPathComponent("udacity")
simpleURL?.appendPathComponent("id819700933")
//print(simpleURL)

print("----------------------------------")

var buildURL = URLComponents()
buildURL.scheme = "https"
buildURL.host = "itunes.apple.com"
buildURL.path = "/us/app/udacity/id81970093"
buildURL.queryItems = [URLQueryItem(name: "mt", value: "8")]
print(buildURL)



struct AppStore {

    static let scheme = "https"
    static let host = "itunes.apple.com"
    static let udacityPath = "/us/app/udacity/id81970093"
    
    enum ParametersKey : String {
        case mediaType = "mt"
    }
    
    enum MediaType : String {
        case music = "1"
        case podcasts = "2"
        case audiobooks = "3"
        case tvShows = "4"
        case musicVideos = "5"
        case movies = "6"
        case ipodGames = "7"
        case mobileApps = "8"
    }
}
