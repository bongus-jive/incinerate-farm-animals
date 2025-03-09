require "/scripts/actions/monsters/farmable.lua"

function dropMonsterHarvest()
  monster.setDropPool(nil)

  status.addEphemeralEffect("burning", math.huge)
  status.addEphemeralEffect("melting", math.huge)

  local pos = entity.position()
  local id = entity.id()
  local params = {power = 0}

  for i = 1, 10 do
    local angle = math.pi * 2 * math.random()
    local vec = {math.cos(angle), math.sin(angle)}
    world.spawnProjectile("molotovflame", pos, id, vec, false, params)
  end

  local timer = 0
  local req = {
    damageType = "IgnoresDef",
    damageSourceKind = "fire",
    damage = status.resourceMax("health") / 25,
    sourceEntityId = id,
  }

  while status.resource("health") > 0 do
    timer = timer - script.updateDt()
    if timer <= 0 then
      timer = 0.08
      status.applySelfDamageRequest(req)
    end

    coroutine.yield()
  end

  return true
end
