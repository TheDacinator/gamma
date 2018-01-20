_G.gcmd = {} --Used to store global functions and variables
_G.gamma = {} --Used to store account info
gcmd.usecoins = false --Toggles whether coin conversions are allowed
gcmd.gcoins = {[0]=30,[1]=40,[64]=30,[65]=30,[66]=40,[67]=40,[68]=40,[69]=60,[70]=80,[71]=100,[72]=150,[96]=40,[97]=40,[98]=40,[99]=30,[100]=45,[101]=100,[102]=100,[103]=150} --list of all the coins with their rf values divided by 1000, used for conversions to gamma
gcmd.gsave = function()
  bagelBot.setPersistence("gamma",_G.gamma)
end
gcmd.gadd = function(name)
  if not gamma[name] then
    gamma[name] = gamma.default
    gamma.lastLogins[name] = 0 --Makes sure people who login for the first time get to use !g login
  end
end
if bagelBot.getPersistence("gamma") then
  gamma = bagelBot.getPersistence("gamma")
else
  gamma = {["default"]=100,["lastLogins"]={}}
end
local _, plrs = commands.testfor("@a")
for i = 1,#plrs do
  gcmd.gadd(string.sub(plrs[i],7))
end
if not gamma.shops then
  gamma.shops = {}
end
gcmd.gsave()
gcmd.patch = function(o)
  local name,command = o()
  table.insert(command,1,"placeholder")
  return gcmd.usecoins,gcmd.gcoins,gcmd.gsave,gcmd.gadd,name,command
end
--Use to make porting commands easier
--local usecoins,gcoins,gsave,gadd,name,command = gcmd.patch(bagelBot.out)
