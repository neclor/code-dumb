
// Game.spawns['Spawn1'].spawnCreep([WORK, WORK, CARRY, MOVE], "Name", {memory: {role: 'harvester'}});

var spawn_functions = require('spawn_functions');

var creep_harvester = require('creep_harvester');
var creep_upgrader = require('creep_upgrader');
var creep_builder = require('creep_builder');


module.exports.loop = function ()
{
    spawn_functions.move_creeps();
    spawn_functions.spawn_creep();
    spawn_functions.show_spawning_creep_name();
}
