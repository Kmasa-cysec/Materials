# 素材置き場
## Shellの環境設定
- Install zsh  
`sudo apt install zsh`  
`brew install zsh`

- Change LoginShell  
`chsh -s /usr/local/bin/zsh`

- Install prezto  
`git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"`

- Create configuration  
```
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do  
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"  
done
```

- Chose theme (powerlevel10k)  
`prompt -s powerlevel10k`
or  
add to ~/.zpreztorc  
`zstyle 'prezto:module:prompt' theme 'powerlevel10k'`

- Install Fonts  
Meslo Nerd Font  
[MesloLGS NF Regular.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)  
[MesloLGS NF Bold.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)  
[MesloLGS NF Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)  
[MesloLGS NF Bold Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)  
(if necessary)   
　`mkdir ~/.fonts; mv MesloLGS*.ttf ~/.fonts/`

- (options) add autosuggestions & syntax-highlighting  
add to ~/.zpreztorc  
```
'syntax-highlighting' \  
'autosuggesitons' \
```
```
zstyle ':preztp:module:syntax-highlighting' color 'yes'  
zstyle ':preztp:module:autosuggestions:color' found 'fg=blue'
```
