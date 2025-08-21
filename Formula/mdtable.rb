class Mdtable < Formula
  desc "Convert Markdown tables to HTML with support for nested lists"
  homepage "https://github.com/ji4/markdown-table-formatter"
  url "https://github.com/ji4/markdown-table-formatter/archive/v1.0.1.tar.gz"
  sha256 "e99662283050cc41b3b3f9cf25ff0b6f7a25e1d08298889553fb7fb342d6b284"
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