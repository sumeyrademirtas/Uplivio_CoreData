//
//  MessageViewModel.swift
//  Uplivio_CoreData
//
//  Created by Sümeyra Demirtaş on 10/23/24.
//

import Foundation

class MessageViewModel {
    // JSON dosyasından çekilen verileri tutan property
    private var messageData: Message?

    // Mesaj türünü belirleme
    func getMessageTypeForDay() -> String {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        switch (dayOfYear - 1) % 4 {
        case 0:
            return "motivationalMessages"
        case 1:
            return "inspiringQuotes"
        case 2:
            return "positiveThoughts"
        case 3:
            return "mindfulnessMessages"
        default:
            return "motivationalMessages"
        }
    }

    // Güne göre mesajı al
    func getMessageForToday() -> String {
        guard let messageData = messageData else { return "No message available" }
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1

        // Mesaj grubunu sırayla belirleme
        let messageType = getMessageTypeForDay()

        // Mesajın indeksini belirleme (1 ile 91 arasında)
        let messageIndex = (dayOfYear - 1) % 91

        // Mesaj türüne göre mesajı seçme
        switch messageType {
        case "motivationalMessages":
            return messageData.motivationalMessages[messageIndex]
        case "inspiringQuotes":
            return messageData.inspiringQuotes[messageIndex]
        case "positiveThoughts":
            return messageData.positiveThoughts[messageIndex]
        case "mindfulnessMessages":
            return messageData.mindfulnessMessages[messageIndex]
        default:
            return "No message available"
        }
    }

    // JSON dosyasını yükleyen fonksiyon
    func loadMessages(for language: String) {
        let fileName = (language == "tr") ? "messages_tr" : "messages_en"
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let messageResponse = try JSONDecoder().decode(MessageResponse.self, from: data)
                self.messageData = messageResponse.messages
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
    }
}