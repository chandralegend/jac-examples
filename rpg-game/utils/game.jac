'''Level Generation Module'''

import:py from jaclang.core.llms, Anthropic;

glob llm = Anthropic();

obj 'Position (0-Indexed)'
Position {
    has x: 'X Coordinate': int,
        y: 'Y Coordinate': int;
}

obj 'Wall'
Wall {
    has start_pos: 'Start Position of the Wall': Position,
        end_pos: 'End Position of the Wall': Position;
}

obj 'Map of the Level (Edges of the Map are Walls)'
Map {
    has width: 'Width of the Map': int,
        height: 'Height of the Map': int;
    has walls: 'Walls in the Map Other than Edges': list[Wall],
        small_obstacles: 'Obstacles in the Map': list[Position];
    has enemies: 'Enemies in the Map': list[Position];
    has player_pos: 'Player Position in the Map': Position;
}


can get_str_map(map: Map) -> str {
    map_tiles = [['.' for _ in range(map.width)] for _ in range(map.height)];
    for wall in map.walls {
        for x in range(wall.start_pos.x, wall.end_pos.x + 1) {
            for y in range(wall.start_pos.y, wall.end_pos.y + 1) {
                map_tiles[y][x] = 'B';
            }
        }
    }
    for obs in map.small_obstacles {
        map_tiles[obs.y][obs.x] = 'B';
    }  
    for enemy in map.enemies {
        map_tiles[enemy.y][enemy.x] = 'E';
    }
    map_tiles[map.player_pos.y][map.player_pos.x] = 'P';
    map_tiles = [['B'] + row + ['B'] for row in map_tiles];
    map_tiles = [['B' for _ in range(map.width + 2)]] + map_tiles + [['B' for _ in range(map.width + 2)]];
    return [''.join(row) for row in map_tiles];
}

obj 'Game Level'
Level {
    has name: 'Name of the Level': str,
        difficulty: 'Difficulty of the Level': int,
        num_wall: 'Number of Walls in the Map': int,
        num_enemies: 'Number of Enemies in the Map': int;
    has time_countdown: 'Time Countdown of the Level': int,
        n_retries_allowed: 'Number of Retries Allowed': int;
    has map: 'Map of the Level': Map;
}

obj 'Game'
Game {
    has current_level: int = 1,
        current_difficulty: int = 1,
        prev_levels: list[Level] = [];

    can 'Create the Next Level'
    create_next_level(
        last_levels: 'Last Played': Level,
        difficulty: 'Difficulty of the New Level': int
    ) -> 'Next Level' : Level by llm(temperature = 1.0, incl_info=(
        "Make Sure the New Level is Different from the Previous Levels."
        "Change the Position of Player and Enemies differently in each Level."
        "Player Should have a clear path to enemies."
        "Player nor Enemies should be placed in the Walls."
        "Increase of Decrease the Number of Wall, Enemies, Width, Height of the Map according to the Difficulty."
    ));

    can next_level() -> None {
        if self.current_level/2 == 0 {
            self.current_difficulty += 1;
        }
        if len(self.prev_levels) == 3 {
            self.prev_levels.pop(0);
        }
        new_level = self.create_next_level(self.prev_levels, self.current_difficulty);
        print(new_level);
        self.prev_levels.append(new_level);
        self.current_level += 1;
        print("\n".join(get_str_map(new_level.map)));
    }
}

with entry:__main__{
    game = Game();
    game.next_level();
    game.next_level();
    game.next_level();
    game.next_level();
}