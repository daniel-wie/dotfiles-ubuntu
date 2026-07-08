# download and unpack nerd fonts symbols
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip
unzip -d ~/.local/share/fonts/NerdFontsSymbolsOnly NerdFontsSymbolsOnly.zip
rm NerdFontsSymbolsOnly.zip

# update font cache
fc-cache -fv
