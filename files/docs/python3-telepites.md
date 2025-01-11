# Python3 telepítési útmutató

Ez az útmutató lépésről lépésre bemutatja, hogyan telepíthető a Python 3 operációs rendszereken, mint Windows, Linux és Mac.

## Tartalomjegyzék

1. [Bevezetés](#bevezetés)
2. [Windows](#windows)
    1. [Telepítés](#telepítés-windows)
    2. [Path beállítása](#path-beállítása)
3. [Linux](#linux)
    1. [Telepítés](#telepítés-linux)
4. [Mac](#mac)
    1. [Telepítés](#telepítés-mac)
5. [Ellenőrzés](#ellenőrzés)

## Bevezetés

A Python egy népszerű, magas szintű programozási nyelv, amely széles körben használható különböző szoftverfejlesztési projektekhez, beleértve a webes alkalmazásokat, az adatelemzést, az automatizálást és sok mást. Ennek az útmutatónak a célja, hogy segítsen telepíteni a Python 3-at a különböző operációs rendszereken.

## Windows

### Telepítés (Windows)

1. Látogasson el a Python hivatalos weboldalára: [python.org](https://python.org)
2. Menjen a "Downloads" menüpontra, majd válassza a Windows operációs rendszerhez készült Python legújabb verzióját.
3. Töltse le és futtassa a telepítőt.
4. Fontos: A telepítés kezdetén válassza az "Add Python 3.x to PATH" opciót, hogy a Python elérhető legyen a parancssorból.
5. Kövesse a telepítő további utasításait a telepítés befejezéséhez.

### Path beállítása

Ha a telepítés során nem választotta az "Add Python 3.x to PATH" opciót, manuálisan is hozzáadhatja a Python-t a Path környezeti változóhoz:

1. Keresse meg a Python telepítési könyvtárát (általában `C:\Users\<Felhasználónév>\AppData\Local\Programs\Python\Python3x`).
2. Másolja az elérési útját a vágólapra.
3. Keresse meg a "Környezeti változók szerkesztése a rendszer tulajdonságaihoz" opciót a Start menü keresőjében.
4. A "Rendszer tulajdonságai" ablakban válassza a "Környezeti változók" gombot.
5. A "Rendszer változók" szekcióban keresse meg és válassza ki a "Path" változót, majd kattintson az "Szerkesztés" gombra.
6. Kattintson az "Új" gombra és illessze be a Python elérési útját.
7. Kattintson az "OK" gombra az ablakok bezárásához és a változások mentéséhez.

## Linux

### Telepítés (Linux)

A legtöbb Linux disztribúció már előre telepítve rendelkezik a Python 3-mal. Ellenőrizheti a Python verzióját a következő paranccsal:

```bash
python3 --version
```

Ha a telepített verzió régebbi, mint amire szüksége van, vagy ha a Python nincs telepítve, használja a disztribúciója csomagkezelőjét a telepítéshez. Például Ubuntu esetén:

```bash
sudo apt update
sudo apt install python3
```

## Mac

### Telepítés (Mac)

A Mac OS X

 10.8 és újabb verziói már rendelkeznek Python 2.7-tel, de a Python 3 telepítéséhez kövesse ezeket a lépéseket:

1. Látogasson el a [python.org](https://python.org)-ra és töltse le a Mac OS X-hez készült Python legújabb verzióját.
2. Nyissa meg a letöltött `.pkg` fájlt és kövesse a telepítő utasításait.
3. A telepítés után ellenőrizheti a Python verzióját a "Terminal" alkalmazásban a következő paranccsal:

```bash
python3 --version
```

## Ellenőrzés

A telepítés sikeres voltának ellenőrzéséhez nyissa meg a parancssort vagy terminált és írja be a következőt:

```bash
python3 --version
```

Ha a rendszer kiírja a Python telepített verzióját, akkor a telepítés sikeres volt. Gratulálunk, mostantól készen áll a Python programozási nyelv használatára!

Ez az útmutató általános útmutatásokat nyújt a Python 3 telepítéséhez. Ha specifikus problémába ütközik, érdemes lehet további online forrásokhoz fordulni vagy a hivatalos Python dokumentációhoz.