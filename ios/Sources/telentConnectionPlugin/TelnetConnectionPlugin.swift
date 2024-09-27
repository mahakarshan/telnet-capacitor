import Foundation
import Capacitor

@objc(TelnetConnectionPlugin)
public class TelnetConnectionPlugin: CAPPlugin {
    
    private let implementation = TelnetClient() // Telnet Client implementation

    // Method to establish a Telnet connection
    @objc func connect(_ call: CAPPluginCall) {
        guard let host = call.getString("host") else {
            call.reject("Host is required")
            return
        }
        let port = call.getInt("port") ?? 23 // Default Telnet port is 23

        DispatchQueue.global(qos: .background).async {
            do {
                try self.implementation.connect(host: host, port: port)
                call.resolve() // Successfully connected
            } catch {
                call.reject("Connection failed")
            }
        }
    }

    // Method to send commands to the Telnet server (e.g., username, password)
    @objc func sendCommand(_ call: CAPPluginCall) {
        guard let command = call.getString("command") else {
            call.reject("Command is required")
            return
        }
        
        // Send the command
        if self.implementation.isConnected {
            self.implementation.sendCommand(command: command)
            call.resolve() // Successfully sent command
        } else {
            call.reject("Not connected to the Telnet server")
        }
    }

    // Method to listen for Telnet data
    @objc func listenForData(_ call: CAPPluginCall) {
        if self.implementation.isConnected {
            DispatchQueue.global(qos: .background).async {
                let data = self.implementation.listenForData()
                call.resolve([
                    "data": data
                ])
            }
        } else {
            call.reject("Not connected to the Telnet server")
        }
    }
}
