Facter.add("gateway") do
  setcode do
    gateway = %x{/bin/grep -E '^[     ]*gateway' /etc/network/interfaces|/bin/sed -e 's/^[         ]*gateway[      ]//'}.chomp
  end
end
