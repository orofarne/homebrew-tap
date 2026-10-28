class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.28.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "a0f33cca46cd9e65da6af0603c71ee4dd4c5251a1a89d1271b20c3d6912235af"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "07d999638966a8d717d1d474583aa882cde773fb09830ad1612c9e6eaf44436d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a630172484a03ce3ff138797fbdb63c60cfd4c751d12f0aa326a5a4e6ef81754"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "223bb48983fdc468bf41d96b20d768a46cd25026c70b5061409d84b568bba9b7"
    end
  end

  def install
    bin.install "meshfox"
    (share/"meshfox").mkpath
    (share/"meshfox/install-method").write "homebrew\n"
  end

  def caveats
    <<~EOS
      Update this installation with Homebrew:
        brew upgrade orofarne/tap/meshfox
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/meshfox --version")
    update_message = shell_output("#{bin}/meshfox check-updates --yes")
    assert_match "managed by a package manager", update_message
    assert_match "brew upgrade orofarne/tap/meshfox", update_message
    (testpath/"smoke.canvas.md").write <<~EOS
      <!-- meshfox:canvas -->
      # Homebrew test
      <!-- meshfox:node id="root" -->
      A canvas installed and validated through Homebrew.
    EOS
    system bin/"meshfox", "validate", testpath/"smoke.canvas.md"
  end
end
