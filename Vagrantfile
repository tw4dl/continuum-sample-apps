Vagrant.configure("2") do |config|
  config.vm.box = "apcera/continuum_trial"
  config.vm.box_url = "https://d1g23m5c3hjtbv.cloudfront.net/continuum_trial_vagrant_virtualbox.box"
  config.vm.network :public_network
# config.vm.box_download_checksum_type = "sha1"
# config.vm.box_download_checksum = "4658ad4e1e28da310aaaf3cbcf18a625210aa014"
  config.vm.synced_folder ".", "/home/vagrant/continuum-sample-apps"
end
