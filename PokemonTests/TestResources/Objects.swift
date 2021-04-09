//
//  Objects.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import Foundation
@testable import Pokemon

let pokemonList = [
   PokemonList(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
   PokemonList(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
   PokemonList(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
   PokemonList(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
   PokemonList(name: "charmeleon", url: "https://pokeapi.co/api/v2/pokemon/5/"),
   PokemonList(name: "charizard", url: "https://pokeapi.co/api/v2/pokemon/6/"),
   PokemonList(name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon/7/"),
   PokemonList(name: "wartortle", url: "https://pokeapi.co/api/v2/pokemon/8/"),
   PokemonList(name: "blastoise", url: "https://pokeapi.co/api/v2/pokemon/9/"),
   PokemonList(name: "caterpie", url: "https://pokeapi.co/api/v2/pokemon/10/"),
   PokemonList(name: "metapod", url: "https://pokeapi.co/api/v2/pokemon/11/"),
   PokemonList(name: "butterfree", url: "https://pokeapi.co/api/v2/pokemon/12/"),
   PokemonList(name: "weedle", url: "https://pokeapi.co/api/v2/pokemon/13/"),
   PokemonList(name: "kakuna", url: "https://pokeapi.co/api/v2/pokemon/14/"),
   PokemonList(name: "beedrill", url: "https://pokeapi.co/api/v2/pokemon/15/"),
   PokemonList(name: "pidgey", url: "https://pokeapi.co/api/v2/pokemon/16/"),
   PokemonList(name: "pidgeotto", url: "https://pokeapi.co/api/v2/pokemon/17/"),
   PokemonList(name: "pidgeot", url: "https://pokeapi.co/api/v2/pokemon/18/"),
   PokemonList(name: "rattata", url: "https://pokeapi.co/api/v2/pokemon/19/"),
   PokemonList(name: "raticate", url: "https://pokeapi.co/api/v2/pokemon/20/")
]

let pokemonDetail = PokemonDetail(name: "ivysaur", id: 2, images: ["https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/2.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png"], stats: [Pokemon.PokemonDetail.Stat(name: "hp", base: 60), Pokemon.PokemonDetail.Stat(name: "attack", base: 62), Pokemon.PokemonDetail.Stat(name: "defense", base: 63), Pokemon.PokemonDetail.Stat(name: "special-attack", base: 80), Pokemon.PokemonDetail.Stat(name: "special-defense", base: 80), Pokemon.PokemonDetail.Stat(name: "speed", base: 60)])

let pokemonDetailStoreDto = PokemonDetailStoreDto(name: "ivysaur", id: 2, images: ["https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/2.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png"], stats: [PokemonDetailStoreDto.StatStoreDto(name: "attack", base: 64)])
