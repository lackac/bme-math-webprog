!SLIDE center
## Ruby és webprogramozás
## 09 – Adatbázisok, SQL, Sequel

### **Bácsi László a.k.a. *LacKac***
### [lackac.hu](http://lackac.hu) lackac@lackac.hu

!SLIDE center smbullets
# Adatbáziskezelés előnyei

* perzisztens adatok
* relációk kezelése
* bonyolult dolgok egyszerű lekérdezése
* gyors, stabil

!SLIDE center smbullets
# [SQL](http://en.wikipedia.org/wiki/SQL) és [NoSQL](http://en.wikipedia.org/wiki/NoSQL)

* SQL: relációs modell (minden entitás külön tábla, ezek között vannak relációk)
* NoSQL: séma nélküli modell (key-value store, document store)

!SLIDE center smbullets
# Mit lehet kezdeni az SQL adatbázissal?

* lekérdezéseket futtatni
* adatokat kinyernyi
* sorokat beilleszteni, módosítani és törölni
* táblákat létrehozni
* új adatbázisokat létrehozni, jogosultságokat állítani, stb.

!SLIDE center smbullets
# Mi kell hozzá?

* adatbázis szerver (RDBMS, pl. MySQL, PostgreSQL, Oracle, **Sqlite3**)
* valamilyen program amivel elérjük (**ruby library**, **parancssoros** vagy GUI program)
* **SQL lekérdezések**

!SLIDE center
# Adatbázis táblák

    @@@
    # users tábla
    | id | name   | login  | password_hash            |
    | 1  | László | LacKac | $1$RW13$z0ZlKqEv9gu/p./0 |
    | 2  | Kázmér | Calvin | $1$u.pj$e0h8h6L33nn.nxd1 |
    | 3  | Huba   | Hobbes | $1$Nvr7$vPSkKR1D4n6AcLQ0 |

    # notes tábla
    | id | user_id | note                       | created_on |
    | 13 | 1       | Árvíztűrő tükörfúrógép     | 2010-04-01 |
    | 42 | 3       | lorem ipsum dolor sit amet | 2010-04-13 |

!SLIDE center
# Adatbázis lekérdezések

    @@@ sql
    SELECT * FROM users;
    SELECT note FROM notes WHERE user_id=1;
    SELECT * FROM notes ORDER BY created_on DESC;
    SELECT * FROM notes n JOIN users u ON u.id=n.user_id;

!SLIDE center smbullets
## DML (Data Manipulation Language)

### **`SELECT`**, **`UPDATE`**, **`DELETE`**, **`INSERT INTO`**

## DDL (Data Definition Language)

### `CREATE DATABASE`, `ALTER DATABASE`, **`CREATE TABLE`**, `ALTER TABLE`, `DROP TABLE`, `CREATE INDEX`, `DROP INDEX`

!SLIDE center smbullets
# Sqlite

* fájl vagy memória alapú adatbázis
* minden adatbázis külön fájl
* nincsenek jogosultsági beállítások
* kis dolgokhoz sokkal egyszerűbb managelni, mint a többi rendszert

!SLIDE center
# Sqlite kipróbálás

    @@@ sql
    $ sqlite3 app.db
    SQLite version 3.3.8
    Enter ".help" for instructions
    sqlite> CREATE TABLE users (
       ...>   id INTEGER PRIMARY KEY AUTOINCREMENT,
       ...>   name VARCHAR(255), login VARCHAR(50),
       ...>   password_hash VARCHAR(40) );
    sqlite> CREATE TABLE notes (
       ...>   id INTEGER PRIMARY KEY AUTOINCREMENT,
       ...>   user_id INTEGER, note VARCHAR(255),
       ...>   created_on DATETIME );

!SLIDE center small

    @@@ sql
    sqlite> INSERT INTO users VALUES
       ...>   (NULL, 'László', 'LacKac', '$1$RW13$z0Z');
    sqlite> INSERT INTO users VALUES
       ...>   (NULL, 'Kázmér', 'Calvin', '$1$u.pj$e0h');
    sqlite> INSERT INTO users VALUES
       ...>   (NULL, 'Huba', 'Hobbes', '$1$Nvr7$vPS');
    sqlite> INSERT INTO notes VALUES
       ...>   (NULL, 1, 'Árvíztűrő tükörfúrógép', '2010-04-01');
    sqlite> INSERT INTO notes VALUES
       ...>   (NULL, 3, 'lorem ipsum dolor sit amet', '2010-04-13');
    sqlite> SELECT * FROM users;
    1|László|LacKac|$1$RW13$z0Z
    2|Kázmér|Calvin|$1$u.pj$e0h
    3|Huba|Hobbes|$1$Nvr7$vPS
    sqlite> SELECT * FROM notes n JOIN users u ON u.id=n.user_id;
    1|1|Árvíztűrő tükörfúrógép|2010-04-01|1|László|LacKac|$1$RW13$z0Z
    2|3|lorem ipsum dolor sit amet|2010-04-13|3|Huba|Hobbes|$1$Nvr7$vPS

