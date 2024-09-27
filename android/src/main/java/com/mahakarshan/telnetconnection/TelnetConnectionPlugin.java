package com.example.telnetconnection;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.PluginMethod;

import org.apache.commons.net.telnet.TelnetClient;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.Scanner;

@CapacitorPlugin(name = "TelnetConnection")
public class TelnetConnectionPlugin extends Plugin {

    private TelnetClient telnetClient;
    private InputStream inputStream;
    private PrintStream outputStream;
    private Thread readThread;

    @PluginMethod
    public void connect(PluginCall call) {
        String host = call.getString("host");
        int port = call.getInt("port", 23); // Default Telnet port is 23

        try {
            telnetClient = new TelnetClient();
            telnetClient.connect(host, port);

            inputStream = telnetClient.getInputStream();
            outputStream = new PrintStream(telnetClient.getOutputStream());

            // Start a background thread to listen to data from the server
            readThread = new Thread(() -> {
                try (Scanner scanner = new Scanner(inputStream)) {
                    while (telnetClient.isConnected() && scanner.hasNextLine()) {
                        String serverData = scanner.nextLine();
                        JSObject ret = new JSObject();
                        ret.put("data", serverData);
                        notifyListeners("telnetDataReceived", ret); // Emit event for data received
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            });
            readThread.start();

            call.resolve();
        } catch (Exception e) {
            call.reject("Connection failed", e);
        }
    }

    @PluginMethod
    public void sendCommand(PluginCall call) {
        String command = call.getString("command");

        if (telnetClient != null && telnetClient.isConnected()) {
            outputStream.println(command);
            outputStream.flush();
            call.resolve();
        } else {
            call.reject("Not connected");
        }
    }

    @PluginMethod
    public void disconnect(PluginCall call) {
        try {
            if (telnetClient != null && telnetClient.isConnected()) {
                telnetClient.disconnect();
                if (readThread != null && readThread.isAlive()) {
                    readThread.interrupt();
                }
                call.resolve();
            }
        } catch (Exception e) {
            call.reject("Failed to disconnect", e);
        }
    }
}