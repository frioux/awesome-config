local searchers  = package.searchers
local filesearcher = searchers[2]

local function localsearcher(filename)
  local regularfile = filesearcher(filename)
  if type(regularfile) == 'string' then
    return ''
  end

  local localfile = filesearcher('local.' .. filename)

  if type(localfile) == 'string' then
    return regularfile
  else
    return function(...)
      local retval = regularfile(...)
      localfile(...)
      return retval
    end
  end
end

table.insert(searchers, 2, localsearcher)
