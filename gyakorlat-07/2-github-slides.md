!SLIDE center smbullets
# Mi a GitHub?

* [github.com](http://github.com)
* online kollaboráció projekteken
* git-et használ verziókövetésre
* lehet mások projektjeit *fork*-olni (leágazás)
* és még hibakövetés, dokumentáció, szép és jól használható interfész, stb.
* open-source projektekre ingyenes

!SLIDE commandline
# Regisztrációhoz SSH kulcs

    $ ssh-keygen # utána 3 enter
    $ cat ~/.ssh/id_rsa.pub
    ssh-rsa AAAAB3...

### Regisztrálás: [https://github.com/signup/free](https://github.com/signup/free)
#### (alul adjátok meg az SSH kulcsot)

!SLIDE center smbullets
# Első projekt GitHub-on

* [http://github.com/](http://github.com/) oldalon "New Repository" gomb
* **Projekt név**: webprog-assignement
* **Description**: My 4th semester Web Programming assignement at BUTE
* aztán "Create Repository"
* utána kövessétek az utasításokat a "Next Step" alatt

!SLIDE center smbullets small
# Általános Wrokflow

* szinkronizálás a távoli repóval `git pull`
* fájlok szerkesztgetése
* átnézed, hogy mit változtattál `git diff`
* amit commitolni akarsz, azt berakod az *index*-be `git add .`
* commitolsz `git commit -m "valami commit message"`
* ismételed, amíg gondolod a második ponttól
* kirakod a távoli repóba `git push`

!SLIDE smbullets
# Hasznos linkek

* **GitHub**:
[http://github.com/](http://github.com/)
* **GitHub Help oldalak**:
[http://help.github.com/](http://help.github.com/)
