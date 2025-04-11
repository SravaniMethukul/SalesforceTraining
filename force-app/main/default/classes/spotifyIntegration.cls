public with sharing class spotifyIntegration {
  @AuraEnabled
  public static String searchWithSpotify(String trackName) {
    try {
      HttpRequest req = new HttpRequest();
      Http http = new Http();
      HttpResponse res = new HttpResponse();

      req.setMethod('GET');
      String encoded = EncodingUtil.urlEncode(trackName, 'UTF-8');
      req.setEndPoint(
        'Callout:SpotifyCallback/v1/search?q=' +
          encoded +
          '&type=album&limit=1&offset=1'
      );

      res = http.send(req);
      System.debug('response status : ' + res.getStatusCode());
      if (res.getStatusCode() == 200) {
        System.debug('response body : ' + res.getBody());
        return res.getBody();
      } else {
        return 'Error: Received status code ' + res.getStatusCode();
      }
    } catch (Exception e) {
      System.debug(e.getMessage());
      return e.getMessage();
    }
  }
}
