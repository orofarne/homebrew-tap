class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.28.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.2/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "3d946e11799f7d00a86eb11fb157cdef255be761a119bc17927042f461b752ff"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.2/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "61b043b6bd26738de3f591ed7715523c33f85581922341df56b4f57b997425de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.2/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ad68a8db6a18dc11c2695613830572aeb600e571cb3b0c0c0bc2ab2c27dc0311"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.28.2/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0f5cae9bdf262b1f3048db697e9f8b884b33760944ba4f839a108ba7d4cf24d7"
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
