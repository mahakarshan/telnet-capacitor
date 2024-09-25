export interface telentConnectionPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
