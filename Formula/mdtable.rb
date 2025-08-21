class Mdtable < Formula
  desc "Convert Markdown tables to HTML with support for nested lists"
  homepage "https://github.com/ji4/markdown-table-formatter"
  url "https://github.com/ji4/markdown-table-formatter/archive/v1.0.2.tar.gz"
  sha256 "fffcd16da3846c1b7ec3a70a01409534fa6b5d50573dfaa0de42f19c927b3351"
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