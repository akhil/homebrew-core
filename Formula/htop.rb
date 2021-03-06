class Htop < Formula
  desc "Improved top (interactive process viewer)"
  homepage "https://hisham.hm/htop/"

  stable do
    url "https://hisham.hm/htop/releases/2.1.0/htop-2.1.0.tar.gz"
    sha256 "3260be990d26e25b6b49fc9d96dbc935ad46e61083c0b7f6df413e513bf80748"

    # Remove for > 2.1.0
    # Upstream commit from 25 Mar 2018 "Keep scanning threads for versions
    # before High Sierra 13.0.0 and after 13.3.0."
    patch do
      url "https://github.com/hishamhm/htop/commit/52e2884f.patch?full_index=1"
      sha256 "5daeb1a532cf8e4524a4f3093792a687d77b50c3f78c713b410ebb2bc9ae79b2"
    end
  end

  bottle do
    sha256 "2b821083315e53a46381552d574d078e02494692e8da6068f36e450f6800dd44" => :high_sierra
    sha256 "e75326fdc0d4f968713eb59b028c5dc24c725e546f51391bf38152bbf69e7405" => :sierra
    sha256 "c8adbacd3abd497f92511b6e406aaa27d8ab6f19dbce79c297ef226787655fef" => :el_capitan
  end

  head do
    url "https://github.com/hishamhm/htop.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  option "with-ncurses", "Build using homebrew ncurses (enables mouse scroll)"

  depends_on "pkg-config" => :build
  depends_on "ncurses" => :optional

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats; <<~EOS
    htop requires root privileges to correctly display all running processes,
    so you will need to run `sudo htop`.
    You should be certain that you trust any software you grant root privileges.
    EOS
  end

  test do
    pipe_output("#{bin}/htop", "q", 0)
  end
end
