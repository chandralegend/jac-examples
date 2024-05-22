'''Game Logic'''

import:py pygame;
import:jac utils.level, Level, create_next_level;

'''Main Game Loop'''
walker Game {
    has current_level: int = 0,
        prev_levels: list[Level] = [],
}