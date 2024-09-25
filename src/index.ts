import { registerPlugin } from '@capacitor/core';

import type { telentConnectionPlugin } from './definitions';

const telentConnection = registerPlugin<telentConnectionPlugin>(
  'telentConnection',
  {
    web: () => import('./web').then(m => new m.telentConnectionWeb()),
  },
);

export * from './definitions';
export { telentConnection };
