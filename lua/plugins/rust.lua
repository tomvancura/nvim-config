return {
  "mrcjkb/rustaceanvim",
  opts = {
    -- The `diagnostic` options are part of the rust-analyzer server settings
    server = {
      settings = {
        ["rust-analyzer"] = {
          diagnostic = {
            refreshSupport = false,
          },
        },
      },
    },
  },
}
