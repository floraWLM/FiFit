//
//  SuggestedView.swift
//  Fifits
//
//  Created by Lemeng Wang on 10/19/24.
//

import SwiftUI
import SceneKit

let models = [
    Model(id: 0, type: "Dress", color: "White", modelName: "dress1.usdc"),
    Model(id: 1, type: "Dress", color: "Black", modelName: "dress2.usdc"),
    Model(id: 2, type: "Dress", color: "Red", modelName: "dress3.usdc"),
    Model(id: 3, type: "Dress", color: "Orange", modelName: "dress4.usdc"),
    Model(id: 4, type: "Dress", color: "Yellow", modelName: "dress5.usdc"),
    Model(id: 5, type: "Dress", color: "Green", modelName: "dress6.usdc"),
    Model(id: 6, type: "Dress", color: "Blue", modelName: "dress8.usdc"),
    Model(id: 7, type: "Dress", color: "Purple", modelName: "dress9.usdc"),
    Model(id: 8, type: "shorts", color: "White", modelName: "shorts1.usdz"),
    Model(id: 9, type: "shorts", color: "Black", modelName: "shorts2.usdz"),
    Model(id: 10, type: "shorts", color: "Red", modelName: "shorts3.usdz"),
    Model(id: 11, type: "shorts", color: "Orange", modelName: "shorts4.usdz"),
    Model(id: 12, type: "shorts", color: "Yellow", modelName: "shorts5.usdz"),
    Model(id: 13, type: "shorts", color: "Green", modelName: "shorts6.usdz"),
    Model(id: 14, type: "shorts", color: "Blue", modelName: "shorts8.usdz"),
    Model(id: 15, type: "shorts", color: "Purple", modelName: "shorts9.usdz"),
    Model(id: 16, type: "T-shirt", color: "White", modelName: "tShirt1.usdz"),
    Model(id: 17, type: "T-shirt", color: "Black", modelName: "tShirt2.usdz"),
    Model(id: 18, type: "T-shirt", color: "Red", modelName: "tShirt3.usdz"),
    Model(id: 19, type: "T-shirt", color: "Orange", modelName: "tShirt4.usdz"),
    Model(id: 20, type: "T-shirt", color: "Yellow", modelName: "tShirt5.usdz"),
    Model(id: 21, type: "T-shirt", color: "Green", modelName: "tShirt6.usdz"),
    Model(id: 22, type: "T-shirt", color: "Blue", modelName: "tShirt8.usdz"),
    Model(id: 23, type: "T-shirt", color: "Purple", modelName: "tShirt9.usdz"),
    Model(id: 24, type: "shirt", color: "White", modelName: "longSleeve1.usdz"),
    Model(id: 25, type: "shirt", color: "Black", modelName: "longSleeve2.usdz"),
    Model(id: 26, type: "shirt", color: "Red", modelName: "longSleeve3.usdz"),
    Model(id: 27, type: "shirt", color: "Orange", modelName: "longSleeve4.usdz"),
    Model(id: 28, type: "shirt", color: "Yellow", modelName: "longSleeve5.usdz"),
    Model(id: 29, type: "shirt", color: "Green", modelName: "longSleeve6.usdz"),
    Model(id: 30, type: "shirt", color: "Blue", modelName: "longSleeve8.usdz"),
    Model(id: 31, type: "shirt", color: "Purple", modelName: "longSleeve9.usdz"),
    Model(id: 32, type: "pants", color: "White", modelName: "pants1.usdc"),
    Model(id: 33, type: "pants", color: "Black", modelName: "pants2.usdc"),
    Model(id: 34, type: "pants", color: "Red", modelName: "pants3.usdc"),
    Model(id: 35, type: "pants", color: "Orange", modelName: "pants4.usdc"),
    Model(id: 36, type: "pants", color: "Yellow", modelName: "pants5.usdc"),
    Model(id: 37, type: "pants", color: "Green", modelName: "pants6.usdc"),
    Model(id: 38, type: "pants", color: "Blue", modelName: "pants8.usdc"),
    Model(id: 39, type: "pants", color: "Purple", modelName: "pants9.usdc")

]


struct SuggestedView: View {
    var weatherData: WeatherData
    var body: some View {
        Home(weatherData: weatherData)
    }
}

#Preview {
    SuggestedView(weatherData: WeatherData(locationName: "Test City", temperature: 30.0, condition: "Sunny"))
}

