{ pkgs, ... }: {
  fonts.fonts = with pkgs; [
    freefont_ttf
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    eb-garamond
    barlow

    archivo
    comic-sans
    comic-code
  ];
}
