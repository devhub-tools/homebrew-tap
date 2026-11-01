# Written by .github/workflows/querydesk.yml from devhub-tools/querydesk-cli's latest release.
cask "querydesk" do
  version "2.46.1.1"

  on_macos do
    on_arm do
      sha256 "3989b91d371c05525fa8dadfd6ff12d18b6fbceb10e7f48f60d6446920f546a0"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "8acbf4fffd6f4b9070282cf339f8927a8871597ee862daaf519d75a20ceea294"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "233e3054e738bd75e7447b0910aad7c3ca5a95682a97f588491ba8d8a70ebe98"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "f852d03d84f5ad94962ab98c4fe2820a8ecf8198d187340daa6f2e96a5a07238"
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
