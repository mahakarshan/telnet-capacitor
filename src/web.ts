import { WebPlugin } from '@capacitor/core';
import type { TelnetConnectionPlugin } from './definitions';

export class TelnetConnectionWeb extends WebPlugin implements TelnetConnectionPlugin {
  
  async connect(options: { host: string; port?: number }): Promise<void> {
    console.warn("Telnet connection is not supported on the web platform.");
    return Promise.reject("Telnet connection is not supported on the web platform.");
  }

  async sendCommand(options: { command: string }): Promise<void> {
    console.warn("Telnet command cannot be sent from the web platform.");
    return Promise.reject("Telnet command cannot be sent from the web platform.");
  }

  async disconnect(): Promise<void> {
    console.warn("Telnet disconnection is not supported on the web platform.");
    return Promise.reject("Telnet disconnection is not supported on the web platform.");
  }
}