!SLIDE center smbullets
# [ORM](http://en.wikipedia.org/wiki/Object-relational_mapping) rendszerek

* *Object-relational mapping*
* leegyszerűsítik az SQL adatbázisok elérését és a lekérdezéseket
* objektum orientált szemlélet
* biztonságosabb adatbáziskezelés (kisebb valószínűséggel lesz a kód miatt [SQL injection](http://en.wikipedia.org/wiki/Sql_injection)-re lehetőség)
* Rubyban legismertebbek: [ActiveRecord](http://ar.rubyonrails.org/), [DataMapper](http://datamapper.org/), [Sequel](http://sequel.rubyforge.org/)

!SLIDE center small
# Sequel alapok

    @@@ ruby
    require 'rubygems'
    require 'sequel'

    DB = Sequel.sqlite("app.db")

    DB.create_table :users do
      primary_key :id
      String :name
      String :login
      String :password_hash
      Fixnum :age
    end

    users = DB[:users]
    users.insert(:name => "László", :login => "LacKac", :age => 26)
    users.insert(:name => "Kázmér", :login => "Calvin", :age => 6)
    users.insert(:name => "Huba", :login => "Hobbes", :age =>  7)

    puts "Users count: #{users.count}"

!SLIDE center
# Hagyományos SQL

    @@@ ruby
    # hagyományos SQL futtatás:
    DB.run "CREATE TABLE colors (user_id INT, color VARCHAR(255))"
    dataset = DB["SELECT name FROM users WHERE login = ?", "LacKac"]
    puts dataset.map(:name)
    DB.fetch("SELECT name FROM users") do |row|
      p r[:name]
    end

!SLIDE center small
# Sorok elérése

    @@@ ruby
    users.map {|r| r[:name]}
    users.map(:name) # ugyanaz mint az előbbi

    users.filter(:login => "LacKac").first
      # => {:login=>"LacKac", :name=>"László", :id=>1}
    users.filter(:name => ["Kázmér", "Huba"]).map(:login)
      # => ["Calvin", "Hobbes"]
    users.order(:name).map {|r| [r[:name], r[:age]]}
      # => [["Huba", 7], ["Kázmér", 6], ["László", 26]]
    users.order(:age).limit(2).map(:name)
      # => ["Kázmér", "Huba"]

    # #sql metódus megmutatja mi lenne futtatva
    users.exclude {|r| r.age > 10}.sql
      # => "SELECT * FROM `users` WHERE (`age` <= 10)"
    users.filter(:age => 5..8).sql
      # => "SELECT * FROM `users` WHERE ((`age` >= 5) AND (`age` <= 8))"

!SLIDE center
# Összegzések, számítások

    @@@ ruby
    users.count # => 3
    users.max(:age) # => "26"
    users.min(:age) # => "6"
    users.avg(:age) # => "13.0"
    users.sum(:age) # => "39"

!SLIDE center small
# JOIN

    @@@ ruby
    DB.create_table :notes do
      primary_key :id
      foreign_key :user_id, :users
      String :note
      Time :created_at
    end

    notes = DB[:notes]
    lackac, _, hobbes = users.to_a
    notes.insert(:note => "Árvíztűrő tükörfúrógép",
                 :user_id => lackac[:id], :created_at => Time.now-100000)
    notes.insert(:note => "lorem ipsum dolor sit amet",
                 :user_id => hobbes[:id], :created_at => Time.now)

    notes.join(:users, :id => :user_id).map do |note|
      [note[:login], note[:note]]
    end
      # => [["LacKac", "Árvíztűrő tükörfúrógép"], ["Hobbes", "lorem ipsum dolor sit amet"]]

!SLIDE center
# Kitérő: password_hash?

### nem szép dolog kódolatlanul jelszót tárolni <br/>egy egyszerű megoldás: hash függvénnyel kódolás

    @@@ ruby
    require 'digest/sha1'
    Digest::SHA1.hexdigest("jelszo")
      # => "2f712f2b4c17b108f5961465d36a19c98301c173"

    users.where(:login => params[:user],
      :password_hash => Digest::SHA1.hexdigest(params[:password]))

!SLIDE center smbullets
# Feladat

### Az előző gyakorlat feladatához csináljunk rendes felhasználó kezelést:

* lehessen regisztrálni (teljes név, felhasználónév, jelszó, kor)
* az adatbázis alapján bejelentkezni (tipp: session-ben érdemes a user `id`-jét tárolni)
* bejelentkezett felhasználó láthassa csak a titkot
* legyen egy oldal, ami listázza az összes felhasználót (név, felhasználónév, kor)

!SLIDE smbullets
# Hasznos linkek

* **[SQL](http://en.wikipedia.org/wiki/SQL)**
* **[NoSQL](http://en.wikipedia.org/wiki/NoSQL)**
* **[SQL Tutorial](http://www.w3schools.com/sql/)**
* **[Sequel](http://sequel.rubyforge.org/)**
* [Sequel CheatSheet](http://sequel.rubyforge.org/rdoc/files/doc/cheat_sheet_rdoc.html)
