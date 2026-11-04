-- Pages that set `image-corrections: true` offer the bounded correction
-- exchange of CTM AI feedback on their image activities: after direct API
-- feedback on an uploaded photo, the student can point out one misreading and
-- get one corrected reply (ctm-libs `corrections="true"`). The page reuses the
-- same includes as its ordinary version, so problems and checkers stay in one
-- place. Runs before example-source.lua, so the source panels show the
-- attribute an author would write.
local enabled = false
local function meta(m) enabled = m['image-corrections'] == true end
local function div(el)
  if not enabled or not el.classes:includes('ai-feedback') then return end
  if el.attributes['image-upload'] ~= 'true' or el.attributes['corrections'] ~= nil then return end
  el.attributes['corrections'] = 'true'
  return el
end
return {{Meta = meta}, {Div = div}}
