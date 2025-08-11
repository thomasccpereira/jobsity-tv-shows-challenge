# 📺 TV Series Browser

A Swift-based iOS application that allows users to explore, search, and manage their favorite TV series using data from a remote API.  
The app supports browsing series, viewing detailed information, and organizing favorites — all with a clean, intuitive interface.

---

## ✨ Features

### 🔍 Series Listing & Search
- Browse all series provided by the API using its built-in paging mechanism.
- Search series by name.
- Display at least the **series name** and **poster image** in listing and search results.

### 📄 Series Details
When selecting a series, users can view:
- **Name**
- **Poster**
- **Airtime**: Days and time the series airs
- **Genres**
- **Summary**
- **Episodes** listed by season

### 🎬 Episode Details
For each episode:
- **Name**
- **Number**
- **Season**
- **Summary**
- **Image** (if available)

### ⭐ Favorites Management
- Save series to favorites.
- Remove series from favorites.
- Browse favorite series in alphabetical order.
- Tap on a favorite to view its full details.

---

## 🛠️ Tech Stack

- **Language**: Swift
- **Frameworks**: SwiftUI
- **Networking**: URLSession / async-await
- **Persistence**: SwiftData / Core Data
- **Architecture**: MVVM + Clean Architecture principles
- **Minimum iOS Version**: iOS 17+

---

## 🚀 Getting Started

### Prerequisites
- Xcode 15+
- iOS 17+ Simulator or device

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/tv-series-browser.git

### Project Structure
```TVSeriesBrowser/
├── Data/              # Networking, persistence, DTOs
├── Domain/            # Entities, Use Cases
├── Presentation/      # SwiftUI Views, ViewModels
├── Resources/         # Assets, localized strings
└── SupportingFiles/   # App entry point, configurations```