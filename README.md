# Tower Defense Learning Project 🎯

![Godot](https://img.shields.io/badge/Godot-4.5-blue?logo=godot-engine&logoColor=white) ![Status](https://img.shields.io/badge/Status-WIP-yellow)

This is a **Godot tower defense learning project** that follows [this YouTube tutorial series](https://www.youtube.com/watch?v=wFdpCGbrVXI&list=PLZ-54sd-DMAJltIzTtZ6ZhC-9hkqYXyp6) by _Game Development Center_.  
The goal of this project is to learn the fundamentals of **Godot 4.5**, game architecture, and tower defense mechanics — while building something playable and fun.

---

## 🚀 Project Status

✅ Project setup complete  
✅ Folder structure organized  
✅ First two maps created (`Map1.tscn`, `Map2.tscn`)  
✅ Created simple UI to initiate and quit game  
✅ Added basic towers (`gun_t1.gd`, `gun_t2.gd1` & `missle_t1.gd`)  
✅ Added basic ability to place towers  
✅ Added spawning, targetting, and killing enemies with currency gains
🔄 Currently working on: purchase tower mechanics, save/load mechanics
📅 Next steps: add enemy waves, Settings UI, multiple maps, balance gameplay

---

## 🗂 Project Structure

```text
project.godot             # Main Godot project file
SceneHandler.tscn         # Handles scene transitions

Assets/                   # Game art, tiles, icons, towers, enemies
├── Effects/
├── Enemies/
├── Environments/
│   ├── Props/            # Trees, crates, and other props
│   └── Tilesets/         # Map terrain tiles
├── Fonts/
├── Icons/
├── Towers/
└── UI/

Licenses/                 # License & Attributions for any assets

Resources/                # Configured or customized resources
├── Fonts/                # Post-processed fonts
├── Themes/
└── Tilesets/

Scenes/
├── Effects/              # Special effect animations
├── MainScenes/           # Handlers and UI
├── Maps/                 # Pre-generated game maps
├── SupportScenes/        # technically effects, but meh
├── Towers/               # Towers
└── UIScenes/             # Menus

Singletons/               # Global vars, save/load
```
