class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.31.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.31.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "bf4a866302b35fdca94f306aa187933b91d81d9ce2689903ca9af5f8c7d7c77d"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.31.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "b937ccd783e04b7de0aea60a5c77a6d76a8c5ed9c32611c52186922b2b7cb425"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.31.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fef47ebab5b9d113518e4e61ee07554d8adf98365104c2583ef71fc37e9f32e9"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.31.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6e63f839e1527d9e78dea455330211c588267709956348bf0e3049fd3410d9ce"
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
