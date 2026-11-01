# Written by .github/workflows/querydesk.yml from devhub-tools/querydesk-cli's latest release.
cask "querydesk" do
  version "2.46.1"

  on_macos do
    on_arm do
      sha256 "17e458f8cd21814ae4cceba86005ade40d3a4c8e542fef52f77107c9cdd1dbfe"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "5278d5a38a6d93375a6e7b4b751c4b09a347073e2f86dbdaa4d55323866b4523"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "b721cfa2e414367613d0331ef314f70c0b8252698697c7cad29585e93fbebec5"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "d7e2a159adf4c27f645f098f5433b63515dad2b6605af43ab62a72b1ae8a4942"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_linux_amd64.tar.gz"
    end
  end

  name "QueryDesk CLI"
  desc "Connect Postgres and MySQL clients to QueryDesk over HTTPS"
  homepage "https://github.com/devhub-tools/querydesk-cli"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "querydesk"

  # the binary is unsigned: brew quarantines what it downloads, which Gatekeeper then blocks
  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/querydesk"]
    end
  end
end
