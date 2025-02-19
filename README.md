# Love2D Shooter Game

This is a simple game built using **Love2D**, where a player-controlled character moves around the screen and interacts with moving blocks. The game includes collision detection to prevent the player from passing through blocks and ensures that moving blocks push the player instead of letting them slide through.

## Features
- **Player Movement** (Arrow keys to move around)
- **Moving Blocks** that bounce off screen edges
- **Collision Detection** to prevent the player from sliding through moving blocks
- **Basic Physics** where moving blocks push the player

## Installation
### Prerequisites
- Install [Love2D](https://love2d.org/) (version 11.x recommended)

### Steps to Run
1. Download or clone this repository:
   ```sh
   git clone https://github.com/yourusername/love2d-collision-game.git
   cd love2d-collision-game
   ```
2. Run the game using Love2D:
   ```sh
   love .
   ```

## Controls
- **Arrow Keys**: Move the player
- **Esc**: Quit the game

## File Structure
```
/project_root
│-- main.lua         # Main game loop
│-- player.lua       # Player logic and movement
│-- block.lua        # Block movement and collision detection
│-- conf.lua         # Love2D configuration (optional)
│-- README.md        # This file
```

## Future Improvements
- Add more block types with different behaviors
- Implement score tracking and objectives
- Improve physics for smoother interactions

## License
This project is open-source under the MIT License.

