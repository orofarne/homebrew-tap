class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.33.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.33.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "19f97b09196c10e9241951518ac7e01c3e53fbe02b1590450bee339cdeca84d7"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.33.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "9e327af938939e606b0a40d52dc1a1b8bef0d650bb68d2d01b50462f8aa2cb88"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.33.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8a8ac8d0942da74c36c5307570ccd7f2b31b381f36d3021bb02b8359a804d28d"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.33.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "456657a7ac0f3a2c402b785af112d4eadba76b59a9928346b8a43a8df7256cf3"
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
