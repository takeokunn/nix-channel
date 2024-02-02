{ lib
, stdenv
, fetchFromGitHub
, autoreconfHook
, bison
, libevent
, ncurses
, pkg-config
, libsixel
, runCommand
, withSystemd ? lib.meta.availableOn stdenv.hostPlatform systemd, systemd
, withUtf8proc ? true, utf8proc # gets Unicode updates faster than glibc
, withUtempter ? stdenv.isLinux && !stdenv.hostPlatform.isMusl, libutempter
}:

let
  bashCompletion = fetchFromGitHub {
    owner = "imomaliev";
    repo = "tmux-bash-completion";
    rev = "f5d53239f7658f8e8fbaf02535cc369009c436d6";
    sha256 = "0sq2g3w0h3mkfa6qwqdw93chb5f1hgkz5vdl8yw8mxwdqwhsdprr";
  };
in

stdenv.mkDerivation (finalAttrs: {
  name = "tmux";
  outputs = [ "out" "man" ];

  src = fetchFromGitHub {
    owner = "tmux";
    repo = "tmux";
    rev = "ea7136fb838a2831d38e11ca94094cea61a01e3a";
    sha256 = "0y8j2s1bfvfvq7j539g9q8fknjmcpz3fw7flxa29s87qgpaqm35n";
  };

  patches = [
    ./CVE-2022-47016.patch
  ];

  nativeBuildInputs = [
    pkg-config
    autoreconfHook
    bison
  ];

  buildInputs = [
    ncurses
    libevent
    libsixel
  ] ++ lib.optionals withSystemd [ systemd ]
  ++ lib.optionals withUtf8proc [ utf8proc ]
  ++ lib.optionals withUtempter [ libutempter ];

  configureFlags = [
    "--sysconfdir=/etc"
    "--localstatedir=/var"
    "--enable-sixel"
  ] ++ lib.optionals withSystemd [ "--enable-systemd" ]
  ++ lib.optionals withUtempter [ "--enable-utempter" ]
  ++ lib.optionals withUtf8proc [ "--enable-utf8proc" ];

  enableParallelBuilding = true;

  postInstall = ''
    mkdir -p $out/share/bash-completion/completions
    cp -v ${bashCompletion}/completions/tmux $out/share/bash-completion/completions/tmux
  '' + lib.optionalString stdenv.isDarwin ''
    mkdir $out/nix-support
    echo "${finalAttrs.passthru.terminfo}" >> $out/nix-support/propagated-user-env-packages
  '';

  passthru = {
    terminfo = runCommand "tmux-terminfo" { nativeBuildInputs = [ ncurses ]; } (if stdenv.isDarwin then ''
      mkdir -p $out/share/terminfo/74
      cp -v ${ncurses}/share/terminfo/74/tmux $out/share/terminfo/74
      # macOS ships an old version (5.7) of ncurses which does not include tmux-256color so we need to provide it from our ncurses.
      # However, due to a bug in ncurses 5.7, we need to first patch the terminfo before we can use it with macOS.
      # https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos/
      tic -o $out/share/terminfo -x <(TERMINFO_DIRS=${ncurses}/share/terminfo infocmp -x tmux-256color | sed 's|pairs#0x10000|pairs#32767|')
    '' else ''
      mkdir -p $out/share/terminfo/t
      ln -sv ${ncurses}/share/terminfo/t/{tmux,tmux-256color,tmux-direct} $out/share/terminfo/t
    '');
  };

  meta = {
    homepage = "https://tmux.github.io/";
    description = "Terminal multiplexer";
    longDescription = ''
      tmux is intended to be a modern, BSD-licensed alternative to programs such as GNU screen. Major features include:
      * A powerful, consistent, well-documented and easily scriptable command interface.
      * A window may be split horizontally and vertically into panes.
      * Panes can be freely moved and resized, or arranged into preset layouts.
      * Support for UTF-8 and 256-colour terminals.
      * Copy and paste with multiple buffers.
      * Interactive menus to select windows, sessions or clients.
      * Change the current window by searching for text in the target.
      * Terminal locking, manually or after a timeout.
      * A clean, easily extended, BSD-licensed codebase, under active development.
    '';
    license = lib.licenses.bsd3;
    platforms = lib.platforms.unix;
    mainProgram = "tmux";
    maintainers = with lib.maintainers; [ thammers fpletz ];
  };
})
