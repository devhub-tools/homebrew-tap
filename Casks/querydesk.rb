# Written by .github/workflows/querydesk.yml from devhub-tools/querydesk-cli's latest release.
cask "querydesk" do
  version "3.0.0"

  on_macos do
    on_arm do
      sha256 "a72130a3b89f5631d0603fa57eaa8e593769bdaff5a418ecf0332338ddb892f1"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "19db9067d49b65810146284944710419b44ad5f52b4b9c3f762c4c7fc3730a7f"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "ff31472dbfa307ba861f980015aae05de90e27d8968762d703710f7da9767ef0"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "7436535c28978afd72e5610ebce7fc534e2a791d310a110895819a7f45f6503f"
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
