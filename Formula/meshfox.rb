class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.37.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.37.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "e31fc7372d519896c2e75ea034f52f656c2d70811db271dca15cd7771385fed2"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.37.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "1cc475b9778735fa62ab306973f357d4b38538e1b8159579d96642e5393716db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.37.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "706f34ee79ac85e093fdaaec3f1141205dfdf18b1072439444a83f0ca810ab84"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.37.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7703785e9b8a6d2c647776348504098155cad2d5800c3884a652ebf649f0fe9"
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
