//
//  SearchArticleResponse.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

struct SearchArticlesResponse : Codable {
    // MARK: - Proprties
    var status : String
    var totalResults : Int
    var code : String
    var message : String
    var articles : [ArticleSearchItem]
    
    enum CodingKeys : CodingKey {
        case status ,totalResults, code , message , articles
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.status = try container?.decodeIfPresent(String.self, forKey: .status) ?? "error"
        self.code = try container?.decodeIfPresent(String.self, forKey: .code) ?? ""
        self.message = try container?.decodeIfPresent(String.self, forKey: .message) ?? ""
        self.totalResults = try container?.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
        self.articles = try container?.decodeIfPresent([ArticleSearchItem].self, forKey: .articles) ?? [ArticleSearchItem]()
    }
}
