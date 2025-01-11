# NodeJS 20 telepítési útmutató

Ez az útmutató lépésről lépésre segít a NodeJS 20 verziójának telepítésében különböző operációs rendszerekre, mint Windows, Linux, és Mac.

## Tartalomjegyzék

1. [Bevezetés](#bevezetés)
2. [Windows](#windows)
    1. [Telepítés](#telepítés-windows)
3. [Linux](#linux)
    1. [Telepítés](#telepítés-linux)
4. [Mac](#mac)
    1. [Telepítés](#telepítés-mac)
5. [Ellenőrzés](#ellenőrzés)

## Bevezetés

A Node.js egy nyílt forráskódú, platformfüggetlen JavaScript futtatókörnyezet, amely lehetővé teszi a fejlesztők számára, hogy a szerveroldali és hálózati alkalmazásokat JavaScript-ben írhassák. A NodeJS 20-as verziója számos újítást és fejlesztést tartalmaz, amelyek javítják a teljesítményt, a biztonságot és a fejlesztői élményt.

## Windows

### Telepítés (Windows)

1. Látogasson el a Node.js hivatalos weboldalára: [nodejs.org](https://nodejs.org)
2. A főoldalon válassza a "Recommended For Most Users" opciót, ami automatikusan a legújabb stabil NodeJS verziót fogja kiválasztani, vagy keresse meg a "Downloads" szekcióban a NodeJS 20-at.
3. Töltse le a Windows Installer (.msi) fájlt, 32 vagy 64 bites verzióban, aszerint, hogy melyik illeszkedik a rendszeréhez.
4. Futtassa a letöltött telepítőt, és kövesse a telepítő utasításait. Az alapértelmezett beállítások többnyire megfelelőek, de ellenőrizze, hogy a "Add to PATH" opció be legyen jelölve, hogy a Node.js elérhető legyen a parancssorból.
5. A telepítés befejezése után újraindíthatja a számítógépet, bár ez általában nem szükséges.

## Linux

### Telepítés (Linux)

A Node.js telepítése Linuxon általában a rendszer csomagkezelőjén keresztül történik. Az alábbiakban a Debian és Ubuntu alapú disztribúciókhoz való telepítési lépéseket ismertetjük:

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

Ez a parancssor letölti és futtatja a NodeSource Node.js 20.x telepítő scriptjét, majd telepíti a Node.js-t.

## Mac

### Telepítés (Mac)

A Node.js telepítése Mac-re hasonló a Windows folyamatához:

1. Nyissa meg a [nodejs.org](https://nodejs.org) weboldalt a böngészőjében.
2. Töltse le a Mac-hez szánt legújabb stabil NodeJS verziót a "Downloads" szekcióból, vagy közvetlenül a főoldalról.
3. Nyissa meg a letöltött `.pkg` telepítő fájlt, ami elindítja a Node.js telepítőt.
4. Kövesse a telepítő lépéseit. A telepítő magában foglalja a Node.js-t és a npm-et (a Node.js csomagkezelőjét) is. Győződjön meg róla, hogy a telepítő beállítja a megfelelő útvonalakat.
5. A telepítés végén ellenő

rizheti a telepítést a "Terminal" alkalmazásban.

## Ellenőrzés

A telepítés ellenőrzéséhez nyissa meg a parancssort vagy terminált, és írja be a következő parancsokat:

```bash
node --version
npm --version
```

Ezek a parancsok kiírják a telepített Node.js és npm (Node Package Manager) verzióit. Ha mindkettő sikeresen kiírja a verziószámot, akkor a Node.js és npm helyesen van telepítve a gépén.

Ezeken a lépéseken keresztül sikeresen telepítette a Node.js 20-as verzióját a kívánt operációs rendszerre. Most már készen áll a Node.js használatára a fejlesztési projektekben, a szerveroldali scriptek írásától kezdve a teljes webalkalmazások fejlesztéséig.

Ha bármilyen problémába ütközik a telepítés során, javasoljuk, hogy keresse fel a Node.js [hivatalos dokumentációját](https://nodejs.org/en/docs/), ahol részletes útmutatásokat és a gyakori problémák megoldásait találja. Ezenkívül a Node.js közösség számos fórumon és csoporton keresztül nyújt támogatást, ahol segítséget kérhet és megoszthatja tapasztalatait más fejlesztőkkel.