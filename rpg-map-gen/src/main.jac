'''Game Loop'''

import:jac from utils, get_map;
import:jac from levels, LevelManager;

import:py pygame;

glob WINDOW_SIZE = (800, 600);

obj Game {
    has level_manager: LevelManager = LevelManager();
    has screen: pygame.surface.Surface = pygame.display.set_mode(WINDOW_SIZE);

    can render_map;
    # can intro_screen;
    # can game_over_screen;
    # can game_won_screen;
    # can new_game;
}

:obj:Game:can:render_map {
    map  = get_map(self.level_manager.prev_level_maps[-1]);
    for (i, map_row) in enumerate(map) {
        for (j, map_col) in enumerate(map_row) {
            if map_col == "B" {Block(self, (i, j));}
            elif map_col == "E" {Enemy(self, (i, j));}
            elif map_col == "P" {Player(self, (i, j));} 
            else {Ground(self, (i, j));}
        }
    }
}

with entry:__main__{
    level_manager = LevelManager();
    for _ in range(8) {
        level_manager.get_next_level();
        print(level_manager.prev_levels[-1]);
        print('\n'.join(get_map(level_manager.prev_level_maps[-1])));
    }
}