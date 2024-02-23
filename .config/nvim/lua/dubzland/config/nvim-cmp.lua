local utils = require("dubzland.utils")

local nvim_cmp_config = {}

nvim_cmp_config.init = function(opts)
    opts = opts or {}
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup(utils.merge({
        preselect = cmp.PreselectMode.None,
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            -- {{{ TAB completion
            -- ["<Tab>"] = cmp.mapping(function(fallback)
            --	if cmp.visible() then
            --		cmp.select_next_item()
            --	elseif luasnip.expand_or_jumpable() then
            --		luasnip.expand_or_jump()
            --	elseif utils.has_words_before() then
            --		cmp.complete()
            --	else
            --		fallback()
            --	end
            -- end, { "i", "s" }),
            -- ["<S-Tab>"] = cmp.mapping(function(fallback)
            --	if cmp.visible() then
            --		cmp.select_prev_item()
            --	elseif luasnip.jumpable(-1) then
            --		luasnip.jump(-1)
            --	else
            --		fallback()
            --	end
            -- end, { "i", "s" }),
            -- }}}
            -- {{{ NON-TAB completion
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.close(),
            ["<C-y>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end),
            -- }}}
        }),
        -- Installed sources
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer" },
            { name = "nvim_lsp_signature_help" },
        }),
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        formatting = {
            fields = { "menu", "abbr", "kind" },
            format = function(entry, item)
                local menu_icon = {
                    nvim_lsp = "λ",
                    luasnip = "⋗",
                    buffer = "Ω",
                    path = "🖫",
                }
                item.menu = menu_icon[entry.source.name]
                return item
            end,
        },
    }, opts))
end

return nvim_cmp_config

-- vim: foldmethod=marker
