class Mdtable < Formula
  desc "Convert Markdown tables to HTML with support for nested lists"
  homepage "https://github.com/ji4/markdown-table-formatter"
  url "https://github.com/ji4/markdown-table-formatter/archive/v1.0.3.tar.gz"
  sha256 "3bc47ef2f65de40fd691649d4b4490118e98b38e6dbb8023b83b9ceed22df311"
  license "MIT"
  
  depends_on "perl"
  
  def install
    bin.install "markdown-table-formatter.sh" => "mdtable"
    chmod 0755, bin/"mdtable"
  end
  
  test do
    (testpath/"test.md").write <<~EOS
      | Header 1 | Header 2 |
      |----------|----------|
      | Cell 1   | Cell 2   |
    EOS
    
    system "#{bin}/mdtable", "test.md"
    assert_predicate testpath/"test.html", :exist?
    
    output = (testpath/"test.html").read
    assert_match "<table>", output
    assert_match "Cell 1", output
  end
end