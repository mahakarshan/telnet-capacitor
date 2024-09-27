import { PluginListenerHandle } from "@capacitor/core";

export interface TelnetConnectionPlugin {
  connect(options: { host: string; port?: number }): Promise<void>;
  sendCommand(options: { command: string }): Promise<void>;
  disconnect(): Promise<void>;
  addListener(eventName: string, listenerFunc: (data: any) => void): PluginListenerHandle;

}
