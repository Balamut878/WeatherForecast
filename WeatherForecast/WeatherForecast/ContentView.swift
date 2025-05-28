//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Александр Дудченко on 28.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.forecast, id: \.date) { day in
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(day.formattedDate)
                            .font(.headline)
                        Text(day.day.condition.text)
                            .font(.subheadline)
                        Text("🌡 Темп: \(day.day.avgtemp_c, specifier: "%.1f")°C")
                        Text("💨 Ветер: \(day.day.maxwind_kph, specifier: "%.1f") км/ч")
                        Text("💧 Влажность: \(day.day.avghumidity, specifier: "%.0f")%")
                    }

                    Spacer()

                    AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
                        image
                            .resizable()
                            .frame(width: 64, height: 64)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Прогноз на 5 дней")
        }
        .task {
            await viewModel.fetchWeather()
        }
    }
}

#Preview {
    ContentView()
}
