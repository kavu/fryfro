guard :rspec, env: {'RSPEC_ENV' => 'guard'} do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/fryfro/(.+)\.rb$})  { |m| "spec/fryfro/#{m[1]}_spec.rb" }
  watch('lib/fryfro.rb')            { 'spec/fryfro/fryfro_spec.rb' }
  watch('spec/spec_helper.rb')      { 'spec' }
end
