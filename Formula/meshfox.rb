class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.35.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.35.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "5a4b4402e48cc6544a366ec82eba8f921ffba2996aa090f7c701bd1c7ca68b39"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.35.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "a1033689d6e345607e8202f0dde074700432bc2e9a44a1f34a88de82b7d4233b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.35.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "590805749d6364f092facd9a60163d77f7d123d60e0a4ca5b5ca07ca09faac0c"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.35.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "728e59b8dbe360b6bc14b7270977d8b2880358566c80fa72213fe14fcc053f21"
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
