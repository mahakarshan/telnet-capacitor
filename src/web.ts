import { WebPlugin } from '@capacitor/core';

import type { telentConnectionPlugin } from './definitions';

export class telentConnectionWeb
  extends WebPlugin
  implements telentConnectionPlugin
{
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
