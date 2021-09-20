require "/scripts/actions/monsters/farmable.lua"

function dropMonsterHarvest(...)
	script.setUpdateDelta(5)
	
	monster.setDropPool(nil)
	
	status.addEphemeralEffect("burning", math.huge)
	status.addEphemeralEffect("melting", math.huge)
	
	for i = 1, 10 do
		world.spawnProjectile(
			"molotovflame",
			entity.position(),
			entity.id(),
			vec2.rotate({1, 0}, util.toRadians(math.random(1, 360))),
			false,
			{power = 0}
		)
	end
	
	while status.resource("health") > 0 do
		status.applySelfDamageRequest({
			damageType = "IgnoresDef",
			damage = status.resourceMax("health") / 25,
			damageSourceKind = "fire",
			sourceEntityId = entity.id()
		})
		coroutine.yield()
	end
	
	return true
end
