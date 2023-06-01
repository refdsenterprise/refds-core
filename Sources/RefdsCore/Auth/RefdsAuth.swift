import Foundation
import RefdsResource
import LocalAuthentication

public final class RefdsAuth: ObservableObject {
    @Published public var isLoading: Bool = false
    @Published public var biometryType: LABiometryType = .none
    
    private var context: LAContext?
    
    public init() { context = LAContext() }
    deinit { context = nil }
    
    @MainActor private func checkBiometryAvailability() throws {
        if let context = context {
            var failureReason: NSError?
            guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &failureReason) else {
                if let error = failureReason { throw error }
                return
            }
            self.biometryType = context.biometryType
        }
    }
    
    @MainActor private func authenticateWithBiometry(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        if let context = context, (biometryType == .faceID || biometryType == .touchID) {
            isLoading = true
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: .refdsString(.lockScreen(.requestAuthReason))
            ) { success, _ in
                DispatchQueue.main.async {
                    if success { onSuccess() }
                    else { onError() }
                    self.isLoading = false
                }
            }
        }
    }
    
    @MainActor private func authenticateWithPasscode(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        if let context = context {
            isLoading = true
            context.evaluatePolicy(
                .deviceOwnerAuthentication,
                localizedReason: .refdsString(.lockScreen(.requestAuthReason))
            ) { success, _ in
                DispatchQueue.main.async {
                    if success { onSuccess() }
                    else { onError() }
                    self.isLoading = false
                }
            }
        }
    }
    
    @MainActor public func authenticate(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        do {
            try checkBiometryAvailability()
            authenticateWithBiometry(onSuccess: onSuccess, onError: onError)
        } catch {
            authenticateWithPasscode(onSuccess: onSuccess, onError: onError)
        }
    }
}
