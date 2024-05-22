'''Getting the Map View'''
can get_map_view(map: Map) -> str {
    map_tiles = [['.' for _ in range(map.level.width)] for _ in range(map.level.height)];
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
    map_tiles = [['B' for _ in range(map.level.width + 2)]] + map_tiles + [['B' for _ in range(map.level.width + 2)]];
    return '\n'.join([''.join(row) for row in map_tiles]);
}