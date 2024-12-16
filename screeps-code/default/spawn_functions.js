
const NUMBER_HARVESTER = 2;
const CREEP_300_HARVESTER = [WORK, WORK, CARRY, MOVE];

const NUMBER_UPGRADER = 1;
const CREEP_300_upgrader = [WORK, CARRY, CARRY, CARRY, MOVE];

const NUMBER_BUILDER = 2;
const CREEP_300_builder = [WORK, WORK, CARRY, MOVE];






const CREEPS_ROLES = ['harvester', 'upgrader', 'builder'];

const CREEPS_LIMITS =
{
    'harvester': 2,
    'upgrader': 1,
    'builder': 2
}

const CREEPS_BODY_300 =
{
    'harvester': [WORK, WORK, CARRY, MOVE],
    'upgrader': [WORK, CARRY, CARRY, CARRY, MOVE],
    'builder': [WORK, WORK, CARRY, MOVE]
}







var creep_parameters = require('creep_parameters');

var creep_harvester = require('creep_harvester');
var creep_upgrader = require('creep_upgrader');
var creep_builder = require('creep_builder');

module.exports =
{
    clear_creeps_names: function ()
    {
        for (var name in Memory.creeps)
        {
            if (!Game.creeps[name])
            {
                delete Memory.creeps[name];
            }
        }
    },

    show_spawning_creep_name: function ()
    {
        if (Game.spawns['Spawn1'].spawning)
        {
            var spawning_creep = Game.creeps[Game.spawns['Spawn1'].spawning.name];
            Game.spawns['Spawn1'].room.visual.text(spawning_creep.memory.role, Game.spawns['Spawn1'].pos.x + 1, Game.spawns['Spawn1'].pos.y, { align: 'left', opacity: 0.8 });
        }
    },

    spawn_creep: function ()
    {
        this.clear_creeps_names();

        for (var creep_role in CREEPS_ROLES)
        {
            var creeps = _.filter(Game.creeps, (creep) => creep.memory.role == CREEPS_ROLES[creep_role]);

            if (creeps.length < CREEPS_LIMITS[CREEPS_ROLES[creep_role]])
            {
                var new_creep_name = CREEPS_ROLES[creep_role] + Game.time;

                Game.spawns['Spawn1'].spawnCreep(CREEPS_BODY_300[CREEPS_ROLES[creep_role]], new_creep_name, { memory: { role: CREEPS_ROLES[creep_role] } });
            }
        }
    },

    move_creeps: function ()
    {
        for (var name in Game.creeps)
        {
            var creep = Game.creeps[name];

            if (creep.memory.role == 'harvester')
            {
                creep_harvester.run(creep);
            }
            if (creep.memory.role == 'upgrader')
            {
                creep_upgrader.run(creep);
            }
            if (creep.memory.role == 'builder')
            {
                creep_builder.run(creep);
            }
        }
    }
}