struct Home: View {
    var weatherData: WeatherData
    @State var index = 1
    
    var body: some View {
        let result = outfitGenerator(for: weatherData, from: models)
        if(result[0] == -1){
            VStack{
                Text("Default Suggested Outfit")
                SceneView(scene: SCNScene(named: models[1].modelName),  options: [.autoenablesDefaultLighting, .allowsCameraControl])
                    .frame(width: UIScreen.main.bounds.width/1.1, height:UIScreen.main.bounds.height / 3)
            }
        }else{
            if result[1] == -1 {
                // dress view
                VStack{
                    Text("Suggested Outfit")
                    SceneView(scene: SCNScene(named: models[result[0]].modelName),  options: [.autoenablesDefaultLighting, .allowsCameraControl])
                        .frame(width: UIScreen.main.bounds.width/1.1, height:UIScreen.main.bounds.height / 3)
                }
            }else{
                // other view
                VStack{
                    Text("Suggested Outfit")
                    SceneView(scene: SCNScene(named: models[result[0]].modelName),  options: [.autoenablesDefaultLighting, .allowsCameraControl])
                        .frame(width: UIScreen.main.bounds.width/1.1, height:UIScreen.main.bounds.height / 5)
                    SceneView(scene: SCNScene(named: models[result[1]].modelName),  options: [.autoenablesDefaultLighting, .allowsCameraControl])
                        .frame(width: UIScreen.main.bounds.width/1.1, height:UIScreen.main.bounds.height / 5)
                }
                
            }
        }
        
    }
    
}

func extractDateComponents(from dateString: String) -> (year: Int, month: Int, day: Int)? {
    // Create a DateFormatter
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd" // The format of the date string
    
    // Convert the string to a Date object
    if let date = dateFormatter.date(from: dateString) {
        // Extract the year, month, and day components using Calendar
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return (year, month, day)
    } else {
        print("Invalid date string format")
        return nil
    }
}

