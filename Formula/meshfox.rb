class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.26.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.26.1/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "7e7c1bbcc00d7c248e06a1949ed02cb3771b1fcf22f700405f6b16f81d0c8e37"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.26.1/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "6c3c1805ee91e203116b538079820d787b511153efa27c7b32ded0b9142b9b4c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.26.1/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e2a3b82c92ebd5a2050b7a93c1b4489e6cbdd4c3ccbdb5c933df3ce5ea87fad6"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.26.1/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a185288cb394373a617d24cb794eec4a48f6cc3cc0884316b4cc3e2c97cea56e"
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
