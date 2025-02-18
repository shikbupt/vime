lua << EOF
require('vgit').setup({
  settings = {
    hls = {
      GitBackgroundPrimary = 'NormalFloat',
      GitBackgroundSecondary = {
        gui = nil,
        fg = nil,
        bg = nil,
        sp = nil,
        override = false,
      },
      GitBorder = 'LineNr',
      GitLineNr = 'LineNr',
      GitComment = 'Comment',
      GitSignsAdd = {
        gui = nil,
        fg = '#d7ffaf',
        bg = nil,
        sp = nil,
        override = false,
      },
      GitSignsChange = {
        gui = nil,
        fg = '#7AA6DA',
        bg = nil,
        sp = nil,
        override = false,
      },
      GitSignsDelete = {
        gui = nil,
        fg = '#e95678',
        bg = nil,
        sp = nil,
        override = false,
      },
      GitSignsAddLn = 'DiffAdd',
      GitSignsDeleteLn = 'DiffDelete',
      GitWordAdd = {
        gui = nil,
        fg = nil,
        bg = '#5d7a22',
        sp = nil,
        override = false,
      },
      GitWordDelete = {
        gui = nil,
        fg = nil,
        bg = '#960f3d',
        sp = nil,
        override = false,
      },
    },
    live_blame = {
      enabled = false,
      format = function(blame, git_config)
        local config_author = git_config['user.name']
        local author = blame.author
        if config_author == author then
          author = 'You'
        end
        local time = os.difftime(os.time(), blame.author_time)
          / (60 * 60 * 24 * 30 * 12)
        local time_divisions = {
          { 1, 'years' },
          { 12, 'months' },
          { 30, 'days' },
          { 24, 'hours' },
          { 60, 'minutes' },
          { 60, 'seconds' },
        }
        local counter = 1
        local time_division = time_divisions[counter]
        local time_boundary = time_division[1]
        local time_postfix = time_division[2]
        while time < 1 and counter ~= #time_divisions do
          time_division = time_divisions[counter]
          time_boundary = time_division[1]
          time_postfix = time_division[2]
          time = time * time_boundary
          counter = counter + 1
        end
        local commit_message = blame.commit_message
        if not blame.committed then
          author = 'You'
          commit_message = 'Uncommitted changes'
          return string.format(' %s • %s', author, commit_message)
        end
        local max_commit_message_length = 255
        if #commit_message > max_commit_message_length then
          commit_message = commit_message:sub(1, max_commit_message_length) .. '...'
        end
        return string.format(
          ' %s, %s • %s',
          author,
          string.format(
            '%s %s ago',
            time >= 0 and math.floor(time + 0.5) or math.ceil(time - 0.5),
            time_postfix
          ),
          commit_message
        )
      end,
    },
    live_gutter = {
      enabled = true,
    },
    authorship_code_lens = {
      enabled = false,
    },
    screen = {
      diff_preference = 'unified',
    },
    project_diff_preview = {
      keymaps = {
        buffer_stage = 's',
        buffer_unstage = 'u',
        stage_all = 'a',
        unstage_all = 'd',
        reset_all = 'r',
      },
    },
    signs = {
      priority = 10,
      definitions = {
        GitSignsAddLn = {
          linehl = 'GitSignsAddLn',
          texthl = nil,
          numhl = nil,
          icon = nil,
          text = '',
        },
        GitSignsDeleteLn = {
          linehl = 'GitSignsDeleteLn',
          texthl = nil,
          numhl = nil,
          icon = nil,
          text = '',
        },
        GitSignsAdd = {
          texthl = 'GitSignsAdd',
          numhl = nil,
          icon = nil,
          linehl = nil,
          text = '┃',
        },
        GitSignsDelete = {
          texthl = 'GitSignsDelete',
          numhl = nil,
          icon = nil,
          linehl = nil,
          text = '┃',
        },
        GitSignsChange = {
          texthl = 'GitSignsChange',
          numhl = nil,
          icon = nil,
          linehl = nil,
          text = '┃',
        },
      },
      usage = {
        screen = {
          add = 'GitSignsAddLn',
          remove = 'GitSignsDeleteLn',
        },
        main = {
          add = 'GitSignsAdd',
          remove = 'GitSignsDelete',
          change = 'GitSignsChange',
        },
      },
    },
    symbols = {
      void = '⣿',
    },
  }
})
EOF

if !common#functions#HasPlug("vim-gitgutter") && !common#functions#HasCocPlug('coc-git')
    nmap <leader>gj <esc>:VGit hunk_down<CR>
    nmap <leader>gk <esc>:VGit hunk_up<CR>

    nmap <leader>gp <esc>:VGit buffer_hunk_preview<CR>
    nmap <leader>gP <esc>:VGit project_hunks_preview<CR>
    nmap <leader>gd <esc>:VGit buffer_diff_preview<CR>
    nmap <leader>gD <esc>:VGit project_diff_preview<CR>

    nmap <leader>gh <esc>:VGit buffer_history_preview<CR>

    nmap <leader>gu <esc>:VGit buffer_hunk_reset<CR>
    nmap <leader>gU <esc>:VGit buffer_reset<CR>

    nmap <leader>gb <esc>:VGit buffer_blame_preview<CR>
    nmap <leader>gB <esc>:VGit buffer_gutter_blame_preview<CR>

    nmap <leader>gt <esc>:VGit toggle_diff_preference<CR>
endif
