class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.27.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.1/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "88871a468c08659efc9404406bdf6c233c77f82dc9799fa2e9d9845069493743"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.1/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "d46c54c014d1cd6afee4dd8aae0ac51fc2e42aa1097fd89eae81c78224a3add2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.1/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "33a261b0ff124931278a579bd84f05cc398d494ae7989f92c971d7b963328238"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.1/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7676592d463fa323611cf9fc7ae60fd011f658d669d9195cd0e9d19f0631be2"
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
