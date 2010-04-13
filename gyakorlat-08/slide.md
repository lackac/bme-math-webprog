!SLIDE center
## Ruby és webprogramozás
## 08 – **Sinatra**: forms, POST and session

### **Bácsi László a.k.a. *LacKac***
### [lackac.hu](http://lackac.hu) lackac@lackac.hu

!SLIDE center smbullets
# Űrlapok használata

* regisztráció
* bejelentkezés
* keresés
* új dolgok létrehozása
* és meglevők módosítása

!SLIDE center
# Egy egyszerű `form`

    @@@ html
    <form action="/login" method="POST">
      <fieldset>
        <legend>Bejelentkezés</legend>
        <p>
          <label for="user">Felhasználónév:</label>
          <input type="text" id="user" name="user" />
        </p>
        <p>
          <label for="pass">Jelszó:</label>
          <input type="password" id="pass" name="pass" />
        </p>
        <p><input type="submit" value="Mehet" /></p>
      </fieldset>
    </form>

### [eredmény](/gyakorlat-08/)

!SLIDE center
# Form attribútumok

    @@@
    <form
      action="/login"     <= ide küldjük az adatokat
      method="POST"       <= hogyan küldjük (GET v. POST)
      enctype="application/x-www-form-urlencoded"
                          <= milyen formában küldjük (opcionális)
                             lehet még: multipart/form-data

!SLIDE center
# Elemek tagoláshoz, leíráshoz

    @@@
    <fieldset>            <= form tagolására használható
    <legend>...</legend>  <= egy fieldsetnek ad valami címet
    <label                <= egy input elemhez ad címkét
      for="username"       - hivatkozás az input elemre

!SLIDE center
# Input elemek

    @@@
    <input                <= mindenféle input elem
      id="user"            - egyedi azonosító
      name="user"          - így megy tovább a szerver oldalra
                             ez a kettő minden input elemen van
      value="LacKac"       - alapérték
      type="..."           - input elem típusa, lásd később

    <textarea>...         <= többsoros szöveges mező
                             az érték az elem "belsejében" van
                             (<textarea>alapérték</textarea>)

    <select               <= legördülős választó
      multiple="multiple"  - lehessen-e többet is választani
    <option               <= egy választási lehetőség
      value="HU"           - ha ezt választjuk, ez lesz az érték
      >Hungary</option>    - a megjelenített szöveg

!SLIDE center
# Gombok

    @@@
    <input type="submit"  <= submit gomb
      value="Mehet"        - a value érték lesz a gombra írva
    <input type="reset"   <= reset gomb, űrlap értékek ürítésére

!SLIDE center
# INPUT típusok

    @@@
    type="text"           <= síma szöveges mező
      maxlength="20"       - maximális karakterszám
    type="password"       <= jelszó mező
    type="checkbox"       <= jelölőnégyzet
      checked="checked"    - be van-e alapból jelölve
                          megj.: ha nincs bejelölve, akkor semmi
                                 sem megy szerve felé, ha be van,
                                 akkor a value attribútum megy
    type="radio"          <= több "jelölőnégyzet", amiből csak egy
                             lehet kiválasztva (a name azonos)
    type="hidden"         <= rejtett mező

!SLIDE center
# Form feldolgozás

    @@@ ruby
    post "/login" do
      if params[:user] == "LacKac" and params[:pass] == "jelszo"
        redirect "/titkok"
      else
        redirect "/hiba"
      end
    end

    get "/search" do
      q = params[:q]
      "Találatok: kis #{q}, nagy #{q}, zöld #{q}"
    end

!SLIDE center smbullets
# Pár további tipp

* legtöbb esetben `method="post"` használandó
* `method="GET"` esetében url-ben adódnak át az értékek, általában keresőmezőnél használatos
* `post`-nál érdemes redirect-et használni
* állapotmegőrzéshez pedig session-t

!SLIDE center smbullets
# Session kezelés

* a HTTP protokoll állapotmentes
* állapot megtartására ún. session-t szoktak használni
* sok megvalósítás van
* Sinatra alapból cookie alapú session-t használ, de ezt is be kell kapcsolni

!SLIDE center
# Session használat

    @@@ ruby
    enable :sessions

    post "/login" do
      if params[:user] == "LacKac" and params[:pass] == "jelszo"
        session[:logged_in] = true
        redirect "/titkok"
      else
        redirect "/"
      end
    end

    get "/titkok" do
      if session[:logged_in]
        erb :titkok
      else
        redirect "/"
      end
    end

!SLIDE center smbullets
# Feladat
### Fejezd be az elkezdett példát

* Főoldalon legyen egy bejelentkező form, ami `/login`-ra postol
* ott az alkalmazás beégetett felhasználónévvel és jelszóval ellenőrizzen jogosultságot, és küldjön tovább a `/titok` oldalra
* `/titok` ne legyen elérhető jelszó nélkül
* ha nem jó a jelszó, vagy bejelentkezés nélkül próbálkozik valaki, akkor a bejelentkező form jelenjen meg újra fölötte hibaüzenettel

#### megoldás: [app.rb](http://github.com/lackac/bme-math-webprog/blob/master/gyakorlat-08/app.rb#L15,L39), [home.erb](http://github.com/lackac/bme-math-webprog/blob/master/gyakorlat-08/views/home.erb#L5,L23), [layout.erb](http://github.com/lackac/bme-math-webprog/blob/master/gyakorlat-08/views/layout.erb#L20,L25)

!SLIDE center smbullets
# Feladat
### Közmondások keresése

* szerezz valahonnan legalább 20 közmondást
* tárold egy fájlban
* az alkalmazásban legyen egy kereső form
* a keresés a `/search` útonalon történjen
* és adjon vissza minden olyan közmondást, amiben szerepel a keresett szó

#### megoldás: [kozmondasok.rb](http://github.com/lackac/bme-math-webprog/blob/master/gyakorlat-08/kozmondasok.rb), [app.rb](http://github.com/lackac/bme-math-webprog/blob/master/gyakorlat-08/app.rb#L41,L46), [home.erb](http://github.com/lackac/bme-math-webprog/blob/master/gyakorlat-08/views/home.erb#L25,L34), [search.erb](http://github.com/lackac/bme-math-webprog/blob/master/gyakorlat-08/views/search.erb)

!SLIDE smbullets
# Hasznos linkek

* **[Sinatra könyv](http://sinatra-book.gittr.com/)**
* **[Forms in HTML documents](http://www.w3schools.com/html/html_forms.asp)**
* **[Sinatra Sessions](http://www.sinatrarb.com/faq.html#sessions)**
