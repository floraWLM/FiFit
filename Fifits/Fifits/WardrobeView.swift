//
//  WardrobeView.swift
//  Fifits
//
//  Created by Allen Zhao on 10/19/24.
//

import SwiftUI
import RealityKit

struct WardrobeView: View {
    let categories = [
            "Dress": [],
            "T-shirts": [],
            "Shorts": [],
            "Pants": ["pants1.usdc", "pantstest.usdc", "pantstest2.usdc"],
            "Shirts": [],
            "Coat": []
        ]

        var body: some View {
            NavigationView {
                List {
                    ForEach(categories.keys.sorted(), id: \.self) { category in
                        Section(header: Text(category).font(.headline)) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(categories[category]!, id: \.self) { item in
                                        VStack {
                                            // Use the ModelView to load the USDC model
                                            USDCModelView(modelName: item)
                                                .frame(width: 150, height: 150) // Set size for the ARView
                                                .cornerRadius(8)
                                                .background(Color.gray.opacity(0.1)) // Optional: background color for visibility
                                                .padding(5) // Add some padding around each item
                                        }
                                    }
                                }
                                .padding(.vertical)
                            }
                        }
                    }
                }
                .navigationTitle("My Wardrobe")
            }
        }
    }

    struct CategoryView_Previews: PreviewProvider {
        static var previews: some View {
            WardrobeView()
        }
    }

    // USDCModelView for loading and displaying the USDZ models
struct USDCModelView: UIViewRepresentable {
    let modelName: String
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        loadModel(named: modelName, into: arView)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // No need to update the view for this example
    }
    private func loadModel(named name: String, into arView: ARView) {
        // Load the USDC model
        let modelEntity = try! ModelEntity.loadModel(named: name)
        
        // Create an anchor and add the model entity
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(modelEntity)

        // Create a directional light entity
        let lightEntity = Entity()
        lightEntity.components[DirectionalLightComponent.self] = DirectionalLightComponent(color: .white, intensity: 1000)

        // Position the light (adjust as needed)
        lightEntity.position = [0, 1, 0] // Adjust height as needed
        lightEntity.look(at: [0, 0, 0], from: lightEntity.position, relativeTo: nil) // Point the light towards the model

        // Add the light entity to the anchor
        anchorEntity.addChild(lightEntity)

        // Add the anchor to the scene
        arView.scene.addAnchor(anchorEntity)
    }

    #Preview {
        WardrobeView()
    }
}
