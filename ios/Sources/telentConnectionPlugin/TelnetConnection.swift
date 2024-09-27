import Foundation

@objc public class TelnetConnection: NSObject {
    
    private var inputStream: InputStream?
    private var outputStream: OutputStream?
    private var host: String = ""
    private var port: Int = 23
    
    // Method to connect to the Telnet server
    @objc public func connect(_ host: String, port: Int = 23) throws {
        self.host = host
        self.port = port
        
        Stream.getStreamsToHost(withName: host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        inputStream?.open()
        outputStream?.open()
    }
    
    // Method to send commands to the Telnet server
    @objc public func sendCommand(_ command: String) -> Bool {
        guard let outputStream = self.outputStream else {
            print("Error: Not connected to the Telnet server.")
            return false
        }
        
        let data = "\(command)\n".data(using: .utf8)!
        data.withUnsafeBytes {
            outputStream.write($0, maxLength: data.count)
        }
        return true
    }
    
    // Method to listen for data from the Telnet server
    @objc public func receiveData() -> String {
        guard let inputStream = self.inputStream else {
            return "Error: Not connected to the Telnet server."
        }
        
        let bufferSize = 1024
        var buffer = [UInt8](repeating: 0, count: bufferSize)
        var output = ""

        while inputStream.hasBytesAvailable {
            let bytesRead = inputStream.read(&buffer, maxLength: bufferSize)
            if bytesRead > 0 {
                if let result = String(bytes: buffer, encoding: .utf8) {
                    output += result
                }
            }
        }
        
        return output
    }
    
    // Close the Telnet connection
    @objc public func close() {
        inputStream?.close()
        outputStream?.close()
        inputStream = nil
        outputStream = nil
    }
}
