#!/usr/bin/env bash
# Writes Casks/querydesk.rb for a QueryDesk CLI release from its SHA256SUMS file.
#   scripts/querydesk-cask.sh <version> <sums file>
set -euo pipefail
version=$1
sums=$2

sha() {
  local file="querydesk_${version}_$1.tar.gz"
  awk -v f="$file" '$2 == f {print $1}' "$sums" | grep . || { echo "no checksum for $file" >&2; exit 1; }
}

cat >Casks/querydesk.rb <<CASK
# Written by .github/workflows/querydesk.yml from devhub-tools/querydesk-cli's latest release.
cask "querydesk" do
  version "${version}"

  on_macos do
    on_arm do
      sha256 "$(sha darwin_arm64)"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "$(sha darwin_amd64)"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "$(sha linux_arm64)"
      url "https://github.com/devhub-tools/querydesk-cli/releases/download/v#{version}/querydesk_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "$(sha linux_amd64)"
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
CASK
