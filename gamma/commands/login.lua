local usecoins,gcoins,gsave,gadd,name,command = gcmd.patch(bagelBot.out)
if os.epoch("utc") >= gamma.lastLogins[name] + 86400000 then
  gamma.lastLogins[name] = os.epoch("utc")
  gamma[name] = gamma[name] + 10
  tell(name,"&610g received")
  gsave()
else
  local t = (gamma.lastLogins[name] + 86400000) - os.epoch("utc")
  local h = math.floor(t/3600000)
  t = t - h*3600000
  local m = math.floor(t/60000)
  t = t - m*60000
  local s = math.floor(t/1000)
  tell(name,"&6"..tostring(h).." hours, "..tostring(m).." minutes, and "..tostring(s).." seconds remaining")
end
