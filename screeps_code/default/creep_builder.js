
var creep_functions = require('creep_functions');

module.exports =
{
    run: function (creep)
    {
        if (!creep_functions.build(creep))
        {
            if (!creep_functions.upgrade(creep))
            {
                creep_functions.harvest_energy(creep);
            }
        }
    }
}