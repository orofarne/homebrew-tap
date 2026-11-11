class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.36.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.36.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "13cfe64f30c0c220694a09dd4099594e890abf21690e348f344fc771cf6a61fc"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.36.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "24928b2aec87d58c2097980ebabea18ff1a6bddb7d0975cd662f117e82a1308b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.36.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "920502fe4b56067088d4fe9ef04f71e56a9a3cccd4c922b85351e32084985764"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.36.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1d7e2aeb722bf248bf66a799e158abcc93cb594201bf695eab5299de6b432787"
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
