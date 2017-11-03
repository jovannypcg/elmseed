# Randomizer

Simple frontend application that demonstrates how TEA works.
Its functionality includes generation of random strings, showing gifs using a
public API and random jokes from the Chuck Norris database.

![Mockup](https://s26.postimg.org/srld23h95/randomizer.png)

### Install:
Clone this repo:
```
git clone https://github.com/jovannypcg/randomizer.git
cd randomizer
```

Install all dependencies using the handy `reinstall` script:
```
npm run reinstall
```
*This does a clean (re)install of all npm and elm packages, plus a global elm install.*


### Serve locally:
```
npm start
```
* Access app at `http://localhost:8080/`
* Get coding! The entry point file is `src/elm/Main.elm`
* Browser will refresh automatically on any file changes..


### Build & bundle for prod:
```
npm run build
```

* Files are saved into the `/dist` folder
* To check it, open `dist/index.html`
