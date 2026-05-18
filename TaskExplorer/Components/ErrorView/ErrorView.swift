//
//  ErrorView.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
            
            Text("Something went wrong")
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Button("Retry") {
                retryAction()
            }
        }
        .padding()
    }
}

#Preview {
    ErrorView(message: "Koneksi Bermasalah",
              retryAction: {
        print("error")
    })
}
