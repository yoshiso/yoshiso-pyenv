

default["pyenv"]["user"] = "vagrant"
default["pyenv"]["git_url"] = "https://github.com/yyuu/pyenv.git"
default['pyenv']['virtualenv_git_url'] = "https://github.com/yyuu/pyenv-virtualenv.git"
default["pyenv"]["install_pkgs"] = %w{
    bzip2 bzip2-devel
    git
    grep
    patch
    readline-devel
    sqlite sqlite-devel
    zlib-devel
    openssl-devel
    gcc gcc-c++
    freetype freetype-devel
    libpng libpng-devel
}

# Any python versions you want to install
default["pyenv"]["versions"] = []

# global python version
# defalut['pyenv']['version'] = "2.7.6"