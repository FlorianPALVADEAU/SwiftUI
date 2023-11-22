import SwiftUI
import MapKit

struct ContactDetailView: View {
    @ObservedObject var contact: ContactSchema

    @State private var showModifyContact = false
    @State private var weatherData: WeatherData?
    @State private var updateCounter = 0
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    let halfWindowWidth = (UIScreen.main.bounds.width * 0.5)

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: contact.profilePictureURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: halfWindowWidth, height: halfWindowWidth)
                    .clipShape(Circle())
                    .padding()
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: halfWindowWidth, height: halfWindowWidth)
            }
            Text("\(contact.firstName) \(contact.lastName)")
                .font(.title)

            Text("Phone: \(String(contact.phoneNumber))")
                .padding()

            if contact.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .padding()
            }
            Text("\(contact.localisation)")
            WeatherView(city: contact.localisation, weatherData: $weatherData, updateCounter: $updateCounter)
            .onAppear {
                geocodeCity()
            }

            Map(coordinateRegion: $region, showsUserLocation: true)
                .frame(height: 200)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showModifyContact.toggle()
                }) {
                    Text("Modifier le contact")
                }
                .sheet(isPresented: $showModifyContact) {
                    EditContactView(contacts: .constant([contact]), contact: contact)
                }
            }
        }
        .navigationBarTitle("Détails du Contact")
    }

    private func geocodeCity() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(contact.localisation) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                return
            }
            region.center = location.coordinate
        }
    }
}

struct WeatherView: View {
    let city: String
    @Binding var weatherData: WeatherData?
    @State private var currentUpdateCounter: Int

    init(city: String, weatherData: Binding<WeatherData?>) {
        self.city = city
        _weatherData = weatherData
        _currentUpdateCounter = State(initialValue: updateCounter.wrappedValue)
    }

    var body: some View {
        VStack {
            if let weatherData = weatherData {
                Text("- \(roundedTemperature(weatherData.main.temp))°C - \(weatherData.weather.first?.description ?? "")")
            } else {
                Text("Chargement des données météo...")
                    .onAppear {
                        fetchWeather()
                    }
            }
        }
        .onChange(of: currentUpdateCounter) { _ in
            fetchWeather()
        }
    }

    private func fetchWeather() {
        guard !city.isEmpty else {
            return
        }
        let apiKey = "a32a825225d19883c0b3eb8e44dd36a1"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            print("URL invalide")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur lors de la récupération des données: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Réponse serveur invalide")
                return
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self.weatherData = decodedData
                    }
                } catch {
                    print("Erreur lors de la conversion des données JSON: \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }

    private func roundedTemperature(_ temperature: Double) -> Int {
        return Int(round(temperature))
    }
}

struct WeatherData: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
