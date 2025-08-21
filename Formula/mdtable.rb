class Mdtable < Formula
  desc "Convert Markdown tables to HTML with support for nested lists"
  homepage "https://github.com/ji4/markdown-table-formatter"
  url "https://github.com/ji4/markdown-table-formatter/archive/v1.0.0.tar.gz"
  sha256 "49bcfb6ebe7eb95a3f2e18d2e5855db589c28d5d79db895bd06e6c58c61008d6"
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
    assert_predicate testpath/"test_html.html", :exist?
    
    output = (testpath/"test_html.html").read
    assert_match "<table>", output
    assert_match "Cell 1", output
  end
end