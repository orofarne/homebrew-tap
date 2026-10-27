class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.27.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.2/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "7d8744bf606b08177574b6362657d2fe3f7d8fdbf2615f08a71bbe78ddfd794f"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.2/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "b974f652202374eff060b8cc51b0a6e505e31d61d0f9f6a11c7cd64f0b9fff99"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.2/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a8d6a89378e8873d6af459a93241a1d09fced97063bead01aad449511ae2877d"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.2/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8cd8f2e92b96a7587df489037b9c18ef76dbf5299cb8756dbb5e3d231b124101"
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
