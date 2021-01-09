//
//  NetworkManager.swift
//  News
//
//  Created by Boris on 30.12.2020.
//

import Foundation
import UIKit

enum NetworkManagerError: String, Error {
  case somethingWentWrong = "Sorry, something went wrong"
  case unauthorized = "Invalid authorization, please check api key"
  case tooManyRequests = "Too many requests. You reached your per minute or per day rate limit."
}

class NetworkManager {
  static let shared = NetworkManager()
  
  private let apiUrl = "https://api.nytimes.com/svc"
  
  private var env: NSDictionary?

  public let cache = NSCache<NSString, UIImage>()
  
  private init() {}
  
  // MARK: - Public methods
  func downloadImage(from urlString: String, competed: @escaping(UIImage?) -> Void) {
    let cacheKey = NSString(string: urlString)
    
    if let image = cache.object(forKey: cacheKey) {
      competed(image)
      return
    }
    
    guard let url = URL(string: urlString) else {
      competed(nil)
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let self = self,
        error == nil,
        let response = response as? HTTPURLResponse, response.statusCode == 200,
        let data = data,
        let image = UIImage(data: data)
      else {
        competed(nil)
        return
      }
      
      self.cache.setObject(image, forKey: cacheKey)
      
      competed(image)
    }
    
    task.resume()
  }

  ///  Getting popular articles:
  ///    NetworkManager.shared.getPopularArticles { result in
  ///      switch result {
  ///      case .failure(let error):
  ///        print(error.rawValue)
  ///        break
  ///      case .success(let response):
  ///        print(response)
  ///        break
  ///      }
  ///    }
  public func getPopularArticles(completed: @escaping (Result<[Article], NetworkManagerError>) -> Void) {
    guard let env = getEnv() else {
      print("ENV file doesn't exit!")
      return
    }

    let endpoint = apiUrl + "/mostpopular/v2/viewed/7.json?api-key=\(env.value(forKey: "ApiKey")!)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
    
    print("RESULT \(endpoint)")

    guard let url = URL(string: endpoint) else {
      completed(.failure(.somethingWentWrong))
      return
    }


    makeRequest(
      url: url,
      completed: completed,
      decoded: { [weak self] (rawResponse: Data) in
        guard let self = self else { return }

        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase

          let popularResponse = try decoder.decode(PopularArticlesResponse.self, from: rawResponse)
          completed(.success(self.mapPopularArticlesResponse(data: popularResponse)))
        } catch {
          print("ERROR Decoding data")
          print(error)
          print(error.localizedDescription)
          completed(.failure(.somethingWentWrong))
        }
    })
  }

  /// Getting  articles by category:
  ///    NetworkManager.shared.getArticlesByCategory(category: "automobiles", completed: { result in
  ///        switch result {
  ///        case .failure(let error):
  ///          print(error.rawValue)
  ///          break
  ///        case .success(let response):
  ///          print(response)
  ///          break
  ///        }
  ///      }
  ///    )
  public func getArticlesByCategory(category: String, completed: @escaping (Result<[Article], NetworkManagerError>) -> Void) {
    guard let env = getEnv() else {
      print("ENV file doesn't exit!")
      return
    }

    let endpoint = apiUrl + "/topstories/v2/\(category).json?api-key=\(env.value(forKey: "ApiKey")!)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
    
    print(endpoint)
    guard let url = URL(string: endpoint) else { return }
    
    makeRequest(
      url: url,
      completed: completed,
      decoded: { [weak self] (rawResponse: Data) in
        guard let self = self else { return }

        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase

          let articlesByCategoryResponse = try decoder.decode(ArticlesByCategoryResponse.self, from: rawResponse)
          completed(.success(self.mapArticlesByCategoryResponse(data: articlesByCategoryResponse)))
        } catch {
          print("ERROR Decoding data")
          print(error)
          print(error.localizedDescription)
          completed(.failure(.somethingWentWrong))
        }
    })
  }
  
  /// Getting  currency lis:
  ///    NetworkManager.shared.getCurrencyList { result in
  ///      switch result {
  ///      case .failure(let error):
  ///        print(error.rawValue)
  ///        break
  ///      case .success(let response):
  ///        print(response)
  ///        break
  ///      }
  ///    }
  public func getCurrencyList(completed: @escaping (Result<[Currency], NetworkManagerError>) -> Void) {
    let endpoint = "https://www.cbr-xml-daily.ru/daily_json.js".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!

    guard let url = URL(string: endpoint) else { return }

    makeRequest(
      url: url,
      completed: completed,
      decoded: { [weak self] (rawResponse: Data) in
        guard let self = self else { return }

        do {
          let decoder = JSONDecoder()
          let currencyResponse = try decoder.decode(CurrencyResponse.self, from: rawResponse)

          completed(.success(self.mapCurrencyResponse(data: currencyResponse)))
        } catch {
          print("ERROR Decoding data")
          print(error)
          print(error.localizedDescription)
          completed(.failure(.somethingWentWrong))
        }
    })
  }
  
  /// Search  articles:
  ///    NetworkManager.shared.searchArticles(query: "messi", completed: { result in
  ///        switch result {
  ///        case .failure(let error):
  ///          print(error.rawValue)
  ///          break
  ///        case .success(let response):
  ///          print(response)
  ///          break
  ///        }
  ///      }
  ///    )
  public func searchArticles(query: String, completed: @escaping (Result<[Article], NetworkManagerError>) -> Void) {
    guard let env = getEnv() else {
      print("ENV file doesn't exit!")
      return
    }

    let endpoint = apiUrl + "/search/v2/articlesearch.json?q=\(query)&api-key=\(env.value(forKey: "ApiKey")!)"

    guard let url = URL(string: endpoint) else { return }

    makeRequest(
      url: url,
      completed: completed,
      decoded: { [weak self] (rawResponse: Data) in
        guard let self = self else { return }

        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase

          let searchArticleResponse = try decoder.decode(SearchArticleResponse.self, from: rawResponse)
          completed(.success(self.mapSearchArticleResponse(data: searchArticleResponse)))
        } catch {
          print("ERROR Decoding data")
          print(error)
          print(error.localizedDescription)
          completed(.failure(.somethingWentWrong))
        }
    })
  }
  
  // MARK: - Private methods
  private func makeRequest<T>(url: URL, completed: @escaping (Result<[T], NetworkManagerError>) -> Void, decoded: @escaping (_ rawResponse: Data) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completed(.failure(.somethingWentWrong))
      }
      
      guard let response = response as? HTTPURLResponse else {
        completed(.failure(.somethingWentWrong))
        return
      }
      
      if response.statusCode == 401 {
        completed(.failure(.unauthorized))
        return
      }
      
      if response.statusCode == 429 {
        completed(.failure(.tooManyRequests))
        return
      }
      
      guard let data = data else {
        completed(.failure(.somethingWentWrong))
        return
      }
      
      decoded(data)
    }
    
    task.resume()
  }

  private func getEnv() -> NSDictionary? {
    if env == nil, let path = Bundle.main.path(forResource: "Env", ofType: "plist"), let envDict = NSDictionary(contentsOfFile: path) {
      env = envDict;
    }

    return env
  }
}

