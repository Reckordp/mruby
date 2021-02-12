MRuby::Build.new do |conf|
  toolchain :gcc

  # include all core GEMs
  conf.gembox 'full-core'
  conf.cc.flags += %w(-Werror=declaration-after-statement)
  conf.compilers.each do |c|
    c.defines += %w(MRB_GC_FIXED_ARENA)
  end

  conf.gem 'mrbgems/mruby-at_exit'
  conf.gem 'mrbgems/mruby-hs-regexp'
  conf.gem 'mrbgems/mruby-dir'
  conf.gem 'mrbgems/mruby-errno'
  conf.gem 'mrbgems/mruby-file-stat'
  conf.gem 'mrbgems/mruby-process'
  conf.gem 'mrbgems/mruby-pack'
  conf.gem 'mrbgems/mruby-dir-glob'
end