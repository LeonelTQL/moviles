class GmailConfig {
  // Aquí metes tus datos cuando configures OAuth en Google Cloud.
  // Para Android normalmente se configura el OAuth Client con el package name
  // y el SHA-1 en Google Cloud. Este serverClientId puede quedarse vacío si
  // no usas backend o Web Client ID.
  static const String serverClientId = '';

  // Scopes necesarios para enviar y leer correos con Gmail API.
  static const String scopeEmail = 'email';
  static const String scopeGmailSend = 'https://www.googleapis.com/auth/gmail.send';
  static const String scopeGmailReadOnly = 'https://www.googleapis.com/auth/gmail.readonly';
}
