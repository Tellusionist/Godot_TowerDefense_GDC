# Tower Defense Learning Project 🎯  
![Godot](https://img.shields.io/badge/Godot-4.5-blue?logo=godot-engine&logoColor=white)   ![Status](https://img.shields.io/badge/Status-WIP-yellow)  

This is a **Godot tower defense learning project** that follows [this YouTube tutorial series](https://www.youtube.com/watch?v=wFdpCGbrVXI&list=PLZ-54sd-DMAJltIzTtZ6ZhC-9hkqYXyp6) by *Game Development Center*.  
The goal of this project is to learn the fundamentals of **Godot 4.5**, game architecture, and tower defense mechanics — while building something playable and fun.  

---

## 🚀 Project Status  
✅ Project setup complete  
✅ Folder structure organized  
✅ First two maps created (`Map1.tscn`, `Map2.tscn`)  
🔄 Currently working on: basic gameplay loop (spawning enemies, placing towers)  
📅 Next steps: implement UI, add enemy waves, and balance gameplay  

---

## 🗂 Project Structure  

```text
project.godot             # Main Godot project file
SceneHandler.tscn         # Handles scene transitions

Assets/                   # Game art, tiles, icons, towers, enemies
├── Enemies/
├── Environments/
│   ├── Props/            # Trees, crates, and other props
│   └── Tilesets/         # Map terrain tiles
├── Icons/
├── Towers/
└── UI/

Licenses/                 # License information for any assets

Resources/                # Fonts, themes, tilesets
├── Fonts/
├── Themes/
└── Tilesets/

Scenes/                   # Main scenes, maps, UI, and support scenes
├── MainScenes/
├── Maps/
├── SupportScenes/
└── UIScenes/

Singletons/               # Autoload scripts (global data, managers)
