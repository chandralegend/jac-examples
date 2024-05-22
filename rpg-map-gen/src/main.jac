'''Game Loop'''

import:jac from utils, get_map_view;
import:jac from game, Game;

with entry:__main__{
    game = Game();
    for _ in range(8) {
        game.get_next_level();
        print(game.prev_levels[-1]);
        print(get_map_view(game.prev_level_maps[-1]));
    }
}