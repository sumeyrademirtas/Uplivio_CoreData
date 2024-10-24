//
//  MessageModel.swift
//  Uplivio_CoreData
//
//  Created by Sümeyra Demirtaş on 10/23/24.
//

import Foundation

struct Message: Decodable {
    let motivationalMessages: [String]
    let inspiringQuotes: [String]
    let positiveThoughts: [String]
    let mindfulnessMessages: [String]

    enum CodingKeys: String, CodingKey {
        case motivationalMessages = "motivational_messages"
        case inspiringQuotes = "inspiring_quotes"
        case positiveThoughts = "positive_thoughts"
        case mindfulnessMessages = "mindfulness_messages"
    }
}

struct MessageResponse: Decodable {
    let messages: Message
}