func outfitGenerator(for weatherData: WeatherData, from models: [Model]) -> [Int]{
    @AppStorage("birthdate") var bDate = ""
    print(bDate)
    let dateComponents = extractDateComponents(from: bDate)
    
    let temperature = Int(weatherData.temperature)
    var myArray = [-1, -1]
    let colors = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "White", "Black"]

    // Get the current date
    let currentDate = Date()
    let calendar = Calendar.current
    let day = calendar.component(.day, from: currentDate)
    let month = calendar.component(.month, from: currentDate)
    let year = calendar.component(.year, from: currentDate)
    let ran = (year + month + (dateComponents?.year ?? 2022) + (dateComponents?.month ?? 4)) % 888
    let randomIntO = (day + ran * 10) % colors.count
    let randomIntT = (randomIntO * 2 + 6) % colors.count
    let luckyColorO = colors[randomIntO]
    let luckyColorT = colors[randomIntT]
    print("Lucky Colors: \(luckyColorO) and \(luckyColorT)")

    if temperature > 77 {
        let randomInt = Int.random(in: 0...10)
        if randomInt < 5 {
            // Consider dress
            let filteredModels = models.filter { model in
                model.type == "Dress" && model.color == luckyColorO
            }
            if !filteredModels.isEmpty {
                let randomIndex = Int.random(in: 0..<filteredModels.count)
                myArray[0] = filteredModels[randomIndex].id
            } else {
                let filteredModelDress = models.filter { model in
                    model.type == "Dress"
                }
                if !filteredModelDress.isEmpty {
                    let randomIndex = Int.random(in: 0..<filteredModelDress.count)
                    myArray[0] = filteredModelDress[randomIndex].id
                }
            }
        } else {
            // Consider T-shirt with shorts
            let filteredModelsO = models.filter { model in
                model.type == "T-shirt" && model.color == luckyColorO
            }
            if !filteredModelsO.isEmpty {
                let randomIndex = Int.random(in: 0..<filteredModelsO.count)
                myArray[0] = filteredModelsO[randomIndex].id
            } else {
                let filteredModelTshirt = models.filter { model in
                    model.type == "T-shirt"
                }
                if !filteredModelTshirt.isEmpty {
                    let randomIndex = Int.random(in: 0..<filteredModelTshirt.count)
                    myArray[0] = filteredModelTshirt[randomIndex].id
                }
            }

            // Shorts
            let filteredModelsT = models.filter { model in
                model.type == "shorts" && model.color == luckyColorT
            }
            if !filteredModelsT.isEmpty {
                let randomIndex = Int.random(in: 0..<filteredModelsT.count)
                myArray[1] = filteredModelsT[randomIndex].id
            } else {
                let filteredModelShorts = models.filter { model in
                    model.type == "shorts"
                }
                if !filteredModelShorts.isEmpty {
                    let randomIndex = Int.random(in: 0..<filteredModelShorts.count)
                    myArray[1] = filteredModelShorts[randomIndex].id
                }
            }
        }
    } else if temperature > 68 {
        // Consider T-shirt with pants
        let filteredModelsO = models.filter { model in
            model.type == "T-shirt" && model.color == luckyColorO
        }
        if !filteredModelsO.isEmpty {
            let randomIndex = Int.random(in: 0..<filteredModelsO.count)
            myArray[0] = filteredModelsO[randomIndex].id
        } else {
            let filteredModelTshirt = models.filter { model in
                model.type == "T-shirt"
            }
            if !filteredModelTshirt.isEmpty {
                let randomIndex = Int.random(in: 0..<filteredModelTshirt.count)
                myArray[0] = filteredModelTshirt[randomIndex].id
            }
        }

        // Pants
        let filteredModelsT = models.filter { model in
            model.type == "pants" && model.color == luckyColorT
        }
        if !filteredModelsT.isEmpty {
            let randomIndex = Int.random(in: 0..<filteredModelsT.count)
            myArray[1] = filteredModelsT[randomIndex].id
        } else {
            let filteredModelPants = models.filter { model in
                model.type == "pants"
            }
            if !filteredModelPants.isEmpty {
                let randomIndex = Int.random(in: 0..<filteredModelPants.count)
                myArray[1] = filteredModelPants[randomIndex].id
            }
        }
    } else if temperature > 59 {
        // Consider shirt with pants
        let filteredModelsO = models.filter { model in
            model.type == "shirt" && model.color == luckyColorO
        }
        if !filteredModelsO.isEmpty {
            let randomIndex = Int.random(in: 0..<filteredModelsO.count)
            myArray[0] = filteredModelsO[randomIndex].id
        } else {
            let filteredModelShirt = models.filter { model in
                model.type == "shirt"
            }
            if !filteredModelShirt.isEmpty {
                let randomIndex = Int.random(in: 0..<filteredModelShirt.count)
                myArray[0] = filteredModelShirt[randomIndex].id
            }
        }

        // Pants
        let filteredModelsT = models.filter { model in
            model.type == "pants" && model.color == luckyColorT
        }
        if !filteredModelsT.isEmpty {
            let randomIndex = Int.random(in: 0..<filteredModelsT.count)
            myArray[1] = filteredModelsT[randomIndex].id
        } else {
            let filteredModelPants = models.filter { model in
                model.type == "pants"
            }
            if !filteredModelPants.isEmpty {
                let randomIndex = Int.random(in: 0..<filteredModelPants.count)
                myArray[1] = filteredModelPants[randomIndex].id
            }
        }
    } else {
        // Consider coat with pants
        let filteredModelsO = models.filter { model in
            model.type == "coat" && model.color == luckyColorO
        }
        if !filteredModelsO.isEmpty {
            let randomIndex = Int.random(in: 0..<filteredModelsO.count)
            myArray[0] = filteredModelsO[randomIndex].id
        } else {
            let filteredModelCoat = models.filter { model in
                model.type == "coat"
            }
            if !filteredModelCoat.isEmpty {
                let randomIndex = Int.random(in: 0..<filteredModelCoat.count)
                myArray[0] = filteredModelCoat[randomIndex].id
            }
        }

        // Pants
        let filteredModelsT = models.filter { model in
            model.type == "pants" && model.color == luckyColorT
        }
        if !filteredModelsT.isEmpty {
            let randomIndex = Int.random(in: 0..<filteredModelsT.count)
            myArray[1] = filteredModelsT[randomIndex].id
        } else {
            let filteredModelPants = models.filter { model in
                model.type == "pants"
            }
            if !filteredModelPants.isEmpty {
                let randomIndex = Int.random(in: 0..<filteredModelPants.count)
                myArray[1] = filteredModelPants[randomIndex].id
            }
        }
    }

    return myArray
}


// Data Model
struct Model : Identifiable{
    var id : Int
    var type : String
    var color : String
    var modelName : String
}

