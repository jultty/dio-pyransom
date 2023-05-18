
if [[ "$1" != "cli" && "$1" != "gui" ]]; then
  echo 'Usage: ./dev.sh <gui|cli>'
else

  if [[ ! -f 'test_root.zip' ]]; then
    mv test_root/test_root.zip .
  fi

  function reset_test_root {
    rm test_root/*.jpg
    unzip -qo test_root.zip -d test_root
  }

  if [[ "$1" == 'gui' ]]; then

    while true; do
      reset_test_root
      feh test_root/erebia_aethiops.jpg
      python encrypt.py
      file test_root/erebia_aethiops.jpg.aes
      python decrypt.py
      feh test_root/erebia_aethiops.jpg
      inotifywait -e modify .
      clear
     done

   elif [[ "$1" == 'cli' ]]; then

    while true; do
      reset_test_root
      sha256sum test_root/* > sha256sums
      python encrypt.py
      file test_root/erebia_aethiops.jpg.aes
      python decrypt.py
      echo -e "\n$(sha256sum -c sha256sums) \n"
      inotifywait -e modify .
      clear
     done

  fi
fi
