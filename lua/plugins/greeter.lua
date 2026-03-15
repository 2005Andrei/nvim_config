return {
    'goolord/alpha-nvim',
    config = function()
        local startify = require('alpha.themes.startify')


        -- quotes saved on my machine - api call would be slow, even this is slow but it's alright for now
        local function quote()
            local filepath = vim.fn.expand("~/.config/quotes/quotes.json")
            local f = io.open(filepath, "r")
            if not f then return { "didn't find file" } end
            local content = f:read("*a")
            f:close()
            local ok, quotes = pcall(vim.json.decode, content)
            if not ok or type(quotes) ~= "table" or #quotes == 0 then
                return { "failed to parse quotes" }
            end
            local rand_idx = math.random(1, #quotes)
            local selected = quotes[rand_idx]
            local quote_text = selected.quote or "No quote text"
            local quote_work = selected.work or "Unknown"
            return {
                quote_text,
                "",
                "- " .. quote_work,
            }
        end

        startify.section.header.val = {
            "                            _          ",
            " _ __ ___   ___  _ __ _ __ (_)_ __   __ _ ",
            "| '_ ` _ \\ / _ \\| '__| '_ \\| | '_ \\ / _` |",
            "| | | | | | (_) | |  | | | | | | | | (_| |",
            "|_| |_| |_|\\___/|_|  |_| |_|_|_| |_|\\__, |",
            "                                    |___/ ",
        }

        startify.section.footer = {
            type = "text",
            val = quote(),
            opts = {
                position = "left",
                hl = "Comment",
            },
        }

        table.insert(startify.config.layout, { type = "padding", val = 1 })
        table.insert(startify.config.layout, startify.section.footer)

        require('alpha').setup(startify.config)
    end,
}
