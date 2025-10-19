# Basketball Shooter Simulator - Claude Code Documentation

## Project Overview

A Godot 4.4 basketball shooting simulator game with multiple levels, dialogue system, and pause functionality. The game features physics-based basketball shooting mechanics with aim visualization and progressive difficulty.

## Project Structure

### Core Configuration

- **Engine**: Godot 4.5 (Forward Plus rendering)
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
│   │   ├── Gadget/             # Gadget UI button and counter
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

3. **ScoreManager** - Game state management and gadget system

   - `_score: int` - Current player score
   - `_chance: int` - Remaining attempts (starts at 10)
   - `_available_gadgets: int` - Number of gadgets available to player
   - `_completed_special_levels: Array[int]` - Track which special levels were won
   - `_gadget_active_this_shot: bool` - Whether gadget is active for current shot
   - `increment_score()` - Add to score
   - `reduce_change()` - Remove attempt
   - `reset()` - Reset for new level
   - `mark_special_level_won(level_number)` - Award gadgets for special level completion
   - `use_gadget()` - Activate gadget for current shot
   - `reset_gadget_shot()` - Reset gadget flag after shot completes
   - `save_progress()` / `load_progress()` - Persist gadget data and special level completion

4. **DialogueManager** - Handles cutscene dialogue system

### Core Game Components

#### Basketball (`Scenes/Basketball/Basketball.gd`)

- **Class**: `Basketball` (extends `RigidBody2D`)
- **States**: Ready, Drag, Release
- **Physics**: Impulse-based launching with visual aim indicator
- **Input**: Mouse drag to aim and release to shoot
- **Trajectory Preview**: Shows predicted ball path when gadget is active
  - 12 arrow sprites showing trajectory points
  - Only visible when `_gadget_active` is true
  - Activated dynamically when dragging starts
- **Constants**:
  - `MIN_CLAMP: Vector2(-20, 0)` - Minimum drag distance
  - `MAX_CLAMP: Vector2(0, 20)` - Maximum drag distance
  - `IMPULSE_MULTIPLIER: 25` - Shot power multiplier
  - `IMPULSE_MAX: 1500` - Maximum shot power
  - `TRAJECTORY_POINTS: 12` - Number of trajectory preview arrows
  - `TRAJECTORY_TIME_STEP: 0.05` - Time between trajectory points

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
- **Special Levels**: Levels 4, 8, and 12 award gadgets on victory
  - Level 4: Awards 1 gadget
  - Level 8: Awards 2 gadgets
  - Level 12: Awards 3 gadgets
  - Players can progress even on loss, but don't receive gadget rewards
  - `is_special_level: bool` - Export flag to mark special levels

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

#### Gadget System (`Scenes/UI/Gadget/`)

- **Gadget UI Component** (`Scenes/UI/Gadget/Gadget.gd`):
  - Class name: `Gadget` (extends `Control`)
  - TextureButton for activating gadget
  - Label showing available gadget count ("x#")
  - Automatically hides when no gadgets available
  - Button disables when gadget is active or count is 0
  - Refreshes display after each basketball spawn
- **Functionality**:
  - Click button to activate trajectory preview for next shot
  - Single-use per activation (consumed after shot completes)
  - Integrated into LevelBase for all levels

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

#### Creating Dialogue Resources

Dialogue resources for level cutscenes follow a standardized format. The source of truth for dialogue content is `Assets/ToDo.txt`.

**Workflow:**
1. Read dialogue content from `Assets/ToDo.txt` for the target level
2. Create folder: `Resources/Level{Name}/` (e.g., `LevelSix`, `LevelSeven`)
3. Create two `.tres` files:
   - `Level{Name}IntroDialogue.tres` - Opening cutscene dialogue
   - `Level{Name}EndDialogue.tres` - Closing cutscene dialogue

**File Structure Template:**
```gdscript
[gd_resource type="Resource" script_class="DialogueResource" load_steps=3 format=3 uid="uid://[unique_id]"]

[ext_resource type="Script" uid="uid://1jg5kmdowv5h" path="res://Resources/DialogueResource.gd" id="1_intro01"]
[ext_resource type="Texture2D" uid="uid://c7hueeu5cboy5" path="res://Assets/Bust Shot/Main Character_Bust Shot_1_Normal.png" id="2_intro02"]

[resource]
script = ExtResource("1_intro01")
dialogue_sequence = Array[Dictionary]([{
"character": "科迪",
"line": "dialogue text here",
"texture": ExtResource("2_intro02")
}, {
"character": "军方",
"line": "dialogue text here",
"texture": null
}])
metadata/_custom_type_script = "uid://1jg5kmdowv5h"
```

**Key Points:**
- Each dialogue entry has three fields: `character`, `line`, `texture`
- Main character (科迪) uses texture reference: `ExtResource("2_intro02")`
- Other characters (军方, 外星人, etc.) use `texture: null`
- UIDs should be unique for each file (generate random alphanumeric strings)
- Follow exact dialogue text from `Assets/ToDo.txt` without modifications
- Preserve Chinese characters and punctuation exactly as specified

**Example Levels Created:**
- Level 6 (Australia): Kangaroo protection scene
- Level 7 (Brazil): Soccer ball confusion scene
- Level 8 (Iceland): Female alien makeup scene
- Level 9 (Aircraft Carrier): Interception scene

### Architecture Patterns

- **Singleton Pattern**: Global managers via autoloads
- **Signal-Event Pattern**: Decoupled communication via `SignalManager`
- **Template Method**: `LevelBase` provides structure for all levels
- **State Machine**: Basketball uses enum-based state management

## Recent Changes

- **Dialogue Resources for Levels 6-9** (PR #95)
  - Created dialogue resources for Level 6 (Australia/Kangaroo scene)
  - Created dialogue resources for Level 7 (Brazil/Soccer ball scene)
  - Created dialogue resources for Level 8 (Iceland/Makeup scene)
  - Created dialogue resources for Level 9 (Aircraft Carrier)
  - All dialogue content sourced from `Assets/ToDo.txt`
- **Gadget System Implementation**
  - Added special level system (levels 4, 8, 12)
  - Implemented gadget reward system with progressive awards
  - Created trajectory preview feature for basketball shots
  - Built Gadget UI component with button and counter
  - Integrated save/load system for gadget persistence
  - Dynamic gadget activation on drag start for immediate feedback
- Added level selection system
- Implemented reusable UI components (LevelButton, BackButton, Gadget)
- Enhanced transition system with improved fade animations
- Updated main menu with level select option
- Added pause functionality (PR #66)
- Implemented pause button and menu system
- Added game-over scene functionality

## Git Workflow

- **Main Branch**: `main`
- **Current Status**: Clean working directory
- **Recent**: Pause system implementation completed

### Commit Message Conventions

- **Format**: Use conventional commit format: `type(scope): description`
- **Types**: `feat`, `fix`, `chore`, `docs`, `style`, `refactor`, `test`
- **Examples**:
  - `feat(ui): add level selection menu`
  - `fix(basketball): resolve physics collision bug`
  - `chore(assets): update audio file formats`

### Pull Request Requirements

- **PR Description**: Must include `Resolves #[issue-number]`
- **Issue Tracking**: Issue number should be in branch name, if not present, confirm which issue the PR resolves
- **Title**: Use conventional commit format for PR titles
