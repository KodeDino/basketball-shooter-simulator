# Basketball Shooter Simulator - Claude Code Documentation

## Project Overview
A Godot 4.4 basketball shooting simulator game with multiple levels, dialogue system, and pause functionality. The game features physics-based basketball shooting mechanics with aim visualization and progressive difficulty.

## Project Structure

### Core Configuration
- **Engine**: Godot 4.4 (Forward Plus rendering)
- **Resolution**: 288x162 (scaled to 1152x648)
- **Main Scene**: `res://Scenes/UI/MainMenu/MainMenu.tscn` (game always starts at main menu)
- **Project Name**: `basketball_shooter_simulator`

### Directory Layout
```
/
├── Autoloads/                    # Global singletons
├── Scenes/
│   ├── Basketball/              # Basketball physics object
│   ├── Hoop/                   # Scoring mechanism
│   ├── Levels/
│   │   ├── LevelBase/          # Base level template
│   │   ├── LevelOne/           # First level
│   │   ├── LevelTwo/           # Second level
│   │   └── LevelThree/         # Third level
│   ├── UI/
│   │   ├── BackButton/         # Reusable back navigation button
│   │   ├── Dialog/             # Dialogue system UI
│   │   ├── GameOver/           # Game over screen
│   │   ├── Hud/                # In-game HUD
│   │   ├── LevelButton/        # Reusable level selection button
│   │   ├── LevelSelect/        # Level selection screen
│   │   ├── MainMenu/           # Main menu screen (ENTRY POINT)
│   │   ├── Pause/              # Pause menu system
│   │   └── Transition/         # Scene transition effects
│   └── CutScenes/              # Level intro/outro cutscenes
├── Resources/                   # Dialogue resources (.tres files)
├── Assets/                     # Game assets and settings
└── .godot/                     # Godot editor cache
```

## Key Systems

### Autoloads (Global Singletons)
1. **SignalManager** - Centralized signal management
   - `on_basketball_score` - Basketball scores
   - `on_basketball_removed` - Basketball leaves screen
   - `on_dialogue_updated` - Dialogue system updates
   - `on_dialogue_finished` - Dialogue sequence complete
   - `on_main_menu_button_clicked` - Menu navigation

2. **SceneManager** - Scene transitions and loading
   - `load_next_scene()` - Handles scene transitions with fade effects
   - `load_main_menu()` - Return to main menu
   - `load_level_one_intro()` - Start game sequence

3. **ScoreManager** - Game state management
   - `_score: int` - Current player score
   - `_chance: int` - Remaining attempts (starts at 10)
   - `increment_score()` - Add to score
   - `reduce_change()` - Remove attempt
   - `reset()` - Reset for new level

4. **DialogueManager** - Handles cutscene dialogue system

### Core Game Components

#### Basketball (`Scenes/Basketball/Basketball.gd`)
- **Class**: `Basketball` (extends `RigidBody2D`)
- **States**: Ready, Drag, Release
- **Physics**: Impulse-based launching with visual aim indicator
- **Input**: Mouse drag to aim and release to shoot
- **Constants**:
  - `MIN_CLAMP: Vector2(-20, 0)` - Minimum drag distance
  - `MAX_CLAMP: Vector2(0, 20)` - Maximum drag distance
  - `IMPULSE_MULTIPLIER: 25` - Shot power multiplier
  - `IMPULSE_MAX: 1500` - Maximum shot power

#### Hoop (`Scenes/Hoop/Hoop.gd`)
- **Scoring Logic**: Two-stage validation system
  - Ball must enter top trigger area first
  - Then enter score area to register point
- **Net Physics**: Applies drag to slow down balls
- **Animation**: Plays "hoop" animation on net contact

#### Level System (`Scenes/Levels/LevelBase/LevelBase.gd`)
- **Template**: Base class for all levels
- **Victory Condition**: Player score > enemy score
- **Failure Condition**: Run out of chances (0 remaining)
- **Progression**: Automatic transition to next level on victory
- **Basketball Spawning**: Automatic respawn after ball exits screen

#### Level Selection System (`Scenes/UI/LevelSelect/`)
- **LevelSelect Scene**: Grid-based level selection with 10 level buttons (2 rows of 5)
- **LevelButton Component** (`Scenes/UI/LevelButton/LevelButton.gd`):
  - Reusable button with configurable `target_scene` and `level` text
  - Automatically sets level number display
- **BackButton Component** (`Scenes/UI/BackButton/BackButton.gd`):
  - Reusable navigation button with configurable `back_to_scene`
- **Visual Features**: 
  - Animated title with flashing effect
  - Scoreboard background texture
  - 10 level buttons (levels 1-3 have target scenes, 4-10 are placeholders)

#### Transition System (`Scenes/UI/Transition/`)
- **Enhanced Animations**: 
  - `fade_to_black` - Fades screen to black (0.3s)
  - `fade_to_normal` - Fades from black to normal (0.3s)
- **Improved Flow**: Two-stage transition with scene switch in between fades

### Game Flow
1. **Start**: MainMenu scene loads first
2. **Navigation Options**:
   - **Play Button**: Main menu → Level One Intro → Level One
   - **Level Select Button**: Main menu → Level Select → Choose any level
3. **Level Selection**: 10-level grid with direct access to available levels
4. **Progression**: Complete levels sequentially with cutscenes between
5. **Reset**: Return to main menu via pause menu, game over, or back button

## Input Controls
- **Primary Action**: `drag` (Mouse Button 1)
  - Press and hold to start aiming
  - Drag to adjust aim and power
  - Release to shoot

## Audio Assets
- `basketball-bounce.wav` - Ball bounce sound effects
- `basketball_bounce.mp3` - Alternative bounce sound
- `basketball_score.wav` - Scoring sound effect

## Development Notes

### Testing Commands
- No specific test runner detected - use Godot editor's built-in debugging
- Scene testing via F6 (run specific scene)
- Project testing via F5 (run main scene - starts at MainMenu)

### Common Tasks
- **Add New Level**: Extend `LevelBase` and set `next_level_scene` property
- **Modify Physics**: Adjust constants in `Basketball.gd`
- **Add Dialogue**: Create new `DialogueResource` in `/Resources/`
- **UI Changes**: Modify scenes in `/Scenes/UI/`

### Architecture Patterns
- **Singleton Pattern**: Global managers via autoloads
- **Signal-Event Pattern**: Decoupled communication via `SignalManager`
- **Template Method**: `LevelBase` provides structure for all levels
- **State Machine**: Basketball uses enum-based state management

## Recent Changes
- Added level selection system (current branch)
- Implemented reusable UI components (LevelButton, BackButton)
- Enhanced transition system with improved fade animations
- Updated main menu with level select option
- Added pause functionality (PR #66)
- Implemented pause button and menu system
- Added game-over scene functionality

## Git Workflow
- **Main Branch**: `main`
- **Current Status**: Clean working directory
- **Recent**: Pause system implementation completed