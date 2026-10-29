class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.28.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.1/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "4e6de84f04c66c40cab89e93b09abab6fcf7b92bfe54d0845cf7c8464c4648aa"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.1/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "9540b4f22088e6e41352d48d3aab2d17e40c711363ebf370c0c634106faa451d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.1/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "70fb1b906f102a662a20b8949985c6b183173c956ff8d3331054e43032670661"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.1/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "19e07fcddf8416bf66d94addfec382c1526c2ad6828c15ea43476aa1dc256616"
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
