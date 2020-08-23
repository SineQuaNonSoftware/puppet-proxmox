Facter.add('netdev') do
  setcode do
    Facter.value(:networking)['interfaces'].keys.first
  end
end
