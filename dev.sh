fmt_green="\e[32m"
fmt_red="\e[31m"
fmt_yellow="\e[33m"
fmt_clear="\e[0m"

if [[ "$1" != "cli" && "$1" != "gui" ]]; then
  echo 'Usage: ./dev.sh <gui|cli>'
else

  function reset_test_root {

    echo -e "\n${fmt_yellow}Preparing environment${fmt_clear}\n"

    if [[ ! -f 'test_root.zip' ]]; then
      mv test_root/test_root.zip .
    fi

    rm test_root/*.jpg
    unzip -qo test_root.zip -d test_root
  }

  if [[ "$1" == 'gui' ]]; then

    while true; do
      reset_test_root
      feh test_root/erebia_aethiops.jpg &&
      python encrypt.py &&
      file test_root/erebia_aethiops.jpg.aes &&
      python decrypt.py &&
      feh test_root/erebia_aethiops.jpg &&
        echo -e "\n ${fmt_green}SUCCESS${fmt_clear}\n" ||
        echo -e "\n ${fmt_red}FAIL${fmt_clear}\n"
      inotifywait -e modify .
      clear
     done

   elif [[ "$1" == 'cli' ]]; then

    while true; do
      reset_test_root
      sha256sum test_root/* > sha256sums &&
      python encrypt.py &&
      file test_root/erebia_aethiops.jpg.aes &&
      python decrypt.py &&
      echo -e "\n$(sha256sum -c sha256sums)" &&
        echo -e "\n ${fmt_green}SUCCESS${fmt_clear}\n" ||
        echo -e "\n ${fmt_red}FAIL${fmt_clear}\n"
      inotifywait -e modify .
      clear
     done

  fi
fi
