class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "ecommerce";

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:8080";


  // requests
  static final String REQUEST_SHOW_ALL_PRODUCTS = "/prodotti";
  static final String REQUEST_ADD_PRODUCT = "/prodotti/aggiungiprodotto";
  static final String REQUEST_SEARCH_PRODUCTS = "/prodotti/ricerca/nome";

  static final String REQUEST_ADD_USER = "/utenti/registrazione";
  static final String REQUEST_SEARCH_USER = "/utenti/trovaUtente";
  static final String REQUEST_LOGIN_USER = "/utenti/login";
  static final String REQUEST_SHOW_ALL_USERS = "/utenti";

  static final String REQUEST_SHOW_ALL_PURCHASES = "/acquisti";
  static final String REQUEST_ADD_PURCHASE = "/acquisti/aggiungiacquisto";
  static final String REQUEST_SEARCH_PURCHASE = "/acquisti/ricerca/utente";


  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERRORE_MAIL_IN_USO";
  static final String RESPONSE_ERROR_USER_DOES_NOT_EXIST = "ERRORE_CREDENZIALI_NON_CORRETTE";
  static final String RESPONDE_ERROR_QUANTITY_NOT_AVAILABLE = "QUANTITÀ_NON_DISPONIBILE";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "CONNECTION_ERROR";


}