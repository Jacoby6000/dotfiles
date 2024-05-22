return {
  "alienman5k/jdecomp.nvim",
  opts = {
    decompiler = "cfr", -- cfr, procyon, fernflower
    provider = {
      cfr = {
        bin = "cfr",
      },
      procyon = {
        jar = os.getenv("HOME") .. "/Software/procyon-decompiler-0.6.0.jar",
      },
      fernflower = {
        jar = os.getenv("HOME") .. "/Software/fernflower.jar",
      },
    },
  },
}
