!SLIDE center
## Ruby és webprogramozás
## 06 – **Sinatra**: nézetek és űrlapok

### **Bácsi László a.k.a. *LacKac***
### [lackac.hu](http://lackac.hu) lackac@lackac.hu

!SLIDE center smbullets
# Statikus fájlok

* a `public/` könyvtár alatt minden fájl statikus fájlként lesz kiszolgálva
* tehát a `public/design.css` a `/design.css` útvonalon
* és a `public/images/lolcat.jpg` a `/images/lolcat.jpg` útvonalon lesz elérhető

!SLIDE center smbullets
# View fájlok

* a `views/` könyvtár alatt sablonokat tarthatunk
* ezek általában ruby kóddal kiegészített html fájlok
* többféle sablontípus használható (erb, haml, erubis, stb.)
* meghívása az alkalmazásból pl. `erb :home` (fontos, hogy symbol legyen)

!SLIDE center
# View példa

    @@@ ruby
    # app.rb
    require 'erb'

    get "/hi/:name" do
      erb :hello
    end

    # views/hello.erb
    <h2>Hello, <%= params[:name] %>!</h2>

!SLIDE center
# Erb alapok

    @@@ html
    <p>Ruby kifejezés beillesztése:<br/>
    2 + 2 = <%= 2 + 2 %></p>

    <p>Ruby kód futtatása:<br/>
    <% names = ["Alice", "Bob"] %>
    Mostmár van `names` változónk:<br/>
    names = <%= names.inspect %></p>

    <p>Kontroll kifejezések (iterálás, if/else, stb.):<br/>
    <% names.each do |name| %>
    Hi, <%= name %>!<br/>
    <% end %>
    </p>

!SLIDE center
# Layout használata

### ha van `views/layout.erb` fájl, akkor az minden view "köré" lesz rakva

    @@@ html
    <html>
      <head><title>Layout példa</title></head>
      <body>
        <h1>Ez itt még a layout</h1>
        <p>de itt már a tartalom jön:</p>
        <%= yield %>
      </body>
    </html>

!SLIDE smbullets
# Hasznos linkek

* **[Sinatra Intro](http://www.sinatrarb.com/intro)**
