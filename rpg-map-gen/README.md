# RPG Map Generator

This is a text-based RPG game with an UpView perspective. The objective of the game is to navigate through a map filled with enemies and walls, and defeat all the enemies to complete each level. The game automatically generates a new map after each level based on the time and number of tries it took to complete the previous level.

## Features

- UpView perspective: The game is played from a top-down perspective, allowing the player to see the entire map.
- Enemies: The map is populated with enemies that the player must defeat to progress.
- Walls: The map also contains walls that act as obstacles for the player and enemies.
- Level completion: After defeating all the enemies, the level is considered complete.
- Map generation: Each completed level triggers the automatic generation of a new map based on the player's performance.

## Getting Started

To get started with the RPG Map Generator, follow these steps:

1. Clone the repository: `git clone https://github.com/chandralegend/jac-examples.git`
2. Install the required dependencies: `cd rpg-map-gen && pip install -r requirements.txt`
3. Export the `ANTHROPIC_API_KEY` environment variable with your Anthropic API key: `export ANTHROPIC_API_KEY=your-api-key`
4. Run the game: `jac run main.jac`

## Controls

- Use the arrow keys to move the player character.
- Press the spacebar to attack enemies.

## Contributing

Contributions are welcome! If you'd like to contribute to the RPG Map Generator project.