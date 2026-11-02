class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.30.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.30.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "ebf23d26d0e7f576c3e00ad8da4ee2d1a17e2715765bcb3202ad609e4c9ab50c"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.30.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "8e28087c7d5ce7478e62be9be32bdadce4ce1e883e6235eed347cc5715b63d9e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.30.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4cd11ff7c19119927ad1801b53f9b8fa41e3656776a71556a0166f4bd4663c98"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.30.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cfd27d0267071bfd56578b820dd823c055a7ac0082193b5cbebca6602dc602e5"
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
