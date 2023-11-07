 #!/bin/bash

 wallpapers=$(find ~/Wallpapers/ -name "*.jpg" -o -name "*.png")
 wallpapers=($wallpapers)
 for i in ${!wallpapers[@]};
 do
     echo "$i ${wallpapers[$i]}";
 done

 read -p 'Pick the wallpaper you want: ' choice
bash -c "~/scripts/choose_wallpaper.sh ${wallpapers[$choice]}"
