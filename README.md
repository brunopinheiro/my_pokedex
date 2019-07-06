[![Build Status](https://travis-ci.com/brunopinheiro/my_pokedex.svg?branch=master)](https://travis-ci.com/brunopinheiro/my_pokedex)

# My Pokédex
Pokédex mobile app built using Flutter

> I'm getting the data from [PokéApi](https://pokeapi.co)

## Why I built this project?
I was curious about Flutter, so I decided to create an "advanced Hello World" app. By "advanced Hello World", I mean a project that include some of the things I believe being basic for a mobile app:
  - Automated tests
  - Http requests
  - Linter
  - Continuous Integration

## Considerations
My ideas was to have an experience with Flutter, so I didn't included much on it, just an ordered list of the first generation pokemons. Also, didn't follow any architecture.

## Possible improvements
My last commits were just to fix small details after running the app (I was developing without testing it on a device or simulator, only by tests). Any of my unit tests were able to capture those fixes, making it clear integration tests simulating a user flow would be a good idea.

## Getting Started
### running tests
```sh
$ flutter analyze
$ flutter test
```

### running app on emulator
```sh
$ flutter emulators
$ flutter emulators --launch <emulator_id>
$ flutter run
```
