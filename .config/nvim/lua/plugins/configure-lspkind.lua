return {
  'onsails/lspkind-nvim',
  config = function()
    local icons = require('nvim-nonicons')
    local Function = icons.get('package') .. ' (function)'
    local Method = icons.get('package') .. ' (method)'
    local Variable = icons.get('variable') .. ' (variable)'
    local Constant = icons.get('constant') .. ' (constant)'
    local Struct = icons.get('struct') .. ' (struct)'
    local Class = icons.get('class') .. ' (class)'
    local Interface = icons.get('interface') .. ' (interface)'
    local Text = icons.get('typography') .. ' (text)'
    local Enum = icons.get('list-unordered') .. ' (enum)'
    local EnumMember = icons.get('list-unordered') .. ' (enum member)'
    local Module = '{}(module)'
    local Color = icons.get('heart') .. ' (color)' -- tmp
    local Property = icons.get('tools') .. ' (property)'
    local Field = icons.get('field') .. ' (field)'
    local Unit = icons.get('note') .. ' (unit)'
    local File = icons.get('file') .. ' (file)'
    local Value = icons.get('note') .. ' (value)'
    local Event = icons.get('zap') .. ' (event)'
    local Folder = icons.get('file-directory-outline') .. ' (folder)'
    local Keyword = icons.get('typography') .. ' (keyword)'
    local Snippet = icons.get('snippet') .. ' (snippet)'
    local Operator = icons.get('diff') .. ' (operator)'
    local Reference = icons.get('file-symlink-file') .. ' (reference)'
    local TypeParameter = icons.get('type') .. ' (type parameter)'

    require('lspkind').init({
      symbol_map = {
        Text = Text,
        Method = Method,
        Function = Function,
        Constructor = Class,
        Variable = Variable,
        Class = Class,
        Interface = Interface,
        Module = Module,
        Property = Property,
        Unit = Unit,
        Value = Value,
        Enum = Enum,
        Keyword = Keyword,
        Snippet = Snippet,
        Color = Color,
        Field = Field,
        File = File,
        Folder = Folder,
        EnumMember = EnumMember,
        Constant = Constant,
        Struct = Struct,
      },
    })
  end,
}
