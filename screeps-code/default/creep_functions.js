
module.exports =
{
    check_working: function (creep)
    {
        if (!creep.memory.working && creep.store.getFreeCapacity() == 0)
        {
            creep.memory.working = true;
        }
        if (creep.memory.working && creep.store[RESOURCE_ENERGY] == 0)
        {
            creep.memory.working = false;
        }
    },

    harvest_energy: function (creep)
    {
        if (creep.store.getFreeCapacity() > 0)
        {
            var sources = creep.room.find(FIND_SOURCES);

            creep.say('⛏')
            if (creep.harvest(sources[0]) == ERR_NOT_IN_RANGE)
            {
                creep.say('➜⛏')
                creep.moveTo(sources[0], { visualizePathStyle: { stroke: '#ff8800' } });
            }
            return true;
        }
        else
        {
            return false;
        }
    },

    store_energy: function (creep)
    {
        this.check_working(creep);

        if (creep.memory.working)
        {
            var targets = creep.room.find(FIND_STRUCTURES,
                {
                    filter: (structure) =>
                    {
                        return (
                            structure.structureType == STRUCTURE_SPAWN ||
                            structure.structureType == STRUCTURE_EXTENSION ||
                            structure.structureType == STRUCTURE_TOWER) &&
                            structure.store.getFreeCapacity(RESOURCE_ENERGY) > 0;
                    }
                });

            if (targets.length)
            {
                creep.say('📦')
                if (creep.transfer(targets[0], RESOURCE_ENERGY) == ERR_NOT_IN_RANGE)
                {
                    creep.say('➜📦')
                    creep.moveTo(targets[0], { visualizePathStyle: { stroke: '#ffffff' } });
                }
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        } 
    },

    upgrade: function (creep)
    {
        this.check_working(creep);

        if (creep.memory.working)
        {
            creep.say('🆙');
            if (creep.upgradeController(creep.room.controller) == ERR_NOT_IN_RANGE)
            {
                creep.say('➜🆙');
                creep.moveTo(creep.room.controller, { visualizePathStyle: { stroke: '#00ff00' } });
            }
            return true;
        }
        else
        {
            return false;
        }
    },

    build: function (creep)
    {
        this.check_working(creep);

        if (creep.memory.working)
        {
            var targets = creep.room.find(FIND_CONSTRUCTION_SITES);

            if (targets.length) {
                creep.say('🔨');
                if (creep.build(targets[0]) == ERR_NOT_IN_RANGE) {
                    creep.say('➜🔨');
                    creep.moveTo(targets[0], { visualizePathStyle: { stroke: '#ffff00' } });
                }
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
}