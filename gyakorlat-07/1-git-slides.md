!SLIDE center
## Ruby és webprogramozás
### egy kis kitérő
## 07 – **Git**, **GitHub** és **Heroku**

### **Bácsi László a.k.a. *LacKac***
### [lackac.hu](http://lackac.hu) lackac@lackac.hu

!SLIDE center smbullets
# Mire való a verziókövetés

* **Biztonság**: megvan minden változtatás
* **Rend**: rendezettségre késztet
* **Kooperáció**: megkönnyíti a közös munkát
* **Szabadság**: könnyebbé teszi új dolgok kipróbálását

!SLIDE center smbullets
# Hagyományos verziókövetők

* egy központi *repository*
* sok hálózati forgalom
* nehezebb *branch* kezelés
* pl. SVN, CVS, Perforce

!SLIDE center smbullets
# Elosztott verziókövetők

* mindenkinél van egy lokális *repository*
* csak pár művelet igényel hálózati forgalmat (*sync*)
* nagyon egyszerű *branch*-ek létrehozása
* pl. Git, Mercurial, Bazaar

!SLIDE center smbullets
# Git

* elosztott verziókövető rendszer (DVCS)
* mindenkinél van egy teljes másolat
* ezek között könnyen lehet szinkronizálni
* használat: `git parancs [argumentumok]`

!SLIDE center smbullets smaller
# Alapfogalmak

* ***repository***: az összes verziót tartalmazó *adatbázis*
* ***branch***: egy fejlesztési ág
* ***master***: a fő fejlesztési ág
* ***working copy***: az jelenleg látott állapota a projektnek aktuális változtatásokkal együtt
* ***commit***: egy változtatás a projektben (érinthet több fájlt is, nevezhetjük *revision*-nek is)
* ***HEAD***: a legutolsó *commit* az aktuális *branch*-ben
* ***tag***: egy névvel ellátott *commit*
* ***remote***: távoli *repository*, amivel szinkronizálhatunk
* ***origin***: kitüntetett távoli *repository*

!SLIDE commandline
# Elindulás

    $ git config --global user.name "László Bácsi"
    $ git config --global user.email "lackac@lackac.hu"
    $ git config --global core.editor 'vim' # vagy más
    $ cat ~/.gitconfig

    $ mkdir my_project
    $ cd my_project
    $ git init
    $ echo "Ez itt az én kis projektem" > README
    $ git add .
    $ git commit -m "Első commitom"
    $ git log

!SLIDE commandline
# Szinkronizálás

### Klónozás

    $ git clone git@github.com:lackac/bme-math-webprog.git

### Változások kirakása és leszedése

    $ git push origin master
    $ git pull origin master

!SLIDE commandline smaller
# Fontosabb parancsok

    $ git init
    $ git clone
    $ git add
    $ git commit
    $ git log
    $ git diff
    $ git push
    $ git pull
    $ git checkout -b
    $ git checkout

!SLIDE smbullets
# Hasznos linkek

* **Hivatalos Git Honlap**:
[http://git-scm.com/](http://git-scm.com/)
* **Pro Git** (egy részletes könyv):
[http://progit.org/book/](http://progit.org/book/)
* **Hasznos leírások kezdőknek**:
[http://learn.github.com/](http://learn.github.com/)
* **Tippek minden szinten**:
[http://www.gitready.com/](http://www.gitready.com/)
* **Miben jobb, mint a többi**:
[http://whygitisbetterthanx.com/](http://whygitisbetterthanx.com/)