// MARK: - Extentions
// MARK: - Mappers
extension NetworkManager {
  private func mapPopularArticlesResponse(data: PopularArticlesResponse) -> [Article] {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd"

    return data.results.map { (result: PopularArticleResult) in
      let date = dateFormatter.date(from: result.publishedDate)!
      var imageName = "default"

      if let media = result.media.first, let mediaMetadata = media.mediaMetadata.first {
        imageName = mediaMetadata.url
      }

      return Article(
        image: imageName,
        title: result.title,
        text: "\(result.abstract) \(result.adxKeywords)",
        date: date,
        url: result.url
      )
    }
  }
  
  private func mapArticlesByCategoryResponse(data: ArticlesByCategoryResponse) -> [Article] {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

    return data.results.map { (result: ArticlesByCategoryResult) in
      let date = dateFormatter.date(from: result.publishedDate)!
      var imageName = "default"

      if let media = result.multimedia.first {
        imageName = media.url
      }

      return Article(
        image: imageName,
        title: result.title,
        text: "\(result.abstract) \(result.desFacet.joined(separator: ", "))",
        date: date,
        url: result.url
      )
    }
  }
  
  private func mapSearchArticleResponse(data: SearchArticleResponse) -> [Article] {
    return data.response.docs.map { (docItem) -> Article in
      var imageName = "default"

      if let media = docItem.multimedia.first {
        imageName = "https://static01.nyt.com/\(media.url)"
      }

      return Article(
        image: imageName,
        title: docItem.leadParagraph,
        text: "\(docItem.abstract)",
        date: Date(),
        url: docItem.webUrl
      )
    }
  }

  private func mapCurrencyResponse(data: CurrencyResponse) -> [Currency] {
    return data.Valute.values.map { (valute) -> Currency in
      return Currency(name: valute.charCode, value: "\(valute.value)")
    }
  }
}
