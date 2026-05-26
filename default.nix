{
  pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
    };
  },
}:
pkgs.mkShell rec {
  ANDROID_SDK_ROOT = "/home/tau2c/Android/Sdk";
  ANDROID_HOME = ANDROID_SDK_ROOT;

  buildInputs = with pkgs; [
    # Flutter
    flutter

    # Android
    android-studio
    android-tools
    jdk17

    # Python
    python312
    python312Packages.virtualenv

    # General native deps
    pkg-config
    openssl
    libffi

    # Tools
    curl
    jq
    httpie

    insomnia
  ];

  shellHook = ''
    export JAVA_HOME=${pkgs.jdk17}

    export PATH=$ANDROID_SDK_ROOT/emulator:$PATH
    export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
    export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH

    export LD_LIBRARY_PATH=${
      pkgs.lib.makeLibraryPath [
        pkgs.openssl
        pkgs.libffi
      ]
    }
  '';
}
