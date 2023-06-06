//
//  FaceIDController.swift
//  MovieApp
//
//  Created by digital on 06/06/2023.
//

import Foundation
import LocalAuthentication

class FaceIDAuthenticator {
    func authenticateWithFaceID(completion: @escaping (Bool, String) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authentication with Face ID to access the application"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true, "Authentication successful")
                    } else {
                        if let error = authenticationError as NSError? {
                            completion(false, "Face ID fail: \(error.localizedDescription)")
                        } else {
                            completion(false, "Face ID fail")
                        }
                    }
                }
            }
        } else {
            completion(false, "Face ID is not available")
        }
    }
}
