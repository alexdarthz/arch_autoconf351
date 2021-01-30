# Этот скрипт полностью установят и настроят "ArchLinux".
# Этот скрипт включает в себе 36 строк кода, кроме комментариев.
P="Если долго,то ждите,тк. машина НИКОГДА не ошибается"
cd configs
loadkeys ru
setfont cyr-sun16
cp -v locale.gen /etc/
locale-gen
export LANG=ru_RU.UTF-8
echo 'Форматирование дисков'
echo ${P}
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
swapon /dev/sda2
echo 'Монтирование дисков'
mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home
echo
echo 'Установка "ArchLinux"'
echo ${P}
pacman -Sy --noconfirm --noprogressbar --quiet reflector
pacman -S --noconfirm --needed --noprogressbar --quiet reflector
reflector -l 3 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel
genfstab -p -L /mnt > /mnt/etc/fstab
echo
cd -
cp -R configs /mnt/
cp install-2.sh /mnt/
arch-chroot /mnt 
rm -R /mnt/configs
rm /mnt/install-2.sh
umount /dev/sda3
umount -l /dev/sda1
echo
echo 'Поздравляем, вы установили "ArchLinux"'
echo 'Теперь вам надо ввести 'reboot', чтобы перезагрузиться и не забудь вынуть диск"'
