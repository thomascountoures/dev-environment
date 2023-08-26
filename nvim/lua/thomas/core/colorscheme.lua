-- Load colorscheme using protected call
function load_colorscheme(color_scheme) 
  local status, _ = pcall(vim.cmd, string.format("colorscheme %s", color_scheme))
  if not status then
    print(color_scheme .. " " .. "not installed!")
    return
  end
end


-- Add colorschemes to the color_schemes array
-- For the Kanagawa theme, there are 3 themes: kanagawa-{lotus/dragon/wave}
color_schemes = {"kanagawa-lotus", "kanagawa-dragon", "kanagawa-wave"}

-- Load chosen colorscheme here (just substitute the index)
load_colorscheme(color_schemes[3])