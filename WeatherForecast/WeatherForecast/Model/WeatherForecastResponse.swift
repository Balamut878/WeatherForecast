//
//  WeatherForecastResponse.swift
//  WeatherForecast
//
//  Created by Александр Дудченко on 28.05.2025.
//

import Foundation

struct WeatherForecastResponse: Decodable {
    let forecast: Forecast
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable {
    let date: String
    let day: Day
}

struct Day: Decodable {
    let condition: Condition
    let avgtemp_c: Double
    let maxwind_kph: Double
    let avghumidity: Double
}

struct Condition: Decodable {
    let text: String
    let icon: String
}

extension ForecastDay {
    var formattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "ru_RU")

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ru_RU")
        outputFormatter.dateFormat = "d MMMM"

        if let date = inputFormatter.date(from: self.date) {
            return outputFormatter.string(from: date)
        } else {
            return self.date
        }
    }
}
