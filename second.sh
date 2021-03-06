B='/etc/backup/'
P="Если долго,то ждите,тк. машина НИКОГДА не ошибается"
echo "Настройка начата в $(date +%T)"
echo 'Идет настройка, только что свежеустановленной системы "ArchLinux"'
echo
echo
echo 'Создание бэкапного каталога в /etc/backup'
mkdir --mode=700 ${B}
cd configs
echo
echo 'Генерирование локалей'
echo ${P}
cp -v /etc/locale.gen ${B}
cp -v locale.gen /etc/
locale-gen
echo
echo 'Языковые и региональные настройки'
cp -v locale.conf /etc/
cp -v vconsole.conf /etc/
cp -v hostname /etc/
export LANG=ru_RU.UTF-8
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
loadkeys ru
setfont cyr-sun16
hwclock --systohc --utc
echo
echo 'Настройка сердца "ArchLinux"'
cp -v /etc/pacman.conf ${B}
cp -v pacman.conf /etc/
pacman -Sy --noconfirm --needed --noprogressbar --quiet reflector
mkdir --mode=700 /etc/backup/pacman.d
cp -v /etc/pacman.d/mirrorlist /etc/backup/pacman.d/
echo 'Идет запись лучших зеркал в файл'
echo ${P}
reflector -l 100 --sort rate --save /etc/pacman.d/mirrorlist
echo 'Идет установка и удаление системных программ'
echo ${P}
pacman -R --noconfirm netcfg
pacman -S  --noconfirm --needed --noprogressbar --quiet yaourt sudo grub-bios zsh linux-pf-core2 wireless_tools wpa_supplicant wpa_actiond netctl dialog linux-pf-headers-core2
pacman -Rdd --noconfirm --needed --noprogressbar --quiet linux
echo
echo 'Создание инитрамфса,создание учетки и настройка загрузчика'
echo ${P}
useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video -s /bin/zsh latunix
cp -v /etc/mkinitcpio.conf ${B}
cp -v mkinitcpio.conf /etc/
mkinitcpio -p linux-pf
cp -v /etc/yaourtrc ${B}
cp -v yaourtrc /etc/
mkdir --mode=700 /etc/backup/default
cp -v /etc/default/grub /etc/backup/default/
cp -v default/grub /etc/default/
grub-install --recheck --no-floppy /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo
echo 'Прочие настройки'
cp -v /etc/sudoers ${B}
cp -v sudoers /etc/
cp -v /etc/sysctl.conf ${B}
cp -v sysctl.conf /etc/
cp -v /etc/makepkg.conf ${B}
cp -v makepkg.conf /etc/
cp -v /etc/fstab ${B}
cp -v fstab /etc/
cp -v zsh/ROOT /root/.zshrc
cp -v zsh/USER /home/latunix/.zshrc
echo
echo 'Окончательная настройка'
echo 'Пароль для рута'
passwd
echo 'Пароль для учетки'
passwd latunix
uptime
exit
