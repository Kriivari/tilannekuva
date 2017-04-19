1. Asenna https://s3.amazonaws.com/railsinstaller/Windows/railsinstaller-3.3.0.exe
2. Pura http://kivimaa.fi/tilannekuva.zip sopivaan paikkaan, esim c:\
   (vältä isoja kirjaimia polussa, nämä eivät toimi kaikissa alla olevan Ruby-moottorin
   versioissa)
3. Käynnistä Windows PowerShell
4. Mene hakemistoon C:\tilannekuva
5. Aja: ruby .\bin\bundle install

Asennus on nyt valmis.

6. Käynnistä tilannekuva ajamalla kohdan 4. hakemistossa: ruby .\bin\rails server
   - Jos pitää päästä käsiksi muiltakin koneilta, käynnistä komennolla: ruby .\bin\rails server -b 0.0.0.0
7. Mene osoitteeseen http://localhost:3000/ - käyttäjätunnus on risti ja salasana sparra
8. Klikkaa ylhäältä Yksiköiden hallinta ja muokkaa yksiköt haluamaksesi
9. Jos haluat karttapohjan, klikkaa ylhäältä Operaatiot ja New operation 
   - Paikkapääte on itse asiassa kunta (eli jos operaatio on Lahdessa, laita siihen Lahti).
   - Googlen karttaan hyvä zoom on 12-14, leveys 800 ja korkeus 600-800.
   - Koordinaatit pitää antaa WGS84 desimaalimuodossa, helpoin tapa tähän on
     http://kansalaisen.karttapaikka.fi ja zoomaile kartan kohdistinristi oikeaan keskipisteeseen,
     ja oikealta zoomauspalkin alta xy-napista ETRS89 maantieteelliset, kolmannessa muodossa
     (eli asteita ja asteen desimaaliosia). Koordinaatit pitää antaa pisteellä erotettuna,
     pilkku ei kelpaa.
   - Tekstiviestit ja TETRA-yhteys eivät oikeasti toimi.

Yleisiä käyttöohjeita
- Järjestelmä yrittää olla fiksu ja pyrkii pitämään sijainnin ja tehtäväkoodin
  samoina statuksen vaihtuessa Matkalla -> kohteessa jne. Tämä onnistuu vain,
  jos jättää nämä kentät tyhjiksi.
- Yksikön paikkaa kartalla voi siirtää raahaamalla. Tästä ei synny uutta tapahtumaa,
  ainoastaan yksikön sijaintitieto muuttuu.
- Jonosta tehtävän siirto yksikölle (ja tilaksi Matkalla) aikaansaa tekstiviestin
  lähettämisen, jos yksikölle on asetettu puhelinnumero JA operaation tietoihin
  on asetettu oikeat Twilio-tilin asetukset (www.twilio.com).
- GPRS-paikantimien käytöstä ole erikseen yhteydessä Kalleen (tuetaan paria eri
  kiinalaista halpispaikanninta, mutta tämä vaatii erillisen ohjelmapalikan sekä
  tietysti internet-yhteyden).

Kehitysehdotukset ja vikailmoitukset kalle.kivimaa@iki.fi



