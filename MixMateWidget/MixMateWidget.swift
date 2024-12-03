//
//  MixMateWidget.swift
//  MixMateWidget
//
//  Created by Victor Ulloa on 2024-11-20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let networking = Networking()

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), cocktail: Cocktail(id: 0, name: "Placeholder", shortDescription: nil, imageURL: nil, recipe: nil))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        Task {
            if let cocktail = await networking.fetchCocktails()?.first {
                let entry = SimpleEntry(date: Date(), cocktail: cocktail)
                completion(entry)
            } else {
                let entry = SimpleEntry(date: Date(), cocktail: nil)
                completion(entry)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        Task {
            var entries: [SimpleEntry] = []

            if let cocktail = await networking.fetchCocktails()?.first {
                // Generate a timeline consisting of one entry, starting from the current date.
                let entry = SimpleEntry(date: Date(), cocktail: cocktail)
                entries.append(entry)
            } else {
                // Add a fallback entry in case fetching fails
                let entry = SimpleEntry(date: Date(), cocktail: nil)
                entries.append(entry)
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let cocktail: Cocktail?
}

struct MixMateWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            if let cocktail = entry.cocktail, let imageURL = cocktail.imageURL, let url = URL(string: imageURL) {
                // Load the image with fallback
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        // Loading placeholder (can be empty or a loader)
                        Color.clear
                    case .success(let image):
                        // Successfully loaded image
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                    case .failure:
                        // Fallback to pastel purple background
                        Color.clear
                    @unknown default:
                        // Additional fallback for unknown states
                        Color.clear
                    }
                }
            } else {
                // Fallback background if no image URL is provided
                Color.purple.opacity(0.3)
            }

            // Cocktail name overlay
            if let cocktail = entry.cocktail {
                Text(cocktail.name ?? "Unknown Cocktail")
                    .font(.headline)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.8), radius: 2, x: 0, y: 1)
                    .padding(5)
                    .multilineTextAlignment(.center)
            } else {
                Text("No Cocktails Available")
                    .font(.headline)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.8), radius: 2, x: 0, y: 1)
                    .padding(5)
            }
        }
    }
}

struct MixMateWidget: Widget {
    let kind: String = "MixMateWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MixMateWidgetEntryView(entry: entry)
                    .containerBackground(.purple.opacity(0.3), for: .widget)
            } else {
                MixMateWidgetEntryView(entry: entry)
                    .padding()
            }
        }
        .configurationDisplayName("Cocktail of the Day")
        .description("Displays the first cocktail from your collection with a background image.")
    }
}

#Preview(as: .systemSmall) {
    MixMateWidget()
} timeline: {
    SimpleEntry(date: .now, cocktail: Cocktail(id: 1, name: "Preview Cocktail", shortDescription: nil, imageURL: "https://npcddrdidmrwljkyxolk.supabase.co/storage/v1/object/public/Images/cocktails/Fig_And_Thyme_Spritzer.jpeg", recipe: nil))
}
