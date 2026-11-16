class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.38.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.38.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "d68a9a61792e2eba62446f4fe8f28fda80da6bce204dd4fc592ccb5268332191"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.38.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "960029bacca8184eb32efe7076c2b3727b6a8535356deed1dce708f00fadb90b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.38.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b312c834308dd2099a80b770e9f863eea8ff1e42311f6c4d816b7cf2bac8dc21"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.38.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6a245b8d8fa10ece4142dc706856be27146673f52a8f6061bfece10aea9fc701"
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
