fmt_green="\e[32m"
fmt_red="\e[31m"
fmt_yellow="\e[33m"
fmt_clear="\e[0m"

if [[ "$1" != "cli" && "$1" != "gui" ]]; then
  echo 'Usage: ./dev.sh <gui|cli>'
else

  function info_text {
      echo -e "\n ${fmt_yellow}$1${fmt_clear}"
  }
  
  function pass {
    echo -e "\n ${fmt_green}SUCCESS${fmt_clear}\n"
  }

  function fail {
    echo -e "\n ${fmt_red}FAIL${fmt_clear}\n"
  }

  function reset_test_root {

    info_text "Preparing environment"

    if [[ ! -f 'test_root.zip' ]]; then
      mv test_root/test_root.zip .
    fi

    rm -f test_root/*.jpg
    rm -f test_root/*.aes
    rm -f test_root/erebia_aethiops
    unzip -qo test_root.zip -d test_root
  }

  clear
  if [[ "$1" == 'gui' ]]; then

    while true; do
      reset_test_root
      info_text "Displaying pre-test state" &&
      feh test_root/erebia_aethiops.jpg &&
      info_text "Testing encryption" &&
      python encrypt.py && pass &&
      info_text "Testing decryption" &&
      python decrypt.py &&
      info_text "Displaying results" &&
      feh test_root/erebia_aethiops.jpg && pass || fail
      inotifywait -e modify .
      clear
     done

   elif [[ "$1" == 'cli' ]]; then

    while true; do
      reset_test_root
      info_text "Getting pre-test state" &&
      sha256sum test_root/* > sha256sums &&
      info_text "Testing encryption" &&
      python encrypt.py && pass &&
      info_text "Testing decryption" &&
      python decrypt.py &&
      info_text "Displaying results" &&
      sha256sum -c sha256sums && pass || fail
      sleep 1
      echo
      inotifywait -e modify .
      clear
     done

  fi
fi
