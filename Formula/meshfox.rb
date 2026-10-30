class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.29.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.29.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "5fdbfbd458f78f4157c46fd551964ae8eaa255c49e8675918d34fda8380bd900"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.29.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "cc91c1f6e7916e610f6df1d6e73eab57953af9c0b82552309fe2c3e107d26958"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.29.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7774916f4de0c5090d3332903e9c190e26890cc761915161cb822488a7adac9e"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.29.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "82fdaddf3c8e5ed5c62065154debb512966b107a57be2a2b5489d5310d4c1465"
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
