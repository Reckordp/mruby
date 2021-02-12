MRuby::Build.new do |conf|
  toolchain :gcc

  # include all core GEMs
  conf.gembox 'full-core'
  conf.cc.flags += %w(-Werror=declaration-after-statement)
  conf.compilers.each do |c|
    c.defines += %w(MRB_GC_FIXED_ARENA)
  end

  conf.gem 'mrbgems/mruby-at_exit'
end