//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Александр Дудченко on 28.05.2025.
//

import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var forecast: [ForecastDay] = []

    func fetchWeather(for city: String = "Moscow") async {
        let apiKey = "YOUR_API_KEY" // 🔐 Вставь сюда свой API ключ!
        let urlString = "https://api.weatherapi.com/v1/forecast.json?q=\(city)&days=5&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(WeatherForecastResponse.self, from: data)
            self.forecast = decoded.forecast.forecastday
        } catch {
            print("❌ Ошибка при загрузке данных: \(error)")
        }
    }
}
