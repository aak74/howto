# Проблемы с IO

- [Linux JBD (Journaling Block Device)](https://remoteshaman.com/unix/common/jbd2-journaling-block-device)
- [Linux Wait IO Problem](https://www.chileoffshore.com/en/interesting-articles/126-linux-wait-io-problem)
- [Journaling block device](https://en.wikipedia.org/wiki/Journaling_block_device)

```sh
# Поиск процессов, которые в состоянии IO Wait
while true; do date; ps auxf | awk '{if($8=="D") print $0;}'; sleep 1; done

# Список процессов
while true; do ps auxf | grep D | grep -E "(jbd2\/sda\.*)"; sleep 1; done
```