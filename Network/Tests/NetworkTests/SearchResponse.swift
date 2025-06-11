//  Created by Rafal Zowal 

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct SearchResponse: Codable {
    let query, filter, nextPageToken: String
    let totalCount: Int
    let items: [Item]
    let filterOptions: String?
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let sthpIDS: [SthpID]
    let title, mainTitle: String
    let subtitle: String?
    let originalTitle: String?
    let type: TypeEnum
    let itemDescription: String
    let seriesInfo: String?
    let authors, narrators: [Language]
    let rating, bayesianAverageRating: Double
    let reviewCount: Int
    let parts: [Part]
    let language: Language
    let publishers: [Publisher]
    let cover: Cover
    let tags: [String]
    let seriesID: String
    let seriesName: String
    let orderInSeries: Int
    let seasonNumber: String?
    let resultType: ResultType
    let shareURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case sthpIDS = "sthpIds"
        case title, mainTitle, subtitle, originalTitle, type
        case itemDescription = "description"
        case seriesInfo, authors, narrators, rating, bayesianAverageRating, reviewCount, parts, language, publishers, cover, tags
        case seriesID = "seriesId"
        case seriesName, orderInSeries, seasonNumber, resultType
        case shareURL = "shareUrl"
    }
}

// MARK: - Language
struct Language: Codable {
    let id, name: String
}

// MARK: - Cover
struct Cover: Codable {
    let url: String
    let width, height: Int
}

// MARK: - Part
struct Part: Codable {
    let id: String
    let title, partDescription: String?
    let storytelCategoryIDS, majorGenreCodes, minorGenreCodes: [String]
    let formats: [Format]
    let cover: Cover
    let episodeNumber: Int
    let sttMapAssets: [SttMapAsset]
    let formatAvailability: FormatAvailability

    enum CodingKeys: String, CodingKey {
        case id, title
        case partDescription = "description"
        case storytelCategoryIDS = "storytelCategoryIds"
        case majorGenreCodes, minorGenreCodes, formats, cover, episodeNumber, sttMapAssets, formatAvailability
    }
}

enum FormatAvailability: String, Codable {
    case abook = "abook"
    case ebook = "ebook"
    case premium = "premium"
}

// MARK: - Format
struct Format: Codable {
    let id, isbn: String
    let type: FormatAvailability
    let releaseDate, enterServiceDate: String
    let abridged, searchable: Bool
    let edition: String
    let bookSource: String?
    let isReleased: Bool
    let length: Int
    let cover: Cover
    let audioAssets: [AudioAsset]
    let ebookAssets: [EbookAsset]
    let chapterCount: Int
    let cdnLink, cdnType: String?
}

// MARK: - AudioAsset
struct AudioAsset: Codable {
    let id: String
    let encoding: AudioAssetEncoding
    let fileID: String
    let durationSeconds, numberOfChannels, bitrate: Int

    enum CodingKeys: String, CodingKey {
        case id, encoding
        case fileID = "fileId"
        case durationSeconds, numberOfChannels, bitrate
    }
}

enum AudioAssetEncoding: String, Codable {
    case mp3 = "mp3"
}

// MARK: - EbookAsset
struct EbookAsset: Codable {
    let id: String
    let encoding: String
    let fileID: String
    let characterCount, wordCount: Int

    enum CodingKeys: String, CodingKey {
        case id, encoding
        case fileID = "fileId"
        case characterCount, wordCount
    }
}

// MARK: - SttMapAsset
struct SttMapAsset: Codable {
    let id, fileID, revision: String

    enum CodingKeys: String, CodingKey {
        case id
        case fileID = "fileId"
        case revision
    }
}

// MARK: - Publisher
struct Publisher: Codable {
    let publisherDetails: PublisherDetails
    let id: String
    let name: String
    let slug: String
    let type: FormatAvailability
}

// MARK: - PublisherDetails
struct PublisherDetails: Codable {
    let imprintID, publisherID: String

    enum CodingKeys: String, CodingKey {
        case imprintID = "imprintId"
        case publisherID = "publisherId"
    }
}

enum ResultType: String, Codable {
    case book = "book"
}

// MARK: - SthpID
struct SthpID: Codable {
    let primary: Bool
    let sthpBookID: Int
    let sthpAudioBookID, sthpEbookID: Int?

    enum CodingKeys: String, CodingKey {
        case primary
        case sthpBookID = "sthpBookId"
        case sthpAudioBookID = "sthpAudioBookId"
        case sthpEbookID = "sthpEbookId"
    }
}

enum TypeEnum: String, Codable {
    case single = "single"
}
