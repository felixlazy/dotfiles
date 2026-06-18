return {
  {
    "obsidian-nvim/obsidian.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
          opts.servers.marksman = {
            on_attach = function(client, bufnr)
              local active_clients = vim.lsp.get_clients({ bufnr = bufnr })
              for _, other_client in ipairs(active_clients) do
                if other_client.name == "obsidian-ls" then
                  client.server_capabilities.definitionProvider = false
                  client.server_capabilities.referencesProvider = false
                  client.server_capabilities.renameProvider = false
                  client.server_capabilities.completionProvider = false
                  break
                end
              end
            end,
          }
        end,
      },
    },
    cmd = {
      "Obsidian",
    },
    keys = {
      {
        "<leader>obf",
        "<cmd>Obsidian quick_switch<CR>",
        desc = "ObsidianQuickSwitch",
      },
      {
        "<leader>obg",
        "<cmd>Obsidian search<CR>",
        desc = "ObsidianSearch",
      },
      {
        "<leader>obn",
        "<cmd>Obsidian new<CR>",
        desc = "ObsidianNew",
      },
      {
        "<leader>obc",
        "<cmd>Obsidian toggle_checkbox<CR>",
        desc = "ObsidianToggleCheckbox",
      },
      {
        "<leader>obt",
        "<cmd>Obsidian tags<CR>",
        desc = "ObsidianTags",
      },
      {
        "<leader>obw",
        "<cmd>Obsidian workspace<CR>",
        desc = "ObsidianWorkspace",
      },
      {
        "<leader>obp",
        "<cmd>Obsidian pasteimg<CR>",
        desc = "ObsidianPasteImg",
      },
      {
        "<leader>obl",
        "<cmd>Obsidian links<CR>",
        desc = "ObsidianLinks",
      },
      {
        "<leader>obb",
        "<cmd>Obsidian backlinks<CR>",
        desc = "ObsidianBacklinks",
      },
      {
        "<leader>obo",
        "<cmd>Obsidian open<CR>",
        desc = "ObsidianOpen",
      },
      {
        "<leader>obm",
        "<cmd>Obsidian template<CR>",
        desc = "ObsidianTemplate",
      },
    },

    opts = {
      legacy_commands = false,
      -- Define workspaces for Obsidian
      workspaces = {
        {
          name = "felix",
          path = "~/OneDrive/PARA/",
        },
      },

      notes_subdir = "area/notes", -- Subdirectory for notes
      new_notes_location = "area/notes", -- Location for new notes
      -- Settings for attachments
      attachments = {
        folder = "./image", -- Folder for image attachments
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](/%s)", path.name, path)
        end,
      },
      -- Settings for daily notes
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "area/dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%Y-%m-%d",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },
      ui = {
        enable = false,
      },
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "snacks.pick",
      },
      templates = {
        folder = "resource/templates",
      },
      -- Function to generate frontmatter for notes
      frontmatter = {
        func = function(note)
          -- This is equivalent to the default frontmatter function.
          local out = { id = note.id, aliases = note.aliases, tags = note.tags }

          -- `note.metadata` contains any manually added fields in the frontmatter.
          -- So here we just make sure those fields are kept in the frontmatter.
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end
          return out
        end,
      },

      -- Function to generate note IDs
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
      end,
    },
  },
}
