!SLIDE center smbullets
# Mi a GitHub?

* [github.com](http://github.com)
* online kollaboráció projekteken
* git-et használ verziókövetésre
* lehet mások projektjeit *fork*-olni (leágazás)
* hibakövetés, dokumentáció, szép és jól használható interfész, stb.
* Open Source projektekre ingyenes

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
# Általános Workflow

* szinkronizálás a távoli repóval: `git pull`
* fájlok szerkesztgetése
* átnézed, hogy mit változtattál: `git diff`
* amit commitolni akarsz, azt berakod az *index*-be: `git add .`
* commitolsz: `git commit -m "valami commit message"`
* a második ponttól ismételed, amíg csak akarod
* kirakod a távoli repóba: `git push`
