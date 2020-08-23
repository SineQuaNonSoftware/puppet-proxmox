Facter.add('gatewayv4') do
  setcode do
    %x{/bin/grep -E '^[     ]*gateway' /etc/network/interfaces|/bin/sed -e 's/^[         ]*gateway[      ]//' | head -1}.chomp
  end
end
