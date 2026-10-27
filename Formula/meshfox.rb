class Meshfox < Formula
  desc "Markdown canvas with executable code blocks, terminal and web interfaces"
  homepage "https://meshfox.orofarne.net/"
  version "0.27.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.0/meshfox-aarch64-apple-darwin.tar.gz"
      sha256 "34205166beddff40eac03d8ba58e351c52f7e1bbb35f907ff9a9f06df8796239"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.0/meshfox-x86_64-apple-darwin.tar.gz"
      sha256 "5bfca5ce456e6b828fe76c5b0cd20a786f7c25cd556d6e913b11215fad6ac629"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.0/meshfox-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9dae8d8b77fd913b9f85fe5219575d9d9a9bba1709b7726ece00eff18037c02a"
    end

    on_intel do
      url "https://github.com/orofarne/meshfox/releases/download/v0.27.0/meshfox-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "babaa226cee63921f7c760ab8130a0fdf818f0b2cfb5acc1d0cd02eec00a88cf"
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
