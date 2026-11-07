class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.34.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.34.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "64e02bdd485fdc1f1bccb1c52f61f82a6b6479e7cf6aae0dee634dafdea640a2"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.34.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "bc036efc4a5be14543fafa3560a14a71c3b943ac46167fb2e2fbe076248bb53f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.34.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e89d894efaa2b6c11923a1d9443d88b781930328f6a8d3909d5e50d63835595d"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.34.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "20ed64b8e3d811231dcefe5a257a56efa967a0104474f7ccc1631fcc55bb6862"
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
