import { registerPlugin } from '@capacitor/core';
import type { TelnetConnectionPlugin } from './definitions';

const TelnetConnection = registerPlugin<TelnetConnectionPlugin>('TelnetConnection', {
  web: () => import('./web').then(m => new m.TelnetConnectionWeb()),
});

export * from './definitions';
export { TelnetConnection };
