class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.32.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.32.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "0d69d5373f28fdc9a6ce2b72d2674b7a36f8e29c445ebacd8580cedbf1408f87"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.32.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "39e924060d94e67b950ec60479336e4af06763b2664dae6a7f783f91122ae10e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.32.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "201c66ba403769b9a1e281a049125a84e54b0734a4bbd3a929e747c68bba9cf8"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.32.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cfac6d32f0d9592cfab16a958e2099b6f333764c64f76c8d32bf2c7f860e094c"
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
