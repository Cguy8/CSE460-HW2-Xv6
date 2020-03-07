
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 c0 2f 10 80       	mov    $0x80102fc0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 73 10 80       	push   $0x801073e0
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 85 45 00 00       	call   801045e0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
  bcache.head.prev = &bcache.head;
80100063:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	83 ec 08             	sub    $0x8,%esp
80100085:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 73 10 80       	push   $0x801073e7
80100097:	50                   	push   %eax
80100098:	e8 33 44 00 00       	call   801044d0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a2:	89 da                	mov    %ebx,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a4:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801000dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 f7 45 00 00       	call   801046e0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 99 46 00 00       	call   80104800 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 9e 43 00 00       	call   80104510 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 7f 20 00 00       	call   80102210 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 ee 73 10 80       	push   $0x801073ee
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 ed 43 00 00       	call   801045b0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 37 20 00 00       	jmp    80102210 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 ff 73 10 80       	push   $0x801073ff
801001e1:	e8 aa 01 00 00       	call   80100390 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 ac 43 00 00       	call   801045b0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 5c 43 00 00       	call   80104570 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010021b:	e8 c0 44 00 00       	call   801046e0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 8f 45 00 00       	jmp    80104800 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 06 74 10 80       	push   $0x80107406
80100279:	e8 12 01 00 00       	call   80100390 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100289:	ff 75 08             	pushl  0x8(%ebp)
{
8010028c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010028f:	e8 7c 15 00 00       	call   80101810 <iunlock>
  target = n;
  acquire(&cons.lock);
80100294:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010029b:	e8 40 44 00 00       	call   801046e0 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002a0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002a3:	83 c4 10             	add    $0x10,%esp
801002a6:	31 c0                	xor    %eax,%eax
    *dst++ = c;
801002a8:	01 f7                	add    %esi,%edi
  while(n > 0){
801002aa:	85 f6                	test   %esi,%esi
801002ac:	0f 8e a0 00 00 00    	jle    80100352 <consoleread+0xd2>
801002b2:	89 f3                	mov    %esi,%ebx
    while(input.r == input.w){
801002b4:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002ba:	39 15 a4 ff 10 80    	cmp    %edx,0x8010ffa4
801002c0:	74 29                	je     801002eb <consoleread+0x6b>
801002c2:	eb 5c                	jmp    80100320 <consoleread+0xa0>
801002c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sleep(&input.r, &cons.lock);
801002c8:	83 ec 08             	sub    $0x8,%esp
801002cb:	68 20 a5 10 80       	push   $0x8010a520
801002d0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002d5:	e8 16 3c 00 00       	call   80103ef0 <sleep>
    while(input.r == input.w){
801002da:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002e0:	83 c4 10             	add    $0x10,%esp
801002e3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002e9:	75 35                	jne    80100320 <consoleread+0xa0>
      if(myproc()->killed){
801002eb:	e8 20 36 00 00       	call   80103910 <myproc>
801002f0:	8b 48 24             	mov    0x24(%eax),%ecx
801002f3:	85 c9                	test   %ecx,%ecx
801002f5:	74 d1                	je     801002c8 <consoleread+0x48>
        release(&cons.lock);
801002f7:	83 ec 0c             	sub    $0xc,%esp
801002fa:	68 20 a5 10 80       	push   $0x8010a520
801002ff:	e8 fc 44 00 00       	call   80104800 <release>
        ilock(ip);
80100304:	5a                   	pop    %edx
80100305:	ff 75 08             	pushl  0x8(%ebp)
80100308:	e8 23 14 00 00       	call   80101730 <ilock>
        return -1;
8010030d:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100310:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100313:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100318:	5b                   	pop    %ebx
80100319:	5e                   	pop    %esi
8010031a:	5f                   	pop    %edi
8010031b:	5d                   	pop    %ebp
8010031c:	c3                   	ret    
8010031d:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100320:	8d 42 01             	lea    0x1(%edx),%eax
80100323:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100328:	89 d0                	mov    %edx,%eax
8010032a:	83 e0 7f             	and    $0x7f,%eax
8010032d:	0f be 80 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%eax
    if(c == C('D')){  // EOF
80100334:	83 f8 04             	cmp    $0x4,%eax
80100337:	74 46                	je     8010037f <consoleread+0xff>
    *dst++ = c;
80100339:	89 da                	mov    %ebx,%edx
    --n;
8010033b:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010033e:	f7 da                	neg    %edx
80100340:	88 04 17             	mov    %al,(%edi,%edx,1)
    if(c == '\n')
80100343:	83 f8 0a             	cmp    $0xa,%eax
80100346:	74 31                	je     80100379 <consoleread+0xf9>
  while(n > 0){
80100348:	85 db                	test   %ebx,%ebx
8010034a:	0f 85 64 ff ff ff    	jne    801002b4 <consoleread+0x34>
80100350:	89 f0                	mov    %esi,%eax
  release(&cons.lock);
80100352:	83 ec 0c             	sub    $0xc,%esp
80100355:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100358:	68 20 a5 10 80       	push   $0x8010a520
8010035d:	e8 9e 44 00 00       	call   80104800 <release>
  ilock(ip);
80100362:	58                   	pop    %eax
80100363:	ff 75 08             	pushl  0x8(%ebp)
80100366:	e8 c5 13 00 00       	call   80101730 <ilock>
  return target - n;
8010036b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010036e:	83 c4 10             	add    $0x10,%esp
}
80100371:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100374:	5b                   	pop    %ebx
80100375:	5e                   	pop    %esi
80100376:	5f                   	pop    %edi
80100377:	5d                   	pop    %ebp
80100378:	c3                   	ret    
80100379:	89 f0                	mov    %esi,%eax
8010037b:	29 d8                	sub    %ebx,%eax
8010037d:	eb d3                	jmp    80100352 <consoleread+0xd2>
      if(n < target){
8010037f:	89 f0                	mov    %esi,%eax
80100381:	29 d8                	sub    %ebx,%eax
80100383:	39 f3                	cmp    %esi,%ebx
80100385:	73 cb                	jae    80100352 <consoleread+0xd2>
        input.r--;
80100387:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
8010038d:	eb c3                	jmp    80100352 <consoleread+0xd2>
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 92 24 00 00       	call   80102840 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 0d 74 10 80       	push   $0x8010740d
801003b7:	e8 f4 02 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 eb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 5b 7e 10 80 	movl   $0x80107e5b,(%esp)
801003cc:	e8 df 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	8d 45 08             	lea    0x8(%ebp),%eax
801003d4:	5a                   	pop    %edx
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 23 42 00 00       	call   80104600 <getcallerpcs>
  for(i=0; i<10; i++)
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 21 74 10 80       	push   $0x80107421
801003ed:	e8 be 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
    ;
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010040c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100410 <consputc.part.0>:
consputc(int c)
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 ea 00 00 00    	je     80100510 <consputc.part.0+0x100>
    uartputc(c);
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 d1 5b 00 00       	call   80106000 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100444:	89 ca                	mov    %ecx,%edx
80100446:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100447:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c6                	mov    %eax,%esi
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100457:	89 ca                	mov    %ecx,%edx
80100459:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010045f:	83 fb 0a             	cmp    $0xa,%ebx
80100462:	0f 84 90 00 00 00    	je     801004f8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100468:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046e:	74 70                	je     801004e0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100470:	0f b6 db             	movzbl %bl,%ebx
80100473:	8d 70 01             	lea    0x1(%eax),%esi
80100476:	80 cf 07             	or     $0x7,%bh
80100479:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100480:	80 
  if(pos < 0 || pos > 25*80)
80100481:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100487:	0f 8f f9 00 00 00    	jg     80100586 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010048d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100493:	0f 8f a7 00 00 00    	jg     80100540 <consputc.part.0+0x130>
80100499:	89 f0                	mov    %esi,%eax
8010049b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
801004a2:	88 45 e7             	mov    %al,-0x19(%ebp)
801004a5:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004a8:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004ad:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004ba:	89 f8                	mov    %edi,%eax
801004bc:	89 ca                	mov    %ecx,%edx
801004be:	ee                   	out    %al,(%dx)
801004bf:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c4:	89 da                	mov    %ebx,%edx
801004c6:	ee                   	out    %al,(%dx)
801004c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004cb:	89 ca                	mov    %ecx,%edx
801004cd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004ce:	b8 20 07 00 00       	mov    $0x720,%eax
801004d3:	66 89 06             	mov    %ax,(%esi)
}
801004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d9:	5b                   	pop    %ebx
801004da:	5e                   	pop    %esi
801004db:	5f                   	pop    %edi
801004dc:	5d                   	pop    %ebp
801004dd:	c3                   	ret    
801004de:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004e0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004e3:	85 c0                	test   %eax,%eax
801004e5:	75 9a                	jne    80100481 <consputc.part.0+0x71>
801004e7:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004ec:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004f0:	31 ff                	xor    %edi,%edi
801004f2:	eb b4                	jmp    801004a8 <consputc.part.0+0x98>
801004f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004f8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004fd:	f7 e2                	mul    %edx
801004ff:	c1 ea 06             	shr    $0x6,%edx
80100502:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100505:	c1 e0 04             	shl    $0x4,%eax
80100508:	8d 70 50             	lea    0x50(%eax),%esi
8010050b:	e9 71 ff ff ff       	jmp    80100481 <consputc.part.0+0x71>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	6a 08                	push   $0x8
80100515:	e8 e6 5a 00 00       	call   80106000 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 da 5a 00 00       	call   80106000 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 ce 5a 00 00       	call   80106000 <uartputc>
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	e9 f8 fe ff ff       	jmp    80100432 <consputc.part.0+0x22>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010054b:	68 60 0e 00 00       	push   $0xe60
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100550:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 8a 43 00 00       	call   801048f0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 d5 42 00 00       	call   80104850 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 25 74 10 80       	push   $0x80107425
8010058e:	e8 fd fd ff ff       	call   80100390 <panic>
80100593:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010059a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801005a0 <printint>:
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	83 ec 2c             	sub    $0x2c,%esp
801005a9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
801005ac:	85 c9                	test   %ecx,%ecx
801005ae:	74 04                	je     801005b4 <printint+0x14>
801005b0:	85 c0                	test   %eax,%eax
801005b2:	78 68                	js     8010061c <printint+0x7c>
    x = xx;
801005b4:	89 c1                	mov    %eax,%ecx
801005b6:	31 f6                	xor    %esi,%esi
  i = 0;
801005b8:	31 db                	xor    %ebx,%ebx
801005ba:	eb 04                	jmp    801005c0 <printint+0x20>
  }while((x /= base) != 0);
801005bc:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
801005be:	89 fb                	mov    %edi,%ebx
801005c0:	89 c8                	mov    %ecx,%eax
801005c2:	31 d2                	xor    %edx,%edx
801005c4:	8d 7b 01             	lea    0x1(%ebx),%edi
801005c7:	f7 75 d4             	divl   -0x2c(%ebp)
801005ca:	0f b6 92 50 74 10 80 	movzbl -0x7fef8bb0(%edx),%edx
801005d1:	88 54 3d d7          	mov    %dl,-0x29(%ebp,%edi,1)
  }while((x /= base) != 0);
801005d5:	39 4d d4             	cmp    %ecx,-0x2c(%ebp)
801005d8:	76 e2                	jbe    801005bc <printint+0x1c>
  if(sign)
801005da:	85 f6                	test   %esi,%esi
801005dc:	75 32                	jne    80100610 <printint+0x70>
801005de:	0f be c2             	movsbl %dl,%eax
801005e1:	89 df                	mov    %ebx,%edi
  if(panicked){
801005e3:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801005e9:	85 c9                	test   %ecx,%ecx
801005eb:	75 20                	jne    8010060d <printint+0x6d>
801005ed:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005f1:	e8 1a fe ff ff       	call   80100410 <consputc.part.0>
  while(--i >= 0)
801005f6:	8d 45 d7             	lea    -0x29(%ebp),%eax
801005f9:	39 d8                	cmp    %ebx,%eax
801005fb:	74 27                	je     80100624 <printint+0x84>
  if(panicked){
801005fd:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
    consputc(buf[i]);
80100603:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
80100606:	83 eb 01             	sub    $0x1,%ebx
80100609:	85 d2                	test   %edx,%edx
8010060b:	74 e4                	je     801005f1 <printint+0x51>
  asm volatile("cli");
8010060d:	fa                   	cli    
      ;
8010060e:	eb fe                	jmp    8010060e <printint+0x6e>
    buf[i++] = '-';
80100610:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
80100615:	b8 2d 00 00 00       	mov    $0x2d,%eax
8010061a:	eb c7                	jmp    801005e3 <printint+0x43>
    x = -xx;
8010061c:	f7 d8                	neg    %eax
8010061e:	89 ce                	mov    %ecx,%esi
80100620:	89 c1                	mov    %eax,%ecx
80100622:	eb 94                	jmp    801005b8 <printint+0x18>
}
80100624:	83 c4 2c             	add    $0x2c,%esp
80100627:	5b                   	pop    %ebx
80100628:	5e                   	pop    %esi
80100629:	5f                   	pop    %edi
8010062a:	5d                   	pop    %ebp
8010062b:	c3                   	ret    
8010062c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100630 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100630:	55                   	push   %ebp
80100631:	89 e5                	mov    %esp,%ebp
80100633:	57                   	push   %edi
80100634:	56                   	push   %esi
80100635:	53                   	push   %ebx
80100636:	83 ec 18             	sub    $0x18,%esp
80100639:	8b 7d 10             	mov    0x10(%ebp),%edi
8010063c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int i;

  iunlock(ip);
8010063f:	ff 75 08             	pushl  0x8(%ebp)
80100642:	e8 c9 11 00 00       	call   80101810 <iunlock>
  acquire(&cons.lock);
80100647:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010064e:	e8 8d 40 00 00       	call   801046e0 <acquire>
  for(i = 0; i < n; i++)
80100653:	83 c4 10             	add    $0x10,%esp
80100656:	85 ff                	test   %edi,%edi
80100658:	7e 36                	jle    80100690 <consolewrite+0x60>
  if(panicked){
8010065a:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100660:	85 c9                	test   %ecx,%ecx
80100662:	75 21                	jne    80100685 <consolewrite+0x55>
    consputc(buf[i] & 0xff);
80100664:	0f b6 03             	movzbl (%ebx),%eax
80100667:	8d 73 01             	lea    0x1(%ebx),%esi
8010066a:	01 fb                	add    %edi,%ebx
8010066c:	e8 9f fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; i < n; i++)
80100671:	39 de                	cmp    %ebx,%esi
80100673:	74 1b                	je     80100690 <consolewrite+0x60>
  if(panicked){
80100675:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
    consputc(buf[i] & 0xff);
8010067b:	0f b6 06             	movzbl (%esi),%eax
  if(panicked){
8010067e:	83 c6 01             	add    $0x1,%esi
80100681:	85 d2                	test   %edx,%edx
80100683:	74 e7                	je     8010066c <consolewrite+0x3c>
80100685:	fa                   	cli    
      ;
80100686:	eb fe                	jmp    80100686 <consolewrite+0x56>
80100688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010068f:	90                   	nop
  release(&cons.lock);
80100690:	83 ec 0c             	sub    $0xc,%esp
80100693:	68 20 a5 10 80       	push   $0x8010a520
80100698:	e8 63 41 00 00       	call   80104800 <release>
  ilock(ip);
8010069d:	58                   	pop    %eax
8010069e:	ff 75 08             	pushl  0x8(%ebp)
801006a1:	e8 8a 10 00 00       	call   80101730 <ilock>

  return n;
}
801006a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006a9:	89 f8                	mov    %edi,%eax
801006ab:	5b                   	pop    %ebx
801006ac:	5e                   	pop    %esi
801006ad:	5f                   	pop    %edi
801006ae:	5d                   	pop    %ebp
801006af:	c3                   	ret    

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	a1 54 a5 10 80       	mov    0x8010a554,%eax
801006be:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006c1:	85 c0                	test   %eax,%eax
801006c3:	0f 85 df 00 00 00    	jne    801007a8 <cprintf+0xf8>
  if (fmt == 0)
801006c9:	8b 45 08             	mov    0x8(%ebp),%eax
801006cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006cf:	85 c0                	test   %eax,%eax
801006d1:	0f 84 5e 01 00 00    	je     80100835 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d7:	0f b6 00             	movzbl (%eax),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	74 32                	je     80100710 <cprintf+0x60>
  argp = (uint*)(void*)(&fmt + 1);
801006de:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e1:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	74 40                	je     80100728 <cprintf+0x78>
  if(panicked){
801006e8:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801006ee:	85 c9                	test   %ecx,%ecx
801006f0:	74 0b                	je     801006fd <cprintf+0x4d>
801006f2:	fa                   	cli    
      ;
801006f3:	eb fe                	jmp    801006f3 <cprintf+0x43>
801006f5:	8d 76 00             	lea    0x0(%esi),%esi
801006f8:	b8 25 00 00 00       	mov    $0x25,%eax
801006fd:	e8 0e fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100702:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100705:	83 c6 01             	add    $0x1,%esi
80100708:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
8010070c:	85 c0                	test   %eax,%eax
8010070e:	75 d3                	jne    801006e3 <cprintf+0x33>
  if(locking)
80100710:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100713:	85 db                	test   %ebx,%ebx
80100715:	0f 85 05 01 00 00    	jne    80100820 <cprintf+0x170>
}
8010071b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010071e:	5b                   	pop    %ebx
8010071f:	5e                   	pop    %esi
80100720:	5f                   	pop    %edi
80100721:	5d                   	pop    %ebp
80100722:	c3                   	ret    
80100723:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100727:	90                   	nop
    c = fmt[++i] & 0xff;
80100728:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010072b:	83 c6 01             	add    $0x1,%esi
8010072e:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
80100732:	85 ff                	test   %edi,%edi
80100734:	74 da                	je     80100710 <cprintf+0x60>
    switch(c){
80100736:	83 ff 70             	cmp    $0x70,%edi
80100739:	0f 84 7e 00 00 00    	je     801007bd <cprintf+0x10d>
8010073f:	7f 26                	jg     80100767 <cprintf+0xb7>
80100741:	83 ff 25             	cmp    $0x25,%edi
80100744:	0f 84 be 00 00 00    	je     80100808 <cprintf+0x158>
8010074a:	83 ff 64             	cmp    $0x64,%edi
8010074d:	75 46                	jne    80100795 <cprintf+0xe5>
      printint(*argp++, 10, 1);
8010074f:	8b 03                	mov    (%ebx),%eax
80100751:	8d 7b 04             	lea    0x4(%ebx),%edi
80100754:	b9 01 00 00 00       	mov    $0x1,%ecx
80100759:	ba 0a 00 00 00       	mov    $0xa,%edx
8010075e:	89 fb                	mov    %edi,%ebx
80100760:	e8 3b fe ff ff       	call   801005a0 <printint>
      break;
80100765:	eb 9b                	jmp    80100702 <cprintf+0x52>
    switch(c){
80100767:	83 ff 73             	cmp    $0x73,%edi
8010076a:	75 24                	jne    80100790 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
8010076c:	8d 7b 04             	lea    0x4(%ebx),%edi
8010076f:	8b 1b                	mov    (%ebx),%ebx
80100771:	85 db                	test   %ebx,%ebx
80100773:	75 68                	jne    801007dd <cprintf+0x12d>
80100775:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
8010077a:	bb 38 74 10 80       	mov    $0x80107438,%ebx
  if(panicked){
8010077f:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100785:	85 d2                	test   %edx,%edx
80100787:	74 4c                	je     801007d5 <cprintf+0x125>
80100789:	fa                   	cli    
      ;
8010078a:	eb fe                	jmp    8010078a <cprintf+0xda>
8010078c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100790:	83 ff 78             	cmp    $0x78,%edi
80100793:	74 28                	je     801007bd <cprintf+0x10d>
  if(panicked){
80100795:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
8010079b:	85 d2                	test   %edx,%edx
8010079d:	74 4c                	je     801007eb <cprintf+0x13b>
8010079f:	fa                   	cli    
      ;
801007a0:	eb fe                	jmp    801007a0 <cprintf+0xf0>
801007a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&cons.lock);
801007a8:	83 ec 0c             	sub    $0xc,%esp
801007ab:	68 20 a5 10 80       	push   $0x8010a520
801007b0:	e8 2b 3f 00 00       	call   801046e0 <acquire>
801007b5:	83 c4 10             	add    $0x10,%esp
801007b8:	e9 0c ff ff ff       	jmp    801006c9 <cprintf+0x19>
      printint(*argp++, 16, 0);
801007bd:	8b 03                	mov    (%ebx),%eax
801007bf:	8d 7b 04             	lea    0x4(%ebx),%edi
801007c2:	31 c9                	xor    %ecx,%ecx
801007c4:	ba 10 00 00 00       	mov    $0x10,%edx
801007c9:	89 fb                	mov    %edi,%ebx
801007cb:	e8 d0 fd ff ff       	call   801005a0 <printint>
      break;
801007d0:	e9 2d ff ff ff       	jmp    80100702 <cprintf+0x52>
801007d5:	e8 36 fc ff ff       	call   80100410 <consputc.part.0>
      for(; *s; s++)
801007da:	83 c3 01             	add    $0x1,%ebx
801007dd:	0f be 03             	movsbl (%ebx),%eax
801007e0:	84 c0                	test   %al,%al
801007e2:	75 9b                	jne    8010077f <cprintf+0xcf>
      if((s = (char*)*argp++) == 0)
801007e4:	89 fb                	mov    %edi,%ebx
801007e6:	e9 17 ff ff ff       	jmp    80100702 <cprintf+0x52>
801007eb:	b8 25 00 00 00       	mov    $0x25,%eax
801007f0:	e8 1b fc ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
801007f5:	a1 58 a5 10 80       	mov    0x8010a558,%eax
801007fa:	85 c0                	test   %eax,%eax
801007fc:	74 4a                	je     80100848 <cprintf+0x198>
801007fe:	fa                   	cli    
      ;
801007ff:	eb fe                	jmp    801007ff <cprintf+0x14f>
80100801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100808:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
8010080e:	85 c9                	test   %ecx,%ecx
80100810:	0f 84 e2 fe ff ff    	je     801006f8 <cprintf+0x48>
80100816:	fa                   	cli    
      ;
80100817:	eb fe                	jmp    80100817 <cprintf+0x167>
80100819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 20 a5 10 80       	push   $0x8010a520
80100828:	e8 d3 3f 00 00       	call   80104800 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 e6 fe ff ff       	jmp    8010071b <cprintf+0x6b>
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 3f 74 10 80       	push   $0x8010743f
8010083d:	e8 4e fb ff ff       	call   80100390 <panic>
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100848:	89 f8                	mov    %edi,%eax
8010084a:	e8 c1 fb ff ff       	call   80100410 <consputc.part.0>
8010084f:	e9 ae fe ff ff       	jmp    80100702 <cprintf+0x52>
80100854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010085b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010085f:	90                   	nop

80100860 <consoleintr>:
{
80100860:	55                   	push   %ebp
80100861:	89 e5                	mov    %esp,%ebp
80100863:	57                   	push   %edi
80100864:	56                   	push   %esi
  int c, doprocdump = 0;
80100865:	31 f6                	xor    %esi,%esi
{
80100867:	53                   	push   %ebx
80100868:	83 ec 18             	sub    $0x18,%esp
8010086b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010086e:	68 20 a5 10 80       	push   $0x8010a520
80100873:	e8 68 3e 00 00       	call   801046e0 <acquire>
  while((c = getc()) >= 0){
80100878:	83 c4 10             	add    $0x10,%esp
8010087b:	ff d7                	call   *%edi
8010087d:	89 c3                	mov    %eax,%ebx
8010087f:	85 c0                	test   %eax,%eax
80100881:	0f 88 38 01 00 00    	js     801009bf <consoleintr+0x15f>
    switch(c){
80100887:	83 fb 10             	cmp    $0x10,%ebx
8010088a:	0f 84 f0 00 00 00    	je     80100980 <consoleintr+0x120>
80100890:	0f 8e ba 00 00 00    	jle    80100950 <consoleintr+0xf0>
80100896:	83 fb 15             	cmp    $0x15,%ebx
80100899:	75 35                	jne    801008d0 <consoleintr+0x70>
      while(input.e != input.w &&
8010089b:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008a0:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
801008a6:	74 d3                	je     8010087b <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008a8:	83 e8 01             	sub    $0x1,%eax
801008ab:	89 c2                	mov    %eax,%edx
801008ad:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801008b0:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
801008b7:	74 c2                	je     8010087b <consoleintr+0x1b>
  if(panicked){
801008b9:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
        input.e--;
801008bf:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
801008c4:	85 d2                	test   %edx,%edx
801008c6:	0f 84 be 00 00 00    	je     8010098a <consoleintr+0x12a>
801008cc:	fa                   	cli    
      ;
801008cd:	eb fe                	jmp    801008cd <consoleintr+0x6d>
801008cf:	90                   	nop
    switch(c){
801008d0:	83 fb 7f             	cmp    $0x7f,%ebx
801008d3:	0f 84 7c 00 00 00    	je     80100955 <consoleintr+0xf5>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008d9:	85 db                	test   %ebx,%ebx
801008db:	74 9e                	je     8010087b <consoleintr+0x1b>
801008dd:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008e2:	89 c2                	mov    %eax,%edx
801008e4:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008ea:	83 fa 7f             	cmp    $0x7f,%edx
801008ed:	77 8c                	ja     8010087b <consoleintr+0x1b>
        c = (c == '\r') ? '\n' : c;
801008ef:	8d 48 01             	lea    0x1(%eax),%ecx
801008f2:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801008f8:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
801008fb:	89 0d a8 ff 10 80    	mov    %ecx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
80100901:	83 fb 0d             	cmp    $0xd,%ebx
80100904:	0f 84 d1 00 00 00    	je     801009db <consoleintr+0x17b>
        input.buf[input.e++ % INPUT_BUF] = c;
8010090a:	88 98 20 ff 10 80    	mov    %bl,-0x7fef00e0(%eax)
  if(panicked){
80100910:	85 d2                	test   %edx,%edx
80100912:	0f 85 ce 00 00 00    	jne    801009e6 <consoleintr+0x186>
80100918:	89 d8                	mov    %ebx,%eax
8010091a:	e8 f1 fa ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010091f:	83 fb 0a             	cmp    $0xa,%ebx
80100922:	0f 84 d2 00 00 00    	je     801009fa <consoleintr+0x19a>
80100928:	83 fb 04             	cmp    $0x4,%ebx
8010092b:	0f 84 c9 00 00 00    	je     801009fa <consoleintr+0x19a>
80100931:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
80100936:	83 e8 80             	sub    $0xffffff80,%eax
80100939:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
8010093f:	0f 85 36 ff ff ff    	jne    8010087b <consoleintr+0x1b>
80100945:	e9 b5 00 00 00       	jmp    801009ff <consoleintr+0x19f>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100950:	83 fb 08             	cmp    $0x8,%ebx
80100953:	75 84                	jne    801008d9 <consoleintr+0x79>
      if(input.e != input.w){
80100955:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010095a:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100960:	0f 84 15 ff ff ff    	je     8010087b <consoleintr+0x1b>
        input.e--;
80100966:	83 e8 01             	sub    $0x1,%eax
80100969:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
8010096e:	a1 58 a5 10 80       	mov    0x8010a558,%eax
80100973:	85 c0                	test   %eax,%eax
80100975:	74 39                	je     801009b0 <consoleintr+0x150>
80100977:	fa                   	cli    
      ;
80100978:	eb fe                	jmp    80100978 <consoleintr+0x118>
8010097a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      doprocdump = 1;
80100980:	be 01 00 00 00       	mov    $0x1,%esi
80100985:	e9 f1 fe ff ff       	jmp    8010087b <consoleintr+0x1b>
8010098a:	b8 00 01 00 00       	mov    $0x100,%eax
8010098f:	e8 7c fa ff ff       	call   80100410 <consputc.part.0>
      while(input.e != input.w &&
80100994:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100999:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010099f:	0f 85 03 ff ff ff    	jne    801008a8 <consoleintr+0x48>
801009a5:	e9 d1 fe ff ff       	jmp    8010087b <consoleintr+0x1b>
801009aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801009b0:	b8 00 01 00 00       	mov    $0x100,%eax
801009b5:	e8 56 fa ff ff       	call   80100410 <consputc.part.0>
801009ba:	e9 bc fe ff ff       	jmp    8010087b <consoleintr+0x1b>
  release(&cons.lock);
801009bf:	83 ec 0c             	sub    $0xc,%esp
801009c2:	68 20 a5 10 80       	push   $0x8010a520
801009c7:	e8 34 3e 00 00       	call   80104800 <release>
  if(doprocdump) {
801009cc:	83 c4 10             	add    $0x10,%esp
801009cf:	85 f6                	test   %esi,%esi
801009d1:	75 46                	jne    80100a19 <consoleintr+0x1b9>
}
801009d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009d6:	5b                   	pop    %ebx
801009d7:	5e                   	pop    %esi
801009d8:	5f                   	pop    %edi
801009d9:	5d                   	pop    %ebp
801009da:	c3                   	ret    
        input.buf[input.e++ % INPUT_BUF] = c;
801009db:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
  if(panicked){
801009e2:	85 d2                	test   %edx,%edx
801009e4:	74 0a                	je     801009f0 <consoleintr+0x190>
801009e6:	fa                   	cli    
      ;
801009e7:	eb fe                	jmp    801009e7 <consoleintr+0x187>
801009e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009f0:	b8 0a 00 00 00       	mov    $0xa,%eax
801009f5:	e8 16 fa ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009fa:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
          wakeup(&input.r);
801009ff:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a02:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100a07:	68 a0 ff 10 80       	push   $0x8010ffa0
80100a0c:	e8 9f 36 00 00       	call   801040b0 <wakeup>
80100a11:	83 c4 10             	add    $0x10,%esp
80100a14:	e9 62 fe ff ff       	jmp    8010087b <consoleintr+0x1b>
}
80100a19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a1c:	5b                   	pop    %ebx
80100a1d:	5e                   	pop    %esi
80100a1e:	5f                   	pop    %edi
80100a1f:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a20:	e9 6b 37 00 00       	jmp    80104190 <procdump>
80100a25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100a30 <consoleinit>:

void
consoleinit(void)
{
80100a30:	55                   	push   %ebp
80100a31:	89 e5                	mov    %esp,%ebp
80100a33:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a36:	68 48 74 10 80       	push   $0x80107448
80100a3b:	68 20 a5 10 80       	push   $0x8010a520
80100a40:	e8 9b 3b 00 00       	call   801045e0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a45:	58                   	pop    %eax
80100a46:	5a                   	pop    %edx
80100a47:	6a 00                	push   $0x0
80100a49:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a4b:	c7 05 6c 09 11 80 30 	movl   $0x80100630,0x8011096c
80100a52:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a55:	c7 05 68 09 11 80 80 	movl   $0x80100280,0x80110968
80100a5c:	02 10 80 
  cons.locking = 1;
80100a5f:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100a66:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a69:	e8 52 19 00 00       	call   801023c0 <ioapicenable>
}
80100a6e:	83 c4 10             	add    $0x10,%esp
80100a71:	c9                   	leave  
80100a72:	c3                   	ret    
80100a73:	66 90                	xchg   %ax,%ax
80100a75:	66 90                	xchg   %ax,%ax
80100a77:	66 90                	xchg   %ax,%ax
80100a79:	66 90                	xchg   %ax,%ax
80100a7b:	66 90                	xchg   %ax,%ax
80100a7d:	66 90                	xchg   %ax,%ax
80100a7f:	90                   	nop

80100a80 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a80:	55                   	push   %ebp
80100a81:	89 e5                	mov    %esp,%ebp
80100a83:	57                   	push   %edi
80100a84:	56                   	push   %esi
80100a85:	53                   	push   %ebx
80100a86:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a8c:	e8 7f 2e 00 00       	call   80103910 <myproc>
80100a91:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100a97:	e8 14 22 00 00       	call   80102cb0 <begin_op>

  if((ip = namei(path)) == 0){
80100a9c:	83 ec 0c             	sub    $0xc,%esp
80100a9f:	ff 75 08             	pushl  0x8(%ebp)
80100aa2:	e8 29 15 00 00       	call   80101fd0 <namei>
80100aa7:	83 c4 10             	add    $0x10,%esp
80100aaa:	85 c0                	test   %eax,%eax
80100aac:	0f 84 09 03 00 00    	je     80100dbb <exec+0x33b>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ab2:	83 ec 0c             	sub    $0xc,%esp
80100ab5:	89 c3                	mov    %eax,%ebx
80100ab7:	50                   	push   %eax
80100ab8:	e8 73 0c 00 00       	call   80101730 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100abd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100ac3:	6a 34                	push   $0x34
80100ac5:	6a 00                	push   $0x0
80100ac7:	50                   	push   %eax
80100ac8:	53                   	push   %ebx
80100ac9:	e8 42 0f 00 00       	call   80101a10 <readi>
80100ace:	83 c4 20             	add    $0x20,%esp
80100ad1:	83 f8 34             	cmp    $0x34,%eax
80100ad4:	74 22                	je     80100af8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ad6:	83 ec 0c             	sub    $0xc,%esp
80100ad9:	53                   	push   %ebx
80100ada:	e8 e1 0e 00 00       	call   801019c0 <iunlockput>
    end_op();
80100adf:	e8 3c 22 00 00       	call   80102d20 <end_op>
80100ae4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100ae7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100aec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100aef:	5b                   	pop    %ebx
80100af0:	5e                   	pop    %esi
80100af1:	5f                   	pop    %edi
80100af2:	5d                   	pop    %ebp
80100af3:	c3                   	ret    
80100af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100af8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100aff:	45 4c 46 
80100b02:	75 d2                	jne    80100ad6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b04:	e8 47 66 00 00       	call   80107150 <setupkvm>
80100b09:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b0f:	85 c0                	test   %eax,%eax
80100b11:	74 c3                	je     80100ad6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b13:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b1a:	00 
80100b1b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b21:	0f 84 b3 02 00 00    	je     80100dda <exec+0x35a>
  sz = 0;
80100b27:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b2e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b31:	31 ff                	xor    %edi,%edi
80100b33:	e9 8e 00 00 00       	jmp    80100bc6 <exec+0x146>
80100b38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b3f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100b40:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b47:	75 6c                	jne    80100bb5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b49:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b4f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b55:	0f 82 87 00 00 00    	jb     80100be2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b5b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b61:	72 7f                	jb     80100be2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b63:	83 ec 04             	sub    $0x4,%esp
80100b66:	50                   	push   %eax
80100b67:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b6d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b73:	e8 f8 63 00 00       	call   80106f70 <allocuvm>
80100b78:	83 c4 10             	add    $0x10,%esp
80100b7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b81:	85 c0                	test   %eax,%eax
80100b83:	74 5d                	je     80100be2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100b85:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b8b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b90:	75 50                	jne    80100be2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b92:	83 ec 0c             	sub    $0xc,%esp
80100b95:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b9b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100ba1:	53                   	push   %ebx
80100ba2:	50                   	push   %eax
80100ba3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba9:	e8 02 63 00 00       	call   80106eb0 <loaduvm>
80100bae:	83 c4 20             	add    $0x20,%esp
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	78 2d                	js     80100be2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bb5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bbc:	83 c7 01             	add    $0x1,%edi
80100bbf:	83 c6 20             	add    $0x20,%esi
80100bc2:	39 f8                	cmp    %edi,%eax
80100bc4:	7e 3a                	jle    80100c00 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bc6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bcc:	6a 20                	push   $0x20
80100bce:	56                   	push   %esi
80100bcf:	50                   	push   %eax
80100bd0:	53                   	push   %ebx
80100bd1:	e8 3a 0e 00 00       	call   80101a10 <readi>
80100bd6:	83 c4 10             	add    $0x10,%esp
80100bd9:	83 f8 20             	cmp    $0x20,%eax
80100bdc:	0f 84 5e ff ff ff    	je     80100b40 <exec+0xc0>
    freevm(pgdir);
80100be2:	83 ec 0c             	sub    $0xc,%esp
80100be5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100beb:	e8 e0 64 00 00       	call   801070d0 <freevm>
  if(ip){
80100bf0:	83 c4 10             	add    $0x10,%esp
80100bf3:	e9 de fe ff ff       	jmp    80100ad6 <exec+0x56>
80100bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100bff:	90                   	nop
80100c00:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c06:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c0c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c12:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c18:	83 ec 0c             	sub    $0xc,%esp
80100c1b:	53                   	push   %ebx
80100c1c:	e8 9f 0d 00 00       	call   801019c0 <iunlockput>
  end_op();
80100c21:	e8 fa 20 00 00       	call   80102d20 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c26:	83 c4 0c             	add    $0xc,%esp
80100c29:	56                   	push   %esi
80100c2a:	57                   	push   %edi
80100c2b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c31:	57                   	push   %edi
80100c32:	e8 39 63 00 00       	call   80106f70 <allocuvm>
80100c37:	83 c4 10             	add    $0x10,%esp
80100c3a:	89 c6                	mov    %eax,%esi
80100c3c:	85 c0                	test   %eax,%eax
80100c3e:	0f 84 94 00 00 00    	je     80100cd8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c44:	83 ec 08             	sub    $0x8,%esp
80100c47:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c4d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c4f:	50                   	push   %eax
80100c50:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c51:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c53:	e8 98 65 00 00       	call   801071f0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c58:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c5b:	83 c4 10             	add    $0x10,%esp
80100c5e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c64:	8b 00                	mov    (%eax),%eax
80100c66:	85 c0                	test   %eax,%eax
80100c68:	0f 84 8b 00 00 00    	je     80100cf9 <exec+0x279>
80100c6e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c74:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c7a:	eb 23                	jmp    80100c9f <exec+0x21f>
80100c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c80:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c83:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c8a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c8d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c93:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c96:	85 c0                	test   %eax,%eax
80100c98:	74 59                	je     80100cf3 <exec+0x273>
    if(argc >= MAXARG)
80100c9a:	83 ff 20             	cmp    $0x20,%edi
80100c9d:	74 39                	je     80100cd8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c9f:	83 ec 0c             	sub    $0xc,%esp
80100ca2:	50                   	push   %eax
80100ca3:	e8 a8 3d 00 00       	call   80104a50 <strlen>
80100ca8:	f7 d0                	not    %eax
80100caa:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cac:	58                   	pop    %eax
80100cad:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cb0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cb6:	e8 95 3d 00 00       	call   80104a50 <strlen>
80100cbb:	83 c0 01             	add    $0x1,%eax
80100cbe:	50                   	push   %eax
80100cbf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cc2:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cc5:	53                   	push   %ebx
80100cc6:	56                   	push   %esi
80100cc7:	e8 74 66 00 00       	call   80107340 <copyout>
80100ccc:	83 c4 20             	add    $0x20,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	79 ad                	jns    80100c80 <exec+0x200>
80100cd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cd7:	90                   	nop
    freevm(pgdir);
80100cd8:	83 ec 0c             	sub    $0xc,%esp
80100cdb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ce1:	e8 ea 63 00 00       	call   801070d0 <freevm>
80100ce6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cee:	e9 f9 fd ff ff       	jmp    80100aec <exec+0x6c>
80100cf3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cf9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d00:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d02:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d09:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d0d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d0f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d12:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d18:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d1a:	50                   	push   %eax
80100d1b:	52                   	push   %edx
80100d1c:	53                   	push   %ebx
80100d1d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d23:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d2a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d2d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d33:	e8 08 66 00 00       	call   80107340 <copyout>
80100d38:	83 c4 10             	add    $0x10,%esp
80100d3b:	85 c0                	test   %eax,%eax
80100d3d:	78 99                	js     80100cd8 <exec+0x258>
  for(last=s=path; *s; s++)
80100d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d42:	8b 55 08             	mov    0x8(%ebp),%edx
80100d45:	0f b6 00             	movzbl (%eax),%eax
80100d48:	84 c0                	test   %al,%al
80100d4a:	74 13                	je     80100d5f <exec+0x2df>
80100d4c:	89 d1                	mov    %edx,%ecx
80100d4e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80100d50:	83 c1 01             	add    $0x1,%ecx
80100d53:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d55:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80100d58:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d5b:	84 c0                	test   %al,%al
80100d5d:	75 f1                	jne    80100d50 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d5f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d65:	83 ec 04             	sub    $0x4,%esp
80100d68:	6a 10                	push   $0x10
80100d6a:	89 f8                	mov    %edi,%eax
80100d6c:	52                   	push   %edx
80100d6d:	83 c0 6c             	add    $0x6c,%eax
80100d70:	50                   	push   %eax
80100d71:	e8 9a 3c 00 00       	call   80104a10 <safestrcpy>
  curproc->pgdir = pgdir;
80100d76:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d7c:	89 f8                	mov    %edi,%eax
80100d7e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100d81:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100d83:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100d86:	89 c1                	mov    %eax,%ecx
80100d88:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d8e:	8b 40 18             	mov    0x18(%eax),%eax
80100d91:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d94:	8b 41 18             	mov    0x18(%ecx),%eax
80100d97:	89 58 44             	mov    %ebx,0x44(%eax)
  curproc->priority = 2;	 // Added statement at line 102
80100d9a:	c7 41 7c 02 00 00 00 	movl   $0x2,0x7c(%ecx)
  switchuvm(curproc);
80100da1:	89 0c 24             	mov    %ecx,(%esp)
80100da4:	e8 77 5f 00 00       	call   80106d20 <switchuvm>
  freevm(oldpgdir);
80100da9:	89 3c 24             	mov    %edi,(%esp)
80100dac:	e8 1f 63 00 00       	call   801070d0 <freevm>
  return 0;
80100db1:	83 c4 10             	add    $0x10,%esp
80100db4:	31 c0                	xor    %eax,%eax
80100db6:	e9 31 fd ff ff       	jmp    80100aec <exec+0x6c>
    end_op();
80100dbb:	e8 60 1f 00 00       	call   80102d20 <end_op>
    cprintf("exec: fail\n");
80100dc0:	83 ec 0c             	sub    $0xc,%esp
80100dc3:	68 61 74 10 80       	push   $0x80107461
80100dc8:	e8 e3 f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100dcd:	83 c4 10             	add    $0x10,%esp
80100dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dd5:	e9 12 fd ff ff       	jmp    80100aec <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dda:	31 ff                	xor    %edi,%edi
80100ddc:	be 00 20 00 00       	mov    $0x2000,%esi
80100de1:	e9 32 fe ff ff       	jmp    80100c18 <exec+0x198>
80100de6:	66 90                	xchg   %ax,%ax
80100de8:	66 90                	xchg   %ax,%ax
80100dea:	66 90                	xchg   %ax,%ax
80100dec:	66 90                	xchg   %ax,%ax
80100dee:	66 90                	xchg   %ax,%ax

80100df0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100df6:	68 6d 74 10 80       	push   $0x8010746d
80100dfb:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e00:	e8 db 37 00 00       	call   801045e0 <initlock>
}
80100e05:	83 c4 10             	add    $0x10,%esp
80100e08:	c9                   	leave  
80100e09:	c3                   	ret    
80100e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e10 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e14:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100e19:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e1c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e21:	e8 ba 38 00 00       	call   801046e0 <acquire>
80100e26:	83 c4 10             	add    $0x10,%esp
80100e29:	eb 10                	jmp    80100e3b <filealloc+0x2b>
80100e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e2f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e30:	83 c3 18             	add    $0x18,%ebx
80100e33:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e39:	74 25                	je     80100e60 <filealloc+0x50>
    if(f->ref == 0){
80100e3b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e3e:	85 c0                	test   %eax,%eax
80100e40:	75 ee                	jne    80100e30 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e42:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e45:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e4c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e51:	e8 aa 39 00 00       	call   80104800 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e56:	89 d8                	mov    %ebx,%eax
      return f;
80100e58:	83 c4 10             	add    $0x10,%esp
}
80100e5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e5e:	c9                   	leave  
80100e5f:	c3                   	ret    
  release(&ftable.lock);
80100e60:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e63:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e65:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e6a:	e8 91 39 00 00       	call   80104800 <release>
}
80100e6f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e71:	83 c4 10             	add    $0x10,%esp
}
80100e74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e77:	c9                   	leave  
80100e78:	c3                   	ret    
80100e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e80 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e80:	55                   	push   %ebp
80100e81:	89 e5                	mov    %esp,%ebp
80100e83:	53                   	push   %ebx
80100e84:	83 ec 10             	sub    $0x10,%esp
80100e87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e8a:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e8f:	e8 4c 38 00 00       	call   801046e0 <acquire>
  if(f->ref < 1)
80100e94:	8b 43 04             	mov    0x4(%ebx),%eax
80100e97:	83 c4 10             	add    $0x10,%esp
80100e9a:	85 c0                	test   %eax,%eax
80100e9c:	7e 1a                	jle    80100eb8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e9e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ea1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ea4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ea7:	68 c0 ff 10 80       	push   $0x8010ffc0
80100eac:	e8 4f 39 00 00       	call   80104800 <release>
  return f;
}
80100eb1:	89 d8                	mov    %ebx,%eax
80100eb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eb6:	c9                   	leave  
80100eb7:	c3                   	ret    
    panic("filedup");
80100eb8:	83 ec 0c             	sub    $0xc,%esp
80100ebb:	68 74 74 10 80       	push   $0x80107474
80100ec0:	e8 cb f4 ff ff       	call   80100390 <panic>
80100ec5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ed0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ed0:	55                   	push   %ebp
80100ed1:	89 e5                	mov    %esp,%ebp
80100ed3:	57                   	push   %edi
80100ed4:	56                   	push   %esi
80100ed5:	53                   	push   %ebx
80100ed6:	83 ec 28             	sub    $0x28,%esp
80100ed9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100edc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ee1:	e8 fa 37 00 00       	call   801046e0 <acquire>
  if(f->ref < 1)
80100ee6:	8b 43 04             	mov    0x4(%ebx),%eax
80100ee9:	83 c4 10             	add    $0x10,%esp
80100eec:	85 c0                	test   %eax,%eax
80100eee:	0f 8e a3 00 00 00    	jle    80100f97 <fileclose+0xc7>
    panic("fileclose");
  if(--f->ref > 0){
80100ef4:	83 e8 01             	sub    $0x1,%eax
80100ef7:	89 43 04             	mov    %eax,0x4(%ebx)
80100efa:	75 44                	jne    80100f40 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100efc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f00:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f03:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f05:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f0b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f0e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f11:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f14:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100f19:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f1c:	e8 df 38 00 00       	call   80104800 <release>

  if(ff.type == FD_PIPE)
80100f21:	83 c4 10             	add    $0x10,%esp
80100f24:	83 ff 01             	cmp    $0x1,%edi
80100f27:	74 2f                	je     80100f58 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f29:	83 ff 02             	cmp    $0x2,%edi
80100f2c:	74 4a                	je     80100f78 <fileclose+0xa8>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f31:	5b                   	pop    %ebx
80100f32:	5e                   	pop    %esi
80100f33:	5f                   	pop    %edi
80100f34:	5d                   	pop    %ebp
80100f35:	c3                   	ret    
80100f36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f3d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f40:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
}
80100f47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f4a:	5b                   	pop    %ebx
80100f4b:	5e                   	pop    %esi
80100f4c:	5f                   	pop    %edi
80100f4d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f4e:	e9 ad 38 00 00       	jmp    80104800 <release>
80100f53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f57:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80100f58:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f5c:	83 ec 08             	sub    $0x8,%esp
80100f5f:	53                   	push   %ebx
80100f60:	56                   	push   %esi
80100f61:	e8 fa 24 00 00       	call   80103460 <pipeclose>
80100f66:	83 c4 10             	add    $0x10,%esp
}
80100f69:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6c:	5b                   	pop    %ebx
80100f6d:	5e                   	pop    %esi
80100f6e:	5f                   	pop    %edi
80100f6f:	5d                   	pop    %ebp
80100f70:	c3                   	ret    
80100f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f78:	e8 33 1d 00 00       	call   80102cb0 <begin_op>
    iput(ff.ip);
80100f7d:	83 ec 0c             	sub    $0xc,%esp
80100f80:	ff 75 e0             	pushl  -0x20(%ebp)
80100f83:	e8 d8 08 00 00       	call   80101860 <iput>
    end_op();
80100f88:	83 c4 10             	add    $0x10,%esp
}
80100f8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8e:	5b                   	pop    %ebx
80100f8f:	5e                   	pop    %esi
80100f90:	5f                   	pop    %edi
80100f91:	5d                   	pop    %ebp
    end_op();
80100f92:	e9 89 1d 00 00       	jmp    80102d20 <end_op>
    panic("fileclose");
80100f97:	83 ec 0c             	sub    $0xc,%esp
80100f9a:	68 7c 74 10 80       	push   $0x8010747c
80100f9f:	e8 ec f3 ff ff       	call   80100390 <panic>
80100fa4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100faf:	90                   	nop

80100fb0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fb0:	55                   	push   %ebp
80100fb1:	89 e5                	mov    %esp,%ebp
80100fb3:	53                   	push   %ebx
80100fb4:	83 ec 04             	sub    $0x4,%esp
80100fb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fba:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fbd:	75 31                	jne    80100ff0 <filestat+0x40>
    ilock(f->ip);
80100fbf:	83 ec 0c             	sub    $0xc,%esp
80100fc2:	ff 73 10             	pushl  0x10(%ebx)
80100fc5:	e8 66 07 00 00       	call   80101730 <ilock>
    stati(f->ip, st);
80100fca:	58                   	pop    %eax
80100fcb:	5a                   	pop    %edx
80100fcc:	ff 75 0c             	pushl  0xc(%ebp)
80100fcf:	ff 73 10             	pushl  0x10(%ebx)
80100fd2:	e8 09 0a 00 00       	call   801019e0 <stati>
    iunlock(f->ip);
80100fd7:	59                   	pop    %ecx
80100fd8:	ff 73 10             	pushl  0x10(%ebx)
80100fdb:	e8 30 08 00 00       	call   80101810 <iunlock>
    return 0;
80100fe0:	83 c4 10             	add    $0x10,%esp
80100fe3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100fe5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fe8:	c9                   	leave  
80100fe9:	c3                   	ret    
80100fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ff5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ff8:	c9                   	leave  
80100ff9:	c3                   	ret    
80100ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101000 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 0c             	sub    $0xc,%esp
80101009:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010100c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010100f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101012:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101016:	74 60                	je     80101078 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101018:	8b 03                	mov    (%ebx),%eax
8010101a:	83 f8 01             	cmp    $0x1,%eax
8010101d:	74 41                	je     80101060 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101f:	83 f8 02             	cmp    $0x2,%eax
80101022:	75 5b                	jne    8010107f <fileread+0x7f>
    ilock(f->ip);
80101024:	83 ec 0c             	sub    $0xc,%esp
80101027:	ff 73 10             	pushl  0x10(%ebx)
8010102a:	e8 01 07 00 00       	call   80101730 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010102f:	57                   	push   %edi
80101030:	ff 73 14             	pushl  0x14(%ebx)
80101033:	56                   	push   %esi
80101034:	ff 73 10             	pushl  0x10(%ebx)
80101037:	e8 d4 09 00 00       	call   80101a10 <readi>
8010103c:	83 c4 20             	add    $0x20,%esp
8010103f:	89 c6                	mov    %eax,%esi
80101041:	85 c0                	test   %eax,%eax
80101043:	7e 03                	jle    80101048 <fileread+0x48>
      f->off += r;
80101045:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101048:	83 ec 0c             	sub    $0xc,%esp
8010104b:	ff 73 10             	pushl  0x10(%ebx)
8010104e:	e8 bd 07 00 00       	call   80101810 <iunlock>
    return r;
80101053:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101056:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101059:	89 f0                	mov    %esi,%eax
8010105b:	5b                   	pop    %ebx
8010105c:	5e                   	pop    %esi
8010105d:	5f                   	pop    %edi
8010105e:	5d                   	pop    %ebp
8010105f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101060:	8b 43 0c             	mov    0xc(%ebx),%eax
80101063:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101066:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101069:	5b                   	pop    %ebx
8010106a:	5e                   	pop    %esi
8010106b:	5f                   	pop    %edi
8010106c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010106d:	e9 9e 25 00 00       	jmp    80103610 <piperead>
80101072:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101078:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010107d:	eb d7                	jmp    80101056 <fileread+0x56>
  panic("fileread");
8010107f:	83 ec 0c             	sub    $0xc,%esp
80101082:	68 86 74 10 80       	push   $0x80107486
80101087:	e8 04 f3 ff ff       	call   80100390 <panic>
8010108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101090 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101090:	55                   	push   %ebp
80101091:	89 e5                	mov    %esp,%ebp
80101093:	57                   	push   %edi
80101094:	56                   	push   %esi
80101095:	53                   	push   %ebx
80101096:	83 ec 1c             	sub    $0x1c,%esp
80101099:	8b 45 0c             	mov    0xc(%ebp),%eax
8010109c:	8b 75 08             	mov    0x8(%ebp),%esi
8010109f:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010a2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010a5:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801010a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010ac:	0f 84 bb 00 00 00    	je     8010116d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
801010b2:	8b 06                	mov    (%esi),%eax
801010b4:	83 f8 01             	cmp    $0x1,%eax
801010b7:	0f 84 bf 00 00 00    	je     8010117c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010bd:	83 f8 02             	cmp    $0x2,%eax
801010c0:	0f 85 c8 00 00 00    	jne    8010118e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010c9:	31 ff                	xor    %edi,%edi
    while(i < n){
801010cb:	85 c0                	test   %eax,%eax
801010cd:	7f 30                	jg     801010ff <filewrite+0x6f>
801010cf:	e9 94 00 00 00       	jmp    80101168 <filewrite+0xd8>
801010d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010d8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801010db:	83 ec 0c             	sub    $0xc,%esp
801010de:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801010e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801010e4:	e8 27 07 00 00       	call   80101810 <iunlock>
      end_op();
801010e9:	e8 32 1c 00 00       	call   80102d20 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801010ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010f1:	83 c4 10             	add    $0x10,%esp
801010f4:	39 c3                	cmp    %eax,%ebx
801010f6:	75 60                	jne    80101158 <filewrite+0xc8>
        panic("short filewrite");
      i += r;
801010f8:	01 df                	add    %ebx,%edi
    while(i < n){
801010fa:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010fd:	7e 69                	jle    80101168 <filewrite+0xd8>
      int n1 = n - i;
801010ff:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101102:	b8 00 06 00 00       	mov    $0x600,%eax
80101107:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101109:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
8010110f:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101112:	e8 99 1b 00 00       	call   80102cb0 <begin_op>
      ilock(f->ip);
80101117:	83 ec 0c             	sub    $0xc,%esp
8010111a:	ff 76 10             	pushl  0x10(%esi)
8010111d:	e8 0e 06 00 00       	call   80101730 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101122:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101125:	53                   	push   %ebx
80101126:	ff 76 14             	pushl  0x14(%esi)
80101129:	01 f8                	add    %edi,%eax
8010112b:	50                   	push   %eax
8010112c:	ff 76 10             	pushl  0x10(%esi)
8010112f:	e8 dc 09 00 00       	call   80101b10 <writei>
80101134:	83 c4 20             	add    $0x20,%esp
80101137:	85 c0                	test   %eax,%eax
80101139:	7f 9d                	jg     801010d8 <filewrite+0x48>
      iunlock(f->ip);
8010113b:	83 ec 0c             	sub    $0xc,%esp
8010113e:	ff 76 10             	pushl  0x10(%esi)
80101141:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101144:	e8 c7 06 00 00       	call   80101810 <iunlock>
      end_op();
80101149:	e8 d2 1b 00 00       	call   80102d20 <end_op>
      if(r < 0)
8010114e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101151:	83 c4 10             	add    $0x10,%esp
80101154:	85 c0                	test   %eax,%eax
80101156:	75 15                	jne    8010116d <filewrite+0xdd>
        panic("short filewrite");
80101158:	83 ec 0c             	sub    $0xc,%esp
8010115b:	68 8f 74 10 80       	push   $0x8010748f
80101160:	e8 2b f2 ff ff       	call   80100390 <panic>
80101165:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101168:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
8010116b:	74 05                	je     80101172 <filewrite+0xe2>
    return -1;
8010116d:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  }
  panic("filewrite");
}
80101172:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101175:	89 f8                	mov    %edi,%eax
80101177:	5b                   	pop    %ebx
80101178:	5e                   	pop    %esi
80101179:	5f                   	pop    %edi
8010117a:	5d                   	pop    %ebp
8010117b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010117c:	8b 46 0c             	mov    0xc(%esi),%eax
8010117f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101182:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101185:	5b                   	pop    %ebx
80101186:	5e                   	pop    %esi
80101187:	5f                   	pop    %edi
80101188:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101189:	e9 72 23 00 00       	jmp    80103500 <pipewrite>
  panic("filewrite");
8010118e:	83 ec 0c             	sub    $0xc,%esp
80101191:	68 95 74 10 80       	push   $0x80107495
80101196:	e8 f5 f1 ff ff       	call   80100390 <panic>
8010119b:	66 90                	xchg   %ax,%ax
8010119d:	66 90                	xchg   %ax,%ax
8010119f:	90                   	nop

801011a0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	57                   	push   %edi
801011a4:	56                   	push   %esi
801011a5:	53                   	push   %ebx
801011a6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011a9:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
801011af:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011b2:	85 c9                	test   %ecx,%ecx
801011b4:	0f 84 87 00 00 00    	je     80101241 <balloc+0xa1>
801011ba:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011c1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011c4:	83 ec 08             	sub    $0x8,%esp
801011c7:	89 f0                	mov    %esi,%eax
801011c9:	c1 f8 0c             	sar    $0xc,%eax
801011cc:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011d2:	50                   	push   %eax
801011d3:	ff 75 d8             	pushl  -0x28(%ebp)
801011d6:	e8 f5 ee ff ff       	call   801000d0 <bread>
801011db:	83 c4 10             	add    $0x10,%esp
801011de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011e1:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011e9:	31 c0                	xor    %eax,%eax
801011eb:	eb 2f                	jmp    8010121c <balloc+0x7c>
801011ed:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011f0:	89 c1                	mov    %eax,%ecx
801011f2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011fa:	83 e1 07             	and    $0x7,%ecx
801011fd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011ff:	89 c1                	mov    %eax,%ecx
80101201:	c1 f9 03             	sar    $0x3,%ecx
80101204:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101209:	89 fa                	mov    %edi,%edx
8010120b:	85 df                	test   %ebx,%edi
8010120d:	74 41                	je     80101250 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010120f:	83 c0 01             	add    $0x1,%eax
80101212:	83 c6 01             	add    $0x1,%esi
80101215:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010121a:	74 05                	je     80101221 <balloc+0x81>
8010121c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010121f:	77 cf                	ja     801011f0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101221:	83 ec 0c             	sub    $0xc,%esp
80101224:	ff 75 e4             	pushl  -0x1c(%ebp)
80101227:	e8 c4 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010122c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101233:	83 c4 10             	add    $0x10,%esp
80101236:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101239:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010123f:	77 80                	ja     801011c1 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101241:	83 ec 0c             	sub    $0xc,%esp
80101244:	68 9f 74 10 80       	push   $0x8010749f
80101249:	e8 42 f1 ff ff       	call   80100390 <panic>
8010124e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101250:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101253:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101256:	09 da                	or     %ebx,%edx
80101258:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010125c:	57                   	push   %edi
8010125d:	e8 2e 1c 00 00       	call   80102e90 <log_write>
        brelse(bp);
80101262:	89 3c 24             	mov    %edi,(%esp)
80101265:	e8 86 ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010126a:	58                   	pop    %eax
8010126b:	5a                   	pop    %edx
8010126c:	56                   	push   %esi
8010126d:	ff 75 d8             	pushl  -0x28(%ebp)
80101270:	e8 5b ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101275:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101278:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010127a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010127d:	68 00 02 00 00       	push   $0x200
80101282:	6a 00                	push   $0x0
80101284:	50                   	push   %eax
80101285:	e8 c6 35 00 00       	call   80104850 <memset>
  log_write(bp);
8010128a:	89 1c 24             	mov    %ebx,(%esp)
8010128d:	e8 fe 1b 00 00       	call   80102e90 <log_write>
  brelse(bp);
80101292:	89 1c 24             	mov    %ebx,(%esp)
80101295:	e8 56 ef ff ff       	call   801001f0 <brelse>
}
8010129a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010129d:	89 f0                	mov    %esi,%eax
8010129f:	5b                   	pop    %ebx
801012a0:	5e                   	pop    %esi
801012a1:	5f                   	pop    %edi
801012a2:	5d                   	pop    %ebp
801012a3:	c3                   	ret    
801012a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012af:	90                   	nop

801012b0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012b0:	55                   	push   %ebp
801012b1:	89 e5                	mov    %esp,%ebp
801012b3:	57                   	push   %edi
801012b4:	89 c7                	mov    %eax,%edi
801012b6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012b7:	31 f6                	xor    %esi,%esi
{
801012b9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ba:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
801012bf:	83 ec 28             	sub    $0x28,%esp
801012c2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012c5:	68 e0 09 11 80       	push   $0x801109e0
801012ca:	e8 11 34 00 00       	call   801046e0 <acquire>
801012cf:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012d5:	eb 1b                	jmp    801012f2 <iget+0x42>
801012d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012de:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012e0:	39 3b                	cmp    %edi,(%ebx)
801012e2:	74 6c                	je     80101350 <iget+0xa0>
801012e4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ea:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012f0:	73 26                	jae    80101318 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012f2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012f5:	85 c9                	test   %ecx,%ecx
801012f7:	7f e7                	jg     801012e0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012f9:	85 f6                	test   %esi,%esi
801012fb:	75 e7                	jne    801012e4 <iget+0x34>
801012fd:	8d 83 90 00 00 00    	lea    0x90(%ebx),%eax
80101303:	85 c9                	test   %ecx,%ecx
80101305:	75 70                	jne    80101377 <iget+0xc7>
80101307:	89 de                	mov    %ebx,%esi
80101309:	89 c3                	mov    %eax,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010130b:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101311:	72 df                	jb     801012f2 <iget+0x42>
80101313:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101317:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101318:	85 f6                	test   %esi,%esi
8010131a:	74 74                	je     80101390 <iget+0xe0>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010131c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010131f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101321:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101324:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010132b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101332:	68 e0 09 11 80       	push   $0x801109e0
80101337:	e8 c4 34 00 00       	call   80104800 <release>

  return ip;
8010133c:	83 c4 10             	add    $0x10,%esp
}
8010133f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101342:	89 f0                	mov    %esi,%eax
80101344:	5b                   	pop    %ebx
80101345:	5e                   	pop    %esi
80101346:	5f                   	pop    %edi
80101347:	5d                   	pop    %ebp
80101348:	c3                   	ret    
80101349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101350:	39 53 04             	cmp    %edx,0x4(%ebx)
80101353:	75 8f                	jne    801012e4 <iget+0x34>
      release(&icache.lock);
80101355:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101358:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010135b:	89 de                	mov    %ebx,%esi
      ip->ref++;
8010135d:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101360:	68 e0 09 11 80       	push   $0x801109e0
80101365:	e8 96 34 00 00       	call   80104800 <release>
      return ip;
8010136a:	83 c4 10             	add    $0x10,%esp
}
8010136d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101370:	89 f0                	mov    %esi,%eax
80101372:	5b                   	pop    %ebx
80101373:	5e                   	pop    %esi
80101374:	5f                   	pop    %edi
80101375:	5d                   	pop    %ebp
80101376:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101377:	3d 34 26 11 80       	cmp    $0x80112634,%eax
8010137c:	73 12                	jae    80101390 <iget+0xe0>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010137e:	8b 48 08             	mov    0x8(%eax),%ecx
80101381:	89 c3                	mov    %eax,%ebx
80101383:	85 c9                	test   %ecx,%ecx
80101385:	0f 8f 55 ff ff ff    	jg     801012e0 <iget+0x30>
8010138b:	e9 6d ff ff ff       	jmp    801012fd <iget+0x4d>
    panic("iget: no inodes");
80101390:	83 ec 0c             	sub    $0xc,%esp
80101393:	68 b5 74 10 80       	push   $0x801074b5
80101398:	e8 f3 ef ff ff       	call   80100390 <panic>
8010139d:	8d 76 00             	lea    0x0(%esi),%esi

801013a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	57                   	push   %edi
801013a4:	56                   	push   %esi
801013a5:	89 c6                	mov    %eax,%esi
801013a7:	53                   	push   %ebx
801013a8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013ab:	83 fa 0b             	cmp    $0xb,%edx
801013ae:	0f 86 84 00 00 00    	jbe    80101438 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801013b4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801013b7:	83 fb 7f             	cmp    $0x7f,%ebx
801013ba:	0f 87 98 00 00 00    	ja     80101458 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801013c0:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801013c6:	8b 00                	mov    (%eax),%eax
801013c8:	85 d2                	test   %edx,%edx
801013ca:	74 54                	je     80101420 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013cc:	83 ec 08             	sub    $0x8,%esp
801013cf:	52                   	push   %edx
801013d0:	50                   	push   %eax
801013d1:	e8 fa ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013d6:	83 c4 10             	add    $0x10,%esp
801013d9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
801013dd:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013df:	8b 1a                	mov    (%edx),%ebx
801013e1:	85 db                	test   %ebx,%ebx
801013e3:	74 1b                	je     80101400 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013e5:	83 ec 0c             	sub    $0xc,%esp
801013e8:	57                   	push   %edi
801013e9:	e8 02 ee ff ff       	call   801001f0 <brelse>
    return addr;
801013ee:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
801013f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013f4:	89 d8                	mov    %ebx,%eax
801013f6:	5b                   	pop    %ebx
801013f7:	5e                   	pop    %esi
801013f8:	5f                   	pop    %edi
801013f9:	5d                   	pop    %ebp
801013fa:	c3                   	ret    
801013fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801013ff:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101400:	8b 06                	mov    (%esi),%eax
80101402:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101405:	e8 96 fd ff ff       	call   801011a0 <balloc>
8010140a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010140d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101410:	89 c3                	mov    %eax,%ebx
80101412:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101414:	57                   	push   %edi
80101415:	e8 76 1a 00 00       	call   80102e90 <log_write>
8010141a:	83 c4 10             	add    $0x10,%esp
8010141d:	eb c6                	jmp    801013e5 <bmap+0x45>
8010141f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101420:	e8 7b fd ff ff       	call   801011a0 <balloc>
80101425:	89 c2                	mov    %eax,%edx
80101427:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010142d:	8b 06                	mov    (%esi),%eax
8010142f:	eb 9b                	jmp    801013cc <bmap+0x2c>
80101431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101438:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010143b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010143e:	85 db                	test   %ebx,%ebx
80101440:	75 af                	jne    801013f1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101442:	8b 00                	mov    (%eax),%eax
80101444:	e8 57 fd ff ff       	call   801011a0 <balloc>
80101449:	89 47 5c             	mov    %eax,0x5c(%edi)
8010144c:	89 c3                	mov    %eax,%ebx
}
8010144e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101451:	89 d8                	mov    %ebx,%eax
80101453:	5b                   	pop    %ebx
80101454:	5e                   	pop    %esi
80101455:	5f                   	pop    %edi
80101456:	5d                   	pop    %ebp
80101457:	c3                   	ret    
  panic("bmap: out of range");
80101458:	83 ec 0c             	sub    $0xc,%esp
8010145b:	68 c5 74 10 80       	push   $0x801074c5
80101460:	e8 2b ef ff ff       	call   80100390 <panic>
80101465:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010146c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101470 <readsb>:
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	56                   	push   %esi
80101474:	53                   	push   %ebx
80101475:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101478:	83 ec 08             	sub    $0x8,%esp
8010147b:	6a 01                	push   $0x1
8010147d:	ff 75 08             	pushl  0x8(%ebp)
80101480:	e8 4b ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101485:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101488:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010148a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010148d:	6a 1c                	push   $0x1c
8010148f:	50                   	push   %eax
80101490:	56                   	push   %esi
80101491:	e8 5a 34 00 00       	call   801048f0 <memmove>
  brelse(bp);
80101496:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101499:	83 c4 10             	add    $0x10,%esp
}
8010149c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010149f:	5b                   	pop    %ebx
801014a0:	5e                   	pop    %esi
801014a1:	5d                   	pop    %ebp
  brelse(bp);
801014a2:	e9 49 ed ff ff       	jmp    801001f0 <brelse>
801014a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014ae:	66 90                	xchg   %ax,%ax

801014b0 <bfree>:
{
801014b0:	55                   	push   %ebp
801014b1:	89 e5                	mov    %esp,%ebp
801014b3:	56                   	push   %esi
801014b4:	89 c6                	mov    %eax,%esi
801014b6:	53                   	push   %ebx
801014b7:	89 d3                	mov    %edx,%ebx
  readsb(dev, &sb);
801014b9:	83 ec 08             	sub    $0x8,%esp
801014bc:	68 c0 09 11 80       	push   $0x801109c0
801014c1:	50                   	push   %eax
801014c2:	e8 a9 ff ff ff       	call   80101470 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014c7:	58                   	pop    %eax
801014c8:	5a                   	pop    %edx
801014c9:	89 da                	mov    %ebx,%edx
801014cb:	c1 ea 0c             	shr    $0xc,%edx
801014ce:	03 15 d8 09 11 80    	add    0x801109d8,%edx
801014d4:	52                   	push   %edx
801014d5:	56                   	push   %esi
801014d6:	e8 f5 eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014db:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014dd:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801014e0:	ba 01 00 00 00       	mov    $0x1,%edx
801014e5:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801014e8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801014ee:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801014f1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801014f3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801014f8:	85 d1                	test   %edx,%ecx
801014fa:	74 25                	je     80101521 <bfree+0x71>
  bp->data[bi/8] &= ~m;
801014fc:	f7 d2                	not    %edx
801014fe:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101500:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101503:	21 ca                	and    %ecx,%edx
80101505:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101509:	56                   	push   %esi
8010150a:	e8 81 19 00 00       	call   80102e90 <log_write>
  brelse(bp);
8010150f:	89 34 24             	mov    %esi,(%esp)
80101512:	e8 d9 ec ff ff       	call   801001f0 <brelse>
}
80101517:	83 c4 10             	add    $0x10,%esp
8010151a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010151d:	5b                   	pop    %ebx
8010151e:	5e                   	pop    %esi
8010151f:	5d                   	pop    %ebp
80101520:	c3                   	ret    
    panic("freeing free block");
80101521:	83 ec 0c             	sub    $0xc,%esp
80101524:	68 d8 74 10 80       	push   $0x801074d8
80101529:	e8 62 ee ff ff       	call   80100390 <panic>
8010152e:	66 90                	xchg   %ax,%ax

80101530 <iinit>:
{
80101530:	55                   	push   %ebp
80101531:	89 e5                	mov    %esp,%ebp
80101533:	53                   	push   %ebx
80101534:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101539:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010153c:	68 eb 74 10 80       	push   $0x801074eb
80101541:	68 e0 09 11 80       	push   $0x801109e0
80101546:	e8 95 30 00 00       	call   801045e0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010154b:	83 c4 10             	add    $0x10,%esp
8010154e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101550:	83 ec 08             	sub    $0x8,%esp
80101553:	68 f2 74 10 80       	push   $0x801074f2
80101558:	53                   	push   %ebx
80101559:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010155f:	e8 6c 2f 00 00       	call   801044d0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101564:	83 c4 10             	add    $0x10,%esp
80101567:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010156d:	75 e1                	jne    80101550 <iinit+0x20>
  readsb(dev, &sb);
8010156f:	83 ec 08             	sub    $0x8,%esp
80101572:	68 c0 09 11 80       	push   $0x801109c0
80101577:	ff 75 08             	pushl  0x8(%ebp)
8010157a:	e8 f1 fe ff ff       	call   80101470 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010157f:	ff 35 d8 09 11 80    	pushl  0x801109d8
80101585:	ff 35 d4 09 11 80    	pushl  0x801109d4
8010158b:	ff 35 d0 09 11 80    	pushl  0x801109d0
80101591:	ff 35 cc 09 11 80    	pushl  0x801109cc
80101597:	ff 35 c8 09 11 80    	pushl  0x801109c8
8010159d:	ff 35 c4 09 11 80    	pushl  0x801109c4
801015a3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801015a9:	68 58 75 10 80       	push   $0x80107558
801015ae:	e8 fd f0 ff ff       	call   801006b0 <cprintf>
}
801015b3:	83 c4 30             	add    $0x30,%esp
801015b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015b9:	c9                   	leave  
801015ba:	c3                   	ret    
801015bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015bf:	90                   	nop

801015c0 <ialloc>:
{
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	57                   	push   %edi
801015c4:	56                   	push   %esi
801015c5:	53                   	push   %ebx
801015c6:	83 ec 1c             	sub    $0x1c,%esp
801015c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801015cc:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
801015d3:	8b 75 08             	mov    0x8(%ebp),%esi
801015d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015d9:	0f 86 91 00 00 00    	jbe    80101670 <ialloc+0xb0>
801015df:	bb 01 00 00 00       	mov    $0x1,%ebx
801015e4:	eb 21                	jmp    80101607 <ialloc+0x47>
801015e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015ed:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
801015f0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015f3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
801015f6:	57                   	push   %edi
801015f7:	e8 f4 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801015fc:	83 c4 10             	add    $0x10,%esp
801015ff:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
80101605:	73 69                	jae    80101670 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101607:	89 d8                	mov    %ebx,%eax
80101609:	83 ec 08             	sub    $0x8,%esp
8010160c:	c1 e8 03             	shr    $0x3,%eax
8010160f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101615:	50                   	push   %eax
80101616:	56                   	push   %esi
80101617:	e8 b4 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010161c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010161f:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
80101621:	89 d8                	mov    %ebx,%eax
80101623:	83 e0 07             	and    $0x7,%eax
80101626:	c1 e0 06             	shl    $0x6,%eax
80101629:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010162d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101631:	75 bd                	jne    801015f0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101633:	83 ec 04             	sub    $0x4,%esp
80101636:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101639:	6a 40                	push   $0x40
8010163b:	6a 00                	push   $0x0
8010163d:	51                   	push   %ecx
8010163e:	e8 0d 32 00 00       	call   80104850 <memset>
      dip->type = type;
80101643:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101647:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010164a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010164d:	89 3c 24             	mov    %edi,(%esp)
80101650:	e8 3b 18 00 00       	call   80102e90 <log_write>
      brelse(bp);
80101655:	89 3c 24             	mov    %edi,(%esp)
80101658:	e8 93 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010165d:	83 c4 10             	add    $0x10,%esp
}
80101660:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101663:	89 da                	mov    %ebx,%edx
80101665:	89 f0                	mov    %esi,%eax
}
80101667:	5b                   	pop    %ebx
80101668:	5e                   	pop    %esi
80101669:	5f                   	pop    %edi
8010166a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010166b:	e9 40 fc ff ff       	jmp    801012b0 <iget>
  panic("ialloc: no inodes");
80101670:	83 ec 0c             	sub    $0xc,%esp
80101673:	68 f8 74 10 80       	push   $0x801074f8
80101678:	e8 13 ed ff ff       	call   80100390 <panic>
8010167d:	8d 76 00             	lea    0x0(%esi),%esi

80101680 <iupdate>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	56                   	push   %esi
80101684:	53                   	push   %ebx
80101685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101688:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010168b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010168e:	83 ec 08             	sub    $0x8,%esp
80101691:	c1 e8 03             	shr    $0x3,%eax
80101694:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010169a:	50                   	push   %eax
8010169b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010169e:	e8 2d ea ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801016a3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016a7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016aa:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016ac:	8b 43 a8             	mov    -0x58(%ebx),%eax
801016af:	83 e0 07             	and    $0x7,%eax
801016b2:	c1 e0 06             	shl    $0x6,%eax
801016b5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016b9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016bc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016c0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016c3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016c7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016cb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016cf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016d3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016d7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016da:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016dd:	6a 34                	push   $0x34
801016df:	53                   	push   %ebx
801016e0:	50                   	push   %eax
801016e1:	e8 0a 32 00 00       	call   801048f0 <memmove>
  log_write(bp);
801016e6:	89 34 24             	mov    %esi,(%esp)
801016e9:	e8 a2 17 00 00       	call   80102e90 <log_write>
  brelse(bp);
801016ee:	89 75 08             	mov    %esi,0x8(%ebp)
801016f1:	83 c4 10             	add    $0x10,%esp
}
801016f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016f7:	5b                   	pop    %ebx
801016f8:	5e                   	pop    %esi
801016f9:	5d                   	pop    %ebp
  brelse(bp);
801016fa:	e9 f1 ea ff ff       	jmp    801001f0 <brelse>
801016ff:	90                   	nop

80101700 <idup>:
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	53                   	push   %ebx
80101704:	83 ec 10             	sub    $0x10,%esp
80101707:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010170a:	68 e0 09 11 80       	push   $0x801109e0
8010170f:	e8 cc 2f 00 00       	call   801046e0 <acquire>
  ip->ref++;
80101714:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101718:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010171f:	e8 dc 30 00 00       	call   80104800 <release>
}
80101724:	89 d8                	mov    %ebx,%eax
80101726:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101729:	c9                   	leave  
8010172a:	c3                   	ret    
8010172b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010172f:	90                   	nop

80101730 <ilock>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	56                   	push   %esi
80101734:	53                   	push   %ebx
80101735:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101738:	85 db                	test   %ebx,%ebx
8010173a:	0f 84 b7 00 00 00    	je     801017f7 <ilock+0xc7>
80101740:	8b 53 08             	mov    0x8(%ebx),%edx
80101743:	85 d2                	test   %edx,%edx
80101745:	0f 8e ac 00 00 00    	jle    801017f7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010174b:	83 ec 0c             	sub    $0xc,%esp
8010174e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101751:	50                   	push   %eax
80101752:	e8 b9 2d 00 00       	call   80104510 <acquiresleep>
  if(ip->valid == 0){
80101757:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010175a:	83 c4 10             	add    $0x10,%esp
8010175d:	85 c0                	test   %eax,%eax
8010175f:	74 0f                	je     80101770 <ilock+0x40>
}
80101761:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101764:	5b                   	pop    %ebx
80101765:	5e                   	pop    %esi
80101766:	5d                   	pop    %ebp
80101767:	c3                   	ret    
80101768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010176f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101770:	8b 43 04             	mov    0x4(%ebx),%eax
80101773:	83 ec 08             	sub    $0x8,%esp
80101776:	c1 e8 03             	shr    $0x3,%eax
80101779:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010177f:	50                   	push   %eax
80101780:	ff 33                	pushl  (%ebx)
80101782:	e8 49 e9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101787:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010178a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010178c:	8b 43 04             	mov    0x4(%ebx),%eax
8010178f:	83 e0 07             	and    $0x7,%eax
80101792:	c1 e0 06             	shl    $0x6,%eax
80101795:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101799:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010179c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010179f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017a3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017a7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017ab:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017af:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017b3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017b7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017bb:	8b 50 fc             	mov    -0x4(%eax),%edx
801017be:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017c1:	6a 34                	push   $0x34
801017c3:	50                   	push   %eax
801017c4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017c7:	50                   	push   %eax
801017c8:	e8 23 31 00 00       	call   801048f0 <memmove>
    brelse(bp);
801017cd:	89 34 24             	mov    %esi,(%esp)
801017d0:	e8 1b ea ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
801017d5:	83 c4 10             	add    $0x10,%esp
801017d8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017dd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017e4:	0f 85 77 ff ff ff    	jne    80101761 <ilock+0x31>
      panic("ilock: no type");
801017ea:	83 ec 0c             	sub    $0xc,%esp
801017ed:	68 10 75 10 80       	push   $0x80107510
801017f2:	e8 99 eb ff ff       	call   80100390 <panic>
    panic("ilock");
801017f7:	83 ec 0c             	sub    $0xc,%esp
801017fa:	68 0a 75 10 80       	push   $0x8010750a
801017ff:	e8 8c eb ff ff       	call   80100390 <panic>
80101804:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010180b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010180f:	90                   	nop

80101810 <iunlock>:
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	56                   	push   %esi
80101814:	53                   	push   %ebx
80101815:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101818:	85 db                	test   %ebx,%ebx
8010181a:	74 28                	je     80101844 <iunlock+0x34>
8010181c:	83 ec 0c             	sub    $0xc,%esp
8010181f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101822:	56                   	push   %esi
80101823:	e8 88 2d 00 00       	call   801045b0 <holdingsleep>
80101828:	83 c4 10             	add    $0x10,%esp
8010182b:	85 c0                	test   %eax,%eax
8010182d:	74 15                	je     80101844 <iunlock+0x34>
8010182f:	8b 43 08             	mov    0x8(%ebx),%eax
80101832:	85 c0                	test   %eax,%eax
80101834:	7e 0e                	jle    80101844 <iunlock+0x34>
  releasesleep(&ip->lock);
80101836:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101839:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010183c:	5b                   	pop    %ebx
8010183d:	5e                   	pop    %esi
8010183e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010183f:	e9 2c 2d 00 00       	jmp    80104570 <releasesleep>
    panic("iunlock");
80101844:	83 ec 0c             	sub    $0xc,%esp
80101847:	68 1f 75 10 80       	push   $0x8010751f
8010184c:	e8 3f eb ff ff       	call   80100390 <panic>
80101851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010185f:	90                   	nop

80101860 <iput>:
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	57                   	push   %edi
80101864:	56                   	push   %esi
80101865:	53                   	push   %ebx
80101866:	83 ec 28             	sub    $0x28,%esp
80101869:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010186c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010186f:	57                   	push   %edi
80101870:	e8 9b 2c 00 00       	call   80104510 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101875:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101878:	83 c4 10             	add    $0x10,%esp
8010187b:	85 d2                	test   %edx,%edx
8010187d:	74 07                	je     80101886 <iput+0x26>
8010187f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101884:	74 32                	je     801018b8 <iput+0x58>
  releasesleep(&ip->lock);
80101886:	83 ec 0c             	sub    $0xc,%esp
80101889:	57                   	push   %edi
8010188a:	e8 e1 2c 00 00       	call   80104570 <releasesleep>
  acquire(&icache.lock);
8010188f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101896:	e8 45 2e 00 00       	call   801046e0 <acquire>
  ip->ref--;
8010189b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010189f:	83 c4 10             	add    $0x10,%esp
801018a2:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801018a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018ac:	5b                   	pop    %ebx
801018ad:	5e                   	pop    %esi
801018ae:	5f                   	pop    %edi
801018af:	5d                   	pop    %ebp
  release(&icache.lock);
801018b0:	e9 4b 2f 00 00       	jmp    80104800 <release>
801018b5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018b8:	83 ec 0c             	sub    $0xc,%esp
801018bb:	68 e0 09 11 80       	push   $0x801109e0
801018c0:	e8 1b 2e 00 00       	call   801046e0 <acquire>
    int r = ip->ref;
801018c5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018c8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018cf:	e8 2c 2f 00 00       	call   80104800 <release>
    if(r == 1){
801018d4:	83 c4 10             	add    $0x10,%esp
801018d7:	83 fe 01             	cmp    $0x1,%esi
801018da:	75 aa                	jne    80101886 <iput+0x26>
801018dc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801018e2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018e5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018e8:	89 cf                	mov    %ecx,%edi
801018ea:	eb 0b                	jmp    801018f7 <iput+0x97>
801018ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018f0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018f3:	39 fe                	cmp    %edi,%esi
801018f5:	74 19                	je     80101910 <iput+0xb0>
    if(ip->addrs[i]){
801018f7:	8b 16                	mov    (%esi),%edx
801018f9:	85 d2                	test   %edx,%edx
801018fb:	74 f3                	je     801018f0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801018fd:	8b 03                	mov    (%ebx),%eax
801018ff:	e8 ac fb ff ff       	call   801014b0 <bfree>
      ip->addrs[i] = 0;
80101904:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010190a:	eb e4                	jmp    801018f0 <iput+0x90>
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101910:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101916:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101919:	85 c0                	test   %eax,%eax
8010191b:	75 33                	jne    80101950 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010191d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101920:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101927:	53                   	push   %ebx
80101928:	e8 53 fd ff ff       	call   80101680 <iupdate>
      ip->type = 0;
8010192d:	31 c0                	xor    %eax,%eax
8010192f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101933:	89 1c 24             	mov    %ebx,(%esp)
80101936:	e8 45 fd ff ff       	call   80101680 <iupdate>
      ip->valid = 0;
8010193b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101942:	83 c4 10             	add    $0x10,%esp
80101945:	e9 3c ff ff ff       	jmp    80101886 <iput+0x26>
8010194a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101950:	83 ec 08             	sub    $0x8,%esp
80101953:	50                   	push   %eax
80101954:	ff 33                	pushl  (%ebx)
80101956:	e8 75 e7 ff ff       	call   801000d0 <bread>
8010195b:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010195e:	83 c4 10             	add    $0x10,%esp
80101961:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101967:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
8010196a:	8d 70 5c             	lea    0x5c(%eax),%esi
8010196d:	89 cf                	mov    %ecx,%edi
8010196f:	eb 0e                	jmp    8010197f <iput+0x11f>
80101971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101978:	83 c6 04             	add    $0x4,%esi
8010197b:	39 f7                	cmp    %esi,%edi
8010197d:	74 11                	je     80101990 <iput+0x130>
      if(a[j])
8010197f:	8b 16                	mov    (%esi),%edx
80101981:	85 d2                	test   %edx,%edx
80101983:	74 f3                	je     80101978 <iput+0x118>
        bfree(ip->dev, a[j]);
80101985:	8b 03                	mov    (%ebx),%eax
80101987:	e8 24 fb ff ff       	call   801014b0 <bfree>
8010198c:	eb ea                	jmp    80101978 <iput+0x118>
8010198e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101990:	83 ec 0c             	sub    $0xc,%esp
80101993:	ff 75 e4             	pushl  -0x1c(%ebp)
80101996:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101999:	e8 52 e8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010199e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019a4:	8b 03                	mov    (%ebx),%eax
801019a6:	e8 05 fb ff ff       	call   801014b0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019ab:	83 c4 10             	add    $0x10,%esp
801019ae:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019b5:	00 00 00 
801019b8:	e9 60 ff ff ff       	jmp    8010191d <iput+0xbd>
801019bd:	8d 76 00             	lea    0x0(%esi),%esi

801019c0 <iunlockput>:
{
801019c0:	55                   	push   %ebp
801019c1:	89 e5                	mov    %esp,%ebp
801019c3:	53                   	push   %ebx
801019c4:	83 ec 10             	sub    $0x10,%esp
801019c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019ca:	53                   	push   %ebx
801019cb:	e8 40 fe ff ff       	call   80101810 <iunlock>
  iput(ip);
801019d0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019d3:	83 c4 10             	add    $0x10,%esp
}
801019d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019d9:	c9                   	leave  
  iput(ip);
801019da:	e9 81 fe ff ff       	jmp    80101860 <iput>
801019df:	90                   	nop

801019e0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	8b 55 08             	mov    0x8(%ebp),%edx
801019e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801019e9:	8b 0a                	mov    (%edx),%ecx
801019eb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801019ee:	8b 4a 04             	mov    0x4(%edx),%ecx
801019f1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801019f4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801019f8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801019fb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801019ff:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a03:	8b 52 58             	mov    0x58(%edx),%edx
80101a06:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a09:	5d                   	pop    %ebp
80101a0a:	c3                   	ret    
80101a0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a0f:	90                   	nop

80101a10 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	57                   	push   %edi
80101a14:	56                   	push   %esi
80101a15:	53                   	push   %ebx
80101a16:	83 ec 1c             	sub    $0x1c,%esp
80101a19:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a1c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a1f:	8b 75 10             	mov    0x10(%ebp),%esi
80101a22:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a25:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a28:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a2d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a30:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a33:	0f 84 a7 00 00 00    	je     80101ae0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a3c:	8b 40 58             	mov    0x58(%eax),%eax
80101a3f:	39 c6                	cmp    %eax,%esi
80101a41:	0f 87 ba 00 00 00    	ja     80101b01 <readi+0xf1>
80101a47:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a4a:	31 c9                	xor    %ecx,%ecx
80101a4c:	89 da                	mov    %ebx,%edx
80101a4e:	01 f2                	add    %esi,%edx
80101a50:	0f 92 c1             	setb   %cl
80101a53:	89 cf                	mov    %ecx,%edi
80101a55:	0f 82 a6 00 00 00    	jb     80101b01 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a5b:	89 c1                	mov    %eax,%ecx
80101a5d:	29 f1                	sub    %esi,%ecx
80101a5f:	39 d0                	cmp    %edx,%eax
80101a61:	0f 43 cb             	cmovae %ebx,%ecx
80101a64:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a67:	85 c9                	test   %ecx,%ecx
80101a69:	74 67                	je     80101ad2 <readi+0xc2>
80101a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a6f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a70:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a73:	89 f2                	mov    %esi,%edx
80101a75:	c1 ea 09             	shr    $0x9,%edx
80101a78:	89 d8                	mov    %ebx,%eax
80101a7a:	e8 21 f9 ff ff       	call   801013a0 <bmap>
80101a7f:	83 ec 08             	sub    $0x8,%esp
80101a82:	50                   	push   %eax
80101a83:	ff 33                	pushl  (%ebx)
80101a85:	e8 46 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a8a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a8d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a92:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a95:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a97:	89 f0                	mov    %esi,%eax
80101a99:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a9e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101aa0:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101aa3:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101aa5:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101aa9:	39 d9                	cmp    %ebx,%ecx
80101aab:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101aae:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101aaf:	01 df                	add    %ebx,%edi
80101ab1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101ab3:	50                   	push   %eax
80101ab4:	ff 75 e0             	pushl  -0x20(%ebp)
80101ab7:	e8 34 2e 00 00       	call   801048f0 <memmove>
    brelse(bp);
80101abc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101abf:	89 14 24             	mov    %edx,(%esp)
80101ac2:	e8 29 e7 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ac7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101aca:	83 c4 10             	add    $0x10,%esp
80101acd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101ad0:	77 9e                	ja     80101a70 <readi+0x60>
  }
  return n;
80101ad2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101ad5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ad8:	5b                   	pop    %ebx
80101ad9:	5e                   	pop    %esi
80101ada:	5f                   	pop    %edi
80101adb:	5d                   	pop    %ebp
80101adc:	c3                   	ret    
80101add:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ae0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ae4:	66 83 f8 09          	cmp    $0x9,%ax
80101ae8:	77 17                	ja     80101b01 <readi+0xf1>
80101aea:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101af1:	85 c0                	test   %eax,%eax
80101af3:	74 0c                	je     80101b01 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101af5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101af8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101afb:	5b                   	pop    %ebx
80101afc:	5e                   	pop    %esi
80101afd:	5f                   	pop    %edi
80101afe:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101aff:	ff e0                	jmp    *%eax
      return -1;
80101b01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b06:	eb cd                	jmp    80101ad5 <readi+0xc5>
80101b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b0f:	90                   	nop

80101b10 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	57                   	push   %edi
80101b14:	56                   	push   %esi
80101b15:	53                   	push   %ebx
80101b16:	83 ec 1c             	sub    $0x1c,%esp
80101b19:	8b 45 08             	mov    0x8(%ebp),%eax
80101b1c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b1f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b22:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b27:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b2a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b2d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b30:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b33:	0f 84 b7 00 00 00    	je     80101bf0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b3c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b3f:	0f 82 e7 00 00 00    	jb     80101c2c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b45:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b48:	89 f8                	mov    %edi,%eax
80101b4a:	01 f0                	add    %esi,%eax
80101b4c:	0f 82 da 00 00 00    	jb     80101c2c <writei+0x11c>
80101b52:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b57:	0f 87 cf 00 00 00    	ja     80101c2c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b5d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b64:	85 ff                	test   %edi,%edi
80101b66:	74 79                	je     80101be1 <writei+0xd1>
80101b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b6f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b70:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b73:	89 f2                	mov    %esi,%edx
80101b75:	c1 ea 09             	shr    $0x9,%edx
80101b78:	89 f8                	mov    %edi,%eax
80101b7a:	e8 21 f8 ff ff       	call   801013a0 <bmap>
80101b7f:	83 ec 08             	sub    $0x8,%esp
80101b82:	50                   	push   %eax
80101b83:	ff 37                	pushl  (%edi)
80101b85:	e8 46 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b8a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b8f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b92:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b95:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b97:	89 f0                	mov    %esi,%eax
80101b99:	83 c4 0c             	add    $0xc,%esp
80101b9c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ba1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101ba3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ba7:	39 d9                	cmp    %ebx,%ecx
80101ba9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101bac:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bad:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101baf:	ff 75 dc             	pushl  -0x24(%ebp)
80101bb2:	50                   	push   %eax
80101bb3:	e8 38 2d 00 00       	call   801048f0 <memmove>
    log_write(bp);
80101bb8:	89 3c 24             	mov    %edi,(%esp)
80101bbb:	e8 d0 12 00 00       	call   80102e90 <log_write>
    brelse(bp);
80101bc0:	89 3c 24             	mov    %edi,(%esp)
80101bc3:	e8 28 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bc8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bcb:	83 c4 10             	add    $0x10,%esp
80101bce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bd1:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bd4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101bd7:	77 97                	ja     80101b70 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101bd9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bdc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bdf:	77 37                	ja     80101c18 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101be1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101be4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101be7:	5b                   	pop    %ebx
80101be8:	5e                   	pop    %esi
80101be9:	5f                   	pop    %edi
80101bea:	5d                   	pop    %ebp
80101beb:	c3                   	ret    
80101bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101bf0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101bf4:	66 83 f8 09          	cmp    $0x9,%ax
80101bf8:	77 32                	ja     80101c2c <writei+0x11c>
80101bfa:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101c01:	85 c0                	test   %eax,%eax
80101c03:	74 27                	je     80101c2c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101c05:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c0b:	5b                   	pop    %ebx
80101c0c:	5e                   	pop    %esi
80101c0d:	5f                   	pop    %edi
80101c0e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c0f:	ff e0                	jmp    *%eax
80101c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c18:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c1b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c1e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c21:	50                   	push   %eax
80101c22:	e8 59 fa ff ff       	call   80101680 <iupdate>
80101c27:	83 c4 10             	add    $0x10,%esp
80101c2a:	eb b5                	jmp    80101be1 <writei+0xd1>
      return -1;
80101c2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c31:	eb b1                	jmp    80101be4 <writei+0xd4>
80101c33:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c40 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c40:	55                   	push   %ebp
80101c41:	89 e5                	mov    %esp,%ebp
80101c43:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c46:	6a 0e                	push   $0xe
80101c48:	ff 75 0c             	pushl  0xc(%ebp)
80101c4b:	ff 75 08             	pushl  0x8(%ebp)
80101c4e:	e8 0d 2d 00 00       	call   80104960 <strncmp>
}
80101c53:	c9                   	leave  
80101c54:	c3                   	ret    
80101c55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c60 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	57                   	push   %edi
80101c64:	56                   	push   %esi
80101c65:	53                   	push   %ebx
80101c66:	83 ec 1c             	sub    $0x1c,%esp
80101c69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c6c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c71:	0f 85 85 00 00 00    	jne    80101cfc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c77:	8b 53 58             	mov    0x58(%ebx),%edx
80101c7a:	31 ff                	xor    %edi,%edi
80101c7c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c7f:	85 d2                	test   %edx,%edx
80101c81:	74 3e                	je     80101cc1 <dirlookup+0x61>
80101c83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c87:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c88:	6a 10                	push   $0x10
80101c8a:	57                   	push   %edi
80101c8b:	56                   	push   %esi
80101c8c:	53                   	push   %ebx
80101c8d:	e8 7e fd ff ff       	call   80101a10 <readi>
80101c92:	83 c4 10             	add    $0x10,%esp
80101c95:	83 f8 10             	cmp    $0x10,%eax
80101c98:	75 55                	jne    80101cef <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c9a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c9f:	74 18                	je     80101cb9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101ca1:	83 ec 04             	sub    $0x4,%esp
80101ca4:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ca7:	6a 0e                	push   $0xe
80101ca9:	50                   	push   %eax
80101caa:	ff 75 0c             	pushl  0xc(%ebp)
80101cad:	e8 ae 2c 00 00       	call   80104960 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101cb2:	83 c4 10             	add    $0x10,%esp
80101cb5:	85 c0                	test   %eax,%eax
80101cb7:	74 17                	je     80101cd0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101cb9:	83 c7 10             	add    $0x10,%edi
80101cbc:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101cbf:	72 c7                	jb     80101c88 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101cc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101cc4:	31 c0                	xor    %eax,%eax
}
80101cc6:	5b                   	pop    %ebx
80101cc7:	5e                   	pop    %esi
80101cc8:	5f                   	pop    %edi
80101cc9:	5d                   	pop    %ebp
80101cca:	c3                   	ret    
80101ccb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ccf:	90                   	nop
      if(poff)
80101cd0:	8b 45 10             	mov    0x10(%ebp),%eax
80101cd3:	85 c0                	test   %eax,%eax
80101cd5:	74 05                	je     80101cdc <dirlookup+0x7c>
        *poff = off;
80101cd7:	8b 45 10             	mov    0x10(%ebp),%eax
80101cda:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101cdc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101ce0:	8b 03                	mov    (%ebx),%eax
80101ce2:	e8 c9 f5 ff ff       	call   801012b0 <iget>
}
80101ce7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cea:	5b                   	pop    %ebx
80101ceb:	5e                   	pop    %esi
80101cec:	5f                   	pop    %edi
80101ced:	5d                   	pop    %ebp
80101cee:	c3                   	ret    
      panic("dirlookup read");
80101cef:	83 ec 0c             	sub    $0xc,%esp
80101cf2:	68 39 75 10 80       	push   $0x80107539
80101cf7:	e8 94 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101cfc:	83 ec 0c             	sub    $0xc,%esp
80101cff:	68 27 75 10 80       	push   $0x80107527
80101d04:	e8 87 e6 ff ff       	call   80100390 <panic>
80101d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d10 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d10:	55                   	push   %ebp
80101d11:	89 e5                	mov    %esp,%ebp
80101d13:	57                   	push   %edi
80101d14:	56                   	push   %esi
80101d15:	53                   	push   %ebx
80101d16:	89 c3                	mov    %eax,%ebx
80101d18:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d1b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d1e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101d21:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101d24:	0f 84 86 01 00 00    	je     80101eb0 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d2a:	e8 e1 1b 00 00       	call   80103910 <myproc>
  acquire(&icache.lock);
80101d2f:	83 ec 0c             	sub    $0xc,%esp
80101d32:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80101d34:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d37:	68 e0 09 11 80       	push   $0x801109e0
80101d3c:	e8 9f 29 00 00       	call   801046e0 <acquire>
  ip->ref++;
80101d41:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d45:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101d4c:	e8 af 2a 00 00       	call   80104800 <release>
80101d51:	83 c4 10             	add    $0x10,%esp
80101d54:	eb 0d                	jmp    80101d63 <namex+0x53>
80101d56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d5d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101d60:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101d63:	0f b6 07             	movzbl (%edi),%eax
80101d66:	3c 2f                	cmp    $0x2f,%al
80101d68:	74 f6                	je     80101d60 <namex+0x50>
  if(*path == 0)
80101d6a:	84 c0                	test   %al,%al
80101d6c:	0f 84 ee 00 00 00    	je     80101e60 <namex+0x150>
  while(*path != '/' && *path != 0)
80101d72:	0f b6 07             	movzbl (%edi),%eax
80101d75:	84 c0                	test   %al,%al
80101d77:	0f 84 fb 00 00 00    	je     80101e78 <namex+0x168>
80101d7d:	89 fb                	mov    %edi,%ebx
80101d7f:	3c 2f                	cmp    $0x2f,%al
80101d81:	0f 84 f1 00 00 00    	je     80101e78 <namex+0x168>
80101d87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d8e:	66 90                	xchg   %ax,%ax
    path++;
80101d90:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80101d93:	0f b6 03             	movzbl (%ebx),%eax
80101d96:	3c 2f                	cmp    $0x2f,%al
80101d98:	74 04                	je     80101d9e <namex+0x8e>
80101d9a:	84 c0                	test   %al,%al
80101d9c:	75 f2                	jne    80101d90 <namex+0x80>
  len = path - s;
80101d9e:	89 d8                	mov    %ebx,%eax
80101da0:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80101da2:	83 f8 0d             	cmp    $0xd,%eax
80101da5:	0f 8e 85 00 00 00    	jle    80101e30 <namex+0x120>
    memmove(name, s, DIRSIZ);
80101dab:	83 ec 04             	sub    $0x4,%esp
80101dae:	6a 0e                	push   $0xe
80101db0:	57                   	push   %edi
    path++;
80101db1:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80101db3:	ff 75 e4             	pushl  -0x1c(%ebp)
80101db6:	e8 35 2b 00 00       	call   801048f0 <memmove>
80101dbb:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101dbe:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101dc1:	75 0d                	jne    80101dd0 <namex+0xc0>
80101dc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101dc7:	90                   	nop
    path++;
80101dc8:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101dcb:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101dce:	74 f8                	je     80101dc8 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101dd0:	83 ec 0c             	sub    $0xc,%esp
80101dd3:	56                   	push   %esi
80101dd4:	e8 57 f9 ff ff       	call   80101730 <ilock>
    if(ip->type != T_DIR){
80101dd9:	83 c4 10             	add    $0x10,%esp
80101ddc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101de1:	0f 85 a1 00 00 00    	jne    80101e88 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101de7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101dea:	85 d2                	test   %edx,%edx
80101dec:	74 09                	je     80101df7 <namex+0xe7>
80101dee:	80 3f 00             	cmpb   $0x0,(%edi)
80101df1:	0f 84 d9 00 00 00    	je     80101ed0 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101df7:	83 ec 04             	sub    $0x4,%esp
80101dfa:	6a 00                	push   $0x0
80101dfc:	ff 75 e4             	pushl  -0x1c(%ebp)
80101dff:	56                   	push   %esi
80101e00:	e8 5b fe ff ff       	call   80101c60 <dirlookup>
80101e05:	83 c4 10             	add    $0x10,%esp
80101e08:	89 c3                	mov    %eax,%ebx
80101e0a:	85 c0                	test   %eax,%eax
80101e0c:	74 7a                	je     80101e88 <namex+0x178>
  iunlock(ip);
80101e0e:	83 ec 0c             	sub    $0xc,%esp
80101e11:	56                   	push   %esi
80101e12:	e8 f9 f9 ff ff       	call   80101810 <iunlock>
  iput(ip);
80101e17:	89 34 24             	mov    %esi,(%esp)
80101e1a:	89 de                	mov    %ebx,%esi
80101e1c:	e8 3f fa ff ff       	call   80101860 <iput>
  while(*path == '/')
80101e21:	83 c4 10             	add    $0x10,%esp
80101e24:	e9 3a ff ff ff       	jmp    80101d63 <namex+0x53>
80101e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e30:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e33:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80101e36:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80101e39:	83 ec 04             	sub    $0x4,%esp
80101e3c:	50                   	push   %eax
80101e3d:	57                   	push   %edi
    name[len] = 0;
80101e3e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80101e40:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e43:	e8 a8 2a 00 00       	call   801048f0 <memmove>
    name[len] = 0;
80101e48:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e4b:	83 c4 10             	add    $0x10,%esp
80101e4e:	c6 00 00             	movb   $0x0,(%eax)
80101e51:	e9 68 ff ff ff       	jmp    80101dbe <namex+0xae>
80101e56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e5d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e60:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e63:	85 c0                	test   %eax,%eax
80101e65:	0f 85 85 00 00 00    	jne    80101ef0 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e6e:	89 f0                	mov    %esi,%eax
80101e70:	5b                   	pop    %ebx
80101e71:	5e                   	pop    %esi
80101e72:	5f                   	pop    %edi
80101e73:	5d                   	pop    %ebp
80101e74:	c3                   	ret    
80101e75:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80101e78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e7b:	89 fb                	mov    %edi,%ebx
80101e7d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101e80:	31 c0                	xor    %eax,%eax
80101e82:	eb b5                	jmp    80101e39 <namex+0x129>
80101e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e88:	83 ec 0c             	sub    $0xc,%esp
80101e8b:	56                   	push   %esi
80101e8c:	e8 7f f9 ff ff       	call   80101810 <iunlock>
  iput(ip);
80101e91:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e94:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e96:	e8 c5 f9 ff ff       	call   80101860 <iput>
      return 0;
80101e9b:	83 c4 10             	add    $0x10,%esp
}
80101e9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea1:	89 f0                	mov    %esi,%eax
80101ea3:	5b                   	pop    %ebx
80101ea4:	5e                   	pop    %esi
80101ea5:	5f                   	pop    %edi
80101ea6:	5d                   	pop    %ebp
80101ea7:	c3                   	ret    
80101ea8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eaf:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80101eb0:	ba 01 00 00 00       	mov    $0x1,%edx
80101eb5:	b8 01 00 00 00       	mov    $0x1,%eax
80101eba:	89 df                	mov    %ebx,%edi
80101ebc:	e8 ef f3 ff ff       	call   801012b0 <iget>
80101ec1:	89 c6                	mov    %eax,%esi
80101ec3:	e9 9b fe ff ff       	jmp    80101d63 <namex+0x53>
80101ec8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ecf:	90                   	nop
      iunlock(ip);
80101ed0:	83 ec 0c             	sub    $0xc,%esp
80101ed3:	56                   	push   %esi
80101ed4:	e8 37 f9 ff ff       	call   80101810 <iunlock>
      return ip;
80101ed9:	83 c4 10             	add    $0x10,%esp
}
80101edc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101edf:	89 f0                	mov    %esi,%eax
80101ee1:	5b                   	pop    %ebx
80101ee2:	5e                   	pop    %esi
80101ee3:	5f                   	pop    %edi
80101ee4:	5d                   	pop    %ebp
80101ee5:	c3                   	ret    
80101ee6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eed:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80101ef0:	83 ec 0c             	sub    $0xc,%esp
80101ef3:	56                   	push   %esi
    return 0;
80101ef4:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ef6:	e8 65 f9 ff ff       	call   80101860 <iput>
    return 0;
80101efb:	83 c4 10             	add    $0x10,%esp
80101efe:	e9 68 ff ff ff       	jmp    80101e6b <namex+0x15b>
80101f03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f10 <dirlink>:
{
80101f10:	55                   	push   %ebp
80101f11:	89 e5                	mov    %esp,%ebp
80101f13:	57                   	push   %edi
80101f14:	56                   	push   %esi
80101f15:	53                   	push   %ebx
80101f16:	83 ec 20             	sub    $0x20,%esp
80101f19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f1c:	6a 00                	push   $0x0
80101f1e:	ff 75 0c             	pushl  0xc(%ebp)
80101f21:	53                   	push   %ebx
80101f22:	e8 39 fd ff ff       	call   80101c60 <dirlookup>
80101f27:	83 c4 10             	add    $0x10,%esp
80101f2a:	85 c0                	test   %eax,%eax
80101f2c:	75 67                	jne    80101f95 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f2e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f31:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f34:	85 ff                	test   %edi,%edi
80101f36:	74 29                	je     80101f61 <dirlink+0x51>
80101f38:	31 ff                	xor    %edi,%edi
80101f3a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f3d:	eb 09                	jmp    80101f48 <dirlink+0x38>
80101f3f:	90                   	nop
80101f40:	83 c7 10             	add    $0x10,%edi
80101f43:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f46:	73 19                	jae    80101f61 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f48:	6a 10                	push   $0x10
80101f4a:	57                   	push   %edi
80101f4b:	56                   	push   %esi
80101f4c:	53                   	push   %ebx
80101f4d:	e8 be fa ff ff       	call   80101a10 <readi>
80101f52:	83 c4 10             	add    $0x10,%esp
80101f55:	83 f8 10             	cmp    $0x10,%eax
80101f58:	75 4e                	jne    80101fa8 <dirlink+0x98>
    if(de.inum == 0)
80101f5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f5f:	75 df                	jne    80101f40 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101f61:	83 ec 04             	sub    $0x4,%esp
80101f64:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f67:	6a 0e                	push   $0xe
80101f69:	ff 75 0c             	pushl  0xc(%ebp)
80101f6c:	50                   	push   %eax
80101f6d:	e8 3e 2a 00 00       	call   801049b0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f72:	6a 10                	push   $0x10
  de.inum = inum;
80101f74:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f77:	57                   	push   %edi
80101f78:	56                   	push   %esi
80101f79:	53                   	push   %ebx
  de.inum = inum;
80101f7a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f7e:	e8 8d fb ff ff       	call   80101b10 <writei>
80101f83:	83 c4 20             	add    $0x20,%esp
80101f86:	83 f8 10             	cmp    $0x10,%eax
80101f89:	75 2a                	jne    80101fb5 <dirlink+0xa5>
  return 0;
80101f8b:	31 c0                	xor    %eax,%eax
}
80101f8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f90:	5b                   	pop    %ebx
80101f91:	5e                   	pop    %esi
80101f92:	5f                   	pop    %edi
80101f93:	5d                   	pop    %ebp
80101f94:	c3                   	ret    
    iput(ip);
80101f95:	83 ec 0c             	sub    $0xc,%esp
80101f98:	50                   	push   %eax
80101f99:	e8 c2 f8 ff ff       	call   80101860 <iput>
    return -1;
80101f9e:	83 c4 10             	add    $0x10,%esp
80101fa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fa6:	eb e5                	jmp    80101f8d <dirlink+0x7d>
      panic("dirlink read");
80101fa8:	83 ec 0c             	sub    $0xc,%esp
80101fab:	68 48 75 10 80       	push   $0x80107548
80101fb0:	e8 db e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101fb5:	83 ec 0c             	sub    $0xc,%esp
80101fb8:	68 42 7c 10 80       	push   $0x80107c42
80101fbd:	e8 ce e3 ff ff       	call   80100390 <panic>
80101fc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fd0 <namei>:

struct inode*
namei(char *path)
{
80101fd0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fd1:	31 d2                	xor    %edx,%edx
{
80101fd3:	89 e5                	mov    %esp,%ebp
80101fd5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fd8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fdb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fde:	e8 2d fd ff ff       	call   80101d10 <namex>
}
80101fe3:	c9                   	leave  
80101fe4:	c3                   	ret    
80101fe5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ff0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ff0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ff1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101ff6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ff8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101ffb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ffe:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fff:	e9 0c fd ff ff       	jmp    80101d10 <namex>
80102004:	66 90                	xchg   %ax,%ax
80102006:	66 90                	xchg   %ax,%ax
80102008:	66 90                	xchg   %ax,%ax
8010200a:	66 90                	xchg   %ax,%ax
8010200c:	66 90                	xchg   %ax,%ax
8010200e:	66 90                	xchg   %ax,%ax

80102010 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	57                   	push   %edi
80102014:	56                   	push   %esi
80102015:	53                   	push   %ebx
80102016:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102019:	85 c0                	test   %eax,%eax
8010201b:	0f 84 b4 00 00 00    	je     801020d5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102021:	8b 70 08             	mov    0x8(%eax),%esi
80102024:	89 c3                	mov    %eax,%ebx
80102026:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010202c:	0f 87 96 00 00 00    	ja     801020c8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102032:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010203e:	66 90                	xchg   %ax,%ax
80102040:	89 ca                	mov    %ecx,%edx
80102042:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102043:	83 e0 c0             	and    $0xffffffc0,%eax
80102046:	3c 40                	cmp    $0x40,%al
80102048:	75 f6                	jne    80102040 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010204a:	31 ff                	xor    %edi,%edi
8010204c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102051:	89 f8                	mov    %edi,%eax
80102053:	ee                   	out    %al,(%dx)
80102054:	b8 01 00 00 00       	mov    $0x1,%eax
80102059:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010205e:	ee                   	out    %al,(%dx)
8010205f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102064:	89 f0                	mov    %esi,%eax
80102066:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102067:	89 f0                	mov    %esi,%eax
80102069:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010206e:	c1 f8 08             	sar    $0x8,%eax
80102071:	ee                   	out    %al,(%dx)
80102072:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102077:	89 f8                	mov    %edi,%eax
80102079:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010207a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010207e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102083:	c1 e0 04             	shl    $0x4,%eax
80102086:	83 e0 10             	and    $0x10,%eax
80102089:	83 c8 e0             	or     $0xffffffe0,%eax
8010208c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010208d:	f6 03 04             	testb  $0x4,(%ebx)
80102090:	75 16                	jne    801020a8 <idestart+0x98>
80102092:	b8 20 00 00 00       	mov    $0x20,%eax
80102097:	89 ca                	mov    %ecx,%edx
80102099:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010209a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010209d:	5b                   	pop    %ebx
8010209e:	5e                   	pop    %esi
8010209f:	5f                   	pop    %edi
801020a0:	5d                   	pop    %ebp
801020a1:	c3                   	ret    
801020a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020a8:	b8 30 00 00 00       	mov    $0x30,%eax
801020ad:	89 ca                	mov    %ecx,%edx
801020af:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801020b0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801020b5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801020b8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020bd:	fc                   	cld    
801020be:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801020c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020c3:	5b                   	pop    %ebx
801020c4:	5e                   	pop    %esi
801020c5:	5f                   	pop    %edi
801020c6:	5d                   	pop    %ebp
801020c7:	c3                   	ret    
    panic("incorrect blockno");
801020c8:	83 ec 0c             	sub    $0xc,%esp
801020cb:	68 b4 75 10 80       	push   $0x801075b4
801020d0:	e8 bb e2 ff ff       	call   80100390 <panic>
    panic("idestart");
801020d5:	83 ec 0c             	sub    $0xc,%esp
801020d8:	68 ab 75 10 80       	push   $0x801075ab
801020dd:	e8 ae e2 ff ff       	call   80100390 <panic>
801020e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020f0 <ideinit>:
{
801020f0:	55                   	push   %ebp
801020f1:	89 e5                	mov    %esp,%ebp
801020f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020f6:	68 c6 75 10 80       	push   $0x801075c6
801020fb:	68 80 a5 10 80       	push   $0x8010a580
80102100:	e8 db 24 00 00       	call   801045e0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102105:	58                   	pop    %eax
80102106:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010210b:	5a                   	pop    %edx
8010210c:	83 e8 01             	sub    $0x1,%eax
8010210f:	50                   	push   %eax
80102110:	6a 0e                	push   $0xe
80102112:	e8 a9 02 00 00       	call   801023c0 <ioapicenable>
80102117:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010211a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010211f:	90                   	nop
80102120:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102121:	83 e0 c0             	and    $0xffffffc0,%eax
80102124:	3c 40                	cmp    $0x40,%al
80102126:	75 f8                	jne    80102120 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102128:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010212d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102132:	ee                   	out    %al,(%dx)
80102133:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102138:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010213d:	eb 06                	jmp    80102145 <ideinit+0x55>
8010213f:	90                   	nop
  for(i=0; i<1000; i++){
80102140:	83 e9 01             	sub    $0x1,%ecx
80102143:	74 0f                	je     80102154 <ideinit+0x64>
80102145:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102146:	84 c0                	test   %al,%al
80102148:	74 f6                	je     80102140 <ideinit+0x50>
      havedisk1 = 1;
8010214a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102151:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102154:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102159:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010215e:	ee                   	out    %al,(%dx)
}
8010215f:	c9                   	leave  
80102160:	c3                   	ret    
80102161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010216f:	90                   	nop

80102170 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	57                   	push   %edi
80102174:	56                   	push   %esi
80102175:	53                   	push   %ebx
80102176:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102179:	68 80 a5 10 80       	push   $0x8010a580
8010217e:	e8 5d 25 00 00       	call   801046e0 <acquire>

  if((b = idequeue) == 0){
80102183:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102189:	83 c4 10             	add    $0x10,%esp
8010218c:	85 db                	test   %ebx,%ebx
8010218e:	74 63                	je     801021f3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102190:	8b 43 58             	mov    0x58(%ebx),%eax
80102193:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102198:	8b 33                	mov    (%ebx),%esi
8010219a:	f7 c6 04 00 00 00    	test   $0x4,%esi
801021a0:	75 2f                	jne    801021d1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021a2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ae:	66 90                	xchg   %ax,%ax
801021b0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021b1:	89 c1                	mov    %eax,%ecx
801021b3:	83 e1 c0             	and    $0xffffffc0,%ecx
801021b6:	80 f9 40             	cmp    $0x40,%cl
801021b9:	75 f5                	jne    801021b0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021bb:	a8 21                	test   $0x21,%al
801021bd:	75 12                	jne    801021d1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801021bf:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021c2:	b9 80 00 00 00       	mov    $0x80,%ecx
801021c7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021cc:	fc                   	cld    
801021cd:	f3 6d                	rep insl (%dx),%es:(%edi)
801021cf:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021d1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801021d4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801021d7:	83 ce 02             	or     $0x2,%esi
801021da:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801021dc:	53                   	push   %ebx
801021dd:	e8 ce 1e 00 00       	call   801040b0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021e2:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801021e7:	83 c4 10             	add    $0x10,%esp
801021ea:	85 c0                	test   %eax,%eax
801021ec:	74 05                	je     801021f3 <ideintr+0x83>
    idestart(idequeue);
801021ee:	e8 1d fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021f3:	83 ec 0c             	sub    $0xc,%esp
801021f6:	68 80 a5 10 80       	push   $0x8010a580
801021fb:	e8 00 26 00 00       	call   80104800 <release>

  release(&idelock);
}
80102200:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102203:	5b                   	pop    %ebx
80102204:	5e                   	pop    %esi
80102205:	5f                   	pop    %edi
80102206:	5d                   	pop    %ebp
80102207:	c3                   	ret    
80102208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010220f:	90                   	nop

80102210 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102210:	55                   	push   %ebp
80102211:	89 e5                	mov    %esp,%ebp
80102213:	53                   	push   %ebx
80102214:	83 ec 10             	sub    $0x10,%esp
80102217:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010221a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010221d:	50                   	push   %eax
8010221e:	e8 8d 23 00 00       	call   801045b0 <holdingsleep>
80102223:	83 c4 10             	add    $0x10,%esp
80102226:	85 c0                	test   %eax,%eax
80102228:	0f 84 d3 00 00 00    	je     80102301 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010222e:	8b 03                	mov    (%ebx),%eax
80102230:	83 e0 06             	and    $0x6,%eax
80102233:	83 f8 02             	cmp    $0x2,%eax
80102236:	0f 84 b8 00 00 00    	je     801022f4 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010223c:	8b 53 04             	mov    0x4(%ebx),%edx
8010223f:	85 d2                	test   %edx,%edx
80102241:	74 0d                	je     80102250 <iderw+0x40>
80102243:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102248:	85 c0                	test   %eax,%eax
8010224a:	0f 84 97 00 00 00    	je     801022e7 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102250:	83 ec 0c             	sub    $0xc,%esp
80102253:	68 80 a5 10 80       	push   $0x8010a580
80102258:	e8 83 24 00 00       	call   801046e0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010225d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
  b->qnext = 0;
80102263:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010226a:	83 c4 10             	add    $0x10,%esp
8010226d:	85 d2                	test   %edx,%edx
8010226f:	75 09                	jne    8010227a <iderw+0x6a>
80102271:	eb 6d                	jmp    801022e0 <iderw+0xd0>
80102273:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102277:	90                   	nop
80102278:	89 c2                	mov    %eax,%edx
8010227a:	8b 42 58             	mov    0x58(%edx),%eax
8010227d:	85 c0                	test   %eax,%eax
8010227f:	75 f7                	jne    80102278 <iderw+0x68>
80102281:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102284:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102286:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010228c:	74 42                	je     801022d0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010228e:	8b 03                	mov    (%ebx),%eax
80102290:	83 e0 06             	and    $0x6,%eax
80102293:	83 f8 02             	cmp    $0x2,%eax
80102296:	74 23                	je     801022bb <iderw+0xab>
80102298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010229f:	90                   	nop
    sleep(b, &idelock);
801022a0:	83 ec 08             	sub    $0x8,%esp
801022a3:	68 80 a5 10 80       	push   $0x8010a580
801022a8:	53                   	push   %ebx
801022a9:	e8 42 1c 00 00       	call   80103ef0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801022ae:	8b 03                	mov    (%ebx),%eax
801022b0:	83 c4 10             	add    $0x10,%esp
801022b3:	83 e0 06             	and    $0x6,%eax
801022b6:	83 f8 02             	cmp    $0x2,%eax
801022b9:	75 e5                	jne    801022a0 <iderw+0x90>
  }


  release(&idelock);
801022bb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801022c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022c5:	c9                   	leave  
  release(&idelock);
801022c6:	e9 35 25 00 00       	jmp    80104800 <release>
801022cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022cf:	90                   	nop
    idestart(b);
801022d0:	89 d8                	mov    %ebx,%eax
801022d2:	e8 39 fd ff ff       	call   80102010 <idestart>
801022d7:	eb b5                	jmp    8010228e <iderw+0x7e>
801022d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022e0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801022e5:	eb 9d                	jmp    80102284 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
801022e7:	83 ec 0c             	sub    $0xc,%esp
801022ea:	68 f5 75 10 80       	push   $0x801075f5
801022ef:	e8 9c e0 ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
801022f4:	83 ec 0c             	sub    $0xc,%esp
801022f7:	68 e0 75 10 80       	push   $0x801075e0
801022fc:	e8 8f e0 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102301:	83 ec 0c             	sub    $0xc,%esp
80102304:	68 ca 75 10 80       	push   $0x801075ca
80102309:	e8 82 e0 ff ff       	call   80100390 <panic>
8010230e:	66 90                	xchg   %ax,%ax

80102310 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102310:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102311:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102318:	00 c0 fe 
{
8010231b:	89 e5                	mov    %esp,%ebp
8010231d:	56                   	push   %esi
8010231e:	53                   	push   %ebx
  ioapic->reg = reg;
8010231f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102326:	00 00 00 
  return ioapic->data;
80102329:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010232f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102332:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102338:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010233e:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102345:	c1 ee 10             	shr    $0x10,%esi
80102348:	89 f0                	mov    %esi,%eax
8010234a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010234d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102350:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102353:	39 c2                	cmp    %eax,%edx
80102355:	74 16                	je     8010236d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102357:	83 ec 0c             	sub    $0xc,%esp
8010235a:	68 14 76 10 80       	push   $0x80107614
8010235f:	e8 4c e3 ff ff       	call   801006b0 <cprintf>
80102364:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010236a:	83 c4 10             	add    $0x10,%esp
8010236d:	83 c6 21             	add    $0x21,%esi
{
80102370:	ba 10 00 00 00       	mov    $0x10,%edx
80102375:	b8 20 00 00 00       	mov    $0x20,%eax
8010237a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102380:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102382:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102384:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010238a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010238d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102393:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102396:	8d 5a 01             	lea    0x1(%edx),%ebx
80102399:	83 c2 02             	add    $0x2,%edx
8010239c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010239e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801023a4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801023ab:	39 f0                	cmp    %esi,%eax
801023ad:	75 d1                	jne    80102380 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801023af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023b2:	5b                   	pop    %ebx
801023b3:	5e                   	pop    %esi
801023b4:	5d                   	pop    %ebp
801023b5:	c3                   	ret    
801023b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023bd:	8d 76 00             	lea    0x0(%esi),%esi

801023c0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023c0:	55                   	push   %ebp
  ioapic->reg = reg;
801023c1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801023c7:	89 e5                	mov    %esp,%ebp
801023c9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023cc:	8d 50 20             	lea    0x20(%eax),%edx
801023cf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023d3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023d5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023db:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023de:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023e4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023e6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023eb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023ee:	89 50 10             	mov    %edx,0x10(%eax)
}
801023f1:	5d                   	pop    %ebp
801023f2:	c3                   	ret    
801023f3:	66 90                	xchg   %ax,%ax
801023f5:	66 90                	xchg   %ax,%ax
801023f7:	66 90                	xchg   %ax,%ax
801023f9:	66 90                	xchg   %ax,%ax
801023fb:	66 90                	xchg   %ax,%ax
801023fd:	66 90                	xchg   %ax,%ax
801023ff:	90                   	nop

80102400 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	53                   	push   %ebx
80102404:	83 ec 04             	sub    $0x4,%esp
80102407:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010240a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102410:	75 76                	jne    80102488 <kfree+0x88>
80102412:	81 fb a8 58 11 80    	cmp    $0x801158a8,%ebx
80102418:	72 6e                	jb     80102488 <kfree+0x88>
8010241a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102420:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102425:	77 61                	ja     80102488 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102427:	83 ec 04             	sub    $0x4,%esp
8010242a:	68 00 10 00 00       	push   $0x1000
8010242f:	6a 01                	push   $0x1
80102431:	53                   	push   %ebx
80102432:	e8 19 24 00 00       	call   80104850 <memset>

  if(kmem.use_lock)
80102437:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010243d:	83 c4 10             	add    $0x10,%esp
80102440:	85 d2                	test   %edx,%edx
80102442:	75 1c                	jne    80102460 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102444:	a1 78 26 11 80       	mov    0x80112678,%eax
80102449:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010244b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102450:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102456:	85 c0                	test   %eax,%eax
80102458:	75 1e                	jne    80102478 <kfree+0x78>
    release(&kmem.lock);
}
8010245a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010245d:	c9                   	leave  
8010245e:	c3                   	ret    
8010245f:	90                   	nop
    acquire(&kmem.lock);
80102460:	83 ec 0c             	sub    $0xc,%esp
80102463:	68 40 26 11 80       	push   $0x80112640
80102468:	e8 73 22 00 00       	call   801046e0 <acquire>
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	eb d2                	jmp    80102444 <kfree+0x44>
80102472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102478:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010247f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102482:	c9                   	leave  
    release(&kmem.lock);
80102483:	e9 78 23 00 00       	jmp    80104800 <release>
    panic("kfree");
80102488:	83 ec 0c             	sub    $0xc,%esp
8010248b:	68 46 76 10 80       	push   $0x80107646
80102490:	e8 fb de ff ff       	call   80100390 <panic>
80102495:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010249c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024a0 <freerange>:
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801024a4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801024a7:	8b 75 0c             	mov    0xc(%ebp),%esi
801024aa:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801024ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024bd:	39 de                	cmp    %ebx,%esi
801024bf:	72 23                	jb     801024e4 <freerange+0x44>
801024c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024c8:	83 ec 0c             	sub    $0xc,%esp
801024cb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024d7:	50                   	push   %eax
801024d8:	e8 23 ff ff ff       	call   80102400 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024dd:	83 c4 10             	add    $0x10,%esp
801024e0:	39 f3                	cmp    %esi,%ebx
801024e2:	76 e4                	jbe    801024c8 <freerange+0x28>
}
801024e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024e7:	5b                   	pop    %ebx
801024e8:	5e                   	pop    %esi
801024e9:	5d                   	pop    %ebp
801024ea:	c3                   	ret    
801024eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024ef:	90                   	nop

801024f0 <kinit1>:
{
801024f0:	55                   	push   %ebp
801024f1:	89 e5                	mov    %esp,%ebp
801024f3:	56                   	push   %esi
801024f4:	53                   	push   %ebx
801024f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024f8:	83 ec 08             	sub    $0x8,%esp
801024fb:	68 4c 76 10 80       	push   $0x8010764c
80102500:	68 40 26 11 80       	push   $0x80112640
80102505:	e8 d6 20 00 00       	call   801045e0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010250a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010250d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102510:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102517:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010251a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102520:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102526:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010252c:	39 de                	cmp    %ebx,%esi
8010252e:	72 1c                	jb     8010254c <kinit1+0x5c>
    kfree(p);
80102530:	83 ec 0c             	sub    $0xc,%esp
80102533:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102539:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010253f:	50                   	push   %eax
80102540:	e8 bb fe ff ff       	call   80102400 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102545:	83 c4 10             	add    $0x10,%esp
80102548:	39 de                	cmp    %ebx,%esi
8010254a:	73 e4                	jae    80102530 <kinit1+0x40>
}
8010254c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010254f:	5b                   	pop    %ebx
80102550:	5e                   	pop    %esi
80102551:	5d                   	pop    %ebp
80102552:	c3                   	ret    
80102553:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010255a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102560 <kinit2>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102564:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102567:	8b 75 0c             	mov    0xc(%ebp),%esi
8010256a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010256b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102571:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102577:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010257d:	39 de                	cmp    %ebx,%esi
8010257f:	72 23                	jb     801025a4 <kinit2+0x44>
80102581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102588:	83 ec 0c             	sub    $0xc,%esp
8010258b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102591:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102597:	50                   	push   %eax
80102598:	e8 63 fe ff ff       	call   80102400 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010259d:	83 c4 10             	add    $0x10,%esp
801025a0:	39 de                	cmp    %ebx,%esi
801025a2:	73 e4                	jae    80102588 <kinit2+0x28>
  kmem.use_lock = 1;
801025a4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801025ab:	00 00 00 
}
801025ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025b1:	5b                   	pop    %ebx
801025b2:	5e                   	pop    %esi
801025b3:	5d                   	pop    %ebp
801025b4:	c3                   	ret    
801025b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025c0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	53                   	push   %ebx
801025c4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801025c7:	a1 74 26 11 80       	mov    0x80112674,%eax
801025cc:	85 c0                	test   %eax,%eax
801025ce:	75 20                	jne    801025f0 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025d0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801025d6:	85 db                	test   %ebx,%ebx
801025d8:	74 07                	je     801025e1 <kalloc+0x21>
    kmem.freelist = r->next;
801025da:	8b 03                	mov    (%ebx),%eax
801025dc:	a3 78 26 11 80       	mov    %eax,0x80112678
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801025e1:	89 d8                	mov    %ebx,%eax
801025e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025e6:	c9                   	leave  
801025e7:	c3                   	ret    
801025e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025ef:	90                   	nop
    acquire(&kmem.lock);
801025f0:	83 ec 0c             	sub    $0xc,%esp
801025f3:	68 40 26 11 80       	push   $0x80112640
801025f8:	e8 e3 20 00 00       	call   801046e0 <acquire>
  r = kmem.freelist;
801025fd:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
80102603:	83 c4 10             	add    $0x10,%esp
80102606:	a1 74 26 11 80       	mov    0x80112674,%eax
8010260b:	85 db                	test   %ebx,%ebx
8010260d:	74 08                	je     80102617 <kalloc+0x57>
    kmem.freelist = r->next;
8010260f:	8b 13                	mov    (%ebx),%edx
80102611:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
80102617:	85 c0                	test   %eax,%eax
80102619:	74 c6                	je     801025e1 <kalloc+0x21>
    release(&kmem.lock);
8010261b:	83 ec 0c             	sub    $0xc,%esp
8010261e:	68 40 26 11 80       	push   $0x80112640
80102623:	e8 d8 21 00 00       	call   80104800 <release>
}
80102628:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010262a:	83 c4 10             	add    $0x10,%esp
}
8010262d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102630:	c9                   	leave  
80102631:	c3                   	ret    
80102632:	66 90                	xchg   %ax,%ax
80102634:	66 90                	xchg   %ax,%ax
80102636:	66 90                	xchg   %ax,%ax
80102638:	66 90                	xchg   %ax,%ax
8010263a:	66 90                	xchg   %ax,%ax
8010263c:	66 90                	xchg   %ax,%ax
8010263e:	66 90                	xchg   %ax,%ax

80102640 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102640:	ba 64 00 00 00       	mov    $0x64,%edx
80102645:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102646:	a8 01                	test   $0x1,%al
80102648:	0f 84 c2 00 00 00    	je     80102710 <kbdgetc+0xd0>
{
8010264e:	55                   	push   %ebp
8010264f:	ba 60 00 00 00       	mov    $0x60,%edx
80102654:	89 e5                	mov    %esp,%ebp
80102656:	53                   	push   %ebx
80102657:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102658:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010265b:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
80102661:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102667:	74 57                	je     801026c0 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102669:	89 d9                	mov    %ebx,%ecx
8010266b:	83 e1 40             	and    $0x40,%ecx
8010266e:	84 c0                	test   %al,%al
80102670:	78 5e                	js     801026d0 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102672:	85 c9                	test   %ecx,%ecx
80102674:	74 09                	je     8010267f <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102676:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102679:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
8010267c:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
8010267f:	0f b6 8a 80 77 10 80 	movzbl -0x7fef8880(%edx),%ecx
  shift ^= togglecode[data];
80102686:	0f b6 82 80 76 10 80 	movzbl -0x7fef8980(%edx),%eax
  shift |= shiftcode[data];
8010268d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010268f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102691:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102693:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102699:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010269c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010269f:	8b 04 85 60 76 10 80 	mov    -0x7fef89a0(,%eax,4),%eax
801026a6:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801026aa:	74 0b                	je     801026b7 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
801026ac:	8d 50 9f             	lea    -0x61(%eax),%edx
801026af:	83 fa 19             	cmp    $0x19,%edx
801026b2:	77 44                	ja     801026f8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801026b4:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026b7:	5b                   	pop    %ebx
801026b8:	5d                   	pop    %ebp
801026b9:	c3                   	ret    
801026ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
801026c0:	83 cb 40             	or     $0x40,%ebx
    return 0;
801026c3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801026c5:	89 1d b4 a5 10 80    	mov    %ebx,0x8010a5b4
}
801026cb:	5b                   	pop    %ebx
801026cc:	5d                   	pop    %ebp
801026cd:	c3                   	ret    
801026ce:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801026d0:	83 e0 7f             	and    $0x7f,%eax
801026d3:	85 c9                	test   %ecx,%ecx
801026d5:	0f 44 d0             	cmove  %eax,%edx
    return 0;
801026d8:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026da:	0f b6 8a 80 77 10 80 	movzbl -0x7fef8880(%edx),%ecx
801026e1:	83 c9 40             	or     $0x40,%ecx
801026e4:	0f b6 c9             	movzbl %cl,%ecx
801026e7:	f7 d1                	not    %ecx
801026e9:	21 d9                	and    %ebx,%ecx
}
801026eb:	5b                   	pop    %ebx
801026ec:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
801026ed:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801026f3:	c3                   	ret    
801026f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801026f8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026fb:	8d 50 20             	lea    0x20(%eax),%edx
}
801026fe:	5b                   	pop    %ebx
801026ff:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102700:	83 f9 1a             	cmp    $0x1a,%ecx
80102703:	0f 42 c2             	cmovb  %edx,%eax
}
80102706:	c3                   	ret    
80102707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010270e:	66 90                	xchg   %ax,%ax
    return -1;
80102710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102715:	c3                   	ret    
80102716:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010271d:	8d 76 00             	lea    0x0(%esi),%esi

80102720 <kbdintr>:

void
kbdintr(void)
{
80102720:	55                   	push   %ebp
80102721:	89 e5                	mov    %esp,%ebp
80102723:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102726:	68 40 26 10 80       	push   $0x80102640
8010272b:	e8 30 e1 ff ff       	call   80100860 <consoleintr>
}
80102730:	83 c4 10             	add    $0x10,%esp
80102733:	c9                   	leave  
80102734:	c3                   	ret    
80102735:	66 90                	xchg   %ax,%ax
80102737:	66 90                	xchg   %ax,%ax
80102739:	66 90                	xchg   %ax,%ax
8010273b:	66 90                	xchg   %ax,%ax
8010273d:	66 90                	xchg   %ax,%ax
8010273f:	90                   	nop

80102740 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102740:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102745:	85 c0                	test   %eax,%eax
80102747:	0f 84 cb 00 00 00    	je     80102818 <lapicinit+0xd8>
  lapic[index] = value;
8010274d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102754:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102757:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010275a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102761:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102764:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102767:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010276e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102771:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102774:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010277b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010277e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102781:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102788:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010278b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010278e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102795:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102798:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010279b:	8b 50 30             	mov    0x30(%eax),%edx
8010279e:	c1 ea 10             	shr    $0x10,%edx
801027a1:	81 e2 fc 00 00 00    	and    $0xfc,%edx
801027a7:	75 77                	jne    80102820 <lapicinit+0xe0>
  lapic[index] = value;
801027a9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801027b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027b6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027bd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027c3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027cd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027d0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027d7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027da:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027dd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027f1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027f4:	8b 50 20             	mov    0x20(%eax),%edx
801027f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027fe:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102800:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102806:	80 e6 10             	and    $0x10,%dh
80102809:	75 f5                	jne    80102800 <lapicinit+0xc0>
  lapic[index] = value;
8010280b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102812:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102815:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102818:	c3                   	ret    
80102819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102820:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102827:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010282a:	8b 50 20             	mov    0x20(%eax),%edx
8010282d:	e9 77 ff ff ff       	jmp    801027a9 <lapicinit+0x69>
80102832:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102840 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102840:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102845:	85 c0                	test   %eax,%eax
80102847:	74 07                	je     80102850 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102849:	8b 40 20             	mov    0x20(%eax),%eax
8010284c:	c1 e8 18             	shr    $0x18,%eax
8010284f:	c3                   	ret    
    return 0;
80102850:	31 c0                	xor    %eax,%eax
}
80102852:	c3                   	ret    
80102853:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010285a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102860 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102860:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102865:	85 c0                	test   %eax,%eax
80102867:	74 0d                	je     80102876 <lapiceoi+0x16>
  lapic[index] = value;
80102869:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102870:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102873:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102876:	c3                   	ret    
80102877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010287e:	66 90                	xchg   %ax,%ax

80102880 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102880:	c3                   	ret    
80102881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102888:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010288f:	90                   	nop

80102890 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102890:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102891:	b8 0f 00 00 00       	mov    $0xf,%eax
80102896:	ba 70 00 00 00       	mov    $0x70,%edx
8010289b:	89 e5                	mov    %esp,%ebp
8010289d:	53                   	push   %ebx
8010289e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801028a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801028a4:	ee                   	out    %al,(%dx)
801028a5:	b8 0a 00 00 00       	mov    $0xa,%eax
801028aa:	ba 71 00 00 00       	mov    $0x71,%edx
801028af:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801028b0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801028b2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801028b5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801028bb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028bd:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
801028c0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
801028c2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
801028c5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801028c8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801028ce:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801028d3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028dc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028e3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028e6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028e9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028f0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028f3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028f6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028fc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028ff:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102905:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102908:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010290e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102911:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102917:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102918:	8b 40 20             	mov    0x20(%eax),%eax
}
8010291b:	5d                   	pop    %ebp
8010291c:	c3                   	ret    
8010291d:	8d 76 00             	lea    0x0(%esi),%esi

80102920 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102920:	55                   	push   %ebp
80102921:	b8 0b 00 00 00       	mov    $0xb,%eax
80102926:	ba 70 00 00 00       	mov    $0x70,%edx
8010292b:	89 e5                	mov    %esp,%ebp
8010292d:	57                   	push   %edi
8010292e:	56                   	push   %esi
8010292f:	53                   	push   %ebx
80102930:	83 ec 4c             	sub    $0x4c,%esp
80102933:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102934:	ba 71 00 00 00       	mov    $0x71,%edx
80102939:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010293a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010293d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102942:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102945:	8d 76 00             	lea    0x0(%esi),%esi
80102948:	31 c0                	xor    %eax,%eax
8010294a:	89 da                	mov    %ebx,%edx
8010294c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102952:	89 ca                	mov    %ecx,%edx
80102954:	ec                   	in     (%dx),%al
80102955:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102958:	89 da                	mov    %ebx,%edx
8010295a:	b8 02 00 00 00       	mov    $0x2,%eax
8010295f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102960:	89 ca                	mov    %ecx,%edx
80102962:	ec                   	in     (%dx),%al
80102963:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102966:	89 da                	mov    %ebx,%edx
80102968:	b8 04 00 00 00       	mov    $0x4,%eax
8010296d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296e:	89 ca                	mov    %ecx,%edx
80102970:	ec                   	in     (%dx),%al
80102971:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102974:	89 da                	mov    %ebx,%edx
80102976:	b8 07 00 00 00       	mov    $0x7,%eax
8010297b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010297c:	89 ca                	mov    %ecx,%edx
8010297e:	ec                   	in     (%dx),%al
8010297f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102982:	89 da                	mov    %ebx,%edx
80102984:	b8 08 00 00 00       	mov    $0x8,%eax
80102989:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298a:	89 ca                	mov    %ecx,%edx
8010298c:	ec                   	in     (%dx),%al
8010298d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010298f:	89 da                	mov    %ebx,%edx
80102991:	b8 09 00 00 00       	mov    $0x9,%eax
80102996:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102997:	89 ca                	mov    %ecx,%edx
80102999:	ec                   	in     (%dx),%al
8010299a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010299c:	89 da                	mov    %ebx,%edx
8010299e:	b8 0a 00 00 00       	mov    $0xa,%eax
801029a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a4:	89 ca                	mov    %ecx,%edx
801029a6:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801029a7:	84 c0                	test   %al,%al
801029a9:	78 9d                	js     80102948 <cmostime+0x28>
  return inb(CMOS_RETURN);
801029ab:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801029af:	89 fa                	mov    %edi,%edx
801029b1:	0f b6 fa             	movzbl %dl,%edi
801029b4:	89 f2                	mov    %esi,%edx
801029b6:	89 45 b8             	mov    %eax,-0x48(%ebp)
801029b9:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801029bd:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c0:	89 da                	mov    %ebx,%edx
801029c2:	89 7d c8             	mov    %edi,-0x38(%ebp)
801029c5:	89 45 bc             	mov    %eax,-0x44(%ebp)
801029c8:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801029cc:	89 75 cc             	mov    %esi,-0x34(%ebp)
801029cf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029d2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801029d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801029d9:	31 c0                	xor    %eax,%eax
801029db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029dc:	89 ca                	mov    %ecx,%edx
801029de:	ec                   	in     (%dx),%al
801029df:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e2:	89 da                	mov    %ebx,%edx
801029e4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029e7:	b8 02 00 00 00       	mov    $0x2,%eax
801029ec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ed:	89 ca                	mov    %ecx,%edx
801029ef:	ec                   	in     (%dx),%al
801029f0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f3:	89 da                	mov    %ebx,%edx
801029f5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029f8:	b8 04 00 00 00       	mov    $0x4,%eax
801029fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fe:	89 ca                	mov    %ecx,%edx
80102a00:	ec                   	in     (%dx),%al
80102a01:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a04:	89 da                	mov    %ebx,%edx
80102a06:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a09:	b8 07 00 00 00       	mov    $0x7,%eax
80102a0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a0f:	89 ca                	mov    %ecx,%edx
80102a11:	ec                   	in     (%dx),%al
80102a12:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a15:	89 da                	mov    %ebx,%edx
80102a17:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a1a:	b8 08 00 00 00       	mov    $0x8,%eax
80102a1f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a20:	89 ca                	mov    %ecx,%edx
80102a22:	ec                   	in     (%dx),%al
80102a23:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a26:	89 da                	mov    %ebx,%edx
80102a28:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a2b:	b8 09 00 00 00       	mov    $0x9,%eax
80102a30:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a31:	89 ca                	mov    %ecx,%edx
80102a33:	ec                   	in     (%dx),%al
80102a34:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a37:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102a3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a3d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102a40:	6a 18                	push   $0x18
80102a42:	50                   	push   %eax
80102a43:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a46:	50                   	push   %eax
80102a47:	e8 54 1e 00 00       	call   801048a0 <memcmp>
80102a4c:	83 c4 10             	add    $0x10,%esp
80102a4f:	85 c0                	test   %eax,%eax
80102a51:	0f 85 f1 fe ff ff    	jne    80102948 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a57:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a5b:	75 78                	jne    80102ad5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a5d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a60:	89 c2                	mov    %eax,%edx
80102a62:	83 e0 0f             	and    $0xf,%eax
80102a65:	c1 ea 04             	shr    $0x4,%edx
80102a68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a6e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a71:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a74:	89 c2                	mov    %eax,%edx
80102a76:	83 e0 0f             	and    $0xf,%eax
80102a79:	c1 ea 04             	shr    $0x4,%edx
80102a7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a82:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a85:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a88:	89 c2                	mov    %eax,%edx
80102a8a:	83 e0 0f             	and    $0xf,%eax
80102a8d:	c1 ea 04             	shr    $0x4,%edx
80102a90:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a93:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a96:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a9c:	89 c2                	mov    %eax,%edx
80102a9e:	83 e0 0f             	and    $0xf,%eax
80102aa1:	c1 ea 04             	shr    $0x4,%edx
80102aa4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102aa7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aaa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102aad:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ab0:	89 c2                	mov    %eax,%edx
80102ab2:	83 e0 0f             	and    $0xf,%eax
80102ab5:	c1 ea 04             	shr    $0x4,%edx
80102ab8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102abb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102abe:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102ac1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ac4:	89 c2                	mov    %eax,%edx
80102ac6:	83 e0 0f             	and    $0xf,%eax
80102ac9:	c1 ea 04             	shr    $0x4,%edx
80102acc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102acf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ad2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102ad5:	8b 75 08             	mov    0x8(%ebp),%esi
80102ad8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102adb:	89 06                	mov    %eax,(%esi)
80102add:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ae0:	89 46 04             	mov    %eax,0x4(%esi)
80102ae3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ae6:	89 46 08             	mov    %eax,0x8(%esi)
80102ae9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102aec:	89 46 0c             	mov    %eax,0xc(%esi)
80102aef:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102af2:	89 46 10             	mov    %eax,0x10(%esi)
80102af5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102af8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102afb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102b02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b05:	5b                   	pop    %ebx
80102b06:	5e                   	pop    %esi
80102b07:	5f                   	pop    %edi
80102b08:	5d                   	pop    %ebp
80102b09:	c3                   	ret    
80102b0a:	66 90                	xchg   %ax,%ax
80102b0c:	66 90                	xchg   %ax,%ax
80102b0e:	66 90                	xchg   %ax,%ax

80102b10 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b10:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102b16:	85 c9                	test   %ecx,%ecx
80102b18:	0f 8e 8a 00 00 00    	jle    80102ba8 <install_trans+0x98>
{
80102b1e:	55                   	push   %ebp
80102b1f:	89 e5                	mov    %esp,%ebp
80102b21:	57                   	push   %edi
80102b22:	56                   	push   %esi
80102b23:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102b24:	31 db                	xor    %ebx,%ebx
{
80102b26:	83 ec 0c             	sub    $0xc,%esp
80102b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b30:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102b35:	83 ec 08             	sub    $0x8,%esp
80102b38:	01 d8                	add    %ebx,%eax
80102b3a:	83 c0 01             	add    $0x1,%eax
80102b3d:	50                   	push   %eax
80102b3e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102b44:	e8 87 d5 ff ff       	call   801000d0 <bread>
80102b49:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b4b:	58                   	pop    %eax
80102b4c:	5a                   	pop    %edx
80102b4d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102b54:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b5a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b5d:	e8 6e d5 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b62:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b65:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b67:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b6a:	68 00 02 00 00       	push   $0x200
80102b6f:	50                   	push   %eax
80102b70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b73:	50                   	push   %eax
80102b74:	e8 77 1d 00 00       	call   801048f0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b79:	89 34 24             	mov    %esi,(%esp)
80102b7c:	e8 2f d6 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102b81:	89 3c 24             	mov    %edi,(%esp)
80102b84:	e8 67 d6 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102b89:	89 34 24             	mov    %esi,(%esp)
80102b8c:	e8 5f d6 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b91:	83 c4 10             	add    $0x10,%esp
80102b94:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102b9a:	7f 94                	jg     80102b30 <install_trans+0x20>
  }
}
80102b9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b9f:	5b                   	pop    %ebx
80102ba0:	5e                   	pop    %esi
80102ba1:	5f                   	pop    %edi
80102ba2:	5d                   	pop    %ebp
80102ba3:	c3                   	ret    
80102ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ba8:	c3                   	ret    
80102ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102bb0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	53                   	push   %ebx
80102bb4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102bb7:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102bbd:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102bc3:	e8 08 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102bc8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102bcb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102bcd:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102bd2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102bd5:	85 c0                	test   %eax,%eax
80102bd7:	7e 19                	jle    80102bf2 <write_head+0x42>
80102bd9:	31 d2                	xor    %edx,%edx
80102bdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102bdf:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102be0:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102be7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102beb:	83 c2 01             	add    $0x1,%edx
80102bee:	39 d0                	cmp    %edx,%eax
80102bf0:	75 ee                	jne    80102be0 <write_head+0x30>
  }
  bwrite(buf);
80102bf2:	83 ec 0c             	sub    $0xc,%esp
80102bf5:	53                   	push   %ebx
80102bf6:	e8 b5 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102bfb:	89 1c 24             	mov    %ebx,(%esp)
80102bfe:	e8 ed d5 ff ff       	call   801001f0 <brelse>
}
80102c03:	83 c4 10             	add    $0x10,%esp
80102c06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c09:	c9                   	leave  
80102c0a:	c3                   	ret    
80102c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c0f:	90                   	nop

80102c10 <initlog>:
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	53                   	push   %ebx
80102c14:	83 ec 2c             	sub    $0x2c,%esp
80102c17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102c1a:	68 80 78 10 80       	push   $0x80107880
80102c1f:	68 80 26 11 80       	push   $0x80112680
80102c24:	e8 b7 19 00 00       	call   801045e0 <initlock>
  readsb(dev, &sb);
80102c29:	58                   	pop    %eax
80102c2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c2d:	5a                   	pop    %edx
80102c2e:	50                   	push   %eax
80102c2f:	53                   	push   %ebx
80102c30:	e8 3b e8 ff ff       	call   80101470 <readsb>
  log.start = sb.logstart;
80102c35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102c38:	59                   	pop    %ecx
  log.dev = dev;
80102c39:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102c3f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102c42:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  log.size = sb.nlog;
80102c47:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  struct buf *buf = bread(log.dev, log.start);
80102c4d:	5a                   	pop    %edx
80102c4e:	50                   	push   %eax
80102c4f:	53                   	push   %ebx
80102c50:	e8 7b d4 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102c55:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102c58:	8b 48 5c             	mov    0x5c(%eax),%ecx
80102c5b:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102c61:	85 c9                	test   %ecx,%ecx
80102c63:	7e 1d                	jle    80102c82 <initlog+0x72>
80102c65:	31 d2                	xor    %edx,%edx
80102c67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c6e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102c70:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80102c74:	89 1c 95 cc 26 11 80 	mov    %ebx,-0x7feed934(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c7b:	83 c2 01             	add    $0x1,%edx
80102c7e:	39 d1                	cmp    %edx,%ecx
80102c80:	75 ee                	jne    80102c70 <initlog+0x60>
  brelse(buf);
80102c82:	83 ec 0c             	sub    $0xc,%esp
80102c85:	50                   	push   %eax
80102c86:	e8 65 d5 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c8b:	e8 80 fe ff ff       	call   80102b10 <install_trans>
  log.lh.n = 0;
80102c90:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c97:	00 00 00 
  write_head(); // clear the log
80102c9a:	e8 11 ff ff ff       	call   80102bb0 <write_head>
}
80102c9f:	83 c4 10             	add    $0x10,%esp
80102ca2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ca5:	c9                   	leave  
80102ca6:	c3                   	ret    
80102ca7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cae:	66 90                	xchg   %ax,%ax

80102cb0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102cb6:	68 80 26 11 80       	push   $0x80112680
80102cbb:	e8 20 1a 00 00       	call   801046e0 <acquire>
80102cc0:	83 c4 10             	add    $0x10,%esp
80102cc3:	eb 18                	jmp    80102cdd <begin_op+0x2d>
80102cc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102cc8:	83 ec 08             	sub    $0x8,%esp
80102ccb:	68 80 26 11 80       	push   $0x80112680
80102cd0:	68 80 26 11 80       	push   $0x80112680
80102cd5:	e8 16 12 00 00       	call   80103ef0 <sleep>
80102cda:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102cdd:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102ce2:	85 c0                	test   %eax,%eax
80102ce4:	75 e2                	jne    80102cc8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ce6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102ceb:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102cf1:	83 c0 01             	add    $0x1,%eax
80102cf4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cf7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cfa:	83 fa 1e             	cmp    $0x1e,%edx
80102cfd:	7f c9                	jg     80102cc8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cff:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102d02:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102d07:	68 80 26 11 80       	push   $0x80112680
80102d0c:	e8 ef 1a 00 00       	call   80104800 <release>
      break;
    }
  }
}
80102d11:	83 c4 10             	add    $0x10,%esp
80102d14:	c9                   	leave  
80102d15:	c3                   	ret    
80102d16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d1d:	8d 76 00             	lea    0x0(%esi),%esi

80102d20 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	57                   	push   %edi
80102d24:	56                   	push   %esi
80102d25:	53                   	push   %ebx
80102d26:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d29:	68 80 26 11 80       	push   $0x80112680
80102d2e:	e8 ad 19 00 00       	call   801046e0 <acquire>
  log.outstanding -= 1;
80102d33:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102d38:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102d3e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102d41:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102d44:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102d4a:	85 f6                	test   %esi,%esi
80102d4c:	0f 85 22 01 00 00    	jne    80102e74 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102d52:	85 db                	test   %ebx,%ebx
80102d54:	0f 85 f6 00 00 00    	jne    80102e50 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102d5a:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102d61:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d64:	83 ec 0c             	sub    $0xc,%esp
80102d67:	68 80 26 11 80       	push   $0x80112680
80102d6c:	e8 8f 1a 00 00       	call   80104800 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d71:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102d77:	83 c4 10             	add    $0x10,%esp
80102d7a:	85 c9                	test   %ecx,%ecx
80102d7c:	7f 42                	jg     80102dc0 <end_op+0xa0>
    acquire(&log.lock);
80102d7e:	83 ec 0c             	sub    $0xc,%esp
80102d81:	68 80 26 11 80       	push   $0x80112680
80102d86:	e8 55 19 00 00       	call   801046e0 <acquire>
    wakeup(&log);
80102d8b:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102d92:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d99:	00 00 00 
    wakeup(&log);
80102d9c:	e8 0f 13 00 00       	call   801040b0 <wakeup>
    release(&log.lock);
80102da1:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102da8:	e8 53 1a 00 00       	call   80104800 <release>
80102dad:	83 c4 10             	add    $0x10,%esp
}
80102db0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102db3:	5b                   	pop    %ebx
80102db4:	5e                   	pop    %esi
80102db5:	5f                   	pop    %edi
80102db6:	5d                   	pop    %ebp
80102db7:	c3                   	ret    
80102db8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dbf:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102dc0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102dc5:	83 ec 08             	sub    $0x8,%esp
80102dc8:	01 d8                	add    %ebx,%eax
80102dca:	83 c0 01             	add    $0x1,%eax
80102dcd:	50                   	push   %eax
80102dce:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102dd4:	e8 f7 d2 ff ff       	call   801000d0 <bread>
80102dd9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ddb:	58                   	pop    %eax
80102ddc:	5a                   	pop    %edx
80102ddd:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102de4:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102dea:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ded:	e8 de d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102df2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102df5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102df7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102dfa:	68 00 02 00 00       	push   $0x200
80102dff:	50                   	push   %eax
80102e00:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e03:	50                   	push   %eax
80102e04:	e8 e7 1a 00 00       	call   801048f0 <memmove>
    bwrite(to);  // write the log
80102e09:	89 34 24             	mov    %esi,(%esp)
80102e0c:	e8 9f d3 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102e11:	89 3c 24             	mov    %edi,(%esp)
80102e14:	e8 d7 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102e19:	89 34 24             	mov    %esi,(%esp)
80102e1c:	e8 cf d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e21:	83 c4 10             	add    $0x10,%esp
80102e24:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102e2a:	7c 94                	jl     80102dc0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e2c:	e8 7f fd ff ff       	call   80102bb0 <write_head>
    install_trans(); // Now install writes to home locations
80102e31:	e8 da fc ff ff       	call   80102b10 <install_trans>
    log.lh.n = 0;
80102e36:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102e3d:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e40:	e8 6b fd ff ff       	call   80102bb0 <write_head>
80102e45:	e9 34 ff ff ff       	jmp    80102d7e <end_op+0x5e>
80102e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102e50:	83 ec 0c             	sub    $0xc,%esp
80102e53:	68 80 26 11 80       	push   $0x80112680
80102e58:	e8 53 12 00 00       	call   801040b0 <wakeup>
  release(&log.lock);
80102e5d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e64:	e8 97 19 00 00       	call   80104800 <release>
80102e69:	83 c4 10             	add    $0x10,%esp
}
80102e6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e6f:	5b                   	pop    %ebx
80102e70:	5e                   	pop    %esi
80102e71:	5f                   	pop    %edi
80102e72:	5d                   	pop    %ebp
80102e73:	c3                   	ret    
    panic("log.committing");
80102e74:	83 ec 0c             	sub    $0xc,%esp
80102e77:	68 84 78 10 80       	push   $0x80107884
80102e7c:	e8 0f d5 ff ff       	call   80100390 <panic>
80102e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e8f:	90                   	nop

80102e90 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	53                   	push   %ebx
80102e94:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e97:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102e9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ea0:	83 fa 1d             	cmp    $0x1d,%edx
80102ea3:	0f 8f 94 00 00 00    	jg     80102f3d <log_write+0xad>
80102ea9:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102eae:	83 e8 01             	sub    $0x1,%eax
80102eb1:	39 c2                	cmp    %eax,%edx
80102eb3:	0f 8d 84 00 00 00    	jge    80102f3d <log_write+0xad>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102eb9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102ebe:	85 c0                	test   %eax,%eax
80102ec0:	0f 8e 84 00 00 00    	jle    80102f4a <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102ec6:	83 ec 0c             	sub    $0xc,%esp
80102ec9:	68 80 26 11 80       	push   $0x80112680
80102ece:	e8 0d 18 00 00       	call   801046e0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102ed3:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102ed9:	83 c4 10             	add    $0x10,%esp
80102edc:	85 d2                	test   %edx,%edx
80102ede:	7e 51                	jle    80102f31 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ee0:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102ee3:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ee5:	3b 0d cc 26 11 80    	cmp    0x801126cc,%ecx
80102eeb:	75 0c                	jne    80102ef9 <log_write+0x69>
80102eed:	eb 39                	jmp    80102f28 <log_write+0x98>
80102eef:	90                   	nop
80102ef0:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102ef7:	74 2f                	je     80102f28 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102ef9:	83 c0 01             	add    $0x1,%eax
80102efc:	39 c2                	cmp    %eax,%edx
80102efe:	75 f0                	jne    80102ef0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f00:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102f07:	83 c2 01             	add    $0x1,%edx
80102f0a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102f10:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102f13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102f16:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102f1d:	c9                   	leave  
  release(&log.lock);
80102f1e:	e9 dd 18 00 00       	jmp    80104800 <release>
80102f23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f27:	90                   	nop
  log.lh.block[i] = b->blockno;
80102f28:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
80102f2f:	eb df                	jmp    80102f10 <log_write+0x80>
  log.lh.block[i] = b->blockno;
80102f31:	8b 43 08             	mov    0x8(%ebx),%eax
80102f34:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102f39:	75 d5                	jne    80102f10 <log_write+0x80>
80102f3b:	eb ca                	jmp    80102f07 <log_write+0x77>
    panic("too big a transaction");
80102f3d:	83 ec 0c             	sub    $0xc,%esp
80102f40:	68 93 78 10 80       	push   $0x80107893
80102f45:	e8 46 d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102f4a:	83 ec 0c             	sub    $0xc,%esp
80102f4d:	68 a9 78 10 80       	push   $0x801078a9
80102f52:	e8 39 d4 ff ff       	call   80100390 <panic>
80102f57:	66 90                	xchg   %ax,%ax
80102f59:	66 90                	xchg   %ax,%ax
80102f5b:	66 90                	xchg   %ax,%ax
80102f5d:	66 90                	xchg   %ax,%ax
80102f5f:	90                   	nop

80102f60 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f60:	55                   	push   %ebp
80102f61:	89 e5                	mov    %esp,%ebp
80102f63:	53                   	push   %ebx
80102f64:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f67:	e8 84 09 00 00       	call   801038f0 <cpuid>
80102f6c:	89 c3                	mov    %eax,%ebx
80102f6e:	e8 7d 09 00 00       	call   801038f0 <cpuid>
80102f73:	83 ec 04             	sub    $0x4,%esp
80102f76:	53                   	push   %ebx
80102f77:	50                   	push   %eax
80102f78:	68 c4 78 10 80       	push   $0x801078c4
80102f7d:	e8 2e d7 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80102f82:	e8 89 2c 00 00       	call   80105c10 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f87:	e8 e4 08 00 00       	call   80103870 <mycpu>
80102f8c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f8e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f93:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f9a:	e8 51 0c 00 00       	call   80103bf0 <scheduler>
80102f9f:	90                   	nop

80102fa0 <mpenter>:
{
80102fa0:	55                   	push   %ebp
80102fa1:	89 e5                	mov    %esp,%ebp
80102fa3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102fa6:	e8 65 3d 00 00       	call   80106d10 <switchkvm>
  seginit();
80102fab:	e8 d0 3c 00 00       	call   80106c80 <seginit>
  lapicinit();
80102fb0:	e8 8b f7 ff ff       	call   80102740 <lapicinit>
  mpmain();
80102fb5:	e8 a6 ff ff ff       	call   80102f60 <mpmain>
80102fba:	66 90                	xchg   %ax,%ax
80102fbc:	66 90                	xchg   %ax,%ax
80102fbe:	66 90                	xchg   %ax,%ax

80102fc0 <main>:
{
80102fc0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102fc4:	83 e4 f0             	and    $0xfffffff0,%esp
80102fc7:	ff 71 fc             	pushl  -0x4(%ecx)
80102fca:	55                   	push   %ebp
80102fcb:	89 e5                	mov    %esp,%ebp
80102fcd:	53                   	push   %ebx
80102fce:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102fcf:	83 ec 08             	sub    $0x8,%esp
80102fd2:	68 00 00 40 80       	push   $0x80400000
80102fd7:	68 a8 58 11 80       	push   $0x801158a8
80102fdc:	e8 0f f5 ff ff       	call   801024f0 <kinit1>
  kvmalloc();      // kernel page table
80102fe1:	e8 ea 41 00 00       	call   801071d0 <kvmalloc>
  mpinit();        // detect other processors
80102fe6:	e8 85 01 00 00       	call   80103170 <mpinit>
  lapicinit();     // interrupt controller
80102feb:	e8 50 f7 ff ff       	call   80102740 <lapicinit>
  seginit();       // segment descriptors
80102ff0:	e8 8b 3c 00 00       	call   80106c80 <seginit>
  picinit();       // disable pic
80102ff5:	e8 46 03 00 00       	call   80103340 <picinit>
  ioapicinit();    // another interrupt controller
80102ffa:	e8 11 f3 ff ff       	call   80102310 <ioapicinit>
  consoleinit();   // console hardware
80102fff:	e8 2c da ff ff       	call   80100a30 <consoleinit>
  uartinit();      // serial port
80103004:	e8 37 2f 00 00       	call   80105f40 <uartinit>
  pinit();         // process table
80103009:	e8 42 08 00 00       	call   80103850 <pinit>
  tvinit();        // trap vectors
8010300e:	e8 7d 2b 00 00       	call   80105b90 <tvinit>
  binit();         // buffer cache
80103013:	e8 28 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103018:	e8 d3 dd ff ff       	call   80100df0 <fileinit>
  ideinit();       // disk 
8010301d:	e8 ce f0 ff ff       	call   801020f0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103022:	83 c4 0c             	add    $0xc,%esp
80103025:	68 8a 00 00 00       	push   $0x8a
8010302a:	68 8c a4 10 80       	push   $0x8010a48c
8010302f:	68 00 70 00 80       	push   $0x80007000
80103034:	e8 b7 18 00 00       	call   801048f0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103039:	83 c4 10             	add    $0x10,%esp
8010303c:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103043:	00 00 00 
80103046:	05 80 27 11 80       	add    $0x80112780,%eax
8010304b:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80103050:	76 7e                	jbe    801030d0 <main+0x110>
80103052:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80103057:	eb 20                	jmp    80103079 <main+0xb9>
80103059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103060:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103067:	00 00 00 
8010306a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103070:	05 80 27 11 80       	add    $0x80112780,%eax
80103075:	39 c3                	cmp    %eax,%ebx
80103077:	73 57                	jae    801030d0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103079:	e8 f2 07 00 00       	call   80103870 <mycpu>
8010307e:	39 d8                	cmp    %ebx,%eax
80103080:	74 de                	je     80103060 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103082:	e8 39 f5 ff ff       	call   801025c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103087:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
8010308a:	c7 05 f8 6f 00 80 a0 	movl   $0x80102fa0,0x80006ff8
80103091:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103094:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010309b:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010309e:	05 00 10 00 00       	add    $0x1000,%eax
801030a3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801030a8:	0f b6 03             	movzbl (%ebx),%eax
801030ab:	68 00 70 00 00       	push   $0x7000
801030b0:	50                   	push   %eax
801030b1:	e8 da f7 ff ff       	call   80102890 <lapicstartap>
801030b6:	83 c4 10             	add    $0x10,%esp
801030b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801030c0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801030c6:	85 c0                	test   %eax,%eax
801030c8:	74 f6                	je     801030c0 <main+0x100>
801030ca:	eb 94                	jmp    80103060 <main+0xa0>
801030cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801030d0:	83 ec 08             	sub    $0x8,%esp
801030d3:	68 00 00 00 8e       	push   $0x8e000000
801030d8:	68 00 00 40 80       	push   $0x80400000
801030dd:	e8 7e f4 ff ff       	call   80102560 <kinit2>
  userinit();      // first user process
801030e2:	e8 59 08 00 00       	call   80103940 <userinit>
  mpmain();        // finish this processor's setup
801030e7:	e8 74 fe ff ff       	call   80102f60 <mpmain>
801030ec:	66 90                	xchg   %ax,%ax
801030ee:	66 90                	xchg   %ax,%ax

801030f0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030f0:	55                   	push   %ebp
801030f1:	89 e5                	mov    %esp,%ebp
801030f3:	57                   	push   %edi
801030f4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030f5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801030fb:	53                   	push   %ebx
  e = addr+len;
801030fc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801030ff:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103102:	39 de                	cmp    %ebx,%esi
80103104:	72 10                	jb     80103116 <mpsearch1+0x26>
80103106:	eb 50                	jmp    80103158 <mpsearch1+0x68>
80103108:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010310f:	90                   	nop
80103110:	89 fe                	mov    %edi,%esi
80103112:	39 fb                	cmp    %edi,%ebx
80103114:	76 42                	jbe    80103158 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103116:	83 ec 04             	sub    $0x4,%esp
80103119:	8d 7e 10             	lea    0x10(%esi),%edi
8010311c:	6a 04                	push   $0x4
8010311e:	68 d8 78 10 80       	push   $0x801078d8
80103123:	56                   	push   %esi
80103124:	e8 77 17 00 00       	call   801048a0 <memcmp>
80103129:	83 c4 10             	add    $0x10,%esp
8010312c:	85 c0                	test   %eax,%eax
8010312e:	75 e0                	jne    80103110 <mpsearch1+0x20>
80103130:	89 f1                	mov    %esi,%ecx
80103132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103138:	0f b6 11             	movzbl (%ecx),%edx
8010313b:	83 c1 01             	add    $0x1,%ecx
8010313e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103140:	39 f9                	cmp    %edi,%ecx
80103142:	75 f4                	jne    80103138 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103144:	84 c0                	test   %al,%al
80103146:	75 c8                	jne    80103110 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103148:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010314b:	89 f0                	mov    %esi,%eax
8010314d:	5b                   	pop    %ebx
8010314e:	5e                   	pop    %esi
8010314f:	5f                   	pop    %edi
80103150:	5d                   	pop    %ebp
80103151:	c3                   	ret    
80103152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103158:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010315b:	31 f6                	xor    %esi,%esi
}
8010315d:	5b                   	pop    %ebx
8010315e:	89 f0                	mov    %esi,%eax
80103160:	5e                   	pop    %esi
80103161:	5f                   	pop    %edi
80103162:	5d                   	pop    %ebp
80103163:	c3                   	ret    
80103164:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010316b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010316f:	90                   	nop

80103170 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103170:	55                   	push   %ebp
80103171:	89 e5                	mov    %esp,%ebp
80103173:	57                   	push   %edi
80103174:	56                   	push   %esi
80103175:	53                   	push   %ebx
80103176:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103179:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103180:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103187:	c1 e0 08             	shl    $0x8,%eax
8010318a:	09 d0                	or     %edx,%eax
8010318c:	c1 e0 04             	shl    $0x4,%eax
8010318f:	75 1b                	jne    801031ac <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103191:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103198:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010319f:	c1 e0 08             	shl    $0x8,%eax
801031a2:	09 d0                	or     %edx,%eax
801031a4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031a7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031ac:	ba 00 04 00 00       	mov    $0x400,%edx
801031b1:	e8 3a ff ff ff       	call   801030f0 <mpsearch1>
801031b6:	89 c7                	mov    %eax,%edi
801031b8:	85 c0                	test   %eax,%eax
801031ba:	0f 84 c0 00 00 00    	je     80103280 <mpinit+0x110>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031c0:	8b 5f 04             	mov    0x4(%edi),%ebx
801031c3:	85 db                	test   %ebx,%ebx
801031c5:	0f 84 d5 00 00 00    	je     801032a0 <mpinit+0x130>
  if(memcmp(conf, "PCMP", 4) != 0)
801031cb:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801031ce:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801031d4:	6a 04                	push   $0x4
801031d6:	68 f5 78 10 80       	push   $0x801078f5
801031db:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801031dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801031df:	e8 bc 16 00 00       	call   801048a0 <memcmp>
801031e4:	83 c4 10             	add    $0x10,%esp
801031e7:	85 c0                	test   %eax,%eax
801031e9:	0f 85 b1 00 00 00    	jne    801032a0 <mpinit+0x130>
  if(conf->version != 1 && conf->version != 4)
801031ef:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031f6:	3c 01                	cmp    $0x1,%al
801031f8:	0f 95 c2             	setne  %dl
801031fb:	3c 04                	cmp    $0x4,%al
801031fd:	0f 95 c0             	setne  %al
80103200:	20 c2                	and    %al,%dl
80103202:	0f 85 98 00 00 00    	jne    801032a0 <mpinit+0x130>
  if(sum((uchar*)conf, conf->length) != 0)
80103208:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
  for(i=0; i<len; i++)
8010320f:	66 85 c9             	test   %cx,%cx
80103212:	74 21                	je     80103235 <mpinit+0xc5>
80103214:	89 d8                	mov    %ebx,%eax
80103216:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
  sum = 0;
80103219:	31 d2                	xor    %edx,%edx
8010321b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010321f:	90                   	nop
    sum += addr[i];
80103220:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103227:	83 c0 01             	add    $0x1,%eax
8010322a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010322c:	39 c6                	cmp    %eax,%esi
8010322e:	75 f0                	jne    80103220 <mpinit+0xb0>
80103230:	84 d2                	test   %dl,%dl
80103232:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103235:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103238:	85 c9                	test   %ecx,%ecx
8010323a:	74 64                	je     801032a0 <mpinit+0x130>
8010323c:	84 d2                	test   %dl,%dl
8010323e:	75 60                	jne    801032a0 <mpinit+0x130>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103240:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103246:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010324b:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103252:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103258:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010325d:	01 d1                	add    %edx,%ecx
8010325f:	89 ce                	mov    %ecx,%esi
80103261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103268:	39 c6                	cmp    %eax,%esi
8010326a:	76 4b                	jbe    801032b7 <mpinit+0x147>
    switch(*p){
8010326c:	0f b6 10             	movzbl (%eax),%edx
8010326f:	80 fa 04             	cmp    $0x4,%dl
80103272:	0f 87 bf 00 00 00    	ja     80103337 <mpinit+0x1c7>
80103278:	ff 24 95 1c 79 10 80 	jmp    *-0x7fef86e4(,%edx,4)
8010327f:	90                   	nop
  return mpsearch1(0xF0000, 0x10000);
80103280:	ba 00 00 01 00       	mov    $0x10000,%edx
80103285:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010328a:	e8 61 fe ff ff       	call   801030f0 <mpsearch1>
8010328f:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103291:	85 c0                	test   %eax,%eax
80103293:	0f 85 27 ff ff ff    	jne    801031c0 <mpinit+0x50>
80103299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801032a0:	83 ec 0c             	sub    $0xc,%esp
801032a3:	68 dd 78 10 80       	push   $0x801078dd
801032a8:	e8 e3 d0 ff ff       	call   80100390 <panic>
801032ad:	8d 76 00             	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032b0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032b3:	39 c6                	cmp    %eax,%esi
801032b5:	77 b5                	ja     8010326c <mpinit+0xfc>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032b7:	85 db                	test   %ebx,%ebx
801032b9:	74 6f                	je     8010332a <mpinit+0x1ba>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032bb:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
801032bf:	74 15                	je     801032d6 <mpinit+0x166>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032c1:	b8 70 00 00 00       	mov    $0x70,%eax
801032c6:	ba 22 00 00 00       	mov    $0x22,%edx
801032cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032cc:	ba 23 00 00 00       	mov    $0x23,%edx
801032d1:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801032d2:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032d5:	ee                   	out    %al,(%dx)
  }
}
801032d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032d9:	5b                   	pop    %ebx
801032da:	5e                   	pop    %esi
801032db:	5f                   	pop    %edi
801032dc:	5d                   	pop    %ebp
801032dd:	c3                   	ret    
801032de:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
801032e0:	8b 15 00 2d 11 80    	mov    0x80112d00,%edx
801032e6:	83 fa 07             	cmp    $0x7,%edx
801032e9:	7f 1f                	jg     8010330a <mpinit+0x19a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801032eb:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801032f1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801032f4:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801032f8:	88 91 80 27 11 80    	mov    %dl,-0x7feed880(%ecx)
        ncpu++;
801032fe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103301:	83 c2 01             	add    $0x1,%edx
80103304:	89 15 00 2d 11 80    	mov    %edx,0x80112d00
      p += sizeof(struct mpproc);
8010330a:	83 c0 14             	add    $0x14,%eax
      continue;
8010330d:	e9 56 ff ff ff       	jmp    80103268 <mpinit+0xf8>
80103312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
80103318:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010331c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010331f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      continue;
80103325:	e9 3e ff ff ff       	jmp    80103268 <mpinit+0xf8>
    panic("Didn't find a suitable machine");
8010332a:	83 ec 0c             	sub    $0xc,%esp
8010332d:	68 fc 78 10 80       	push   $0x801078fc
80103332:	e8 59 d0 ff ff       	call   80100390 <panic>
      ismp = 0;
80103337:	31 db                	xor    %ebx,%ebx
80103339:	e9 31 ff ff ff       	jmp    8010326f <mpinit+0xff>
8010333e:	66 90                	xchg   %ax,%ax

80103340 <picinit>:
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103345:	ba 21 00 00 00       	mov    $0x21,%edx
8010334a:	ee                   	out    %al,(%dx)
8010334b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103350:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103351:	c3                   	ret    
80103352:	66 90                	xchg   %ax,%ax
80103354:	66 90                	xchg   %ax,%ax
80103356:	66 90                	xchg   %ax,%ax
80103358:	66 90                	xchg   %ax,%ax
8010335a:	66 90                	xchg   %ax,%ax
8010335c:	66 90                	xchg   %ax,%ax
8010335e:	66 90                	xchg   %ax,%ax

80103360 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	57                   	push   %edi
80103364:	56                   	push   %esi
80103365:	53                   	push   %ebx
80103366:	83 ec 0c             	sub    $0xc,%esp
80103369:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010336c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010336f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103375:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010337b:	e8 90 da ff ff       	call   80100e10 <filealloc>
80103380:	89 03                	mov    %eax,(%ebx)
80103382:	85 c0                	test   %eax,%eax
80103384:	0f 84 a8 00 00 00    	je     80103432 <pipealloc+0xd2>
8010338a:	e8 81 da ff ff       	call   80100e10 <filealloc>
8010338f:	89 06                	mov    %eax,(%esi)
80103391:	85 c0                	test   %eax,%eax
80103393:	0f 84 87 00 00 00    	je     80103420 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103399:	e8 22 f2 ff ff       	call   801025c0 <kalloc>
8010339e:	89 c7                	mov    %eax,%edi
801033a0:	85 c0                	test   %eax,%eax
801033a2:	0f 84 b0 00 00 00    	je     80103458 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
801033a8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801033af:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801033b2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801033b5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033bc:	00 00 00 
  p->nwrite = 0;
801033bf:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033c6:	00 00 00 
  p->nread = 0;
801033c9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033d0:	00 00 00 
  initlock(&p->lock, "pipe");
801033d3:	68 30 79 10 80       	push   $0x80107930
801033d8:	50                   	push   %eax
801033d9:	e8 02 12 00 00       	call   801045e0 <initlock>
  (*f0)->type = FD_PIPE;
801033de:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033e0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801033e3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033e9:	8b 03                	mov    (%ebx),%eax
801033eb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033ef:	8b 03                	mov    (%ebx),%eax
801033f1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033f5:	8b 03                	mov    (%ebx),%eax
801033f7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033fa:	8b 06                	mov    (%esi),%eax
801033fc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103402:	8b 06                	mov    (%esi),%eax
80103404:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103408:	8b 06                	mov    (%esi),%eax
8010340a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010340e:	8b 06                	mov    (%esi),%eax
80103410:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103413:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103416:	31 c0                	xor    %eax,%eax
}
80103418:	5b                   	pop    %ebx
80103419:	5e                   	pop    %esi
8010341a:	5f                   	pop    %edi
8010341b:	5d                   	pop    %ebp
8010341c:	c3                   	ret    
8010341d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103420:	8b 03                	mov    (%ebx),%eax
80103422:	85 c0                	test   %eax,%eax
80103424:	74 1e                	je     80103444 <pipealloc+0xe4>
    fileclose(*f0);
80103426:	83 ec 0c             	sub    $0xc,%esp
80103429:	50                   	push   %eax
8010342a:	e8 a1 da ff ff       	call   80100ed0 <fileclose>
8010342f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103432:	8b 06                	mov    (%esi),%eax
80103434:	85 c0                	test   %eax,%eax
80103436:	74 0c                	je     80103444 <pipealloc+0xe4>
    fileclose(*f1);
80103438:	83 ec 0c             	sub    $0xc,%esp
8010343b:	50                   	push   %eax
8010343c:	e8 8f da ff ff       	call   80100ed0 <fileclose>
80103441:	83 c4 10             	add    $0x10,%esp
}
80103444:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103447:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010344c:	5b                   	pop    %ebx
8010344d:	5e                   	pop    %esi
8010344e:	5f                   	pop    %edi
8010344f:	5d                   	pop    %ebp
80103450:	c3                   	ret    
80103451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103458:	8b 03                	mov    (%ebx),%eax
8010345a:	85 c0                	test   %eax,%eax
8010345c:	75 c8                	jne    80103426 <pipealloc+0xc6>
8010345e:	eb d2                	jmp    80103432 <pipealloc+0xd2>

80103460 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103460:	55                   	push   %ebp
80103461:	89 e5                	mov    %esp,%ebp
80103463:	56                   	push   %esi
80103464:	53                   	push   %ebx
80103465:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103468:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010346b:	83 ec 0c             	sub    $0xc,%esp
8010346e:	53                   	push   %ebx
8010346f:	e8 6c 12 00 00       	call   801046e0 <acquire>
  if(writable){
80103474:	83 c4 10             	add    $0x10,%esp
80103477:	85 f6                	test   %esi,%esi
80103479:	74 65                	je     801034e0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010347b:	83 ec 0c             	sub    $0xc,%esp
8010347e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103484:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010348b:	00 00 00 
    wakeup(&p->nread);
8010348e:	50                   	push   %eax
8010348f:	e8 1c 0c 00 00       	call   801040b0 <wakeup>
80103494:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103497:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010349d:	85 d2                	test   %edx,%edx
8010349f:	75 0a                	jne    801034ab <pipeclose+0x4b>
801034a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801034a7:	85 c0                	test   %eax,%eax
801034a9:	74 15                	je     801034c0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801034ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801034ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034b1:	5b                   	pop    %ebx
801034b2:	5e                   	pop    %esi
801034b3:	5d                   	pop    %ebp
    release(&p->lock);
801034b4:	e9 47 13 00 00       	jmp    80104800 <release>
801034b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801034c0:	83 ec 0c             	sub    $0xc,%esp
801034c3:	53                   	push   %ebx
801034c4:	e8 37 13 00 00       	call   80104800 <release>
    kfree((char*)p);
801034c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034cc:	83 c4 10             	add    $0x10,%esp
}
801034cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034d2:	5b                   	pop    %ebx
801034d3:	5e                   	pop    %esi
801034d4:	5d                   	pop    %ebp
    kfree((char*)p);
801034d5:	e9 26 ef ff ff       	jmp    80102400 <kfree>
801034da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801034e0:	83 ec 0c             	sub    $0xc,%esp
801034e3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801034e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801034f0:	00 00 00 
    wakeup(&p->nwrite);
801034f3:	50                   	push   %eax
801034f4:	e8 b7 0b 00 00       	call   801040b0 <wakeup>
801034f9:	83 c4 10             	add    $0x10,%esp
801034fc:	eb 99                	jmp    80103497 <pipeclose+0x37>
801034fe:	66 90                	xchg   %ax,%ax

80103500 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103500:	55                   	push   %ebp
80103501:	89 e5                	mov    %esp,%ebp
80103503:	57                   	push   %edi
80103504:	56                   	push   %esi
80103505:	53                   	push   %ebx
80103506:	83 ec 28             	sub    $0x28,%esp
80103509:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010350c:	53                   	push   %ebx
8010350d:	e8 ce 11 00 00       	call   801046e0 <acquire>
  for(i = 0; i < n; i++){
80103512:	8b 45 10             	mov    0x10(%ebp),%eax
80103515:	83 c4 10             	add    $0x10,%esp
80103518:	85 c0                	test   %eax,%eax
8010351a:	0f 8e c8 00 00 00    	jle    801035e8 <pipewrite+0xe8>
80103520:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103523:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103529:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010352f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103532:	03 4d 10             	add    0x10(%ebp),%ecx
80103535:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103538:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010353e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103544:	39 d0                	cmp    %edx,%eax
80103546:	75 71                	jne    801035b9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103548:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010354e:	85 c0                	test   %eax,%eax
80103550:	74 4e                	je     801035a0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103552:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103558:	eb 3a                	jmp    80103594 <pipewrite+0x94>
8010355a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103560:	83 ec 0c             	sub    $0xc,%esp
80103563:	57                   	push   %edi
80103564:	e8 47 0b 00 00       	call   801040b0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103569:	5a                   	pop    %edx
8010356a:	59                   	pop    %ecx
8010356b:	53                   	push   %ebx
8010356c:	56                   	push   %esi
8010356d:	e8 7e 09 00 00       	call   80103ef0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103572:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103578:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010357e:	83 c4 10             	add    $0x10,%esp
80103581:	05 00 02 00 00       	add    $0x200,%eax
80103586:	39 c2                	cmp    %eax,%edx
80103588:	75 36                	jne    801035c0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010358a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103590:	85 c0                	test   %eax,%eax
80103592:	74 0c                	je     801035a0 <pipewrite+0xa0>
80103594:	e8 77 03 00 00       	call   80103910 <myproc>
80103599:	8b 40 24             	mov    0x24(%eax),%eax
8010359c:	85 c0                	test   %eax,%eax
8010359e:	74 c0                	je     80103560 <pipewrite+0x60>
        release(&p->lock);
801035a0:	83 ec 0c             	sub    $0xc,%esp
801035a3:	53                   	push   %ebx
801035a4:	e8 57 12 00 00       	call   80104800 <release>
        return -1;
801035a9:	83 c4 10             	add    $0x10,%esp
801035ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801035b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035b4:	5b                   	pop    %ebx
801035b5:	5e                   	pop    %esi
801035b6:	5f                   	pop    %edi
801035b7:	5d                   	pop    %ebp
801035b8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035b9:	89 c2                	mov    %eax,%edx
801035bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035bf:	90                   	nop
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801035c0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801035c3:	8d 42 01             	lea    0x1(%edx),%eax
801035c6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801035cc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801035d2:	0f b6 0e             	movzbl (%esi),%ecx
801035d5:	83 c6 01             	add    $0x1,%esi
801035d8:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801035db:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801035df:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801035e2:	0f 85 50 ff ff ff    	jne    80103538 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035e8:	83 ec 0c             	sub    $0xc,%esp
801035eb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801035f1:	50                   	push   %eax
801035f2:	e8 b9 0a 00 00       	call   801040b0 <wakeup>
  release(&p->lock);
801035f7:	89 1c 24             	mov    %ebx,(%esp)
801035fa:	e8 01 12 00 00       	call   80104800 <release>
  return n;
801035ff:	83 c4 10             	add    $0x10,%esp
80103602:	8b 45 10             	mov    0x10(%ebp),%eax
80103605:	eb aa                	jmp    801035b1 <pipewrite+0xb1>
80103607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010360e:	66 90                	xchg   %ax,%ax

80103610 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	57                   	push   %edi
80103614:	56                   	push   %esi
80103615:	53                   	push   %ebx
80103616:	83 ec 18             	sub    $0x18,%esp
80103619:	8b 75 08             	mov    0x8(%ebp),%esi
8010361c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010361f:	56                   	push   %esi
80103620:	e8 bb 10 00 00       	call   801046e0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103625:	83 c4 10             	add    $0x10,%esp
80103628:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010362e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103634:	75 6a                	jne    801036a0 <piperead+0x90>
80103636:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010363c:	85 db                	test   %ebx,%ebx
8010363e:	0f 84 c4 00 00 00    	je     80103708 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103644:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010364a:	eb 2d                	jmp    80103679 <piperead+0x69>
8010364c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103650:	83 ec 08             	sub    $0x8,%esp
80103653:	56                   	push   %esi
80103654:	53                   	push   %ebx
80103655:	e8 96 08 00 00       	call   80103ef0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010365a:	83 c4 10             	add    $0x10,%esp
8010365d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103663:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103669:	75 35                	jne    801036a0 <piperead+0x90>
8010366b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103671:	85 d2                	test   %edx,%edx
80103673:	0f 84 8f 00 00 00    	je     80103708 <piperead+0xf8>
    if(myproc()->killed){
80103679:	e8 92 02 00 00       	call   80103910 <myproc>
8010367e:	8b 48 24             	mov    0x24(%eax),%ecx
80103681:	85 c9                	test   %ecx,%ecx
80103683:	74 cb                	je     80103650 <piperead+0x40>
      release(&p->lock);
80103685:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103688:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010368d:	56                   	push   %esi
8010368e:	e8 6d 11 00 00       	call   80104800 <release>
      return -1;
80103693:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103696:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103699:	89 d8                	mov    %ebx,%eax
8010369b:	5b                   	pop    %ebx
8010369c:	5e                   	pop    %esi
8010369d:	5f                   	pop    %edi
8010369e:	5d                   	pop    %ebp
8010369f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036a0:	8b 45 10             	mov    0x10(%ebp),%eax
801036a3:	85 c0                	test   %eax,%eax
801036a5:	7e 61                	jle    80103708 <piperead+0xf8>
    if(p->nread == p->nwrite)
801036a7:	31 db                	xor    %ebx,%ebx
801036a9:	eb 13                	jmp    801036be <piperead+0xae>
801036ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036af:	90                   	nop
801036b0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036b6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036bc:	74 1f                	je     801036dd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801036be:	8d 41 01             	lea    0x1(%ecx),%eax
801036c1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801036c7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801036cd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801036d2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036d5:	83 c3 01             	add    $0x1,%ebx
801036d8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801036db:	75 d3                	jne    801036b0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801036dd:	83 ec 0c             	sub    $0xc,%esp
801036e0:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801036e6:	50                   	push   %eax
801036e7:	e8 c4 09 00 00       	call   801040b0 <wakeup>
  release(&p->lock);
801036ec:	89 34 24             	mov    %esi,(%esp)
801036ef:	e8 0c 11 00 00       	call   80104800 <release>
  return i;
801036f4:	83 c4 10             	add    $0x10,%esp
}
801036f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036fa:	89 d8                	mov    %ebx,%eax
801036fc:	5b                   	pop    %ebx
801036fd:	5e                   	pop    %esi
801036fe:	5f                   	pop    %edi
801036ff:	5d                   	pop    %ebp
80103700:	c3                   	ret    
80103701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
80103708:	31 db                	xor    %ebx,%ebx
8010370a:	eb d1                	jmp    801036dd <piperead+0xcd>
8010370c:	66 90                	xchg   %ax,%ax
8010370e:	66 90                	xchg   %ax,%ax

80103710 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103710:	55                   	push   %ebp
80103711:	89 e5                	mov    %esp,%ebp
80103713:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103714:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
80103719:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010371c:	68 20 2d 11 80       	push   $0x80112d20
80103721:	e8 ba 0f 00 00       	call   801046e0 <acquire>
80103726:	83 c4 10             	add    $0x10,%esp
80103729:	eb 17                	jmp    80103742 <allocproc+0x32>
8010372b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010372f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103730:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103736:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
8010373c:	0f 84 8e 00 00 00    	je     801037d0 <allocproc+0xc0>
    if(p->state == UNUSED)
80103742:	8b 43 0c             	mov    0xc(%ebx),%eax
80103745:	85 c0                	test   %eax,%eax
80103747:	75 e7                	jne    80103730 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103749:	a1 04 a0 10 80       	mov    0x8010a004,%eax
  p->priority = 10;	//default priority

  release(&ptable.lock);
8010374e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103751:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority = 10;	//default priority
80103758:	c7 43 7c 0a 00 00 00 	movl   $0xa,0x7c(%ebx)
  p->pid = nextpid++;
8010375f:	89 43 10             	mov    %eax,0x10(%ebx)
80103762:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103765:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
8010376a:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103770:	e8 8b 10 00 00       	call   80104800 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103775:	e8 46 ee ff ff       	call   801025c0 <kalloc>
8010377a:	83 c4 10             	add    $0x10,%esp
8010377d:	89 43 08             	mov    %eax,0x8(%ebx)
80103780:	85 c0                	test   %eax,%eax
80103782:	74 65                	je     801037e9 <allocproc+0xd9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103784:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010378a:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010378d:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103792:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103795:	c7 40 14 7f 5b 10 80 	movl   $0x80105b7f,0x14(%eax)
  p->context = (struct context*)sp;
8010379c:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010379f:	6a 14                	push   $0x14
801037a1:	6a 00                	push   $0x0
801037a3:	50                   	push   %eax
801037a4:	e8 a7 10 00 00       	call   80104850 <memset>
  p->context->eip = (uint)forkret;
801037a9:	8b 43 1c             	mov    0x1c(%ebx),%eax
  
  //KL, adding initialization for start_ticks
  p->start_ticks = ticks;
  
  return p;
801037ac:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801037af:	c7 40 10 00 38 10 80 	movl   $0x80103800,0x10(%eax)
  p->start_ticks = ticks;
801037b6:	a1 a0 58 11 80       	mov    0x801158a0,%eax
801037bb:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
}
801037c1:	89 d8                	mov    %ebx,%eax
801037c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037c6:	c9                   	leave  
801037c7:	c3                   	ret    
801037c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037cf:	90                   	nop
  release(&ptable.lock);
801037d0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801037d3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801037d5:	68 20 2d 11 80       	push   $0x80112d20
801037da:	e8 21 10 00 00       	call   80104800 <release>
}
801037df:	89 d8                	mov    %ebx,%eax
  return 0;
801037e1:	83 c4 10             	add    $0x10,%esp
}
801037e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037e7:	c9                   	leave  
801037e8:	c3                   	ret    
    p->state = UNUSED;
801037e9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801037f0:	31 db                	xor    %ebx,%ebx
}
801037f2:	89 d8                	mov    %ebx,%eax
801037f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037f7:	c9                   	leave  
801037f8:	c3                   	ret    
801037f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103800 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103806:	68 20 2d 11 80       	push   $0x80112d20
8010380b:	e8 f0 0f 00 00       	call   80104800 <release>

  if (first) {
80103810:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103815:	83 c4 10             	add    $0x10,%esp
80103818:	85 c0                	test   %eax,%eax
8010381a:	75 04                	jne    80103820 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010381c:	c9                   	leave  
8010381d:	c3                   	ret    
8010381e:	66 90                	xchg   %ax,%ax
    first = 0;
80103820:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103827:	00 00 00 
    iinit(ROOTDEV);
8010382a:	83 ec 0c             	sub    $0xc,%esp
8010382d:	6a 01                	push   $0x1
8010382f:	e8 fc dc ff ff       	call   80101530 <iinit>
    initlog(ROOTDEV);
80103834:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010383b:	e8 d0 f3 ff ff       	call   80102c10 <initlog>
80103840:	83 c4 10             	add    $0x10,%esp
}
80103843:	c9                   	leave  
80103844:	c3                   	ret    
80103845:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010384c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103850 <pinit>:
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103856:	68 35 79 10 80       	push   $0x80107935
8010385b:	68 20 2d 11 80       	push   $0x80112d20
80103860:	e8 7b 0d 00 00       	call   801045e0 <initlock>
}
80103865:	83 c4 10             	add    $0x10,%esp
80103868:	c9                   	leave  
80103869:	c3                   	ret    
8010386a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103870 <mycpu>:
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	56                   	push   %esi
80103874:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103875:	9c                   	pushf  
80103876:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103877:	f6 c4 02             	test   $0x2,%ah
8010387a:	75 5d                	jne    801038d9 <mycpu+0x69>
  apicid = lapicid();
8010387c:	e8 bf ef ff ff       	call   80102840 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103881:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103887:	85 f6                	test   %esi,%esi
80103889:	7e 41                	jle    801038cc <mycpu+0x5c>
    if (cpus[i].apicid == apicid)
8010388b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103892:	39 d0                	cmp    %edx,%eax
80103894:	74 2f                	je     801038c5 <mycpu+0x55>
  for (i = 0; i < ncpu; ++i) {
80103896:	31 d2                	xor    %edx,%edx
80103898:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010389f:	90                   	nop
801038a0:	83 c2 01             	add    $0x1,%edx
801038a3:	39 f2                	cmp    %esi,%edx
801038a5:	74 25                	je     801038cc <mycpu+0x5c>
    if (cpus[i].apicid == apicid)
801038a7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801038ad:	0f b6 99 80 27 11 80 	movzbl -0x7feed880(%ecx),%ebx
801038b4:	39 c3                	cmp    %eax,%ebx
801038b6:	75 e8                	jne    801038a0 <mycpu+0x30>
801038b8:	8d 81 80 27 11 80    	lea    -0x7feed880(%ecx),%eax
}
801038be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038c1:	5b                   	pop    %ebx
801038c2:	5e                   	pop    %esi
801038c3:	5d                   	pop    %ebp
801038c4:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801038c5:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
801038ca:	eb f2                	jmp    801038be <mycpu+0x4e>
  panic("unknown apicid\n");
801038cc:	83 ec 0c             	sub    $0xc,%esp
801038cf:	68 3c 79 10 80       	push   $0x8010793c
801038d4:	e8 b7 ca ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801038d9:	83 ec 0c             	sub    $0xc,%esp
801038dc:	68 98 7a 10 80       	push   $0x80107a98
801038e1:	e8 aa ca ff ff       	call   80100390 <panic>
801038e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ed:	8d 76 00             	lea    0x0(%esi),%esi

801038f0 <cpuid>:
cpuid() {
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801038f6:	e8 75 ff ff ff       	call   80103870 <mycpu>
}
801038fb:	c9                   	leave  
  return mycpu()-cpus;
801038fc:	2d 80 27 11 80       	sub    $0x80112780,%eax
80103901:	c1 f8 04             	sar    $0x4,%eax
80103904:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010390a:	c3                   	ret    
8010390b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010390f:	90                   	nop

80103910 <myproc>:
myproc(void) {
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	53                   	push   %ebx
80103914:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103917:	e8 74 0d 00 00       	call   80104690 <pushcli>
  c = mycpu();
8010391c:	e8 4f ff ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103921:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103927:	e8 74 0e 00 00       	call   801047a0 <popcli>
}
8010392c:	83 c4 04             	add    $0x4,%esp
8010392f:	89 d8                	mov    %ebx,%eax
80103931:	5b                   	pop    %ebx
80103932:	5d                   	pop    %ebp
80103933:	c3                   	ret    
80103934:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010393b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010393f:	90                   	nop

80103940 <userinit>:
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	53                   	push   %ebx
80103944:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103947:	e8 c4 fd ff ff       	call   80103710 <allocproc>
8010394c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010394e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103953:	e8 f8 37 00 00       	call   80107150 <setupkvm>
80103958:	89 43 04             	mov    %eax,0x4(%ebx)
8010395b:	85 c0                	test   %eax,%eax
8010395d:	0f 84 bd 00 00 00    	je     80103a20 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103963:	83 ec 04             	sub    $0x4,%esp
80103966:	68 2c 00 00 00       	push   $0x2c
8010396b:	68 60 a4 10 80       	push   $0x8010a460
80103970:	50                   	push   %eax
80103971:	e8 ba 34 00 00       	call   80106e30 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103976:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103979:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010397f:	6a 4c                	push   $0x4c
80103981:	6a 00                	push   $0x0
80103983:	ff 73 18             	pushl  0x18(%ebx)
80103986:	e8 c5 0e 00 00       	call   80104850 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010398b:	8b 43 18             	mov    0x18(%ebx),%eax
8010398e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103993:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103996:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010399b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010399f:	8b 43 18             	mov    0x18(%ebx),%eax
801039a2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039a6:	8b 43 18             	mov    0x18(%ebx),%eax
801039a9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039ad:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039b1:	8b 43 18             	mov    0x18(%ebx),%eax
801039b4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039b8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039bc:	8b 43 18             	mov    0x18(%ebx),%eax
801039bf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801039c6:	8b 43 18             	mov    0x18(%ebx),%eax
801039c9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801039d0:	8b 43 18             	mov    0x18(%ebx),%eax
801039d3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039da:	8d 43 6c             	lea    0x6c(%ebx),%eax
801039dd:	6a 10                	push   $0x10
801039df:	68 65 79 10 80       	push   $0x80107965
801039e4:	50                   	push   %eax
801039e5:	e8 26 10 00 00       	call   80104a10 <safestrcpy>
  p->cwd = namei("/");
801039ea:	c7 04 24 6e 79 10 80 	movl   $0x8010796e,(%esp)
801039f1:	e8 da e5 ff ff       	call   80101fd0 <namei>
801039f6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801039f9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a00:	e8 db 0c 00 00       	call   801046e0 <acquire>
  p->state = RUNNABLE;
80103a05:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a0c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a13:	e8 e8 0d 00 00       	call   80104800 <release>
}
80103a18:	83 c4 10             	add    $0x10,%esp
80103a1b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a1e:	c9                   	leave  
80103a1f:	c3                   	ret    
    panic("userinit: out of memory?");
80103a20:	83 ec 0c             	sub    $0xc,%esp
80103a23:	68 4c 79 10 80       	push   $0x8010794c
80103a28:	e8 63 c9 ff ff       	call   80100390 <panic>
80103a2d:	8d 76 00             	lea    0x0(%esi),%esi

80103a30 <growproc>:
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	56                   	push   %esi
80103a34:	53                   	push   %ebx
80103a35:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a38:	e8 53 0c 00 00       	call   80104690 <pushcli>
  c = mycpu();
80103a3d:	e8 2e fe ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103a42:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a48:	e8 53 0d 00 00       	call   801047a0 <popcli>
  sz = curproc->sz;
80103a4d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a4f:	85 f6                	test   %esi,%esi
80103a51:	7f 1d                	jg     80103a70 <growproc+0x40>
  } else if(n < 0){
80103a53:	75 3b                	jne    80103a90 <growproc+0x60>
  switchuvm(curproc);
80103a55:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a58:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a5a:	53                   	push   %ebx
80103a5b:	e8 c0 32 00 00       	call   80106d20 <switchuvm>
  return 0;
80103a60:	83 c4 10             	add    $0x10,%esp
80103a63:	31 c0                	xor    %eax,%eax
}
80103a65:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a68:	5b                   	pop    %ebx
80103a69:	5e                   	pop    %esi
80103a6a:	5d                   	pop    %ebp
80103a6b:	c3                   	ret    
80103a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a70:	83 ec 04             	sub    $0x4,%esp
80103a73:	01 c6                	add    %eax,%esi
80103a75:	56                   	push   %esi
80103a76:	50                   	push   %eax
80103a77:	ff 73 04             	pushl  0x4(%ebx)
80103a7a:	e8 f1 34 00 00       	call   80106f70 <allocuvm>
80103a7f:	83 c4 10             	add    $0x10,%esp
80103a82:	85 c0                	test   %eax,%eax
80103a84:	75 cf                	jne    80103a55 <growproc+0x25>
      return -1;
80103a86:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a8b:	eb d8                	jmp    80103a65 <growproc+0x35>
80103a8d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a90:	83 ec 04             	sub    $0x4,%esp
80103a93:	01 c6                	add    %eax,%esi
80103a95:	56                   	push   %esi
80103a96:	50                   	push   %eax
80103a97:	ff 73 04             	pushl  0x4(%ebx)
80103a9a:	e8 01 36 00 00       	call   801070a0 <deallocuvm>
80103a9f:	83 c4 10             	add    $0x10,%esp
80103aa2:	85 c0                	test   %eax,%eax
80103aa4:	75 af                	jne    80103a55 <growproc+0x25>
80103aa6:	eb de                	jmp    80103a86 <growproc+0x56>
80103aa8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103aaf:	90                   	nop

80103ab0 <fork>:
{
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	57                   	push   %edi
80103ab4:	56                   	push   %esi
80103ab5:	53                   	push   %ebx
80103ab6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103ab9:	e8 d2 0b 00 00       	call   80104690 <pushcli>
  c = mycpu();
80103abe:	e8 ad fd ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103ac3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ac9:	e8 d2 0c 00 00       	call   801047a0 <popcli>
  if((np = allocproc()) == 0){
80103ace:	e8 3d fc ff ff       	call   80103710 <allocproc>
80103ad3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ad6:	85 c0                	test   %eax,%eax
80103ad8:	0f 84 d7 00 00 00    	je     80103bb5 <fork+0x105>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103ade:	83 ec 08             	sub    $0x8,%esp
80103ae1:	ff 33                	pushl  (%ebx)
80103ae3:	89 c7                	mov    %eax,%edi
80103ae5:	ff 73 04             	pushl  0x4(%ebx)
80103ae8:	e8 33 37 00 00       	call   80107220 <copyuvm>
80103aed:	83 c4 10             	add    $0x10,%esp
80103af0:	89 47 04             	mov    %eax,0x4(%edi)
80103af3:	85 c0                	test   %eax,%eax
80103af5:	0f 84 c1 00 00 00    	je     80103bbc <fork+0x10c>
  np->sz = curproc->sz;
80103afb:	8b 03                	mov    (%ebx),%eax
80103afd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  *np->tf = *curproc->tf;
80103b00:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103b05:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80103b07:	8b 7a 18             	mov    0x18(%edx),%edi
  np->parent = curproc;
80103b0a:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
80103b0d:	8b 73 18             	mov    0x18(%ebx),%esi
80103b10:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b12:	31 f6                	xor    %esi,%esi
	np->uid = curproc->uid;
80103b14:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80103b1a:	89 82 84 00 00 00    	mov    %eax,0x84(%edx)
	np->gid = curproc->gid;
80103b20:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
80103b26:	89 82 88 00 00 00    	mov    %eax,0x88(%edx)
  np->tf->eax = 0;
80103b2c:	8b 42 18             	mov    0x18(%edx),%eax
80103b2f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103b36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[i])
80103b40:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b44:	85 c0                	test   %eax,%eax
80103b46:	74 13                	je     80103b5b <fork+0xab>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b48:	83 ec 0c             	sub    $0xc,%esp
80103b4b:	50                   	push   %eax
80103b4c:	e8 2f d3 ff ff       	call   80100e80 <filedup>
80103b51:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b54:	83 c4 10             	add    $0x10,%esp
80103b57:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b5b:	83 c6 01             	add    $0x1,%esi
80103b5e:	83 fe 10             	cmp    $0x10,%esi
80103b61:	75 dd                	jne    80103b40 <fork+0x90>
  np->cwd = idup(curproc->cwd);
80103b63:	83 ec 0c             	sub    $0xc,%esp
80103b66:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b69:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103b6c:	e8 8f db ff ff       	call   80101700 <idup>
80103b71:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b74:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103b77:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b7a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b7d:	6a 10                	push   $0x10
80103b7f:	53                   	push   %ebx
80103b80:	50                   	push   %eax
80103b81:	e8 8a 0e 00 00       	call   80104a10 <safestrcpy>
  pid = np->pid;
80103b86:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103b89:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b90:	e8 4b 0b 00 00       	call   801046e0 <acquire>
  np->state = RUNNABLE;
80103b95:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103b9c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ba3:	e8 58 0c 00 00       	call   80104800 <release>
  return pid;
80103ba8:	83 c4 10             	add    $0x10,%esp
}
80103bab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bae:	89 d8                	mov    %ebx,%eax
80103bb0:	5b                   	pop    %ebx
80103bb1:	5e                   	pop    %esi
80103bb2:	5f                   	pop    %edi
80103bb3:	5d                   	pop    %ebp
80103bb4:	c3                   	ret    
    return -1;
80103bb5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103bba:	eb ef                	jmp    80103bab <fork+0xfb>
    kfree(np->kstack);
80103bbc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103bbf:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80103bc2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103bc7:	ff 77 08             	pushl  0x8(%edi)
80103bca:	e8 31 e8 ff ff       	call   80102400 <kfree>
    np->kstack = 0;
80103bcf:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    return -1;
80103bd6:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103bd9:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103be0:	eb c9                	jmp    80103bab <fork+0xfb>
80103be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103bf0 <scheduler>:
{
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	57                   	push   %edi
80103bf4:	56                   	push   %esi
80103bf5:	53                   	push   %ebx
80103bf6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103bf9:	e8 72 fc ff ff       	call   80103870 <mycpu>
  c->proc = 0;
80103bfe:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c05:	00 00 00 
  struct cpu *c = mycpu();
80103c08:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103c0a:	8d 70 04             	lea    0x4(%eax),%esi
80103c0d:	eb 1f                	jmp    80103c2e <scheduler+0x3e>
80103c0f:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c10:	81 c7 8c 00 00 00    	add    $0x8c,%edi
80103c16:	81 ff 54 50 11 80    	cmp    $0x80115054,%edi
80103c1c:	72 26                	jb     80103c44 <scheduler+0x54>
    release(&ptable.lock);
80103c1e:	83 ec 0c             	sub    $0xc,%esp
80103c21:	68 20 2d 11 80       	push   $0x80112d20
80103c26:	e8 d5 0b 00 00       	call   80104800 <release>
  for(;;){
80103c2b:	83 c4 10             	add    $0x10,%esp
  asm volatile("sti");
80103c2e:	fb                   	sti    
    acquire(&ptable.lock);
80103c2f:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c32:	bf 54 2d 11 80       	mov    $0x80112d54,%edi
    acquire(&ptable.lock);
80103c37:	68 20 2d 11 80       	push   $0x80112d20
80103c3c:	e8 9f 0a 00 00       	call   801046e0 <acquire>
80103c41:	83 c4 10             	add    $0x10,%esp
      if(p->state != RUNNABLE)
80103c44:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
80103c48:	75 c6                	jne    80103c10 <scheduler+0x20>
      for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103c4a:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103c4f:	90                   	nop
        if(p1->state != RUNNABLE)
80103c50:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103c54:	75 09                	jne    80103c5f <scheduler+0x6f>
        if ( highP->priority > p1->priority )   // larger value, lower priority 
80103c56:	8b 50 7c             	mov    0x7c(%eax),%edx
80103c59:	39 57 7c             	cmp    %edx,0x7c(%edi)
80103c5c:	0f 4f f8             	cmovg  %eax,%edi
      for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103c5f:	05 8c 00 00 00       	add    $0x8c,%eax
80103c64:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103c69:	75 e5                	jne    80103c50 <scheduler+0x60>
      switchuvm(p);
80103c6b:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103c6e:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
      switchuvm(p);
80103c74:	57                   	push   %edi
80103c75:	e8 a6 30 00 00       	call   80106d20 <switchuvm>
      p->state = RUNNING;
80103c7a:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
      swtch(&(c->scheduler), p->context);
80103c81:	58                   	pop    %eax
80103c82:	5a                   	pop    %edx
80103c83:	ff 77 1c             	pushl  0x1c(%edi)
80103c86:	56                   	push   %esi
80103c87:	e8 df 0d 00 00       	call   80104a6b <swtch>
      switchkvm();
80103c8c:	e8 7f 30 00 00       	call   80106d10 <switchkvm>
      c->proc = 0;
80103c91:	83 c4 10             	add    $0x10,%esp
80103c94:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103c9b:	00 00 00 
80103c9e:	e9 6d ff ff ff       	jmp    80103c10 <scheduler+0x20>
80103ca3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103cb0 <sched>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	56                   	push   %esi
80103cb4:	53                   	push   %ebx
  pushcli();
80103cb5:	e8 d6 09 00 00       	call   80104690 <pushcli>
  c = mycpu();
80103cba:	e8 b1 fb ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103cbf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cc5:	e8 d6 0a 00 00       	call   801047a0 <popcli>
  if(!holding(&ptable.lock))
80103cca:	83 ec 0c             	sub    $0xc,%esp
80103ccd:	68 20 2d 11 80       	push   $0x80112d20
80103cd2:	e8 79 09 00 00       	call   80104650 <holding>
80103cd7:	83 c4 10             	add    $0x10,%esp
80103cda:	85 c0                	test   %eax,%eax
80103cdc:	74 4f                	je     80103d2d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cde:	e8 8d fb ff ff       	call   80103870 <mycpu>
80103ce3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cea:	75 68                	jne    80103d54 <sched+0xa4>
  if(p->state == RUNNING)
80103cec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103cf0:	74 55                	je     80103d47 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cf2:	9c                   	pushf  
80103cf3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cf4:	f6 c4 02             	test   $0x2,%ah
80103cf7:	75 41                	jne    80103d3a <sched+0x8a>
  intena = mycpu()->intena;
80103cf9:	e8 72 fb ff ff       	call   80103870 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cfe:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d07:	e8 64 fb ff ff       	call   80103870 <mycpu>
80103d0c:	83 ec 08             	sub    $0x8,%esp
80103d0f:	ff 70 04             	pushl  0x4(%eax)
80103d12:	53                   	push   %ebx
80103d13:	e8 53 0d 00 00       	call   80104a6b <swtch>
  mycpu()->intena = intena;
80103d18:	e8 53 fb ff ff       	call   80103870 <mycpu>
}
80103d1d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d29:	5b                   	pop    %ebx
80103d2a:	5e                   	pop    %esi
80103d2b:	5d                   	pop    %ebp
80103d2c:	c3                   	ret    
    panic("sched ptable.lock");
80103d2d:	83 ec 0c             	sub    $0xc,%esp
80103d30:	68 70 79 10 80       	push   $0x80107970
80103d35:	e8 56 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103d3a:	83 ec 0c             	sub    $0xc,%esp
80103d3d:	68 9c 79 10 80       	push   $0x8010799c
80103d42:	e8 49 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103d47:	83 ec 0c             	sub    $0xc,%esp
80103d4a:	68 8e 79 10 80       	push   $0x8010798e
80103d4f:	e8 3c c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103d54:	83 ec 0c             	sub    $0xc,%esp
80103d57:	68 82 79 10 80       	push   $0x80107982
80103d5c:	e8 2f c6 ff ff       	call   80100390 <panic>
80103d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d6f:	90                   	nop

80103d70 <exit>:
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	57                   	push   %edi
80103d74:	56                   	push   %esi
80103d75:	53                   	push   %ebx
80103d76:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d79:	e8 12 09 00 00       	call   80104690 <pushcli>
  c = mycpu();
80103d7e:	e8 ed fa ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103d83:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d89:	e8 12 0a 00 00       	call   801047a0 <popcli>
  if(curproc == initproc)
80103d8e:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d91:	8d 7e 68             	lea    0x68(%esi),%edi
80103d94:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d9a:	0f 84 f1 00 00 00    	je     80103e91 <exit+0x121>
    if(curproc->ofile[fd]){
80103da0:	8b 03                	mov    (%ebx),%eax
80103da2:	85 c0                	test   %eax,%eax
80103da4:	74 12                	je     80103db8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103da6:	83 ec 0c             	sub    $0xc,%esp
80103da9:	50                   	push   %eax
80103daa:	e8 21 d1 ff ff       	call   80100ed0 <fileclose>
      curproc->ofile[fd] = 0;
80103daf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103db5:	83 c4 10             	add    $0x10,%esp
80103db8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103dbb:	39 fb                	cmp    %edi,%ebx
80103dbd:	75 e1                	jne    80103da0 <exit+0x30>
  begin_op();
80103dbf:	e8 ec ee ff ff       	call   80102cb0 <begin_op>
  iput(curproc->cwd);
80103dc4:	83 ec 0c             	sub    $0xc,%esp
80103dc7:	ff 76 68             	pushl  0x68(%esi)
80103dca:	e8 91 da ff ff       	call   80101860 <iput>
  end_op();
80103dcf:	e8 4c ef ff ff       	call   80102d20 <end_op>
  curproc->cwd = 0;
80103dd4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103ddb:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103de2:	e8 f9 08 00 00       	call   801046e0 <acquire>
  wakeup1(curproc->parent);
80103de7:	8b 56 14             	mov    0x14(%esi),%edx
80103dea:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ded:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103df2:	eb 10                	jmp    80103e04 <exit+0x94>
80103df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103df8:	05 8c 00 00 00       	add    $0x8c,%eax
80103dfd:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103e02:	74 1e                	je     80103e22 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103e04:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e08:	75 ee                	jne    80103df8 <exit+0x88>
80103e0a:	3b 50 20             	cmp    0x20(%eax),%edx
80103e0d:	75 e9                	jne    80103df8 <exit+0x88>
      p->state = RUNNABLE;
80103e0f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e16:	05 8c 00 00 00       	add    $0x8c,%eax
80103e1b:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103e20:	75 e2                	jne    80103e04 <exit+0x94>
      p->parent = initproc;
80103e22:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e28:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103e2d:	eb 0f                	jmp    80103e3e <exit+0xce>
80103e2f:	90                   	nop
80103e30:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103e36:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103e3c:	74 3a                	je     80103e78 <exit+0x108>
    if(p->parent == curproc){
80103e3e:	39 72 14             	cmp    %esi,0x14(%edx)
80103e41:	75 ed                	jne    80103e30 <exit+0xc0>
      if(p->state == ZOMBIE)
80103e43:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e47:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e4a:	75 e4                	jne    80103e30 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e4c:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103e51:	eb 11                	jmp    80103e64 <exit+0xf4>
80103e53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e57:	90                   	nop
80103e58:	05 8c 00 00 00       	add    $0x8c,%eax
80103e5d:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103e62:	74 cc                	je     80103e30 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e64:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e68:	75 ee                	jne    80103e58 <exit+0xe8>
80103e6a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e6d:	75 e9                	jne    80103e58 <exit+0xe8>
      p->state = RUNNABLE;
80103e6f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e76:	eb e0                	jmp    80103e58 <exit+0xe8>
  curproc->state = ZOMBIE;
80103e78:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e7f:	e8 2c fe ff ff       	call   80103cb0 <sched>
  panic("zombie exit");
80103e84:	83 ec 0c             	sub    $0xc,%esp
80103e87:	68 bd 79 10 80       	push   $0x801079bd
80103e8c:	e8 ff c4 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e91:	83 ec 0c             	sub    $0xc,%esp
80103e94:	68 b0 79 10 80       	push   $0x801079b0
80103e99:	e8 f2 c4 ff ff       	call   80100390 <panic>
80103e9e:	66 90                	xchg   %ax,%ax

80103ea0 <yield>:
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	53                   	push   %ebx
80103ea4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ea7:	68 20 2d 11 80       	push   $0x80112d20
80103eac:	e8 2f 08 00 00       	call   801046e0 <acquire>
  pushcli();
80103eb1:	e8 da 07 00 00       	call   80104690 <pushcli>
  c = mycpu();
80103eb6:	e8 b5 f9 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103ebb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ec1:	e8 da 08 00 00       	call   801047a0 <popcli>
  myproc()->state = RUNNABLE;
80103ec6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103ecd:	e8 de fd ff ff       	call   80103cb0 <sched>
  release(&ptable.lock);
80103ed2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ed9:	e8 22 09 00 00       	call   80104800 <release>
}
80103ede:	83 c4 10             	add    $0x10,%esp
80103ee1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ee4:	c9                   	leave  
80103ee5:	c3                   	ret    
80103ee6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eed:	8d 76 00             	lea    0x0(%esi),%esi

80103ef0 <sleep>:
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	57                   	push   %edi
80103ef4:	56                   	push   %esi
80103ef5:	53                   	push   %ebx
80103ef6:	83 ec 0c             	sub    $0xc,%esp
80103ef9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103efc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103eff:	e8 8c 07 00 00       	call   80104690 <pushcli>
  c = mycpu();
80103f04:	e8 67 f9 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103f09:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f0f:	e8 8c 08 00 00       	call   801047a0 <popcli>
  if(p == 0)
80103f14:	85 db                	test   %ebx,%ebx
80103f16:	0f 84 87 00 00 00    	je     80103fa3 <sleep+0xb3>
  if(lk == 0)
80103f1c:	85 f6                	test   %esi,%esi
80103f1e:	74 76                	je     80103f96 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f20:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103f26:	74 50                	je     80103f78 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f28:	83 ec 0c             	sub    $0xc,%esp
80103f2b:	68 20 2d 11 80       	push   $0x80112d20
80103f30:	e8 ab 07 00 00       	call   801046e0 <acquire>
    release(lk);
80103f35:	89 34 24             	mov    %esi,(%esp)
80103f38:	e8 c3 08 00 00       	call   80104800 <release>
  p->chan = chan;
80103f3d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f40:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f47:	e8 64 fd ff ff       	call   80103cb0 <sched>
  p->chan = 0;
80103f4c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103f53:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f5a:	e8 a1 08 00 00       	call   80104800 <release>
    acquire(lk);
80103f5f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f62:	83 c4 10             	add    $0x10,%esp
}
80103f65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f68:	5b                   	pop    %ebx
80103f69:	5e                   	pop    %esi
80103f6a:	5f                   	pop    %edi
80103f6b:	5d                   	pop    %ebp
    acquire(lk);
80103f6c:	e9 6f 07 00 00       	jmp    801046e0 <acquire>
80103f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f78:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f7b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f82:	e8 29 fd ff ff       	call   80103cb0 <sched>
  p->chan = 0;
80103f87:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f91:	5b                   	pop    %ebx
80103f92:	5e                   	pop    %esi
80103f93:	5f                   	pop    %edi
80103f94:	5d                   	pop    %ebp
80103f95:	c3                   	ret    
    panic("sleep without lk");
80103f96:	83 ec 0c             	sub    $0xc,%esp
80103f99:	68 cf 79 10 80       	push   $0x801079cf
80103f9e:	e8 ed c3 ff ff       	call   80100390 <panic>
    panic("sleep");
80103fa3:	83 ec 0c             	sub    $0xc,%esp
80103fa6:	68 c9 79 10 80       	push   $0x801079c9
80103fab:	e8 e0 c3 ff ff       	call   80100390 <panic>

80103fb0 <wait>:
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	56                   	push   %esi
80103fb4:	53                   	push   %ebx
  pushcli();
80103fb5:	e8 d6 06 00 00       	call   80104690 <pushcli>
  c = mycpu();
80103fba:	e8 b1 f8 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103fbf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fc5:	e8 d6 07 00 00       	call   801047a0 <popcli>
  acquire(&ptable.lock);
80103fca:	83 ec 0c             	sub    $0xc,%esp
80103fcd:	68 20 2d 11 80       	push   $0x80112d20
80103fd2:	e8 09 07 00 00       	call   801046e0 <acquire>
80103fd7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103fda:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fdc:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103fe1:	eb 13                	jmp    80103ff6 <wait+0x46>
80103fe3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fe7:	90                   	nop
80103fe8:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103fee:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103ff4:	74 1e                	je     80104014 <wait+0x64>
      if(p->parent != curproc)
80103ff6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ff9:	75 ed                	jne    80103fe8 <wait+0x38>
      if(p->state == ZOMBIE){
80103ffb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103fff:	74 37                	je     80104038 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104001:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
80104007:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010400c:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80104012:	75 e2                	jne    80103ff6 <wait+0x46>
    if(!havekids || curproc->killed){
80104014:	85 c0                	test   %eax,%eax
80104016:	74 76                	je     8010408e <wait+0xde>
80104018:	8b 46 24             	mov    0x24(%esi),%eax
8010401b:	85 c0                	test   %eax,%eax
8010401d:	75 6f                	jne    8010408e <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010401f:	83 ec 08             	sub    $0x8,%esp
80104022:	68 20 2d 11 80       	push   $0x80112d20
80104027:	56                   	push   %esi
80104028:	e8 c3 fe ff ff       	call   80103ef0 <sleep>
    havekids = 0;
8010402d:	83 c4 10             	add    $0x10,%esp
80104030:	eb a8                	jmp    80103fda <wait+0x2a>
80104032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104038:	83 ec 0c             	sub    $0xc,%esp
8010403b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010403e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104041:	e8 ba e3 ff ff       	call   80102400 <kfree>
        freevm(p->pgdir);
80104046:	5a                   	pop    %edx
80104047:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010404a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104051:	e8 7a 30 00 00       	call   801070d0 <freevm>
        release(&ptable.lock);
80104056:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
8010405d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104064:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010406b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010406f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104076:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010407d:	e8 7e 07 00 00       	call   80104800 <release>
        return pid;
80104082:	83 c4 10             	add    $0x10,%esp
}
80104085:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104088:	89 f0                	mov    %esi,%eax
8010408a:	5b                   	pop    %ebx
8010408b:	5e                   	pop    %esi
8010408c:	5d                   	pop    %ebp
8010408d:	c3                   	ret    
      release(&ptable.lock);
8010408e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104091:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104096:	68 20 2d 11 80       	push   $0x80112d20
8010409b:	e8 60 07 00 00       	call   80104800 <release>
      return -1;
801040a0:	83 c4 10             	add    $0x10,%esp
801040a3:	eb e0                	jmp    80104085 <wait+0xd5>
801040a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801040b0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040b0:	55                   	push   %ebp
801040b1:	89 e5                	mov    %esp,%ebp
801040b3:	53                   	push   %ebx
801040b4:	83 ec 10             	sub    $0x10,%esp
801040b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040ba:	68 20 2d 11 80       	push   $0x80112d20
801040bf:	e8 1c 06 00 00       	call   801046e0 <acquire>
801040c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040c7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040cc:	eb 0e                	jmp    801040dc <wakeup+0x2c>
801040ce:	66 90                	xchg   %ax,%ax
801040d0:	05 8c 00 00 00       	add    $0x8c,%eax
801040d5:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801040da:	74 1e                	je     801040fa <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801040dc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040e0:	75 ee                	jne    801040d0 <wakeup+0x20>
801040e2:	3b 58 20             	cmp    0x20(%eax),%ebx
801040e5:	75 e9                	jne    801040d0 <wakeup+0x20>
      p->state = RUNNABLE;
801040e7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040ee:	05 8c 00 00 00       	add    $0x8c,%eax
801040f3:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801040f8:	75 e2                	jne    801040dc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801040fa:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80104101:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104104:	c9                   	leave  
  release(&ptable.lock);
80104105:	e9 f6 06 00 00       	jmp    80104800 <release>
8010410a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104110 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	53                   	push   %ebx
80104114:	83 ec 10             	sub    $0x10,%esp
80104117:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010411a:	68 20 2d 11 80       	push   $0x80112d20
8010411f:	e8 bc 05 00 00       	call   801046e0 <acquire>
80104124:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104127:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010412c:	eb 0e                	jmp    8010413c <kill+0x2c>
8010412e:	66 90                	xchg   %ax,%ax
80104130:	05 8c 00 00 00       	add    $0x8c,%eax
80104135:	3d 54 50 11 80       	cmp    $0x80115054,%eax
8010413a:	74 34                	je     80104170 <kill+0x60>
    if(p->pid == pid){
8010413c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010413f:	75 ef                	jne    80104130 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104141:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104145:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010414c:	75 07                	jne    80104155 <kill+0x45>
        p->state = RUNNABLE;
8010414e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104155:	83 ec 0c             	sub    $0xc,%esp
80104158:	68 20 2d 11 80       	push   $0x80112d20
8010415d:	e8 9e 06 00 00       	call   80104800 <release>
      return 0;
80104162:	83 c4 10             	add    $0x10,%esp
80104165:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104167:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010416a:	c9                   	leave  
8010416b:	c3                   	ret    
8010416c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104170:	83 ec 0c             	sub    $0xc,%esp
80104173:	68 20 2d 11 80       	push   $0x80112d20
80104178:	e8 83 06 00 00       	call   80104800 <release>
  return -1;
8010417d:	83 c4 10             	add    $0x10,%esp
80104180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104185:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104188:	c9                   	leave  
80104189:	c3                   	ret    
8010418a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104190 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104190:	55                   	push   %ebp
80104191:	89 e5                	mov    %esp,%ebp
80104193:	57                   	push   %edi
80104194:	56                   	push   %esi
      
    //KL, modifying to print time elapsed and size
    
    uint elapsed = ticks - p->start_ticks;
    uint front = elapsed/1000;
    uint back = elapsed%1000;
80104195:	be d3 4d 62 10       	mov    $0x10624dd3,%esi
{
8010419a:	53                   	push   %ebx
8010419b:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
801041a0:	83 ec 48             	sub    $0x48,%esp
  cprintf("\nPID\tState\tName\tElapsed\t\tSize\t\t PCs\n");
801041a3:	68 c0 7a 10 80       	push   $0x80107ac0
801041a8:	e8 03 c5 ff ff       	call   801006b0 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041ad:	83 c4 10             	add    $0x10,%esp
801041b0:	eb 28                	jmp    801041da <procdump+0x4a>
801041b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041b8:	83 ec 0c             	sub    $0xc,%esp
801041bb:	68 5b 7e 10 80       	push   $0x80107e5b
801041c0:	e8 eb c4 ff ff       	call   801006b0 <cprintf>
801041c5:	83 c4 10             	add    $0x10,%esp
801041c8:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041ce:	81 fb c0 50 11 80    	cmp    $0x801150c0,%ebx
801041d4:	0f 84 a6 00 00 00    	je     80104280 <procdump+0xf0>
    if(p->state == UNUSED)
801041da:	8b 43 a0             	mov    -0x60(%ebx),%eax
801041dd:	85 c0                	test   %eax,%eax
801041df:	74 e7                	je     801041c8 <procdump+0x38>
      state = "???";
801041e1:	bf e0 79 10 80       	mov    $0x801079e0,%edi
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041e6:	83 f8 05             	cmp    $0x5,%eax
801041e9:	77 11                	ja     801041fc <procdump+0x6c>
801041eb:	8b 3c 85 30 7b 10 80 	mov    -0x7fef84d0(,%eax,4),%edi
      state = "???";
801041f2:	b8 e0 79 10 80       	mov    $0x801079e0,%eax
801041f7:	85 ff                	test   %edi,%edi
801041f9:	0f 44 f8             	cmove  %eax,%edi
    uint elapsed = ticks - p->start_ticks;
801041fc:	8b 0d a0 58 11 80    	mov    0x801158a0,%ecx
80104202:	2b 4b 14             	sub    0x14(%ebx),%ecx
    cprintf("%d\t%s\t%s\t%d.%d seconds\t%d bytes\t", p->pid, state, p->name, front, back, p->sz);
80104205:	83 ec 04             	sub    $0x4,%esp
80104208:	ff 73 94             	pushl  -0x6c(%ebx)
    uint back = elapsed%1000;
8010420b:	89 c8                	mov    %ecx,%eax
8010420d:	f7 e6                	mul    %esi
8010420f:	c1 ea 06             	shr    $0x6,%edx
80104212:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
80104218:	29 c1                	sub    %eax,%ecx
    cprintf("%d\t%s\t%s\t%d.%d seconds\t%d bytes\t", p->pid, state, p->name, front, back, p->sz);
8010421a:	51                   	push   %ecx
8010421b:	52                   	push   %edx
8010421c:	53                   	push   %ebx
8010421d:	57                   	push   %edi
8010421e:	ff 73 a4             	pushl  -0x5c(%ebx)
80104221:	68 e8 7a 10 80       	push   $0x80107ae8
80104226:	e8 85 c4 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
8010422b:	83 c4 20             	add    $0x20,%esp
8010422e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104232:	75 84                	jne    801041b8 <procdump+0x28>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104234:	83 ec 08             	sub    $0x8,%esp
80104237:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010423a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010423d:	50                   	push   %eax
8010423e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104241:	8b 40 0c             	mov    0xc(%eax),%eax
80104244:	83 c0 08             	add    $0x8,%eax
80104247:	50                   	push   %eax
80104248:	e8 b3 03 00 00       	call   80104600 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010424d:	83 c4 10             	add    $0x10,%esp
80104250:	8b 07                	mov    (%edi),%eax
80104252:	85 c0                	test   %eax,%eax
80104254:	0f 84 5e ff ff ff    	je     801041b8 <procdump+0x28>
        cprintf(" %p", pc[i]);
8010425a:	83 ec 08             	sub    $0x8,%esp
8010425d:	83 c7 04             	add    $0x4,%edi
80104260:	50                   	push   %eax
80104261:	68 21 74 10 80       	push   $0x80107421
80104266:	e8 45 c4 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010426b:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010426e:	83 c4 10             	add    $0x10,%esp
80104271:	39 f8                	cmp    %edi,%eax
80104273:	75 db                	jne    80104250 <procdump+0xc0>
80104275:	e9 3e ff ff ff       	jmp    801041b8 <procdump+0x28>
8010427a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
}
80104280:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104283:	5b                   	pop    %ebx
80104284:	5e                   	pop    %esi
80104285:	5f                   	pop    %edi
80104286:	5d                   	pop    %ebp
80104287:	c3                   	ret    
80104288:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010428f:	90                   	nop

80104290 <cps>:

//current process status
int
cps()
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	53                   	push   %ebx
80104294:	83 ec 10             	sub    $0x10,%esp
  asm volatile("sti");
80104297:	fb                   	sti    

  // Enable interrupts on this processor.
  sti();

  // Loop over process table looking for process with pid.
  acquire(&ptable.lock);
80104298:	68 20 2d 11 80       	push   $0x80112d20
  cprintf("name \t pid \t state \t \t priority \n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010429d:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  acquire(&ptable.lock);
801042a2:	e8 39 04 00 00       	call   801046e0 <acquire>
  cprintf("name \t pid \t state \t \t priority \n");
801042a7:	c7 04 24 0c 7b 10 80 	movl   $0x80107b0c,(%esp)
801042ae:	e8 fd c3 ff ff       	call   801006b0 <cprintf>
801042b3:	83 c4 10             	add    $0x10,%esp
801042b6:	eb 20                	jmp    801042d8 <cps+0x48>
801042b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042bf:	90                   	nop
      if ( p->state == SLEEPING ) {
        cprintf("%s \t %d  \t SLEEPING \t %d\n ", p->name, p->pid, p->priority );
      }
      else if ( p->state == RUNNING ) {
801042c0:	83 f8 04             	cmp    $0x4,%eax
801042c3:	74 5b                	je     80104320 <cps+0x90>
        cprintf("%s \t %d  \t RUNNING \t %d\n", p->name, p->pid, p->priority );
      }
      else if (p->state == RUNNABLE){
801042c5:	83 f8 03             	cmp    $0x3,%eax
801042c8:	74 76                	je     80104340 <cps+0xb0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042ca:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801042d0:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
801042d6:	74 2d                	je     80104305 <cps+0x75>
      if ( p->state == SLEEPING ) {
801042d8:	8b 43 0c             	mov    0xc(%ebx),%eax
801042db:	83 f8 02             	cmp    $0x2,%eax
801042de:	75 e0                	jne    801042c0 <cps+0x30>
        cprintf("%s \t %d  \t SLEEPING \t %d\n ", p->name, p->pid, p->priority );
801042e0:	8d 43 6c             	lea    0x6c(%ebx),%eax
801042e3:	ff 73 7c             	pushl  0x7c(%ebx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042e6:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
        cprintf("%s \t %d  \t SLEEPING \t %d\n ", p->name, p->pid, p->priority );
801042ec:	ff 73 84             	pushl  -0x7c(%ebx)
801042ef:	50                   	push   %eax
801042f0:	68 e4 79 10 80       	push   $0x801079e4
801042f5:	e8 b6 c3 ff ff       	call   801006b0 <cprintf>
801042fa:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042fd:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80104303:	75 d3                	jne    801042d8 <cps+0x48>
        cprintf("%s \t %d  \t RUNNABLE \t %d\n ", p->name, p->pid, p->priority );
      }
  }
  
  release(&ptable.lock);
80104305:	83 ec 0c             	sub    $0xc,%esp
80104308:	68 20 2d 11 80       	push   $0x80112d20
8010430d:	e8 ee 04 00 00       	call   80104800 <release>
  
  return 22;
}
80104312:	b8 16 00 00 00       	mov    $0x16,%eax
80104317:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010431a:	c9                   	leave  
8010431b:	c3                   	ret    
8010431c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf("%s \t %d  \t RUNNING \t %d\n", p->name, p->pid, p->priority );
80104320:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104323:	ff 73 7c             	pushl  0x7c(%ebx)
80104326:	ff 73 10             	pushl  0x10(%ebx)
80104329:	50                   	push   %eax
8010432a:	68 ff 79 10 80       	push   $0x801079ff
8010432f:	e8 7c c3 ff ff       	call   801006b0 <cprintf>
80104334:	83 c4 10             	add    $0x10,%esp
80104337:	eb 91                	jmp    801042ca <cps+0x3a>
80104339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        cprintf("%s \t %d  \t RUNNABLE \t %d\n ", p->name, p->pid, p->priority );
80104340:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104343:	ff 73 7c             	pushl  0x7c(%ebx)
80104346:	ff 73 10             	pushl  0x10(%ebx)
80104349:	50                   	push   %eax
8010434a:	68 18 7a 10 80       	push   $0x80107a18
8010434f:	e8 5c c3 ff ff       	call   801006b0 <cprintf>
80104354:	83 c4 10             	add    $0x10,%esp
80104357:	e9 6e ff ff ff       	jmp    801042ca <cps+0x3a>
8010435c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104360 <nps>:
//number of processes
//Seems like it would've been a lot more efficient to include this
//as a part of cps, but whatever.
int
nps()
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	53                   	push   %ebx
80104364:	83 ec 10             	sub    $0x10,%esp
80104367:	fb                   	sti    

  // Enable interrupts on this processor.
  sti();

  // Loop over process table looking for process with pid.
  acquire(&ptable.lock);
80104368:	68 20 2d 11 80       	push   $0x80112d20
	runTotal = 0;
8010436d:	31 db                	xor    %ebx,%ebx
  acquire(&ptable.lock);
8010436f:	e8 6c 03 00 00       	call   801046e0 <acquire>
80104374:	83 c4 10             	add    $0x10,%esp
  int sleepTotal = 0,
80104377:	31 c9                	xor    %ecx,%ecx

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104379:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010437e:	eb 17                	jmp    80104397 <nps+0x37>
      if ( p->state == SLEEPING ) {
	sleepTotal += 1;

      }
      else if ( p->state == RUNNING ) {
	runTotal += 1;
80104380:	83 fa 04             	cmp    $0x4,%edx
80104383:	0f 94 c2             	sete   %dl
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104386:	05 8c 00 00 00       	add    $0x8c,%eax
	runTotal += 1;
8010438b:	0f b6 d2             	movzbl %dl,%edx
8010438e:	01 d3                	add    %edx,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104390:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80104395:	74 17                	je     801043ae <nps+0x4e>
      if ( p->state == SLEEPING ) {
80104397:	8b 50 0c             	mov    0xc(%eax),%edx
8010439a:	83 fa 02             	cmp    $0x2,%edx
8010439d:	75 e1                	jne    80104380 <nps+0x20>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010439f:	05 8c 00 00 00       	add    $0x8c,%eax
	sleepTotal += 1;
801043a4:	83 c1 01             	add    $0x1,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043a7:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801043ac:	75 e9                	jne    80104397 <nps+0x37>

      }
  }

  cprintf("Total SLEEPING processes: %d\n", sleepTotal);
801043ae:	83 ec 08             	sub    $0x8,%esp
801043b1:	51                   	push   %ecx
801043b2:	68 33 7a 10 80       	push   $0x80107a33
801043b7:	e8 f4 c2 ff ff       	call   801006b0 <cprintf>
  cprintf("Total RUNNING processes: %d\n", runTotal);
801043bc:	58                   	pop    %eax
801043bd:	5a                   	pop    %edx
801043be:	53                   	push   %ebx
801043bf:	68 51 7a 10 80       	push   $0x80107a51
801043c4:	e8 e7 c2 ff ff       	call   801006b0 <cprintf>
  
  release(&ptable.lock);
801043c9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801043d0:	e8 2b 04 00 00       	call   80104800 <release>

  return 22;
}
801043d5:	b8 16 00 00 00       	mov    $0x16,%eax
801043da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043dd:	c9                   	leave  
801043de:	c3                   	ret    
801043df:	90                   	nop

801043e0 <chpr>:

//change priority
int
chpr( int pid, int priority )
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 10             	sub    $0x10,%esp
801043e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  
  acquire(&ptable.lock);
801043ea:	68 20 2d 11 80       	push   $0x80112d20
801043ef:	e8 ec 02 00 00       	call   801046e0 <acquire>
801043f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043f7:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
801043fc:	eb 10                	jmp    8010440e <chpr+0x2e>
801043fe:	66 90                	xchg   %ax,%ax
80104400:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80104406:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
8010440c:	74 0b                	je     80104419 <chpr+0x39>
    if(p->pid == pid ) {
8010440e:	39 5a 10             	cmp    %ebx,0x10(%edx)
80104411:	75 ed                	jne    80104400 <chpr+0x20>
        p->priority = priority;
80104413:	8b 45 0c             	mov    0xc(%ebp),%eax
80104416:	89 42 7c             	mov    %eax,0x7c(%edx)
        break;
    }
  }
  release(&ptable.lock);
80104419:	83 ec 0c             	sub    $0xc,%esp
8010441c:	68 20 2d 11 80       	push   $0x80112d20
80104421:	e8 da 03 00 00       	call   80104800 <release>

  return pid;
}
80104426:	89 d8                	mov    %ebx,%eax
80104428:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010442b:	c9                   	leave  
8010442c:	c3                   	ret    
8010442d:	8d 76 00             	lea    0x0(%esi),%esi

80104430 <setuid>:

//Edit for setting ids --- Colby Holloman
int
setuid(uint uid)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	56                   	push   %esi
80104434:	53                   	push   %ebx
80104435:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104438:	83 ec 0c             	sub    $0xc,%esp
8010443b:	68 20 2d 11 80       	push   $0x80112d20
80104440:	e8 9b 02 00 00       	call   801046e0 <acquire>
  pushcli();
80104445:	e8 46 02 00 00       	call   80104690 <pushcli>
  c = mycpu();
8010444a:	e8 21 f4 ff ff       	call   80103870 <mycpu>
  p = c->proc;
8010444f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104455:	e8 46 03 00 00       	call   801047a0 <popcli>

  myproc()->uid = uid;
8010445a:	89 9e 84 00 00 00    	mov    %ebx,0x84(%esi)

  release(&ptable.lock);	
80104460:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104467:	e8 94 03 00 00       	call   80104800 <release>

	return uid;
}
8010446c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010446f:	89 d8                	mov    %ebx,%eax
80104471:	5b                   	pop    %ebx
80104472:	5e                   	pop    %esi
80104473:	5d                   	pop    %ebp
80104474:	c3                   	ret    
80104475:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010447c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104480 <setgid>:

int
setgid(uint gid)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	56                   	push   %esi
80104484:	53                   	push   %ebx
80104485:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104488:	83 ec 0c             	sub    $0xc,%esp
8010448b:	68 20 2d 11 80       	push   $0x80112d20
80104490:	e8 4b 02 00 00       	call   801046e0 <acquire>
  pushcli();
80104495:	e8 f6 01 00 00       	call   80104690 <pushcli>
  c = mycpu();
8010449a:	e8 d1 f3 ff ff       	call   80103870 <mycpu>
  p = c->proc;
8010449f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801044a5:	e8 f6 02 00 00       	call   801047a0 <popcli>

  myproc()->gid = gid;
801044aa:	89 9e 88 00 00 00    	mov    %ebx,0x88(%esi)

  release(&ptable.lock);	
801044b0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801044b7:	e8 44 03 00 00       	call   80104800 <release>

	return gid;
}
801044bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044bf:	89 d8                	mov    %ebx,%eax
801044c1:	5b                   	pop    %ebx
801044c2:	5e                   	pop    %esi
801044c3:	5d                   	pop    %ebp
801044c4:	c3                   	ret    
801044c5:	66 90                	xchg   %ax,%ax
801044c7:	66 90                	xchg   %ax,%ax
801044c9:	66 90                	xchg   %ax,%ax
801044cb:	66 90                	xchg   %ax,%ax
801044cd:	66 90                	xchg   %ax,%ax
801044cf:	90                   	nop

801044d0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	83 ec 0c             	sub    $0xc,%esp
801044d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801044da:	68 48 7b 10 80       	push   $0x80107b48
801044df:	8d 43 04             	lea    0x4(%ebx),%eax
801044e2:	50                   	push   %eax
801044e3:	e8 f8 00 00 00       	call   801045e0 <initlock>
  lk->name = name;
801044e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801044eb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801044f1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801044f4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801044fb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801044fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104501:	c9                   	leave  
80104502:	c3                   	ret    
80104503:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010450a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104510 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	56                   	push   %esi
80104514:	53                   	push   %ebx
80104515:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104518:	8d 73 04             	lea    0x4(%ebx),%esi
8010451b:	83 ec 0c             	sub    $0xc,%esp
8010451e:	56                   	push   %esi
8010451f:	e8 bc 01 00 00       	call   801046e0 <acquire>
  while (lk->locked) {
80104524:	8b 13                	mov    (%ebx),%edx
80104526:	83 c4 10             	add    $0x10,%esp
80104529:	85 d2                	test   %edx,%edx
8010452b:	74 16                	je     80104543 <acquiresleep+0x33>
8010452d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104530:	83 ec 08             	sub    $0x8,%esp
80104533:	56                   	push   %esi
80104534:	53                   	push   %ebx
80104535:	e8 b6 f9 ff ff       	call   80103ef0 <sleep>
  while (lk->locked) {
8010453a:	8b 03                	mov    (%ebx),%eax
8010453c:	83 c4 10             	add    $0x10,%esp
8010453f:	85 c0                	test   %eax,%eax
80104541:	75 ed                	jne    80104530 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104543:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104549:	e8 c2 f3 ff ff       	call   80103910 <myproc>
8010454e:	8b 40 10             	mov    0x10(%eax),%eax
80104551:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104554:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104557:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010455a:	5b                   	pop    %ebx
8010455b:	5e                   	pop    %esi
8010455c:	5d                   	pop    %ebp
  release(&lk->lk);
8010455d:	e9 9e 02 00 00       	jmp    80104800 <release>
80104562:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104570 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	56                   	push   %esi
80104574:	53                   	push   %ebx
80104575:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104578:	8d 73 04             	lea    0x4(%ebx),%esi
8010457b:	83 ec 0c             	sub    $0xc,%esp
8010457e:	56                   	push   %esi
8010457f:	e8 5c 01 00 00       	call   801046e0 <acquire>
  lk->locked = 0;
80104584:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010458a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104591:	89 1c 24             	mov    %ebx,(%esp)
80104594:	e8 17 fb ff ff       	call   801040b0 <wakeup>
  release(&lk->lk);
80104599:	89 75 08             	mov    %esi,0x8(%ebp)
8010459c:	83 c4 10             	add    $0x10,%esp
}
8010459f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045a2:	5b                   	pop    %ebx
801045a3:	5e                   	pop    %esi
801045a4:	5d                   	pop    %ebp
  release(&lk->lk);
801045a5:	e9 56 02 00 00       	jmp    80104800 <release>
801045aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045b0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	56                   	push   %esi
801045b4:	53                   	push   %ebx
801045b5:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
801045b8:	8d 5e 04             	lea    0x4(%esi),%ebx
801045bb:	83 ec 0c             	sub    $0xc,%esp
801045be:	53                   	push   %ebx
801045bf:	e8 1c 01 00 00       	call   801046e0 <acquire>
  r = lk->locked;
801045c4:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
801045c6:	89 1c 24             	mov    %ebx,(%esp)
801045c9:	e8 32 02 00 00       	call   80104800 <release>
  return r;
}
801045ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045d1:	89 f0                	mov    %esi,%eax
801045d3:	5b                   	pop    %ebx
801045d4:	5e                   	pop    %esi
801045d5:	5d                   	pop    %ebp
801045d6:	c3                   	ret    
801045d7:	66 90                	xchg   %ax,%ax
801045d9:	66 90                	xchg   %ax,%ax
801045db:	66 90                	xchg   %ax,%ax
801045dd:	66 90                	xchg   %ax,%ax
801045df:	90                   	nop

801045e0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801045e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801045e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801045ef:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801045f2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801045f9:	5d                   	pop    %ebp
801045fa:	c3                   	ret    
801045fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045ff:	90                   	nop

80104600 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104600:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104601:	31 d2                	xor    %edx,%edx
{
80104603:	89 e5                	mov    %esp,%ebp
80104605:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104606:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104609:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010460c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010460f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104610:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104616:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010461c:	77 1a                	ja     80104638 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010461e:	8b 58 04             	mov    0x4(%eax),%ebx
80104621:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104624:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104627:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104629:	83 fa 0a             	cmp    $0xa,%edx
8010462c:	75 e2                	jne    80104610 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010462e:	5b                   	pop    %ebx
8010462f:	5d                   	pop    %ebp
80104630:	c3                   	ret    
80104631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104638:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010463b:	8d 51 28             	lea    0x28(%ecx),%edx
8010463e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104640:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104646:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104649:	39 c2                	cmp    %eax,%edx
8010464b:	75 f3                	jne    80104640 <getcallerpcs+0x40>
}
8010464d:	5b                   	pop    %ebx
8010464e:	5d                   	pop    %ebp
8010464f:	c3                   	ret    

80104650 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	53                   	push   %ebx
80104654:	83 ec 04             	sub    $0x4,%esp
80104657:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010465a:	8b 02                	mov    (%edx),%eax
8010465c:	85 c0                	test   %eax,%eax
8010465e:	75 10                	jne    80104670 <holding+0x20>
}
80104660:	83 c4 04             	add    $0x4,%esp
80104663:	31 c0                	xor    %eax,%eax
80104665:	5b                   	pop    %ebx
80104666:	5d                   	pop    %ebp
80104667:	c3                   	ret    
80104668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010466f:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
80104670:	8b 5a 08             	mov    0x8(%edx),%ebx
80104673:	e8 f8 f1 ff ff       	call   80103870 <mycpu>
80104678:	39 c3                	cmp    %eax,%ebx
8010467a:	0f 94 c0             	sete   %al
}
8010467d:	83 c4 04             	add    $0x4,%esp
  return lock->locked && lock->cpu == mycpu();
80104680:	0f b6 c0             	movzbl %al,%eax
}
80104683:	5b                   	pop    %ebx
80104684:	5d                   	pop    %ebp
80104685:	c3                   	ret    
80104686:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010468d:	8d 76 00             	lea    0x0(%esi),%esi

80104690 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	53                   	push   %ebx
80104694:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104697:	9c                   	pushf  
80104698:	5b                   	pop    %ebx
  asm volatile("cli");
80104699:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010469a:	e8 d1 f1 ff ff       	call   80103870 <mycpu>
8010469f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801046a5:	85 c0                	test   %eax,%eax
801046a7:	74 17                	je     801046c0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801046a9:	e8 c2 f1 ff ff       	call   80103870 <mycpu>
801046ae:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801046b5:	83 c4 04             	add    $0x4,%esp
801046b8:	5b                   	pop    %ebx
801046b9:	5d                   	pop    %ebp
801046ba:	c3                   	ret    
801046bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046bf:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
801046c0:	e8 ab f1 ff ff       	call   80103870 <mycpu>
801046c5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801046cb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801046d1:	eb d6                	jmp    801046a9 <pushcli+0x19>
801046d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046e0 <acquire>:
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	56                   	push   %esi
801046e4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801046e5:	e8 a6 ff ff ff       	call   80104690 <pushcli>
  if(holding(lk))
801046ea:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
801046ed:	8b 03                	mov    (%ebx),%eax
801046ef:	85 c0                	test   %eax,%eax
801046f1:	0f 85 81 00 00 00    	jne    80104778 <acquire+0x98>
  asm volatile("lock; xchgl %0, %1" :
801046f7:	ba 01 00 00 00       	mov    $0x1,%edx
801046fc:	eb 05                	jmp    80104703 <acquire+0x23>
801046fe:	66 90                	xchg   %ax,%ax
80104700:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104703:	89 d0                	mov    %edx,%eax
80104705:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104708:	85 c0                	test   %eax,%eax
8010470a:	75 f4                	jne    80104700 <acquire+0x20>
  __sync_synchronize();
8010470c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104711:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104714:	e8 57 f1 ff ff       	call   80103870 <mycpu>
  ebp = (uint*)v - 2;
80104719:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
8010471b:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
8010471e:	31 c0                	xor    %eax,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104720:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
80104726:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
8010472c:	77 22                	ja     80104750 <acquire+0x70>
    pcs[i] = ebp[1];     // saved %eip
8010472e:	8b 4a 04             	mov    0x4(%edx),%ecx
80104731:	89 4c 83 0c          	mov    %ecx,0xc(%ebx,%eax,4)
  for(i = 0; i < 10; i++){
80104735:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104738:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010473a:	83 f8 0a             	cmp    $0xa,%eax
8010473d:	75 e1                	jne    80104720 <acquire+0x40>
}
8010473f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104742:	5b                   	pop    %ebx
80104743:	5e                   	pop    %esi
80104744:	5d                   	pop    %ebp
80104745:	c3                   	ret    
80104746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010474d:	8d 76 00             	lea    0x0(%esi),%esi
80104750:	8d 44 83 0c          	lea    0xc(%ebx,%eax,4),%eax
80104754:	83 c3 34             	add    $0x34,%ebx
80104757:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010475e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104760:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104766:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104769:	39 c3                	cmp    %eax,%ebx
8010476b:	75 f3                	jne    80104760 <acquire+0x80>
}
8010476d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104770:	5b                   	pop    %ebx
80104771:	5e                   	pop    %esi
80104772:	5d                   	pop    %ebp
80104773:	c3                   	ret    
80104774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return lock->locked && lock->cpu == mycpu();
80104778:	8b 73 08             	mov    0x8(%ebx),%esi
8010477b:	e8 f0 f0 ff ff       	call   80103870 <mycpu>
80104780:	39 c6                	cmp    %eax,%esi
80104782:	0f 85 6f ff ff ff    	jne    801046f7 <acquire+0x17>
    panic("acquire");
80104788:	83 ec 0c             	sub    $0xc,%esp
8010478b:	68 53 7b 10 80       	push   $0x80107b53
80104790:	e8 fb bb ff ff       	call   80100390 <panic>
80104795:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010479c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047a0 <popcli>:

void
popcli(void)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801047a6:	9c                   	pushf  
801047a7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801047a8:	f6 c4 02             	test   $0x2,%ah
801047ab:	75 35                	jne    801047e2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801047ad:	e8 be f0 ff ff       	call   80103870 <mycpu>
801047b2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801047b9:	78 34                	js     801047ef <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801047bb:	e8 b0 f0 ff ff       	call   80103870 <mycpu>
801047c0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801047c6:	85 d2                	test   %edx,%edx
801047c8:	74 06                	je     801047d0 <popcli+0x30>
    sti();
}
801047ca:	c9                   	leave  
801047cb:	c3                   	ret    
801047cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801047d0:	e8 9b f0 ff ff       	call   80103870 <mycpu>
801047d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801047db:	85 c0                	test   %eax,%eax
801047dd:	74 eb                	je     801047ca <popcli+0x2a>
  asm volatile("sti");
801047df:	fb                   	sti    
}
801047e0:	c9                   	leave  
801047e1:	c3                   	ret    
    panic("popcli - interruptible");
801047e2:	83 ec 0c             	sub    $0xc,%esp
801047e5:	68 5b 7b 10 80       	push   $0x80107b5b
801047ea:	e8 a1 bb ff ff       	call   80100390 <panic>
    panic("popcli");
801047ef:	83 ec 0c             	sub    $0xc,%esp
801047f2:	68 72 7b 10 80       	push   $0x80107b72
801047f7:	e8 94 bb ff ff       	call   80100390 <panic>
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104800 <release>:
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	56                   	push   %esi
80104804:	53                   	push   %ebx
80104805:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
80104808:	8b 03                	mov    (%ebx),%eax
8010480a:	85 c0                	test   %eax,%eax
8010480c:	75 12                	jne    80104820 <release+0x20>
    panic("release");
8010480e:	83 ec 0c             	sub    $0xc,%esp
80104811:	68 79 7b 10 80       	push   $0x80107b79
80104816:	e8 75 bb ff ff       	call   80100390 <panic>
8010481b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010481f:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
80104820:	8b 73 08             	mov    0x8(%ebx),%esi
80104823:	e8 48 f0 ff ff       	call   80103870 <mycpu>
80104828:	39 c6                	cmp    %eax,%esi
8010482a:	75 e2                	jne    8010480e <release+0xe>
  lk->pcs[0] = 0;
8010482c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104833:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
8010483a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010483f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104845:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104848:	5b                   	pop    %ebx
80104849:	5e                   	pop    %esi
8010484a:	5d                   	pop    %ebp
  popcli();
8010484b:	e9 50 ff ff ff       	jmp    801047a0 <popcli>

80104850 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	57                   	push   %edi
80104854:	8b 55 08             	mov    0x8(%ebp),%edx
80104857:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010485a:	53                   	push   %ebx
8010485b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
8010485e:	89 d7                	mov    %edx,%edi
80104860:	09 cf                	or     %ecx,%edi
80104862:	83 e7 03             	and    $0x3,%edi
80104865:	75 29                	jne    80104890 <memset+0x40>
    c &= 0xFF;
80104867:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010486a:	c1 e0 18             	shl    $0x18,%eax
8010486d:	89 fb                	mov    %edi,%ebx
8010486f:	c1 e9 02             	shr    $0x2,%ecx
80104872:	c1 e3 10             	shl    $0x10,%ebx
80104875:	09 d8                	or     %ebx,%eax
80104877:	09 f8                	or     %edi,%eax
80104879:	c1 e7 08             	shl    $0x8,%edi
8010487c:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010487e:	89 d7                	mov    %edx,%edi
80104880:	fc                   	cld    
80104881:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104883:	5b                   	pop    %ebx
80104884:	89 d0                	mov    %edx,%eax
80104886:	5f                   	pop    %edi
80104887:	5d                   	pop    %ebp
80104888:	c3                   	ret    
80104889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104890:	89 d7                	mov    %edx,%edi
80104892:	fc                   	cld    
80104893:	f3 aa                	rep stos %al,%es:(%edi)
80104895:	5b                   	pop    %ebx
80104896:	89 d0                	mov    %edx,%eax
80104898:	5f                   	pop    %edi
80104899:	5d                   	pop    %ebp
8010489a:	c3                   	ret    
8010489b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010489f:	90                   	nop

801048a0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	56                   	push   %esi
801048a4:	8b 75 10             	mov    0x10(%ebp),%esi
801048a7:	8b 55 08             	mov    0x8(%ebp),%edx
801048aa:	53                   	push   %ebx
801048ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801048ae:	85 f6                	test   %esi,%esi
801048b0:	74 2e                	je     801048e0 <memcmp+0x40>
801048b2:	01 c6                	add    %eax,%esi
801048b4:	eb 14                	jmp    801048ca <memcmp+0x2a>
801048b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048bd:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801048c0:	83 c0 01             	add    $0x1,%eax
801048c3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801048c6:	39 f0                	cmp    %esi,%eax
801048c8:	74 16                	je     801048e0 <memcmp+0x40>
    if(*s1 != *s2)
801048ca:	0f b6 0a             	movzbl (%edx),%ecx
801048cd:	0f b6 18             	movzbl (%eax),%ebx
801048d0:	38 d9                	cmp    %bl,%cl
801048d2:	74 ec                	je     801048c0 <memcmp+0x20>
      return *s1 - *s2;
801048d4:	0f b6 c1             	movzbl %cl,%eax
801048d7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801048d9:	5b                   	pop    %ebx
801048da:	5e                   	pop    %esi
801048db:	5d                   	pop    %ebp
801048dc:	c3                   	ret    
801048dd:	8d 76 00             	lea    0x0(%esi),%esi
801048e0:	5b                   	pop    %ebx
  return 0;
801048e1:	31 c0                	xor    %eax,%eax
}
801048e3:	5e                   	pop    %esi
801048e4:	5d                   	pop    %ebp
801048e5:	c3                   	ret    
801048e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048ed:	8d 76 00             	lea    0x0(%esi),%esi

801048f0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	57                   	push   %edi
801048f4:	8b 55 08             	mov    0x8(%ebp),%edx
801048f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048fa:	56                   	push   %esi
801048fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801048fe:	39 d6                	cmp    %edx,%esi
80104900:	73 26                	jae    80104928 <memmove+0x38>
80104902:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104905:	39 fa                	cmp    %edi,%edx
80104907:	73 1f                	jae    80104928 <memmove+0x38>
80104909:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
8010490c:	85 c9                	test   %ecx,%ecx
8010490e:	74 0f                	je     8010491f <memmove+0x2f>
      *--d = *--s;
80104910:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104914:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104917:	83 e8 01             	sub    $0x1,%eax
8010491a:	83 f8 ff             	cmp    $0xffffffff,%eax
8010491d:	75 f1                	jne    80104910 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010491f:	5e                   	pop    %esi
80104920:	89 d0                	mov    %edx,%eax
80104922:	5f                   	pop    %edi
80104923:	5d                   	pop    %ebp
80104924:	c3                   	ret    
80104925:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80104928:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
8010492b:	89 d7                	mov    %edx,%edi
8010492d:	85 c9                	test   %ecx,%ecx
8010492f:	74 ee                	je     8010491f <memmove+0x2f>
80104931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104938:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104939:	39 f0                	cmp    %esi,%eax
8010493b:	75 fb                	jne    80104938 <memmove+0x48>
}
8010493d:	5e                   	pop    %esi
8010493e:	89 d0                	mov    %edx,%eax
80104940:	5f                   	pop    %edi
80104941:	5d                   	pop    %ebp
80104942:	c3                   	ret    
80104943:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010494a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104950 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104950:	eb 9e                	jmp    801048f0 <memmove>
80104952:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104960 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	56                   	push   %esi
80104964:	8b 75 10             	mov    0x10(%ebp),%esi
80104967:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010496a:	53                   	push   %ebx
8010496b:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
8010496e:	85 f6                	test   %esi,%esi
80104970:	74 36                	je     801049a8 <strncmp+0x48>
80104972:	01 c6                	add    %eax,%esi
80104974:	eb 18                	jmp    8010498e <strncmp+0x2e>
80104976:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010497d:	8d 76 00             	lea    0x0(%esi),%esi
80104980:	38 da                	cmp    %bl,%dl
80104982:	75 14                	jne    80104998 <strncmp+0x38>
    n--, p++, q++;
80104984:	83 c0 01             	add    $0x1,%eax
80104987:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010498a:	39 f0                	cmp    %esi,%eax
8010498c:	74 1a                	je     801049a8 <strncmp+0x48>
8010498e:	0f b6 11             	movzbl (%ecx),%edx
80104991:	0f b6 18             	movzbl (%eax),%ebx
80104994:	84 d2                	test   %dl,%dl
80104996:	75 e8                	jne    80104980 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104998:	0f b6 c2             	movzbl %dl,%eax
8010499b:	29 d8                	sub    %ebx,%eax
}
8010499d:	5b                   	pop    %ebx
8010499e:	5e                   	pop    %esi
8010499f:	5d                   	pop    %ebp
801049a0:	c3                   	ret    
801049a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049a8:	5b                   	pop    %ebx
    return 0;
801049a9:	31 c0                	xor    %eax,%eax
}
801049ab:	5e                   	pop    %esi
801049ac:	5d                   	pop    %ebp
801049ad:	c3                   	ret    
801049ae:	66 90                	xchg   %ax,%ax

801049b0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	57                   	push   %edi
801049b4:	56                   	push   %esi
801049b5:	8b 75 08             	mov    0x8(%ebp),%esi
801049b8:	53                   	push   %ebx
801049b9:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801049bc:	89 f2                	mov    %esi,%edx
801049be:	eb 17                	jmp    801049d7 <strncpy+0x27>
801049c0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801049c4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801049c7:	83 c2 01             	add    $0x1,%edx
801049ca:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
801049ce:	89 f9                	mov    %edi,%ecx
801049d0:	88 4a ff             	mov    %cl,-0x1(%edx)
801049d3:	84 c9                	test   %cl,%cl
801049d5:	74 09                	je     801049e0 <strncpy+0x30>
801049d7:	89 c3                	mov    %eax,%ebx
801049d9:	83 e8 01             	sub    $0x1,%eax
801049dc:	85 db                	test   %ebx,%ebx
801049de:	7f e0                	jg     801049c0 <strncpy+0x10>
    ;
  while(n-- > 0)
801049e0:	89 d1                	mov    %edx,%ecx
801049e2:	85 c0                	test   %eax,%eax
801049e4:	7e 1d                	jle    80104a03 <strncpy+0x53>
801049e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ed:	8d 76 00             	lea    0x0(%esi),%esi
    *s++ = 0;
801049f0:	83 c1 01             	add    $0x1,%ecx
801049f3:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
801049f7:	89 c8                	mov    %ecx,%eax
801049f9:	f7 d0                	not    %eax
801049fb:	01 d0                	add    %edx,%eax
801049fd:	01 d8                	add    %ebx,%eax
801049ff:	85 c0                	test   %eax,%eax
80104a01:	7f ed                	jg     801049f0 <strncpy+0x40>
  return os;
}
80104a03:	5b                   	pop    %ebx
80104a04:	89 f0                	mov    %esi,%eax
80104a06:	5e                   	pop    %esi
80104a07:	5f                   	pop    %edi
80104a08:	5d                   	pop    %ebp
80104a09:	c3                   	ret    
80104a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a10 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	56                   	push   %esi
80104a14:	8b 55 10             	mov    0x10(%ebp),%edx
80104a17:	8b 75 08             	mov    0x8(%ebp),%esi
80104a1a:	53                   	push   %ebx
80104a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104a1e:	85 d2                	test   %edx,%edx
80104a20:	7e 25                	jle    80104a47 <safestrcpy+0x37>
80104a22:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104a26:	89 f2                	mov    %esi,%edx
80104a28:	eb 16                	jmp    80104a40 <safestrcpy+0x30>
80104a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104a30:	0f b6 08             	movzbl (%eax),%ecx
80104a33:	83 c0 01             	add    $0x1,%eax
80104a36:	83 c2 01             	add    $0x1,%edx
80104a39:	88 4a ff             	mov    %cl,-0x1(%edx)
80104a3c:	84 c9                	test   %cl,%cl
80104a3e:	74 04                	je     80104a44 <safestrcpy+0x34>
80104a40:	39 d8                	cmp    %ebx,%eax
80104a42:	75 ec                	jne    80104a30 <safestrcpy+0x20>
    ;
  *s = 0;
80104a44:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104a47:	89 f0                	mov    %esi,%eax
80104a49:	5b                   	pop    %ebx
80104a4a:	5e                   	pop    %esi
80104a4b:	5d                   	pop    %ebp
80104a4c:	c3                   	ret    
80104a4d:	8d 76 00             	lea    0x0(%esi),%esi

80104a50 <strlen>:

int
strlen(const char *s)
{
80104a50:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104a51:	31 c0                	xor    %eax,%eax
{
80104a53:	89 e5                	mov    %esp,%ebp
80104a55:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104a58:	80 3a 00             	cmpb   $0x0,(%edx)
80104a5b:	74 0c                	je     80104a69 <strlen+0x19>
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi
80104a60:	83 c0 01             	add    $0x1,%eax
80104a63:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104a67:	75 f7                	jne    80104a60 <strlen+0x10>
    ;
  return n;
}
80104a69:	5d                   	pop    %ebp
80104a6a:	c3                   	ret    

80104a6b <swtch>:
80104a6b:	8b 44 24 04          	mov    0x4(%esp),%eax
80104a6f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104a73:	55                   	push   %ebp
80104a74:	53                   	push   %ebx
80104a75:	56                   	push   %esi
80104a76:	57                   	push   %edi
80104a77:	89 20                	mov    %esp,(%eax)
80104a79:	89 d4                	mov    %edx,%esp
80104a7b:	5f                   	pop    %edi
80104a7c:	5e                   	pop    %esi
80104a7d:	5b                   	pop    %ebx
80104a7e:	5d                   	pop    %ebp
80104a7f:	c3                   	ret    

80104a80 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	53                   	push   %ebx
80104a84:	83 ec 04             	sub    $0x4,%esp
80104a87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104a8a:	e8 81 ee ff ff       	call   80103910 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a8f:	8b 00                	mov    (%eax),%eax
80104a91:	39 d8                	cmp    %ebx,%eax
80104a93:	76 1b                	jbe    80104ab0 <fetchint+0x30>
80104a95:	8d 53 04             	lea    0x4(%ebx),%edx
80104a98:	39 d0                	cmp    %edx,%eax
80104a9a:	72 14                	jb     80104ab0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a9f:	8b 13                	mov    (%ebx),%edx
80104aa1:	89 10                	mov    %edx,(%eax)
  return 0;
80104aa3:	31 c0                	xor    %eax,%eax
}
80104aa5:	83 c4 04             	add    $0x4,%esp
80104aa8:	5b                   	pop    %ebx
80104aa9:	5d                   	pop    %ebp
80104aaa:	c3                   	ret    
80104aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104aaf:	90                   	nop
    return -1;
80104ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ab5:	eb ee                	jmp    80104aa5 <fetchint+0x25>
80104ab7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104abe:	66 90                	xchg   %ax,%ax

80104ac0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	53                   	push   %ebx
80104ac4:	83 ec 04             	sub    $0x4,%esp
80104ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104aca:	e8 41 ee ff ff       	call   80103910 <myproc>

  if(addr >= curproc->sz)
80104acf:	39 18                	cmp    %ebx,(%eax)
80104ad1:	76 29                	jbe    80104afc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104ad3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ad6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104ad8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104ada:	39 d3                	cmp    %edx,%ebx
80104adc:	73 1e                	jae    80104afc <fetchstr+0x3c>
    if(*s == 0)
80104ade:	80 3b 00             	cmpb   $0x0,(%ebx)
80104ae1:	74 35                	je     80104b18 <fetchstr+0x58>
80104ae3:	89 d8                	mov    %ebx,%eax
80104ae5:	eb 0e                	jmp    80104af5 <fetchstr+0x35>
80104ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aee:	66 90                	xchg   %ax,%ax
80104af0:	80 38 00             	cmpb   $0x0,(%eax)
80104af3:	74 1b                	je     80104b10 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104af5:	83 c0 01             	add    $0x1,%eax
80104af8:	39 c2                	cmp    %eax,%edx
80104afa:	77 f4                	ja     80104af0 <fetchstr+0x30>
    return -1;
80104afc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104b01:	83 c4 04             	add    $0x4,%esp
80104b04:	5b                   	pop    %ebx
80104b05:	5d                   	pop    %ebp
80104b06:	c3                   	ret    
80104b07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b0e:	66 90                	xchg   %ax,%ax
80104b10:	83 c4 04             	add    $0x4,%esp
80104b13:	29 d8                	sub    %ebx,%eax
80104b15:	5b                   	pop    %ebx
80104b16:	5d                   	pop    %ebp
80104b17:	c3                   	ret    
    if(*s == 0)
80104b18:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104b1a:	eb e5                	jmp    80104b01 <fetchstr+0x41>
80104b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	56                   	push   %esi
80104b24:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b25:	e8 e6 ed ff ff       	call   80103910 <myproc>
80104b2a:	8b 55 08             	mov    0x8(%ebp),%edx
80104b2d:	8b 40 18             	mov    0x18(%eax),%eax
80104b30:	8b 40 44             	mov    0x44(%eax),%eax
80104b33:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104b36:	e8 d5 ed ff ff       	call   80103910 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b3b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b3e:	8b 00                	mov    (%eax),%eax
80104b40:	39 c6                	cmp    %eax,%esi
80104b42:	73 1c                	jae    80104b60 <argint+0x40>
80104b44:	8d 53 08             	lea    0x8(%ebx),%edx
80104b47:	39 d0                	cmp    %edx,%eax
80104b49:	72 15                	jb     80104b60 <argint+0x40>
  *ip = *(int*)(addr);
80104b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b4e:	8b 53 04             	mov    0x4(%ebx),%edx
80104b51:	89 10                	mov    %edx,(%eax)
  return 0;
80104b53:	31 c0                	xor    %eax,%eax
}
80104b55:	5b                   	pop    %ebx
80104b56:	5e                   	pop    %esi
80104b57:	5d                   	pop    %ebp
80104b58:	c3                   	ret    
80104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b65:	eb ee                	jmp    80104b55 <argint+0x35>
80104b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b6e:	66 90                	xchg   %ax,%ax

80104b70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	56                   	push   %esi
80104b74:	53                   	push   %ebx
80104b75:	83 ec 10             	sub    $0x10,%esp
80104b78:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104b7b:	e8 90 ed ff ff       	call   80103910 <myproc>
 
  if(argint(n, &i) < 0)
80104b80:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80104b83:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
80104b85:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b88:	50                   	push   %eax
80104b89:	ff 75 08             	pushl  0x8(%ebp)
80104b8c:	e8 8f ff ff ff       	call   80104b20 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104b91:	83 c4 10             	add    $0x10,%esp
80104b94:	85 c0                	test   %eax,%eax
80104b96:	78 28                	js     80104bc0 <argptr+0x50>
80104b98:	85 db                	test   %ebx,%ebx
80104b9a:	78 24                	js     80104bc0 <argptr+0x50>
80104b9c:	8b 16                	mov    (%esi),%edx
80104b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ba1:	39 c2                	cmp    %eax,%edx
80104ba3:	76 1b                	jbe    80104bc0 <argptr+0x50>
80104ba5:	01 c3                	add    %eax,%ebx
80104ba7:	39 da                	cmp    %ebx,%edx
80104ba9:	72 15                	jb     80104bc0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104bab:	8b 55 0c             	mov    0xc(%ebp),%edx
80104bae:	89 02                	mov    %eax,(%edx)
  return 0;
80104bb0:	31 c0                	xor    %eax,%eax
}
80104bb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bb5:	5b                   	pop    %ebx
80104bb6:	5e                   	pop    %esi
80104bb7:	5d                   	pop    %ebp
80104bb8:	c3                   	ret    
80104bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bc5:	eb eb                	jmp    80104bb2 <argptr+0x42>
80104bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bce:	66 90                	xchg   %ax,%ax

80104bd0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104bd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bd9:	50                   	push   %eax
80104bda:	ff 75 08             	pushl  0x8(%ebp)
80104bdd:	e8 3e ff ff ff       	call   80104b20 <argint>
80104be2:	83 c4 10             	add    $0x10,%esp
80104be5:	85 c0                	test   %eax,%eax
80104be7:	78 17                	js     80104c00 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104be9:	83 ec 08             	sub    $0x8,%esp
80104bec:	ff 75 0c             	pushl  0xc(%ebp)
80104bef:	ff 75 f4             	pushl  -0xc(%ebp)
80104bf2:	e8 c9 fe ff ff       	call   80104ac0 <fetchstr>
80104bf7:	83 c4 10             	add    $0x10,%esp
}
80104bfa:	c9                   	leave  
80104bfb:	c3                   	ret    
80104bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c00:	c9                   	leave  
    return -1;
80104c01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c06:	c3                   	ret    
80104c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c0e:	66 90                	xchg   %ax,%ax

80104c10 <syscall>:
[SYS_setgid]  sys_setgid,
};

void
syscall(void)
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	53                   	push   %ebx
80104c14:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104c17:	e8 f4 ec ff ff       	call   80103910 <myproc>
80104c1c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104c1e:	8b 40 18             	mov    0x18(%eax),%eax
80104c21:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104c24:	8d 50 ff             	lea    -0x1(%eax),%edx
80104c27:	83 fa 1d             	cmp    $0x1d,%edx
80104c2a:	77 1c                	ja     80104c48 <syscall+0x38>
80104c2c:	8b 14 85 a0 7b 10 80 	mov    -0x7fef8460(,%eax,4),%edx
80104c33:	85 d2                	test   %edx,%edx
80104c35:	74 11                	je     80104c48 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104c37:	ff d2                	call   *%edx
80104c39:	8b 53 18             	mov    0x18(%ebx),%edx
80104c3c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104c3f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c42:	c9                   	leave  
80104c43:	c3                   	ret    
80104c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104c48:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104c49:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104c4c:	50                   	push   %eax
80104c4d:	ff 73 10             	pushl  0x10(%ebx)
80104c50:	68 81 7b 10 80       	push   $0x80107b81
80104c55:	e8 56 ba ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80104c5a:	8b 43 18             	mov    0x18(%ebx),%eax
80104c5d:	83 c4 10             	add    $0x10,%esp
80104c60:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104c67:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c6a:	c9                   	leave  
80104c6b:	c3                   	ret    
80104c6c:	66 90                	xchg   %ax,%ax
80104c6e:	66 90                	xchg   %ax,%ax

80104c70 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	57                   	push   %edi
80104c74:	56                   	push   %esi
80104c75:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104c76:	8d 5d da             	lea    -0x26(%ebp),%ebx
{
80104c79:	83 ec 44             	sub    $0x44,%esp
80104c7c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104c7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104c82:	53                   	push   %ebx
80104c83:	50                   	push   %eax
{
80104c84:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104c87:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104c8a:	e8 61 d3 ff ff       	call   80101ff0 <nameiparent>
80104c8f:	83 c4 10             	add    $0x10,%esp
80104c92:	85 c0                	test   %eax,%eax
80104c94:	0f 84 46 01 00 00    	je     80104de0 <create+0x170>
    return 0;
  ilock(dp);
80104c9a:	83 ec 0c             	sub    $0xc,%esp
80104c9d:	89 c6                	mov    %eax,%esi
80104c9f:	50                   	push   %eax
80104ca0:	e8 8b ca ff ff       	call   80101730 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104ca5:	83 c4 0c             	add    $0xc,%esp
80104ca8:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104cab:	50                   	push   %eax
80104cac:	53                   	push   %ebx
80104cad:	56                   	push   %esi
80104cae:	e8 ad cf ff ff       	call   80101c60 <dirlookup>
80104cb3:	83 c4 10             	add    $0x10,%esp
80104cb6:	89 c7                	mov    %eax,%edi
80104cb8:	85 c0                	test   %eax,%eax
80104cba:	74 54                	je     80104d10 <create+0xa0>
    iunlockput(dp);
80104cbc:	83 ec 0c             	sub    $0xc,%esp
80104cbf:	56                   	push   %esi
80104cc0:	e8 fb cc ff ff       	call   801019c0 <iunlockput>
    ilock(ip);
80104cc5:	89 3c 24             	mov    %edi,(%esp)
80104cc8:	e8 63 ca ff ff       	call   80101730 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104ccd:	83 c4 10             	add    $0x10,%esp
80104cd0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104cd5:	75 19                	jne    80104cf0 <create+0x80>
80104cd7:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104cdc:	75 12                	jne    80104cf0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104cde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ce1:	89 f8                	mov    %edi,%eax
80104ce3:	5b                   	pop    %ebx
80104ce4:	5e                   	pop    %esi
80104ce5:	5f                   	pop    %edi
80104ce6:	5d                   	pop    %ebp
80104ce7:	c3                   	ret    
80104ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cef:	90                   	nop
    iunlockput(ip);
80104cf0:	83 ec 0c             	sub    $0xc,%esp
80104cf3:	57                   	push   %edi
    return 0;
80104cf4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104cf6:	e8 c5 cc ff ff       	call   801019c0 <iunlockput>
    return 0;
80104cfb:	83 c4 10             	add    $0x10,%esp
}
80104cfe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d01:	89 f8                	mov    %edi,%eax
80104d03:	5b                   	pop    %ebx
80104d04:	5e                   	pop    %esi
80104d05:	5f                   	pop    %edi
80104d06:	5d                   	pop    %ebp
80104d07:	c3                   	ret    
80104d08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d0f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104d10:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104d14:	83 ec 08             	sub    $0x8,%esp
80104d17:	50                   	push   %eax
80104d18:	ff 36                	pushl  (%esi)
80104d1a:	e8 a1 c8 ff ff       	call   801015c0 <ialloc>
80104d1f:	83 c4 10             	add    $0x10,%esp
80104d22:	89 c7                	mov    %eax,%edi
80104d24:	85 c0                	test   %eax,%eax
80104d26:	0f 84 cd 00 00 00    	je     80104df9 <create+0x189>
  ilock(ip);
80104d2c:	83 ec 0c             	sub    $0xc,%esp
80104d2f:	50                   	push   %eax
80104d30:	e8 fb c9 ff ff       	call   80101730 <ilock>
  ip->major = major;
80104d35:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104d39:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104d3d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104d41:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104d45:	b8 01 00 00 00       	mov    $0x1,%eax
80104d4a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104d4e:	89 3c 24             	mov    %edi,(%esp)
80104d51:	e8 2a c9 ff ff       	call   80101680 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104d56:	83 c4 10             	add    $0x10,%esp
80104d59:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104d5e:	74 30                	je     80104d90 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104d60:	83 ec 04             	sub    $0x4,%esp
80104d63:	ff 77 04             	pushl  0x4(%edi)
80104d66:	53                   	push   %ebx
80104d67:	56                   	push   %esi
80104d68:	e8 a3 d1 ff ff       	call   80101f10 <dirlink>
80104d6d:	83 c4 10             	add    $0x10,%esp
80104d70:	85 c0                	test   %eax,%eax
80104d72:	78 78                	js     80104dec <create+0x17c>
  iunlockput(dp);
80104d74:	83 ec 0c             	sub    $0xc,%esp
80104d77:	56                   	push   %esi
80104d78:	e8 43 cc ff ff       	call   801019c0 <iunlockput>
  return ip;
80104d7d:	83 c4 10             	add    $0x10,%esp
}
80104d80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d83:	89 f8                	mov    %edi,%eax
80104d85:	5b                   	pop    %ebx
80104d86:	5e                   	pop    %esi
80104d87:	5f                   	pop    %edi
80104d88:	5d                   	pop    %ebp
80104d89:	c3                   	ret    
80104d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104d90:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104d93:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80104d98:	56                   	push   %esi
80104d99:	e8 e2 c8 ff ff       	call   80101680 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104d9e:	83 c4 0c             	add    $0xc,%esp
80104da1:	ff 77 04             	pushl  0x4(%edi)
80104da4:	68 38 7c 10 80       	push   $0x80107c38
80104da9:	57                   	push   %edi
80104daa:	e8 61 d1 ff ff       	call   80101f10 <dirlink>
80104daf:	83 c4 10             	add    $0x10,%esp
80104db2:	85 c0                	test   %eax,%eax
80104db4:	78 18                	js     80104dce <create+0x15e>
80104db6:	83 ec 04             	sub    $0x4,%esp
80104db9:	ff 76 04             	pushl  0x4(%esi)
80104dbc:	68 37 7c 10 80       	push   $0x80107c37
80104dc1:	57                   	push   %edi
80104dc2:	e8 49 d1 ff ff       	call   80101f10 <dirlink>
80104dc7:	83 c4 10             	add    $0x10,%esp
80104dca:	85 c0                	test   %eax,%eax
80104dcc:	79 92                	jns    80104d60 <create+0xf0>
      panic("create dots");
80104dce:	83 ec 0c             	sub    $0xc,%esp
80104dd1:	68 2b 7c 10 80       	push   $0x80107c2b
80104dd6:	e8 b5 b5 ff ff       	call   80100390 <panic>
80104ddb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ddf:	90                   	nop
}
80104de0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104de3:	31 ff                	xor    %edi,%edi
}
80104de5:	5b                   	pop    %ebx
80104de6:	89 f8                	mov    %edi,%eax
80104de8:	5e                   	pop    %esi
80104de9:	5f                   	pop    %edi
80104dea:	5d                   	pop    %ebp
80104deb:	c3                   	ret    
    panic("create: dirlink");
80104dec:	83 ec 0c             	sub    $0xc,%esp
80104def:	68 3a 7c 10 80       	push   $0x80107c3a
80104df4:	e8 97 b5 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104df9:	83 ec 0c             	sub    $0xc,%esp
80104dfc:	68 1c 7c 10 80       	push   $0x80107c1c
80104e01:	e8 8a b5 ff ff       	call   80100390 <panic>
80104e06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e0d:	8d 76 00             	lea    0x0(%esi),%esi

80104e10 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	56                   	push   %esi
80104e14:	89 d6                	mov    %edx,%esi
80104e16:	53                   	push   %ebx
80104e17:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104e19:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104e1c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e1f:	50                   	push   %eax
80104e20:	6a 00                	push   $0x0
80104e22:	e8 f9 fc ff ff       	call   80104b20 <argint>
80104e27:	83 c4 10             	add    $0x10,%esp
80104e2a:	85 c0                	test   %eax,%eax
80104e2c:	78 2a                	js     80104e58 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e2e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e32:	77 24                	ja     80104e58 <argfd.constprop.0+0x48>
80104e34:	e8 d7 ea ff ff       	call   80103910 <myproc>
80104e39:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e3c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104e40:	85 c0                	test   %eax,%eax
80104e42:	74 14                	je     80104e58 <argfd.constprop.0+0x48>
  if(pfd)
80104e44:	85 db                	test   %ebx,%ebx
80104e46:	74 02                	je     80104e4a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104e48:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104e4a:	89 06                	mov    %eax,(%esi)
  return 0;
80104e4c:	31 c0                	xor    %eax,%eax
}
80104e4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e51:	5b                   	pop    %ebx
80104e52:	5e                   	pop    %esi
80104e53:	5d                   	pop    %ebp
80104e54:	c3                   	ret    
80104e55:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104e58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e5d:	eb ef                	jmp    80104e4e <argfd.constprop.0+0x3e>
80104e5f:	90                   	nop

80104e60 <sys_dup>:
{
80104e60:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104e61:	31 c0                	xor    %eax,%eax
{
80104e63:	89 e5                	mov    %esp,%ebp
80104e65:	56                   	push   %esi
80104e66:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104e67:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104e6a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104e6d:	e8 9e ff ff ff       	call   80104e10 <argfd.constprop.0>
80104e72:	85 c0                	test   %eax,%eax
80104e74:	78 1a                	js     80104e90 <sys_dup+0x30>
  if((fd=fdalloc(f)) < 0)
80104e76:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104e79:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104e7b:	e8 90 ea ff ff       	call   80103910 <myproc>
    if(curproc->ofile[fd] == 0){
80104e80:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104e84:	85 d2                	test   %edx,%edx
80104e86:	74 18                	je     80104ea0 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
80104e88:	83 c3 01             	add    $0x1,%ebx
80104e8b:	83 fb 10             	cmp    $0x10,%ebx
80104e8e:	75 f0                	jne    80104e80 <sys_dup+0x20>
}
80104e90:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104e93:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104e98:	89 d8                	mov    %ebx,%eax
80104e9a:	5b                   	pop    %ebx
80104e9b:	5e                   	pop    %esi
80104e9c:	5d                   	pop    %ebp
80104e9d:	c3                   	ret    
80104e9e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80104ea0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104ea4:	83 ec 0c             	sub    $0xc,%esp
80104ea7:	ff 75 f4             	pushl  -0xc(%ebp)
80104eaa:	e8 d1 bf ff ff       	call   80100e80 <filedup>
  return fd;
80104eaf:	83 c4 10             	add    $0x10,%esp
}
80104eb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eb5:	89 d8                	mov    %ebx,%eax
80104eb7:	5b                   	pop    %ebx
80104eb8:	5e                   	pop    %esi
80104eb9:	5d                   	pop    %ebp
80104eba:	c3                   	ret    
80104ebb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ebf:	90                   	nop

80104ec0 <sys_read>:
{
80104ec0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ec1:	31 c0                	xor    %eax,%eax
{
80104ec3:	89 e5                	mov    %esp,%ebp
80104ec5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ec8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ecb:	e8 40 ff ff ff       	call   80104e10 <argfd.constprop.0>
80104ed0:	85 c0                	test   %eax,%eax
80104ed2:	78 4c                	js     80104f20 <sys_read+0x60>
80104ed4:	83 ec 08             	sub    $0x8,%esp
80104ed7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104eda:	50                   	push   %eax
80104edb:	6a 02                	push   $0x2
80104edd:	e8 3e fc ff ff       	call   80104b20 <argint>
80104ee2:	83 c4 10             	add    $0x10,%esp
80104ee5:	85 c0                	test   %eax,%eax
80104ee7:	78 37                	js     80104f20 <sys_read+0x60>
80104ee9:	83 ec 04             	sub    $0x4,%esp
80104eec:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104eef:	ff 75 f0             	pushl  -0x10(%ebp)
80104ef2:	50                   	push   %eax
80104ef3:	6a 01                	push   $0x1
80104ef5:	e8 76 fc ff ff       	call   80104b70 <argptr>
80104efa:	83 c4 10             	add    $0x10,%esp
80104efd:	85 c0                	test   %eax,%eax
80104eff:	78 1f                	js     80104f20 <sys_read+0x60>
  return fileread(f, p, n);
80104f01:	83 ec 04             	sub    $0x4,%esp
80104f04:	ff 75 f0             	pushl  -0x10(%ebp)
80104f07:	ff 75 f4             	pushl  -0xc(%ebp)
80104f0a:	ff 75 ec             	pushl  -0x14(%ebp)
80104f0d:	e8 ee c0 ff ff       	call   80101000 <fileread>
80104f12:	83 c4 10             	add    $0x10,%esp
}
80104f15:	c9                   	leave  
80104f16:	c3                   	ret    
80104f17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f1e:	66 90                	xchg   %ax,%ax
80104f20:	c9                   	leave  
    return -1;
80104f21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f26:	c3                   	ret    
80104f27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f2e:	66 90                	xchg   %ax,%ax

80104f30 <sys_write>:
{
80104f30:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f31:	31 c0                	xor    %eax,%eax
{
80104f33:	89 e5                	mov    %esp,%ebp
80104f35:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f38:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f3b:	e8 d0 fe ff ff       	call   80104e10 <argfd.constprop.0>
80104f40:	85 c0                	test   %eax,%eax
80104f42:	78 4c                	js     80104f90 <sys_write+0x60>
80104f44:	83 ec 08             	sub    $0x8,%esp
80104f47:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f4a:	50                   	push   %eax
80104f4b:	6a 02                	push   $0x2
80104f4d:	e8 ce fb ff ff       	call   80104b20 <argint>
80104f52:	83 c4 10             	add    $0x10,%esp
80104f55:	85 c0                	test   %eax,%eax
80104f57:	78 37                	js     80104f90 <sys_write+0x60>
80104f59:	83 ec 04             	sub    $0x4,%esp
80104f5c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f5f:	ff 75 f0             	pushl  -0x10(%ebp)
80104f62:	50                   	push   %eax
80104f63:	6a 01                	push   $0x1
80104f65:	e8 06 fc ff ff       	call   80104b70 <argptr>
80104f6a:	83 c4 10             	add    $0x10,%esp
80104f6d:	85 c0                	test   %eax,%eax
80104f6f:	78 1f                	js     80104f90 <sys_write+0x60>
  return filewrite(f, p, n);
80104f71:	83 ec 04             	sub    $0x4,%esp
80104f74:	ff 75 f0             	pushl  -0x10(%ebp)
80104f77:	ff 75 f4             	pushl  -0xc(%ebp)
80104f7a:	ff 75 ec             	pushl  -0x14(%ebp)
80104f7d:	e8 0e c1 ff ff       	call   80101090 <filewrite>
80104f82:	83 c4 10             	add    $0x10,%esp
}
80104f85:	c9                   	leave  
80104f86:	c3                   	ret    
80104f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f8e:	66 90                	xchg   %ax,%ax
80104f90:	c9                   	leave  
    return -1;
80104f91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f96:	c3                   	ret    
80104f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f9e:	66 90                	xchg   %ax,%ax

80104fa0 <sys_close>:
{
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104fa6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104fa9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fac:	e8 5f fe ff ff       	call   80104e10 <argfd.constprop.0>
80104fb1:	85 c0                	test   %eax,%eax
80104fb3:	78 2b                	js     80104fe0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104fb5:	e8 56 e9 ff ff       	call   80103910 <myproc>
80104fba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104fbd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104fc0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104fc7:	00 
  fileclose(f);
80104fc8:	ff 75 f4             	pushl  -0xc(%ebp)
80104fcb:	e8 00 bf ff ff       	call   80100ed0 <fileclose>
  return 0;
80104fd0:	83 c4 10             	add    $0x10,%esp
80104fd3:	31 c0                	xor    %eax,%eax
}
80104fd5:	c9                   	leave  
80104fd6:	c3                   	ret    
80104fd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fde:	66 90                	xchg   %ax,%ax
80104fe0:	c9                   	leave  
    return -1;
80104fe1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fe6:	c3                   	ret    
80104fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fee:	66 90                	xchg   %ax,%ax

80104ff0 <sys_fstat>:
{
80104ff0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ff1:	31 c0                	xor    %eax,%eax
{
80104ff3:	89 e5                	mov    %esp,%ebp
80104ff5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ff8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104ffb:	e8 10 fe ff ff       	call   80104e10 <argfd.constprop.0>
80105000:	85 c0                	test   %eax,%eax
80105002:	78 2c                	js     80105030 <sys_fstat+0x40>
80105004:	83 ec 04             	sub    $0x4,%esp
80105007:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010500a:	6a 14                	push   $0x14
8010500c:	50                   	push   %eax
8010500d:	6a 01                	push   $0x1
8010500f:	e8 5c fb ff ff       	call   80104b70 <argptr>
80105014:	83 c4 10             	add    $0x10,%esp
80105017:	85 c0                	test   %eax,%eax
80105019:	78 15                	js     80105030 <sys_fstat+0x40>
  return filestat(f, st);
8010501b:	83 ec 08             	sub    $0x8,%esp
8010501e:	ff 75 f4             	pushl  -0xc(%ebp)
80105021:	ff 75 f0             	pushl  -0x10(%ebp)
80105024:	e8 87 bf ff ff       	call   80100fb0 <filestat>
80105029:	83 c4 10             	add    $0x10,%esp
}
8010502c:	c9                   	leave  
8010502d:	c3                   	ret    
8010502e:	66 90                	xchg   %ax,%ax
80105030:	c9                   	leave  
    return -1;
80105031:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105036:	c3                   	ret    
80105037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010503e:	66 90                	xchg   %ax,%ax

80105040 <sys_link>:
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	57                   	push   %edi
80105044:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105045:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105048:	53                   	push   %ebx
80105049:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010504c:	50                   	push   %eax
8010504d:	6a 00                	push   $0x0
8010504f:	e8 7c fb ff ff       	call   80104bd0 <argstr>
80105054:	83 c4 10             	add    $0x10,%esp
80105057:	85 c0                	test   %eax,%eax
80105059:	0f 88 fb 00 00 00    	js     8010515a <sys_link+0x11a>
8010505f:	83 ec 08             	sub    $0x8,%esp
80105062:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105065:	50                   	push   %eax
80105066:	6a 01                	push   $0x1
80105068:	e8 63 fb ff ff       	call   80104bd0 <argstr>
8010506d:	83 c4 10             	add    $0x10,%esp
80105070:	85 c0                	test   %eax,%eax
80105072:	0f 88 e2 00 00 00    	js     8010515a <sys_link+0x11a>
  begin_op();
80105078:	e8 33 dc ff ff       	call   80102cb0 <begin_op>
  if((ip = namei(old)) == 0){
8010507d:	83 ec 0c             	sub    $0xc,%esp
80105080:	ff 75 d4             	pushl  -0x2c(%ebp)
80105083:	e8 48 cf ff ff       	call   80101fd0 <namei>
80105088:	83 c4 10             	add    $0x10,%esp
8010508b:	89 c3                	mov    %eax,%ebx
8010508d:	85 c0                	test   %eax,%eax
8010508f:	0f 84 e4 00 00 00    	je     80105179 <sys_link+0x139>
  ilock(ip);
80105095:	83 ec 0c             	sub    $0xc,%esp
80105098:	50                   	push   %eax
80105099:	e8 92 c6 ff ff       	call   80101730 <ilock>
  if(ip->type == T_DIR){
8010509e:	83 c4 10             	add    $0x10,%esp
801050a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050a6:	0f 84 b5 00 00 00    	je     80105161 <sys_link+0x121>
  iupdate(ip);
801050ac:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801050af:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801050b4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801050b7:	53                   	push   %ebx
801050b8:	e8 c3 c5 ff ff       	call   80101680 <iupdate>
  iunlock(ip);
801050bd:	89 1c 24             	mov    %ebx,(%esp)
801050c0:	e8 4b c7 ff ff       	call   80101810 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801050c5:	58                   	pop    %eax
801050c6:	5a                   	pop    %edx
801050c7:	57                   	push   %edi
801050c8:	ff 75 d0             	pushl  -0x30(%ebp)
801050cb:	e8 20 cf ff ff       	call   80101ff0 <nameiparent>
801050d0:	83 c4 10             	add    $0x10,%esp
801050d3:	89 c6                	mov    %eax,%esi
801050d5:	85 c0                	test   %eax,%eax
801050d7:	74 5b                	je     80105134 <sys_link+0xf4>
  ilock(dp);
801050d9:	83 ec 0c             	sub    $0xc,%esp
801050dc:	50                   	push   %eax
801050dd:	e8 4e c6 ff ff       	call   80101730 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801050e2:	83 c4 10             	add    $0x10,%esp
801050e5:	8b 03                	mov    (%ebx),%eax
801050e7:	39 06                	cmp    %eax,(%esi)
801050e9:	75 3d                	jne    80105128 <sys_link+0xe8>
801050eb:	83 ec 04             	sub    $0x4,%esp
801050ee:	ff 73 04             	pushl  0x4(%ebx)
801050f1:	57                   	push   %edi
801050f2:	56                   	push   %esi
801050f3:	e8 18 ce ff ff       	call   80101f10 <dirlink>
801050f8:	83 c4 10             	add    $0x10,%esp
801050fb:	85 c0                	test   %eax,%eax
801050fd:	78 29                	js     80105128 <sys_link+0xe8>
  iunlockput(dp);
801050ff:	83 ec 0c             	sub    $0xc,%esp
80105102:	56                   	push   %esi
80105103:	e8 b8 c8 ff ff       	call   801019c0 <iunlockput>
  iput(ip);
80105108:	89 1c 24             	mov    %ebx,(%esp)
8010510b:	e8 50 c7 ff ff       	call   80101860 <iput>
  end_op();
80105110:	e8 0b dc ff ff       	call   80102d20 <end_op>
  return 0;
80105115:	83 c4 10             	add    $0x10,%esp
80105118:	31 c0                	xor    %eax,%eax
}
8010511a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010511d:	5b                   	pop    %ebx
8010511e:	5e                   	pop    %esi
8010511f:	5f                   	pop    %edi
80105120:	5d                   	pop    %ebp
80105121:	c3                   	ret    
80105122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105128:	83 ec 0c             	sub    $0xc,%esp
8010512b:	56                   	push   %esi
8010512c:	e8 8f c8 ff ff       	call   801019c0 <iunlockput>
    goto bad;
80105131:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105134:	83 ec 0c             	sub    $0xc,%esp
80105137:	53                   	push   %ebx
80105138:	e8 f3 c5 ff ff       	call   80101730 <ilock>
  ip->nlink--;
8010513d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105142:	89 1c 24             	mov    %ebx,(%esp)
80105145:	e8 36 c5 ff ff       	call   80101680 <iupdate>
  iunlockput(ip);
8010514a:	89 1c 24             	mov    %ebx,(%esp)
8010514d:	e8 6e c8 ff ff       	call   801019c0 <iunlockput>
  end_op();
80105152:	e8 c9 db ff ff       	call   80102d20 <end_op>
  return -1;
80105157:	83 c4 10             	add    $0x10,%esp
8010515a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010515f:	eb b9                	jmp    8010511a <sys_link+0xda>
    iunlockput(ip);
80105161:	83 ec 0c             	sub    $0xc,%esp
80105164:	53                   	push   %ebx
80105165:	e8 56 c8 ff ff       	call   801019c0 <iunlockput>
    end_op();
8010516a:	e8 b1 db ff ff       	call   80102d20 <end_op>
    return -1;
8010516f:	83 c4 10             	add    $0x10,%esp
80105172:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105177:	eb a1                	jmp    8010511a <sys_link+0xda>
    end_op();
80105179:	e8 a2 db ff ff       	call   80102d20 <end_op>
    return -1;
8010517e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105183:	eb 95                	jmp    8010511a <sys_link+0xda>
80105185:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010518c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105190 <sys_unlink>:
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	57                   	push   %edi
80105194:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105195:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105198:	53                   	push   %ebx
80105199:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010519c:	50                   	push   %eax
8010519d:	6a 00                	push   $0x0
8010519f:	e8 2c fa ff ff       	call   80104bd0 <argstr>
801051a4:	83 c4 10             	add    $0x10,%esp
801051a7:	85 c0                	test   %eax,%eax
801051a9:	0f 88 91 01 00 00    	js     80105340 <sys_unlink+0x1b0>
  begin_op();
801051af:	e8 fc da ff ff       	call   80102cb0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801051b4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801051b7:	83 ec 08             	sub    $0x8,%esp
801051ba:	53                   	push   %ebx
801051bb:	ff 75 c0             	pushl  -0x40(%ebp)
801051be:	e8 2d ce ff ff       	call   80101ff0 <nameiparent>
801051c3:	83 c4 10             	add    $0x10,%esp
801051c6:	89 c6                	mov    %eax,%esi
801051c8:	85 c0                	test   %eax,%eax
801051ca:	0f 84 7a 01 00 00    	je     8010534a <sys_unlink+0x1ba>
  ilock(dp);
801051d0:	83 ec 0c             	sub    $0xc,%esp
801051d3:	50                   	push   %eax
801051d4:	e8 57 c5 ff ff       	call   80101730 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801051d9:	58                   	pop    %eax
801051da:	5a                   	pop    %edx
801051db:	68 38 7c 10 80       	push   $0x80107c38
801051e0:	53                   	push   %ebx
801051e1:	e8 5a ca ff ff       	call   80101c40 <namecmp>
801051e6:	83 c4 10             	add    $0x10,%esp
801051e9:	85 c0                	test   %eax,%eax
801051eb:	0f 84 0f 01 00 00    	je     80105300 <sys_unlink+0x170>
801051f1:	83 ec 08             	sub    $0x8,%esp
801051f4:	68 37 7c 10 80       	push   $0x80107c37
801051f9:	53                   	push   %ebx
801051fa:	e8 41 ca ff ff       	call   80101c40 <namecmp>
801051ff:	83 c4 10             	add    $0x10,%esp
80105202:	85 c0                	test   %eax,%eax
80105204:	0f 84 f6 00 00 00    	je     80105300 <sys_unlink+0x170>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010520a:	83 ec 04             	sub    $0x4,%esp
8010520d:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105210:	50                   	push   %eax
80105211:	53                   	push   %ebx
80105212:	56                   	push   %esi
80105213:	e8 48 ca ff ff       	call   80101c60 <dirlookup>
80105218:	83 c4 10             	add    $0x10,%esp
8010521b:	89 c3                	mov    %eax,%ebx
8010521d:	85 c0                	test   %eax,%eax
8010521f:	0f 84 db 00 00 00    	je     80105300 <sys_unlink+0x170>
  ilock(ip);
80105225:	83 ec 0c             	sub    $0xc,%esp
80105228:	50                   	push   %eax
80105229:	e8 02 c5 ff ff       	call   80101730 <ilock>
  if(ip->nlink < 1)
8010522e:	83 c4 10             	add    $0x10,%esp
80105231:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105236:	0f 8e 37 01 00 00    	jle    80105373 <sys_unlink+0x1e3>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010523c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105241:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105244:	74 6a                	je     801052b0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105246:	83 ec 04             	sub    $0x4,%esp
80105249:	6a 10                	push   $0x10
8010524b:	6a 00                	push   $0x0
8010524d:	57                   	push   %edi
8010524e:	e8 fd f5 ff ff       	call   80104850 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105253:	6a 10                	push   $0x10
80105255:	ff 75 c4             	pushl  -0x3c(%ebp)
80105258:	57                   	push   %edi
80105259:	56                   	push   %esi
8010525a:	e8 b1 c8 ff ff       	call   80101b10 <writei>
8010525f:	83 c4 20             	add    $0x20,%esp
80105262:	83 f8 10             	cmp    $0x10,%eax
80105265:	0f 85 fb 00 00 00    	jne    80105366 <sys_unlink+0x1d6>
  if(ip->type == T_DIR){
8010526b:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105270:	0f 84 aa 00 00 00    	je     80105320 <sys_unlink+0x190>
  iunlockput(dp);
80105276:	83 ec 0c             	sub    $0xc,%esp
80105279:	56                   	push   %esi
8010527a:	e8 41 c7 ff ff       	call   801019c0 <iunlockput>
  ip->nlink--;
8010527f:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105284:	89 1c 24             	mov    %ebx,(%esp)
80105287:	e8 f4 c3 ff ff       	call   80101680 <iupdate>
  iunlockput(ip);
8010528c:	89 1c 24             	mov    %ebx,(%esp)
8010528f:	e8 2c c7 ff ff       	call   801019c0 <iunlockput>
  end_op();
80105294:	e8 87 da ff ff       	call   80102d20 <end_op>
  return 0;
80105299:	83 c4 10             	add    $0x10,%esp
8010529c:	31 c0                	xor    %eax,%eax
}
8010529e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052a1:	5b                   	pop    %ebx
801052a2:	5e                   	pop    %esi
801052a3:	5f                   	pop    %edi
801052a4:	5d                   	pop    %ebp
801052a5:	c3                   	ret    
801052a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801052b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801052b4:	76 90                	jbe    80105246 <sys_unlink+0xb6>
801052b6:	ba 20 00 00 00       	mov    $0x20,%edx
801052bb:	eb 0f                	jmp    801052cc <sys_unlink+0x13c>
801052bd:	8d 76 00             	lea    0x0(%esi),%esi
801052c0:	83 c2 10             	add    $0x10,%edx
801052c3:	39 53 58             	cmp    %edx,0x58(%ebx)
801052c6:	0f 86 7a ff ff ff    	jbe    80105246 <sys_unlink+0xb6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052cc:	6a 10                	push   $0x10
801052ce:	52                   	push   %edx
801052cf:	57                   	push   %edi
801052d0:	53                   	push   %ebx
801052d1:	89 55 b4             	mov    %edx,-0x4c(%ebp)
801052d4:	e8 37 c7 ff ff       	call   80101a10 <readi>
801052d9:	83 c4 10             	add    $0x10,%esp
801052dc:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801052df:	83 f8 10             	cmp    $0x10,%eax
801052e2:	75 75                	jne    80105359 <sys_unlink+0x1c9>
    if(de.inum != 0)
801052e4:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801052e9:	74 d5                	je     801052c0 <sys_unlink+0x130>
    iunlockput(ip);
801052eb:	83 ec 0c             	sub    $0xc,%esp
801052ee:	53                   	push   %ebx
801052ef:	e8 cc c6 ff ff       	call   801019c0 <iunlockput>
    goto bad;
801052f4:	83 c4 10             	add    $0x10,%esp
801052f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052fe:	66 90                	xchg   %ax,%ax
  iunlockput(dp);
80105300:	83 ec 0c             	sub    $0xc,%esp
80105303:	56                   	push   %esi
80105304:	e8 b7 c6 ff ff       	call   801019c0 <iunlockput>
  end_op();
80105309:	e8 12 da ff ff       	call   80102d20 <end_op>
  return -1;
8010530e:	83 c4 10             	add    $0x10,%esp
80105311:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105316:	eb 86                	jmp    8010529e <sys_unlink+0x10e>
80105318:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010531f:	90                   	nop
    iupdate(dp);
80105320:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105323:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105328:	56                   	push   %esi
80105329:	e8 52 c3 ff ff       	call   80101680 <iupdate>
8010532e:	83 c4 10             	add    $0x10,%esp
80105331:	e9 40 ff ff ff       	jmp    80105276 <sys_unlink+0xe6>
80105336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010533d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105345:	e9 54 ff ff ff       	jmp    8010529e <sys_unlink+0x10e>
    end_op();
8010534a:	e8 d1 d9 ff ff       	call   80102d20 <end_op>
    return -1;
8010534f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105354:	e9 45 ff ff ff       	jmp    8010529e <sys_unlink+0x10e>
      panic("isdirempty: readi");
80105359:	83 ec 0c             	sub    $0xc,%esp
8010535c:	68 5c 7c 10 80       	push   $0x80107c5c
80105361:	e8 2a b0 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105366:	83 ec 0c             	sub    $0xc,%esp
80105369:	68 6e 7c 10 80       	push   $0x80107c6e
8010536e:	e8 1d b0 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105373:	83 ec 0c             	sub    $0xc,%esp
80105376:	68 4a 7c 10 80       	push   $0x80107c4a
8010537b:	e8 10 b0 ff ff       	call   80100390 <panic>

80105380 <sys_open>:

int
sys_open(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	57                   	push   %edi
80105384:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105385:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105388:	53                   	push   %ebx
80105389:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010538c:	50                   	push   %eax
8010538d:	6a 00                	push   $0x0
8010538f:	e8 3c f8 ff ff       	call   80104bd0 <argstr>
80105394:	83 c4 10             	add    $0x10,%esp
80105397:	85 c0                	test   %eax,%eax
80105399:	0f 88 8e 00 00 00    	js     8010542d <sys_open+0xad>
8010539f:	83 ec 08             	sub    $0x8,%esp
801053a2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801053a5:	50                   	push   %eax
801053a6:	6a 01                	push   $0x1
801053a8:	e8 73 f7 ff ff       	call   80104b20 <argint>
801053ad:	83 c4 10             	add    $0x10,%esp
801053b0:	85 c0                	test   %eax,%eax
801053b2:	78 79                	js     8010542d <sys_open+0xad>
    return -1;

  begin_op();
801053b4:	e8 f7 d8 ff ff       	call   80102cb0 <begin_op>

  if(omode & O_CREATE){
801053b9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801053bd:	75 79                	jne    80105438 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801053bf:	83 ec 0c             	sub    $0xc,%esp
801053c2:	ff 75 e0             	pushl  -0x20(%ebp)
801053c5:	e8 06 cc ff ff       	call   80101fd0 <namei>
801053ca:	83 c4 10             	add    $0x10,%esp
801053cd:	89 c6                	mov    %eax,%esi
801053cf:	85 c0                	test   %eax,%eax
801053d1:	0f 84 7e 00 00 00    	je     80105455 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801053d7:	83 ec 0c             	sub    $0xc,%esp
801053da:	50                   	push   %eax
801053db:	e8 50 c3 ff ff       	call   80101730 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801053e0:	83 c4 10             	add    $0x10,%esp
801053e3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801053e8:	0f 84 c2 00 00 00    	je     801054b0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801053ee:	e8 1d ba ff ff       	call   80100e10 <filealloc>
801053f3:	89 c7                	mov    %eax,%edi
801053f5:	85 c0                	test   %eax,%eax
801053f7:	74 23                	je     8010541c <sys_open+0x9c>
  struct proc *curproc = myproc();
801053f9:	e8 12 e5 ff ff       	call   80103910 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801053fe:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105400:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105404:	85 d2                	test   %edx,%edx
80105406:	74 60                	je     80105468 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105408:	83 c3 01             	add    $0x1,%ebx
8010540b:	83 fb 10             	cmp    $0x10,%ebx
8010540e:	75 f0                	jne    80105400 <sys_open+0x80>
    if(f)
      fileclose(f);
80105410:	83 ec 0c             	sub    $0xc,%esp
80105413:	57                   	push   %edi
80105414:	e8 b7 ba ff ff       	call   80100ed0 <fileclose>
80105419:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010541c:	83 ec 0c             	sub    $0xc,%esp
8010541f:	56                   	push   %esi
80105420:	e8 9b c5 ff ff       	call   801019c0 <iunlockput>
    end_op();
80105425:	e8 f6 d8 ff ff       	call   80102d20 <end_op>
    return -1;
8010542a:	83 c4 10             	add    $0x10,%esp
8010542d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105432:	eb 6d                	jmp    801054a1 <sys_open+0x121>
80105434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105438:	83 ec 0c             	sub    $0xc,%esp
8010543b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010543e:	31 c9                	xor    %ecx,%ecx
80105440:	ba 02 00 00 00       	mov    $0x2,%edx
80105445:	6a 00                	push   $0x0
80105447:	e8 24 f8 ff ff       	call   80104c70 <create>
    if(ip == 0){
8010544c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010544f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105451:	85 c0                	test   %eax,%eax
80105453:	75 99                	jne    801053ee <sys_open+0x6e>
      end_op();
80105455:	e8 c6 d8 ff ff       	call   80102d20 <end_op>
      return -1;
8010545a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010545f:	eb 40                	jmp    801054a1 <sys_open+0x121>
80105461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105468:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010546b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010546f:	56                   	push   %esi
80105470:	e8 9b c3 ff ff       	call   80101810 <iunlock>
  end_op();
80105475:	e8 a6 d8 ff ff       	call   80102d20 <end_op>

  f->type = FD_INODE;
8010547a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105480:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105483:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105486:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105489:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010548b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105492:	f7 d0                	not    %eax
80105494:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105497:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010549a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010549d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801054a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054a4:	89 d8                	mov    %ebx,%eax
801054a6:	5b                   	pop    %ebx
801054a7:	5e                   	pop    %esi
801054a8:	5f                   	pop    %edi
801054a9:	5d                   	pop    %ebp
801054aa:	c3                   	ret    
801054ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054af:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801054b0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801054b3:	85 c9                	test   %ecx,%ecx
801054b5:	0f 84 33 ff ff ff    	je     801053ee <sys_open+0x6e>
801054bb:	e9 5c ff ff ff       	jmp    8010541c <sys_open+0x9c>

801054c0 <sys_mkdir>:

int
sys_mkdir(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801054c6:	e8 e5 d7 ff ff       	call   80102cb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801054cb:	83 ec 08             	sub    $0x8,%esp
801054ce:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054d1:	50                   	push   %eax
801054d2:	6a 00                	push   $0x0
801054d4:	e8 f7 f6 ff ff       	call   80104bd0 <argstr>
801054d9:	83 c4 10             	add    $0x10,%esp
801054dc:	85 c0                	test   %eax,%eax
801054de:	78 30                	js     80105510 <sys_mkdir+0x50>
801054e0:	83 ec 0c             	sub    $0xc,%esp
801054e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054e6:	31 c9                	xor    %ecx,%ecx
801054e8:	ba 01 00 00 00       	mov    $0x1,%edx
801054ed:	6a 00                	push   $0x0
801054ef:	e8 7c f7 ff ff       	call   80104c70 <create>
801054f4:	83 c4 10             	add    $0x10,%esp
801054f7:	85 c0                	test   %eax,%eax
801054f9:	74 15                	je     80105510 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801054fb:	83 ec 0c             	sub    $0xc,%esp
801054fe:	50                   	push   %eax
801054ff:	e8 bc c4 ff ff       	call   801019c0 <iunlockput>
  end_op();
80105504:	e8 17 d8 ff ff       	call   80102d20 <end_op>
  return 0;
80105509:	83 c4 10             	add    $0x10,%esp
8010550c:	31 c0                	xor    %eax,%eax
}
8010550e:	c9                   	leave  
8010550f:	c3                   	ret    
    end_op();
80105510:	e8 0b d8 ff ff       	call   80102d20 <end_op>
    return -1;
80105515:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010551a:	c9                   	leave  
8010551b:	c3                   	ret    
8010551c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105520 <sys_mknod>:

int
sys_mknod(void)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105526:	e8 85 d7 ff ff       	call   80102cb0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010552b:	83 ec 08             	sub    $0x8,%esp
8010552e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105531:	50                   	push   %eax
80105532:	6a 00                	push   $0x0
80105534:	e8 97 f6 ff ff       	call   80104bd0 <argstr>
80105539:	83 c4 10             	add    $0x10,%esp
8010553c:	85 c0                	test   %eax,%eax
8010553e:	78 60                	js     801055a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105540:	83 ec 08             	sub    $0x8,%esp
80105543:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105546:	50                   	push   %eax
80105547:	6a 01                	push   $0x1
80105549:	e8 d2 f5 ff ff       	call   80104b20 <argint>
  if((argstr(0, &path)) < 0 ||
8010554e:	83 c4 10             	add    $0x10,%esp
80105551:	85 c0                	test   %eax,%eax
80105553:	78 4b                	js     801055a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105555:	83 ec 08             	sub    $0x8,%esp
80105558:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010555b:	50                   	push   %eax
8010555c:	6a 02                	push   $0x2
8010555e:	e8 bd f5 ff ff       	call   80104b20 <argint>
     argint(1, &major) < 0 ||
80105563:	83 c4 10             	add    $0x10,%esp
80105566:	85 c0                	test   %eax,%eax
80105568:	78 36                	js     801055a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010556a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010556e:	83 ec 0c             	sub    $0xc,%esp
80105571:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105575:	ba 03 00 00 00       	mov    $0x3,%edx
8010557a:	50                   	push   %eax
8010557b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010557e:	e8 ed f6 ff ff       	call   80104c70 <create>
     argint(2, &minor) < 0 ||
80105583:	83 c4 10             	add    $0x10,%esp
80105586:	85 c0                	test   %eax,%eax
80105588:	74 16                	je     801055a0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010558a:	83 ec 0c             	sub    $0xc,%esp
8010558d:	50                   	push   %eax
8010558e:	e8 2d c4 ff ff       	call   801019c0 <iunlockput>
  end_op();
80105593:	e8 88 d7 ff ff       	call   80102d20 <end_op>
  return 0;
80105598:	83 c4 10             	add    $0x10,%esp
8010559b:	31 c0                	xor    %eax,%eax
}
8010559d:	c9                   	leave  
8010559e:	c3                   	ret    
8010559f:	90                   	nop
    end_op();
801055a0:	e8 7b d7 ff ff       	call   80102d20 <end_op>
    return -1;
801055a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055aa:	c9                   	leave  
801055ab:	c3                   	ret    
801055ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055b0 <sys_chdir>:

int
sys_chdir(void)
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	56                   	push   %esi
801055b4:	53                   	push   %ebx
801055b5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801055b8:	e8 53 e3 ff ff       	call   80103910 <myproc>
801055bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801055bf:	e8 ec d6 ff ff       	call   80102cb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801055c4:	83 ec 08             	sub    $0x8,%esp
801055c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055ca:	50                   	push   %eax
801055cb:	6a 00                	push   $0x0
801055cd:	e8 fe f5 ff ff       	call   80104bd0 <argstr>
801055d2:	83 c4 10             	add    $0x10,%esp
801055d5:	85 c0                	test   %eax,%eax
801055d7:	78 77                	js     80105650 <sys_chdir+0xa0>
801055d9:	83 ec 0c             	sub    $0xc,%esp
801055dc:	ff 75 f4             	pushl  -0xc(%ebp)
801055df:	e8 ec c9 ff ff       	call   80101fd0 <namei>
801055e4:	83 c4 10             	add    $0x10,%esp
801055e7:	89 c3                	mov    %eax,%ebx
801055e9:	85 c0                	test   %eax,%eax
801055eb:	74 63                	je     80105650 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801055ed:	83 ec 0c             	sub    $0xc,%esp
801055f0:	50                   	push   %eax
801055f1:	e8 3a c1 ff ff       	call   80101730 <ilock>
  if(ip->type != T_DIR){
801055f6:	83 c4 10             	add    $0x10,%esp
801055f9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055fe:	75 30                	jne    80105630 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105600:	83 ec 0c             	sub    $0xc,%esp
80105603:	53                   	push   %ebx
80105604:	e8 07 c2 ff ff       	call   80101810 <iunlock>
  iput(curproc->cwd);
80105609:	58                   	pop    %eax
8010560a:	ff 76 68             	pushl  0x68(%esi)
8010560d:	e8 4e c2 ff ff       	call   80101860 <iput>
  end_op();
80105612:	e8 09 d7 ff ff       	call   80102d20 <end_op>
  curproc->cwd = ip;
80105617:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010561a:	83 c4 10             	add    $0x10,%esp
8010561d:	31 c0                	xor    %eax,%eax
}
8010561f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105622:	5b                   	pop    %ebx
80105623:	5e                   	pop    %esi
80105624:	5d                   	pop    %ebp
80105625:	c3                   	ret    
80105626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010562d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105630:	83 ec 0c             	sub    $0xc,%esp
80105633:	53                   	push   %ebx
80105634:	e8 87 c3 ff ff       	call   801019c0 <iunlockput>
    end_op();
80105639:	e8 e2 d6 ff ff       	call   80102d20 <end_op>
    return -1;
8010563e:	83 c4 10             	add    $0x10,%esp
80105641:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105646:	eb d7                	jmp    8010561f <sys_chdir+0x6f>
80105648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010564f:	90                   	nop
    end_op();
80105650:	e8 cb d6 ff ff       	call   80102d20 <end_op>
    return -1;
80105655:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010565a:	eb c3                	jmp    8010561f <sys_chdir+0x6f>
8010565c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105660 <sys_exec>:

int
sys_exec(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	57                   	push   %edi
80105664:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105665:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010566b:	53                   	push   %ebx
8010566c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105672:	50                   	push   %eax
80105673:	6a 00                	push   $0x0
80105675:	e8 56 f5 ff ff       	call   80104bd0 <argstr>
8010567a:	83 c4 10             	add    $0x10,%esp
8010567d:	85 c0                	test   %eax,%eax
8010567f:	0f 88 87 00 00 00    	js     8010570c <sys_exec+0xac>
80105685:	83 ec 08             	sub    $0x8,%esp
80105688:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010568e:	50                   	push   %eax
8010568f:	6a 01                	push   $0x1
80105691:	e8 8a f4 ff ff       	call   80104b20 <argint>
80105696:	83 c4 10             	add    $0x10,%esp
80105699:	85 c0                	test   %eax,%eax
8010569b:	78 6f                	js     8010570c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010569d:	83 ec 04             	sub    $0x4,%esp
801056a0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
801056a6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801056a8:	68 80 00 00 00       	push   $0x80
801056ad:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801056b3:	6a 00                	push   $0x0
801056b5:	50                   	push   %eax
801056b6:	e8 95 f1 ff ff       	call   80104850 <memset>
801056bb:	83 c4 10             	add    $0x10,%esp
801056be:	66 90                	xchg   %ax,%ax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801056c0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801056c6:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801056cd:	83 ec 08             	sub    $0x8,%esp
801056d0:	57                   	push   %edi
801056d1:	01 f0                	add    %esi,%eax
801056d3:	50                   	push   %eax
801056d4:	e8 a7 f3 ff ff       	call   80104a80 <fetchint>
801056d9:	83 c4 10             	add    $0x10,%esp
801056dc:	85 c0                	test   %eax,%eax
801056de:	78 2c                	js     8010570c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801056e0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801056e6:	85 c0                	test   %eax,%eax
801056e8:	74 36                	je     80105720 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801056ea:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801056f0:	83 ec 08             	sub    $0x8,%esp
801056f3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801056f6:	52                   	push   %edx
801056f7:	50                   	push   %eax
801056f8:	e8 c3 f3 ff ff       	call   80104ac0 <fetchstr>
801056fd:	83 c4 10             	add    $0x10,%esp
80105700:	85 c0                	test   %eax,%eax
80105702:	78 08                	js     8010570c <sys_exec+0xac>
  for(i=0;; i++){
80105704:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105707:	83 fb 20             	cmp    $0x20,%ebx
8010570a:	75 b4                	jne    801056c0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010570c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010570f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105714:	5b                   	pop    %ebx
80105715:	5e                   	pop    %esi
80105716:	5f                   	pop    %edi
80105717:	5d                   	pop    %ebp
80105718:	c3                   	ret    
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105720:	83 ec 08             	sub    $0x8,%esp
80105723:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105729:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105730:	00 00 00 00 
  return exec(path, argv);
80105734:	50                   	push   %eax
80105735:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010573b:	e8 40 b3 ff ff       	call   80100a80 <exec>
80105740:	83 c4 10             	add    $0x10,%esp
}
80105743:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105746:	5b                   	pop    %ebx
80105747:	5e                   	pop    %esi
80105748:	5f                   	pop    %edi
80105749:	5d                   	pop    %ebp
8010574a:	c3                   	ret    
8010574b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010574f:	90                   	nop

80105750 <sys_pipe>:

int
sys_pipe(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	57                   	push   %edi
80105754:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105755:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105758:	53                   	push   %ebx
80105759:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010575c:	6a 08                	push   $0x8
8010575e:	50                   	push   %eax
8010575f:	6a 00                	push   $0x0
80105761:	e8 0a f4 ff ff       	call   80104b70 <argptr>
80105766:	83 c4 10             	add    $0x10,%esp
80105769:	85 c0                	test   %eax,%eax
8010576b:	78 4a                	js     801057b7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010576d:	83 ec 08             	sub    $0x8,%esp
80105770:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105773:	50                   	push   %eax
80105774:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105777:	50                   	push   %eax
80105778:	e8 e3 db ff ff       	call   80103360 <pipealloc>
8010577d:	83 c4 10             	add    $0x10,%esp
80105780:	85 c0                	test   %eax,%eax
80105782:	78 33                	js     801057b7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105784:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105787:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105789:	e8 82 e1 ff ff       	call   80103910 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010578e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105790:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105794:	85 f6                	test   %esi,%esi
80105796:	74 28                	je     801057c0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105798:	83 c3 01             	add    $0x1,%ebx
8010579b:	83 fb 10             	cmp    $0x10,%ebx
8010579e:	75 f0                	jne    80105790 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801057a0:	83 ec 0c             	sub    $0xc,%esp
801057a3:	ff 75 e0             	pushl  -0x20(%ebp)
801057a6:	e8 25 b7 ff ff       	call   80100ed0 <fileclose>
    fileclose(wf);
801057ab:	58                   	pop    %eax
801057ac:	ff 75 e4             	pushl  -0x1c(%ebp)
801057af:	e8 1c b7 ff ff       	call   80100ed0 <fileclose>
    return -1;
801057b4:	83 c4 10             	add    $0x10,%esp
801057b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057bc:	eb 53                	jmp    80105811 <sys_pipe+0xc1>
801057be:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801057c0:	8d 73 08             	lea    0x8(%ebx),%esi
801057c3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057c7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801057ca:	e8 41 e1 ff ff       	call   80103910 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801057cf:	31 d2                	xor    %edx,%edx
801057d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801057d8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801057dc:	85 c9                	test   %ecx,%ecx
801057de:	74 20                	je     80105800 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
801057e0:	83 c2 01             	add    $0x1,%edx
801057e3:	83 fa 10             	cmp    $0x10,%edx
801057e6:	75 f0                	jne    801057d8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
801057e8:	e8 23 e1 ff ff       	call   80103910 <myproc>
801057ed:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801057f4:	00 
801057f5:	eb a9                	jmp    801057a0 <sys_pipe+0x50>
801057f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057fe:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105800:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105804:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105807:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105809:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010580c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010580f:	31 c0                	xor    %eax,%eax
}
80105811:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105814:	5b                   	pop    %ebx
80105815:	5e                   	pop    %esi
80105816:	5f                   	pop    %edi
80105817:	5d                   	pop    %ebp
80105818:	c3                   	ret    
80105819:	66 90                	xchg   %ax,%ax
8010581b:	66 90                	xchg   %ax,%ax
8010581d:	66 90                	xchg   %ax,%ax
8010581f:	90                   	nop

80105820 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105820:	e9 8b e2 ff ff       	jmp    80103ab0 <fork>
80105825:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010582c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105830 <sys_exit>:
}

int
sys_exit(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	83 ec 08             	sub    $0x8,%esp
  exit();
80105836:	e8 35 e5 ff ff       	call   80103d70 <exit>
  return 0;  // not reached
}
8010583b:	31 c0                	xor    %eax,%eax
8010583d:	c9                   	leave  
8010583e:	c3                   	ret    
8010583f:	90                   	nop

80105840 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105840:	e9 6b e7 ff ff       	jmp    80103fb0 <wait>
80105845:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010584c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105850 <sys_kill>:
}

int
sys_kill(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105856:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105859:	50                   	push   %eax
8010585a:	6a 00                	push   $0x0
8010585c:	e8 bf f2 ff ff       	call   80104b20 <argint>
80105861:	83 c4 10             	add    $0x10,%esp
80105864:	85 c0                	test   %eax,%eax
80105866:	78 18                	js     80105880 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105868:	83 ec 0c             	sub    $0xc,%esp
8010586b:	ff 75 f4             	pushl  -0xc(%ebp)
8010586e:	e8 9d e8 ff ff       	call   80104110 <kill>
80105873:	83 c4 10             	add    $0x10,%esp
}
80105876:	c9                   	leave  
80105877:	c3                   	ret    
80105878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010587f:	90                   	nop
80105880:	c9                   	leave  
    return -1;
80105881:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105886:	c3                   	ret    
80105887:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010588e:	66 90                	xchg   %ax,%ax

80105890 <sys_getpid>:

int
sys_getpid(void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105896:	e8 75 e0 ff ff       	call   80103910 <myproc>
8010589b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010589e:	c9                   	leave  
8010589f:	c3                   	ret    

801058a0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058a7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801058aa:	50                   	push   %eax
801058ab:	6a 00                	push   $0x0
801058ad:	e8 6e f2 ff ff       	call   80104b20 <argint>
801058b2:	83 c4 10             	add    $0x10,%esp
801058b5:	85 c0                	test   %eax,%eax
801058b7:	78 27                	js     801058e0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801058b9:	e8 52 e0 ff ff       	call   80103910 <myproc>
  if(growproc(n) < 0)
801058be:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801058c1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801058c3:	ff 75 f4             	pushl  -0xc(%ebp)
801058c6:	e8 65 e1 ff ff       	call   80103a30 <growproc>
801058cb:	83 c4 10             	add    $0x10,%esp
801058ce:	85 c0                	test   %eax,%eax
801058d0:	78 0e                	js     801058e0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801058d2:	89 d8                	mov    %ebx,%eax
801058d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058d7:	c9                   	leave  
801058d8:	c3                   	ret    
801058d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801058e0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801058e5:	eb eb                	jmp    801058d2 <sys_sbrk+0x32>
801058e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058ee:	66 90                	xchg   %ax,%ax

801058f0 <sys_sleep>:

int
sys_sleep(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801058f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058f7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801058fa:	50                   	push   %eax
801058fb:	6a 00                	push   $0x0
801058fd:	e8 1e f2 ff ff       	call   80104b20 <argint>
80105902:	83 c4 10             	add    $0x10,%esp
80105905:	85 c0                	test   %eax,%eax
80105907:	0f 88 8a 00 00 00    	js     80105997 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010590d:	83 ec 0c             	sub    $0xc,%esp
80105910:	68 60 50 11 80       	push   $0x80115060
80105915:	e8 c6 ed ff ff       	call   801046e0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010591a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010591d:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  while(ticks - ticks0 < n){
80105923:	83 c4 10             	add    $0x10,%esp
80105926:	85 d2                	test   %edx,%edx
80105928:	75 27                	jne    80105951 <sys_sleep+0x61>
8010592a:	eb 54                	jmp    80105980 <sys_sleep+0x90>
8010592c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105930:	83 ec 08             	sub    $0x8,%esp
80105933:	68 60 50 11 80       	push   $0x80115060
80105938:	68 a0 58 11 80       	push   $0x801158a0
8010593d:	e8 ae e5 ff ff       	call   80103ef0 <sleep>
  while(ticks - ticks0 < n){
80105942:	a1 a0 58 11 80       	mov    0x801158a0,%eax
80105947:	83 c4 10             	add    $0x10,%esp
8010594a:	29 d8                	sub    %ebx,%eax
8010594c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010594f:	73 2f                	jae    80105980 <sys_sleep+0x90>
    if(myproc()->killed){
80105951:	e8 ba df ff ff       	call   80103910 <myproc>
80105956:	8b 40 24             	mov    0x24(%eax),%eax
80105959:	85 c0                	test   %eax,%eax
8010595b:	74 d3                	je     80105930 <sys_sleep+0x40>
      release(&tickslock);
8010595d:	83 ec 0c             	sub    $0xc,%esp
80105960:	68 60 50 11 80       	push   $0x80115060
80105965:	e8 96 ee ff ff       	call   80104800 <release>
      return -1;
8010596a:	83 c4 10             	add    $0x10,%esp
8010596d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105972:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105975:	c9                   	leave  
80105976:	c3                   	ret    
80105977:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105980:	83 ec 0c             	sub    $0xc,%esp
80105983:	68 60 50 11 80       	push   $0x80115060
80105988:	e8 73 ee ff ff       	call   80104800 <release>
  return 0;
8010598d:	83 c4 10             	add    $0x10,%esp
80105990:	31 c0                	xor    %eax,%eax
}
80105992:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105995:	c9                   	leave  
80105996:	c3                   	ret    
    return -1;
80105997:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010599c:	eb f4                	jmp    80105992 <sys_sleep+0xa2>
8010599e:	66 90                	xchg   %ax,%ax

801059a0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	53                   	push   %ebx
801059a4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059a7:	68 60 50 11 80       	push   $0x80115060
801059ac:	e8 2f ed ff ff       	call   801046e0 <acquire>
  xticks = ticks;
801059b1:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  release(&tickslock);
801059b7:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
801059be:	e8 3d ee ff ff       	call   80104800 <release>
  return xticks;
}
801059c3:	89 d8                	mov    %ebx,%eax
801059c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059c8:	c9                   	leave  
801059c9:	c3                   	ret    
801059ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801059d0 <sys_cps>:

int
sys_cps(void)
{
  return cps();
801059d0:	e9 bb e8 ff ff       	jmp    80104290 <cps>
801059d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059e0 <sys_nps>:
}

int
sys_nps(void)
{
  return nps();
801059e0:	e9 7b e9 ff ff       	jmp    80104360 <nps>
801059e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059f0 <sys_chpr>:
}

int
sys_chpr (void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	83 ec 20             	sub    $0x20,%esp
  int pid, pr;
  if(argint(0, &pid) < 0)
801059f6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059f9:	50                   	push   %eax
801059fa:	6a 00                	push   $0x0
801059fc:	e8 1f f1 ff ff       	call   80104b20 <argint>
80105a01:	83 c4 10             	add    $0x10,%esp
80105a04:	85 c0                	test   %eax,%eax
80105a06:	78 28                	js     80105a30 <sys_chpr+0x40>
    return -1;
  if(argint(1, &pr) < 0)
80105a08:	83 ec 08             	sub    $0x8,%esp
80105a0b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a0e:	50                   	push   %eax
80105a0f:	6a 01                	push   $0x1
80105a11:	e8 0a f1 ff ff       	call   80104b20 <argint>
80105a16:	83 c4 10             	add    $0x10,%esp
80105a19:	85 c0                	test   %eax,%eax
80105a1b:	78 13                	js     80105a30 <sys_chpr+0x40>
    return -1;

  return chpr ( pid, pr );
80105a1d:	83 ec 08             	sub    $0x8,%esp
80105a20:	ff 75 f4             	pushl  -0xc(%ebp)
80105a23:	ff 75 f0             	pushl  -0x10(%ebp)
80105a26:	e8 b5 e9 ff ff       	call   801043e0 <chpr>
80105a2b:	83 c4 10             	add    $0x10,%esp
}
80105a2e:	c9                   	leave  
80105a2f:	c3                   	ret    
80105a30:	c9                   	leave  
    return -1;
80105a31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a36:	c3                   	ret    
80105a37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a3e:	66 90                	xchg   %ax,%ax

80105a40 <sys_getuid>:

//edits for id system calls --- Colby Holloman
int
sys_getuid(void)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	83 ec 08             	sub    $0x8,%esp
	return myproc()->uid;
80105a46:	e8 c5 de ff ff       	call   80103910 <myproc>
80105a4b:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
}
80105a51:	c9                   	leave  
80105a52:	c3                   	ret    
80105a53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a60 <sys_getgid>:

int
sys_getgid(void)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	83 ec 08             	sub    $0x8,%esp
	return myproc()->gid;
80105a66:	e8 a5 de ff ff       	call   80103910 <myproc>
80105a6b:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
}
80105a71:	c9                   	leave  
80105a72:	c3                   	ret    
80105a73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a80 <sys_getppid>:

int
sys_getppid(void)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	83 ec 08             	sub    $0x8,%esp
	if (myproc()->parent != 0)
80105a86:	e8 85 de ff ff       	call   80103910 <myproc>
80105a8b:	31 d2                	xor    %edx,%edx
80105a8d:	8b 40 14             	mov    0x14(%eax),%eax
80105a90:	85 c0                	test   %eax,%eax
80105a92:	74 0b                	je     80105a9f <sys_getppid+0x1f>
		return myproc()->parent->pid;
80105a94:	e8 77 de ff ff       	call   80103910 <myproc>
80105a99:	8b 40 14             	mov    0x14(%eax),%eax
80105a9c:	8b 50 10             	mov    0x10(%eax),%edx
	else return 0;
}
80105a9f:	c9                   	leave  
80105aa0:	89 d0                	mov    %edx,%eax
80105aa2:	c3                   	ret    
80105aa3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ab0 <sys_setuid>:

int
sys_setuid(void)
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	83 ec 20             	sub    $0x20,%esp
	int uid;
	if (argint(0,&uid) < 0)
80105ab6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ab9:	50                   	push   %eax
80105aba:	6a 00                	push   $0x0
80105abc:	e8 5f f0 ff ff       	call   80104b20 <argint>
80105ac1:	83 c4 10             	add    $0x10,%esp
80105ac4:	85 c0                	test   %eax,%eax
80105ac6:	78 18                	js     80105ae0 <sys_setuid+0x30>
		return -1;

	setuid((uint)uid);
80105ac8:	83 ec 0c             	sub    $0xc,%esp
80105acb:	ff 75 f4             	pushl  -0xc(%ebp)
80105ace:	e8 5d e9 ff ff       	call   80104430 <setuid>
	return 0;
80105ad3:	83 c4 10             	add    $0x10,%esp
80105ad6:	31 c0                	xor    %eax,%eax
}
80105ad8:	c9                   	leave  
80105ad9:	c3                   	ret    
80105ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105ae0:	c9                   	leave  
		return -1;
80105ae1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ae6:	c3                   	ret    
80105ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aee:	66 90                	xchg   %ax,%ax

80105af0 <sys_setgid>:

int
sys_setgid(void)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	83 ec 20             	sub    $0x20,%esp
	int gid;
	if (argint(0,&gid) < 0)
80105af6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105af9:	50                   	push   %eax
80105afa:	6a 00                	push   $0x0
80105afc:	e8 1f f0 ff ff       	call   80104b20 <argint>
80105b01:	83 c4 10             	add    $0x10,%esp
80105b04:	85 c0                	test   %eax,%eax
80105b06:	78 18                	js     80105b20 <sys_setgid+0x30>
		return -1;

	setgid((uint)gid);
80105b08:	83 ec 0c             	sub    $0xc,%esp
80105b0b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b0e:	e8 6d e9 ff ff       	call   80104480 <setgid>
	return 0;
80105b13:	83 c4 10             	add    $0x10,%esp
80105b16:	31 c0                	xor    %eax,%eax
}
80105b18:	c9                   	leave  
80105b19:	c3                   	ret    
80105b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b20:	c9                   	leave  
		return -1;
80105b21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b26:	c3                   	ret    
80105b27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b2e:	66 90                	xchg   %ax,%ax

80105b30 <sys_date>:

//starting edits---Ken Lin
int sys_date(void)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	83 ec 1c             	sub    $0x1c,%esp
  struct rtcdate *d;
  if(argptr(0, (void*)&d, sizeof(struct rtcdate)) < 0)
80105b36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b39:	6a 18                	push   $0x18
80105b3b:	50                   	push   %eax
80105b3c:	6a 00                	push   $0x0
80105b3e:	e8 2d f0 ff ff       	call   80104b70 <argptr>
80105b43:	83 c4 10             	add    $0x10,%esp
80105b46:	85 c0                	test   %eax,%eax
80105b48:	78 16                	js     80105b60 <sys_date+0x30>
    return -1;
  cmostime(d);
80105b4a:	83 ec 0c             	sub    $0xc,%esp
80105b4d:	ff 75 f4             	pushl  -0xc(%ebp)
80105b50:	e8 cb cd ff ff       	call   80102920 <cmostime>
  return 0;
80105b55:	83 c4 10             	add    $0x10,%esp
80105b58:	31 c0                	xor    %eax,%eax
}
80105b5a:	c9                   	leave  
80105b5b:	c3                   	ret    
80105b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b60:	c9                   	leave  
    return -1;
80105b61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b66:	c3                   	ret    

80105b67 <alltraps>:
80105b67:	1e                   	push   %ds
80105b68:	06                   	push   %es
80105b69:	0f a0                	push   %fs
80105b6b:	0f a8                	push   %gs
80105b6d:	60                   	pusha  
80105b6e:	66 b8 10 00          	mov    $0x10,%ax
80105b72:	8e d8                	mov    %eax,%ds
80105b74:	8e c0                	mov    %eax,%es
80105b76:	54                   	push   %esp
80105b77:	e8 c4 00 00 00       	call   80105c40 <trap>
80105b7c:	83 c4 04             	add    $0x4,%esp

80105b7f <trapret>:
80105b7f:	61                   	popa   
80105b80:	0f a9                	pop    %gs
80105b82:	0f a1                	pop    %fs
80105b84:	07                   	pop    %es
80105b85:	1f                   	pop    %ds
80105b86:	83 c4 08             	add    $0x8,%esp
80105b89:	cf                   	iret   
80105b8a:	66 90                	xchg   %ax,%ax
80105b8c:	66 90                	xchg   %ax,%ax
80105b8e:	66 90                	xchg   %ax,%ax

80105b90 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105b90:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105b91:	31 c0                	xor    %eax,%eax
{
80105b93:	89 e5                	mov    %esp,%ebp
80105b95:	83 ec 08             	sub    $0x8,%esp
80105b98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b9f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105ba0:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105ba7:	c7 04 c5 a2 50 11 80 	movl   $0x8e000008,-0x7feeaf5e(,%eax,8)
80105bae:	08 00 00 8e 
80105bb2:	66 89 14 c5 a0 50 11 	mov    %dx,-0x7feeaf60(,%eax,8)
80105bb9:	80 
80105bba:	c1 ea 10             	shr    $0x10,%edx
80105bbd:	66 89 14 c5 a6 50 11 	mov    %dx,-0x7feeaf5a(,%eax,8)
80105bc4:	80 
  for(i = 0; i < 256; i++)
80105bc5:	83 c0 01             	add    $0x1,%eax
80105bc8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105bcd:	75 d1                	jne    80105ba0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105bcf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105bd2:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105bd7:	c7 05 a2 52 11 80 08 	movl   $0xef000008,0x801152a2
80105bde:	00 00 ef 
  initlock(&tickslock, "time");
80105be1:	68 7d 7c 10 80       	push   $0x80107c7d
80105be6:	68 60 50 11 80       	push   $0x80115060
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105beb:	66 a3 a0 52 11 80    	mov    %ax,0x801152a0
80105bf1:	c1 e8 10             	shr    $0x10,%eax
80105bf4:	66 a3 a6 52 11 80    	mov    %ax,0x801152a6
  initlock(&tickslock, "time");
80105bfa:	e8 e1 e9 ff ff       	call   801045e0 <initlock>
}
80105bff:	83 c4 10             	add    $0x10,%esp
80105c02:	c9                   	leave  
80105c03:	c3                   	ret    
80105c04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c0f:	90                   	nop

80105c10 <idtinit>:

void
idtinit(void)
{
80105c10:	55                   	push   %ebp
  pd[0] = size-1;
80105c11:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105c16:	89 e5                	mov    %esp,%ebp
80105c18:	83 ec 10             	sub    $0x10,%esp
80105c1b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105c1f:	b8 a0 50 11 80       	mov    $0x801150a0,%eax
80105c24:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105c28:	c1 e8 10             	shr    $0x10,%eax
80105c2b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105c2f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105c32:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105c35:	c9                   	leave  
80105c36:	c3                   	ret    
80105c37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c3e:	66 90                	xchg   %ax,%ax

80105c40 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105c40:	55                   	push   %ebp
80105c41:	89 e5                	mov    %esp,%ebp
80105c43:	57                   	push   %edi
80105c44:	56                   	push   %esi
80105c45:	53                   	push   %ebx
80105c46:	83 ec 1c             	sub    $0x1c,%esp
80105c49:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105c4c:	8b 47 30             	mov    0x30(%edi),%eax
80105c4f:	83 f8 40             	cmp    $0x40,%eax
80105c52:	0f 84 b8 01 00 00    	je     80105e10 <trap+0x1d0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105c58:	83 e8 20             	sub    $0x20,%eax
80105c5b:	83 f8 1f             	cmp    $0x1f,%eax
80105c5e:	77 10                	ja     80105c70 <trap+0x30>
80105c60:	ff 24 85 24 7d 10 80 	jmp    *-0x7fef82dc(,%eax,4)
80105c67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c6e:	66 90                	xchg   %ax,%ax
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105c70:	e8 9b dc ff ff       	call   80103910 <myproc>
80105c75:	8b 5f 38             	mov    0x38(%edi),%ebx
80105c78:	85 c0                	test   %eax,%eax
80105c7a:	0f 84 17 02 00 00    	je     80105e97 <trap+0x257>
80105c80:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105c84:	0f 84 0d 02 00 00    	je     80105e97 <trap+0x257>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105c8a:	0f 20 d1             	mov    %cr2,%ecx
80105c8d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c90:	e8 5b dc ff ff       	call   801038f0 <cpuid>
80105c95:	8b 77 30             	mov    0x30(%edi),%esi
80105c98:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105c9b:	8b 47 34             	mov    0x34(%edi),%eax
80105c9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105ca1:	e8 6a dc ff ff       	call   80103910 <myproc>
80105ca6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ca9:	e8 62 dc ff ff       	call   80103910 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cae:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105cb1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105cb4:	51                   	push   %ecx
80105cb5:	53                   	push   %ebx
80105cb6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105cb7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cba:	ff 75 e4             	pushl  -0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105cbd:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cc0:	56                   	push   %esi
80105cc1:	52                   	push   %edx
80105cc2:	ff 70 10             	pushl  0x10(%eax)
80105cc5:	68 e0 7c 10 80       	push   $0x80107ce0
80105cca:	e8 e1 a9 ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105ccf:	83 c4 20             	add    $0x20,%esp
80105cd2:	e8 39 dc ff ff       	call   80103910 <myproc>
80105cd7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105cde:	e8 2d dc ff ff       	call   80103910 <myproc>
80105ce3:	85 c0                	test   %eax,%eax
80105ce5:	74 1d                	je     80105d04 <trap+0xc4>
80105ce7:	e8 24 dc ff ff       	call   80103910 <myproc>
80105cec:	8b 50 24             	mov    0x24(%eax),%edx
80105cef:	85 d2                	test   %edx,%edx
80105cf1:	74 11                	je     80105d04 <trap+0xc4>
80105cf3:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105cf7:	83 e0 03             	and    $0x3,%eax
80105cfa:	66 83 f8 03          	cmp    $0x3,%ax
80105cfe:	0f 84 44 01 00 00    	je     80105e48 <trap+0x208>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105d04:	e8 07 dc ff ff       	call   80103910 <myproc>
80105d09:	85 c0                	test   %eax,%eax
80105d0b:	74 0b                	je     80105d18 <trap+0xd8>
80105d0d:	e8 fe db ff ff       	call   80103910 <myproc>
80105d12:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105d16:	74 38                	je     80105d50 <trap+0x110>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d18:	e8 f3 db ff ff       	call   80103910 <myproc>
80105d1d:	85 c0                	test   %eax,%eax
80105d1f:	74 1d                	je     80105d3e <trap+0xfe>
80105d21:	e8 ea db ff ff       	call   80103910 <myproc>
80105d26:	8b 40 24             	mov    0x24(%eax),%eax
80105d29:	85 c0                	test   %eax,%eax
80105d2b:	74 11                	je     80105d3e <trap+0xfe>
80105d2d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105d31:	83 e0 03             	and    $0x3,%eax
80105d34:	66 83 f8 03          	cmp    $0x3,%ax
80105d38:	0f 84 fb 00 00 00    	je     80105e39 <trap+0x1f9>
    exit();
}
80105d3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d41:	5b                   	pop    %ebx
80105d42:	5e                   	pop    %esi
80105d43:	5f                   	pop    %edi
80105d44:	5d                   	pop    %ebp
80105d45:	c3                   	ret    
80105d46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d4d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105d50:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105d54:	75 c2                	jne    80105d18 <trap+0xd8>
    yield();
80105d56:	e8 45 e1 ff ff       	call   80103ea0 <yield>
80105d5b:	eb bb                	jmp    80105d18 <trap+0xd8>
80105d5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105d60:	e8 8b db ff ff       	call   801038f0 <cpuid>
80105d65:	85 c0                	test   %eax,%eax
80105d67:	0f 84 eb 00 00 00    	je     80105e58 <trap+0x218>
    lapiceoi();
80105d6d:	e8 ee ca ff ff       	call   80102860 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d72:	e8 99 db ff ff       	call   80103910 <myproc>
80105d77:	85 c0                	test   %eax,%eax
80105d79:	0f 85 68 ff ff ff    	jne    80105ce7 <trap+0xa7>
80105d7f:	eb 83                	jmp    80105d04 <trap+0xc4>
80105d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105d88:	e8 93 c9 ff ff       	call   80102720 <kbdintr>
    lapiceoi();
80105d8d:	e8 ce ca ff ff       	call   80102860 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d92:	e8 79 db ff ff       	call   80103910 <myproc>
80105d97:	85 c0                	test   %eax,%eax
80105d99:	0f 85 48 ff ff ff    	jne    80105ce7 <trap+0xa7>
80105d9f:	e9 60 ff ff ff       	jmp    80105d04 <trap+0xc4>
80105da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105da8:	e8 83 02 00 00       	call   80106030 <uartintr>
    lapiceoi();
80105dad:	e8 ae ca ff ff       	call   80102860 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105db2:	e8 59 db ff ff       	call   80103910 <myproc>
80105db7:	85 c0                	test   %eax,%eax
80105db9:	0f 85 28 ff ff ff    	jne    80105ce7 <trap+0xa7>
80105dbf:	e9 40 ff ff ff       	jmp    80105d04 <trap+0xc4>
80105dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105dc8:	8b 77 38             	mov    0x38(%edi),%esi
80105dcb:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105dcf:	e8 1c db ff ff       	call   801038f0 <cpuid>
80105dd4:	56                   	push   %esi
80105dd5:	53                   	push   %ebx
80105dd6:	50                   	push   %eax
80105dd7:	68 88 7c 10 80       	push   $0x80107c88
80105ddc:	e8 cf a8 ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80105de1:	e8 7a ca ff ff       	call   80102860 <lapiceoi>
    break;
80105de6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105de9:	e8 22 db ff ff       	call   80103910 <myproc>
80105dee:	85 c0                	test   %eax,%eax
80105df0:	0f 85 f1 fe ff ff    	jne    80105ce7 <trap+0xa7>
80105df6:	e9 09 ff ff ff       	jmp    80105d04 <trap+0xc4>
80105dfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105dff:	90                   	nop
    ideintr();
80105e00:	e8 6b c3 ff ff       	call   80102170 <ideintr>
80105e05:	e9 63 ff ff ff       	jmp    80105d6d <trap+0x12d>
80105e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105e10:	e8 fb da ff ff       	call   80103910 <myproc>
80105e15:	8b 58 24             	mov    0x24(%eax),%ebx
80105e18:	85 db                	test   %ebx,%ebx
80105e1a:	75 74                	jne    80105e90 <trap+0x250>
    myproc()->tf = tf;
80105e1c:	e8 ef da ff ff       	call   80103910 <myproc>
80105e21:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105e24:	e8 e7 ed ff ff       	call   80104c10 <syscall>
    if(myproc()->killed)
80105e29:	e8 e2 da ff ff       	call   80103910 <myproc>
80105e2e:	8b 48 24             	mov    0x24(%eax),%ecx
80105e31:	85 c9                	test   %ecx,%ecx
80105e33:	0f 84 05 ff ff ff    	je     80105d3e <trap+0xfe>
}
80105e39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e3c:	5b                   	pop    %ebx
80105e3d:	5e                   	pop    %esi
80105e3e:	5f                   	pop    %edi
80105e3f:	5d                   	pop    %ebp
      exit();
80105e40:	e9 2b df ff ff       	jmp    80103d70 <exit>
80105e45:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80105e48:	e8 23 df ff ff       	call   80103d70 <exit>
80105e4d:	e9 b2 fe ff ff       	jmp    80105d04 <trap+0xc4>
80105e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105e58:	83 ec 0c             	sub    $0xc,%esp
80105e5b:	68 60 50 11 80       	push   $0x80115060
80105e60:	e8 7b e8 ff ff       	call   801046e0 <acquire>
      wakeup(&ticks);
80105e65:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
      ticks++;
80105e6c:	83 05 a0 58 11 80 01 	addl   $0x1,0x801158a0
      wakeup(&ticks);
80105e73:	e8 38 e2 ff ff       	call   801040b0 <wakeup>
      release(&tickslock);
80105e78:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105e7f:	e8 7c e9 ff ff       	call   80104800 <release>
80105e84:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105e87:	e9 e1 fe ff ff       	jmp    80105d6d <trap+0x12d>
80105e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit();
80105e90:	e8 db de ff ff       	call   80103d70 <exit>
80105e95:	eb 85                	jmp    80105e1c <trap+0x1dc>
80105e97:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105e9a:	e8 51 da ff ff       	call   801038f0 <cpuid>
80105e9f:	83 ec 0c             	sub    $0xc,%esp
80105ea2:	56                   	push   %esi
80105ea3:	53                   	push   %ebx
80105ea4:	50                   	push   %eax
80105ea5:	ff 77 30             	pushl  0x30(%edi)
80105ea8:	68 ac 7c 10 80       	push   $0x80107cac
80105ead:	e8 fe a7 ff ff       	call   801006b0 <cprintf>
      panic("trap");
80105eb2:	83 c4 14             	add    $0x14,%esp
80105eb5:	68 82 7c 10 80       	push   $0x80107c82
80105eba:	e8 d1 a4 ff ff       	call   80100390 <panic>
80105ebf:	90                   	nop

80105ec0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105ec0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105ec5:	85 c0                	test   %eax,%eax
80105ec7:	74 17                	je     80105ee0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105ec9:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ece:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105ecf:	a8 01                	test   $0x1,%al
80105ed1:	74 0d                	je     80105ee0 <uartgetc+0x20>
80105ed3:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ed8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105ed9:	0f b6 c0             	movzbl %al,%eax
80105edc:	c3                   	ret    
80105edd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105ee0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ee5:	c3                   	ret    
80105ee6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eed:	8d 76 00             	lea    0x0(%esi),%esi

80105ef0 <uartputc.part.0>:
uartputc(int c)
80105ef0:	55                   	push   %ebp
80105ef1:	89 e5                	mov    %esp,%ebp
80105ef3:	57                   	push   %edi
80105ef4:	89 c7                	mov    %eax,%edi
80105ef6:	56                   	push   %esi
80105ef7:	be fd 03 00 00       	mov    $0x3fd,%esi
80105efc:	53                   	push   %ebx
80105efd:	bb 80 00 00 00       	mov    $0x80,%ebx
80105f02:	83 ec 0c             	sub    $0xc,%esp
80105f05:	eb 1b                	jmp    80105f22 <uartputc.part.0+0x32>
80105f07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f0e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80105f10:	83 ec 0c             	sub    $0xc,%esp
80105f13:	6a 0a                	push   $0xa
80105f15:	e8 66 c9 ff ff       	call   80102880 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105f1a:	83 c4 10             	add    $0x10,%esp
80105f1d:	83 eb 01             	sub    $0x1,%ebx
80105f20:	74 07                	je     80105f29 <uartputc.part.0+0x39>
80105f22:	89 f2                	mov    %esi,%edx
80105f24:	ec                   	in     (%dx),%al
80105f25:	a8 20                	test   $0x20,%al
80105f27:	74 e7                	je     80105f10 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f29:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f2e:	89 f8                	mov    %edi,%eax
80105f30:	ee                   	out    %al,(%dx)
}
80105f31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f34:	5b                   	pop    %ebx
80105f35:	5e                   	pop    %esi
80105f36:	5f                   	pop    %edi
80105f37:	5d                   	pop    %ebp
80105f38:	c3                   	ret    
80105f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f40 <uartinit>:
{
80105f40:	55                   	push   %ebp
80105f41:	31 c9                	xor    %ecx,%ecx
80105f43:	89 c8                	mov    %ecx,%eax
80105f45:	89 e5                	mov    %esp,%ebp
80105f47:	57                   	push   %edi
80105f48:	56                   	push   %esi
80105f49:	53                   	push   %ebx
80105f4a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105f4f:	89 da                	mov    %ebx,%edx
80105f51:	83 ec 0c             	sub    $0xc,%esp
80105f54:	ee                   	out    %al,(%dx)
80105f55:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105f5a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105f5f:	89 fa                	mov    %edi,%edx
80105f61:	ee                   	out    %al,(%dx)
80105f62:	b8 0c 00 00 00       	mov    $0xc,%eax
80105f67:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f6c:	ee                   	out    %al,(%dx)
80105f6d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105f72:	89 c8                	mov    %ecx,%eax
80105f74:	89 f2                	mov    %esi,%edx
80105f76:	ee                   	out    %al,(%dx)
80105f77:	b8 03 00 00 00       	mov    $0x3,%eax
80105f7c:	89 fa                	mov    %edi,%edx
80105f7e:	ee                   	out    %al,(%dx)
80105f7f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105f84:	89 c8                	mov    %ecx,%eax
80105f86:	ee                   	out    %al,(%dx)
80105f87:	b8 01 00 00 00       	mov    $0x1,%eax
80105f8c:	89 f2                	mov    %esi,%edx
80105f8e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105f8f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105f94:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105f95:	3c ff                	cmp    $0xff,%al
80105f97:	74 56                	je     80105fef <uartinit+0xaf>
  uart = 1;
80105f99:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105fa0:	00 00 00 
80105fa3:	89 da                	mov    %ebx,%edx
80105fa5:	ec                   	in     (%dx),%al
80105fa6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105fab:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105fac:	83 ec 08             	sub    $0x8,%esp
80105faf:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80105fb4:	bb a4 7d 10 80       	mov    $0x80107da4,%ebx
  ioapicenable(IRQ_COM1, 0);
80105fb9:	6a 00                	push   $0x0
80105fbb:	6a 04                	push   $0x4
80105fbd:	e8 fe c3 ff ff       	call   801023c0 <ioapicenable>
80105fc2:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105fc5:	b8 78 00 00 00       	mov    $0x78,%eax
80105fca:	eb 08                	jmp    80105fd4 <uartinit+0x94>
80105fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fd0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80105fd4:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105fda:	85 d2                	test   %edx,%edx
80105fdc:	74 08                	je     80105fe6 <uartinit+0xa6>
    uartputc(*p);
80105fde:	0f be c0             	movsbl %al,%eax
80105fe1:	e8 0a ff ff ff       	call   80105ef0 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80105fe6:	89 f0                	mov    %esi,%eax
80105fe8:	83 c3 01             	add    $0x1,%ebx
80105feb:	84 c0                	test   %al,%al
80105fed:	75 e1                	jne    80105fd0 <uartinit+0x90>
}
80105fef:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ff2:	5b                   	pop    %ebx
80105ff3:	5e                   	pop    %esi
80105ff4:	5f                   	pop    %edi
80105ff5:	5d                   	pop    %ebp
80105ff6:	c3                   	ret    
80105ff7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ffe:	66 90                	xchg   %ax,%ax

80106000 <uartputc>:
{
80106000:	55                   	push   %ebp
  if(!uart)
80106001:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80106007:	89 e5                	mov    %esp,%ebp
80106009:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010600c:	85 d2                	test   %edx,%edx
8010600e:	74 10                	je     80106020 <uartputc+0x20>
}
80106010:	5d                   	pop    %ebp
80106011:	e9 da fe ff ff       	jmp    80105ef0 <uartputc.part.0>
80106016:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010601d:	8d 76 00             	lea    0x0(%esi),%esi
80106020:	5d                   	pop    %ebp
80106021:	c3                   	ret    
80106022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106030 <uartintr>:

void
uartintr(void)
{
80106030:	55                   	push   %ebp
80106031:	89 e5                	mov    %esp,%ebp
80106033:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106036:	68 c0 5e 10 80       	push   $0x80105ec0
8010603b:	e8 20 a8 ff ff       	call   80100860 <consoleintr>
}
80106040:	83 c4 10             	add    $0x10,%esp
80106043:	c9                   	leave  
80106044:	c3                   	ret    

80106045 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106045:	6a 00                	push   $0x0
  pushl $0
80106047:	6a 00                	push   $0x0
  jmp alltraps
80106049:	e9 19 fb ff ff       	jmp    80105b67 <alltraps>

8010604e <vector1>:
.globl vector1
vector1:
  pushl $0
8010604e:	6a 00                	push   $0x0
  pushl $1
80106050:	6a 01                	push   $0x1
  jmp alltraps
80106052:	e9 10 fb ff ff       	jmp    80105b67 <alltraps>

80106057 <vector2>:
.globl vector2
vector2:
  pushl $0
80106057:	6a 00                	push   $0x0
  pushl $2
80106059:	6a 02                	push   $0x2
  jmp alltraps
8010605b:	e9 07 fb ff ff       	jmp    80105b67 <alltraps>

80106060 <vector3>:
.globl vector3
vector3:
  pushl $0
80106060:	6a 00                	push   $0x0
  pushl $3
80106062:	6a 03                	push   $0x3
  jmp alltraps
80106064:	e9 fe fa ff ff       	jmp    80105b67 <alltraps>

80106069 <vector4>:
.globl vector4
vector4:
  pushl $0
80106069:	6a 00                	push   $0x0
  pushl $4
8010606b:	6a 04                	push   $0x4
  jmp alltraps
8010606d:	e9 f5 fa ff ff       	jmp    80105b67 <alltraps>

80106072 <vector5>:
.globl vector5
vector5:
  pushl $0
80106072:	6a 00                	push   $0x0
  pushl $5
80106074:	6a 05                	push   $0x5
  jmp alltraps
80106076:	e9 ec fa ff ff       	jmp    80105b67 <alltraps>

8010607b <vector6>:
.globl vector6
vector6:
  pushl $0
8010607b:	6a 00                	push   $0x0
  pushl $6
8010607d:	6a 06                	push   $0x6
  jmp alltraps
8010607f:	e9 e3 fa ff ff       	jmp    80105b67 <alltraps>

80106084 <vector7>:
.globl vector7
vector7:
  pushl $0
80106084:	6a 00                	push   $0x0
  pushl $7
80106086:	6a 07                	push   $0x7
  jmp alltraps
80106088:	e9 da fa ff ff       	jmp    80105b67 <alltraps>

8010608d <vector8>:
.globl vector8
vector8:
  pushl $8
8010608d:	6a 08                	push   $0x8
  jmp alltraps
8010608f:	e9 d3 fa ff ff       	jmp    80105b67 <alltraps>

80106094 <vector9>:
.globl vector9
vector9:
  pushl $0
80106094:	6a 00                	push   $0x0
  pushl $9
80106096:	6a 09                	push   $0x9
  jmp alltraps
80106098:	e9 ca fa ff ff       	jmp    80105b67 <alltraps>

8010609d <vector10>:
.globl vector10
vector10:
  pushl $10
8010609d:	6a 0a                	push   $0xa
  jmp alltraps
8010609f:	e9 c3 fa ff ff       	jmp    80105b67 <alltraps>

801060a4 <vector11>:
.globl vector11
vector11:
  pushl $11
801060a4:	6a 0b                	push   $0xb
  jmp alltraps
801060a6:	e9 bc fa ff ff       	jmp    80105b67 <alltraps>

801060ab <vector12>:
.globl vector12
vector12:
  pushl $12
801060ab:	6a 0c                	push   $0xc
  jmp alltraps
801060ad:	e9 b5 fa ff ff       	jmp    80105b67 <alltraps>

801060b2 <vector13>:
.globl vector13
vector13:
  pushl $13
801060b2:	6a 0d                	push   $0xd
  jmp alltraps
801060b4:	e9 ae fa ff ff       	jmp    80105b67 <alltraps>

801060b9 <vector14>:
.globl vector14
vector14:
  pushl $14
801060b9:	6a 0e                	push   $0xe
  jmp alltraps
801060bb:	e9 a7 fa ff ff       	jmp    80105b67 <alltraps>

801060c0 <vector15>:
.globl vector15
vector15:
  pushl $0
801060c0:	6a 00                	push   $0x0
  pushl $15
801060c2:	6a 0f                	push   $0xf
  jmp alltraps
801060c4:	e9 9e fa ff ff       	jmp    80105b67 <alltraps>

801060c9 <vector16>:
.globl vector16
vector16:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $16
801060cb:	6a 10                	push   $0x10
  jmp alltraps
801060cd:	e9 95 fa ff ff       	jmp    80105b67 <alltraps>

801060d2 <vector17>:
.globl vector17
vector17:
  pushl $17
801060d2:	6a 11                	push   $0x11
  jmp alltraps
801060d4:	e9 8e fa ff ff       	jmp    80105b67 <alltraps>

801060d9 <vector18>:
.globl vector18
vector18:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $18
801060db:	6a 12                	push   $0x12
  jmp alltraps
801060dd:	e9 85 fa ff ff       	jmp    80105b67 <alltraps>

801060e2 <vector19>:
.globl vector19
vector19:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $19
801060e4:	6a 13                	push   $0x13
  jmp alltraps
801060e6:	e9 7c fa ff ff       	jmp    80105b67 <alltraps>

801060eb <vector20>:
.globl vector20
vector20:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $20
801060ed:	6a 14                	push   $0x14
  jmp alltraps
801060ef:	e9 73 fa ff ff       	jmp    80105b67 <alltraps>

801060f4 <vector21>:
.globl vector21
vector21:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $21
801060f6:	6a 15                	push   $0x15
  jmp alltraps
801060f8:	e9 6a fa ff ff       	jmp    80105b67 <alltraps>

801060fd <vector22>:
.globl vector22
vector22:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $22
801060ff:	6a 16                	push   $0x16
  jmp alltraps
80106101:	e9 61 fa ff ff       	jmp    80105b67 <alltraps>

80106106 <vector23>:
.globl vector23
vector23:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $23
80106108:	6a 17                	push   $0x17
  jmp alltraps
8010610a:	e9 58 fa ff ff       	jmp    80105b67 <alltraps>

8010610f <vector24>:
.globl vector24
vector24:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $24
80106111:	6a 18                	push   $0x18
  jmp alltraps
80106113:	e9 4f fa ff ff       	jmp    80105b67 <alltraps>

80106118 <vector25>:
.globl vector25
vector25:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $25
8010611a:	6a 19                	push   $0x19
  jmp alltraps
8010611c:	e9 46 fa ff ff       	jmp    80105b67 <alltraps>

80106121 <vector26>:
.globl vector26
vector26:
  pushl $0
80106121:	6a 00                	push   $0x0
  pushl $26
80106123:	6a 1a                	push   $0x1a
  jmp alltraps
80106125:	e9 3d fa ff ff       	jmp    80105b67 <alltraps>

8010612a <vector27>:
.globl vector27
vector27:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $27
8010612c:	6a 1b                	push   $0x1b
  jmp alltraps
8010612e:	e9 34 fa ff ff       	jmp    80105b67 <alltraps>

80106133 <vector28>:
.globl vector28
vector28:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $28
80106135:	6a 1c                	push   $0x1c
  jmp alltraps
80106137:	e9 2b fa ff ff       	jmp    80105b67 <alltraps>

8010613c <vector29>:
.globl vector29
vector29:
  pushl $0
8010613c:	6a 00                	push   $0x0
  pushl $29
8010613e:	6a 1d                	push   $0x1d
  jmp alltraps
80106140:	e9 22 fa ff ff       	jmp    80105b67 <alltraps>

80106145 <vector30>:
.globl vector30
vector30:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $30
80106147:	6a 1e                	push   $0x1e
  jmp alltraps
80106149:	e9 19 fa ff ff       	jmp    80105b67 <alltraps>

8010614e <vector31>:
.globl vector31
vector31:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $31
80106150:	6a 1f                	push   $0x1f
  jmp alltraps
80106152:	e9 10 fa ff ff       	jmp    80105b67 <alltraps>

80106157 <vector32>:
.globl vector32
vector32:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $32
80106159:	6a 20                	push   $0x20
  jmp alltraps
8010615b:	e9 07 fa ff ff       	jmp    80105b67 <alltraps>

80106160 <vector33>:
.globl vector33
vector33:
  pushl $0
80106160:	6a 00                	push   $0x0
  pushl $33
80106162:	6a 21                	push   $0x21
  jmp alltraps
80106164:	e9 fe f9 ff ff       	jmp    80105b67 <alltraps>

80106169 <vector34>:
.globl vector34
vector34:
  pushl $0
80106169:	6a 00                	push   $0x0
  pushl $34
8010616b:	6a 22                	push   $0x22
  jmp alltraps
8010616d:	e9 f5 f9 ff ff       	jmp    80105b67 <alltraps>

80106172 <vector35>:
.globl vector35
vector35:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $35
80106174:	6a 23                	push   $0x23
  jmp alltraps
80106176:	e9 ec f9 ff ff       	jmp    80105b67 <alltraps>

8010617b <vector36>:
.globl vector36
vector36:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $36
8010617d:	6a 24                	push   $0x24
  jmp alltraps
8010617f:	e9 e3 f9 ff ff       	jmp    80105b67 <alltraps>

80106184 <vector37>:
.globl vector37
vector37:
  pushl $0
80106184:	6a 00                	push   $0x0
  pushl $37
80106186:	6a 25                	push   $0x25
  jmp alltraps
80106188:	e9 da f9 ff ff       	jmp    80105b67 <alltraps>

8010618d <vector38>:
.globl vector38
vector38:
  pushl $0
8010618d:	6a 00                	push   $0x0
  pushl $38
8010618f:	6a 26                	push   $0x26
  jmp alltraps
80106191:	e9 d1 f9 ff ff       	jmp    80105b67 <alltraps>

80106196 <vector39>:
.globl vector39
vector39:
  pushl $0
80106196:	6a 00                	push   $0x0
  pushl $39
80106198:	6a 27                	push   $0x27
  jmp alltraps
8010619a:	e9 c8 f9 ff ff       	jmp    80105b67 <alltraps>

8010619f <vector40>:
.globl vector40
vector40:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $40
801061a1:	6a 28                	push   $0x28
  jmp alltraps
801061a3:	e9 bf f9 ff ff       	jmp    80105b67 <alltraps>

801061a8 <vector41>:
.globl vector41
vector41:
  pushl $0
801061a8:	6a 00                	push   $0x0
  pushl $41
801061aa:	6a 29                	push   $0x29
  jmp alltraps
801061ac:	e9 b6 f9 ff ff       	jmp    80105b67 <alltraps>

801061b1 <vector42>:
.globl vector42
vector42:
  pushl $0
801061b1:	6a 00                	push   $0x0
  pushl $42
801061b3:	6a 2a                	push   $0x2a
  jmp alltraps
801061b5:	e9 ad f9 ff ff       	jmp    80105b67 <alltraps>

801061ba <vector43>:
.globl vector43
vector43:
  pushl $0
801061ba:	6a 00                	push   $0x0
  pushl $43
801061bc:	6a 2b                	push   $0x2b
  jmp alltraps
801061be:	e9 a4 f9 ff ff       	jmp    80105b67 <alltraps>

801061c3 <vector44>:
.globl vector44
vector44:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $44
801061c5:	6a 2c                	push   $0x2c
  jmp alltraps
801061c7:	e9 9b f9 ff ff       	jmp    80105b67 <alltraps>

801061cc <vector45>:
.globl vector45
vector45:
  pushl $0
801061cc:	6a 00                	push   $0x0
  pushl $45
801061ce:	6a 2d                	push   $0x2d
  jmp alltraps
801061d0:	e9 92 f9 ff ff       	jmp    80105b67 <alltraps>

801061d5 <vector46>:
.globl vector46
vector46:
  pushl $0
801061d5:	6a 00                	push   $0x0
  pushl $46
801061d7:	6a 2e                	push   $0x2e
  jmp alltraps
801061d9:	e9 89 f9 ff ff       	jmp    80105b67 <alltraps>

801061de <vector47>:
.globl vector47
vector47:
  pushl $0
801061de:	6a 00                	push   $0x0
  pushl $47
801061e0:	6a 2f                	push   $0x2f
  jmp alltraps
801061e2:	e9 80 f9 ff ff       	jmp    80105b67 <alltraps>

801061e7 <vector48>:
.globl vector48
vector48:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $48
801061e9:	6a 30                	push   $0x30
  jmp alltraps
801061eb:	e9 77 f9 ff ff       	jmp    80105b67 <alltraps>

801061f0 <vector49>:
.globl vector49
vector49:
  pushl $0
801061f0:	6a 00                	push   $0x0
  pushl $49
801061f2:	6a 31                	push   $0x31
  jmp alltraps
801061f4:	e9 6e f9 ff ff       	jmp    80105b67 <alltraps>

801061f9 <vector50>:
.globl vector50
vector50:
  pushl $0
801061f9:	6a 00                	push   $0x0
  pushl $50
801061fb:	6a 32                	push   $0x32
  jmp alltraps
801061fd:	e9 65 f9 ff ff       	jmp    80105b67 <alltraps>

80106202 <vector51>:
.globl vector51
vector51:
  pushl $0
80106202:	6a 00                	push   $0x0
  pushl $51
80106204:	6a 33                	push   $0x33
  jmp alltraps
80106206:	e9 5c f9 ff ff       	jmp    80105b67 <alltraps>

8010620b <vector52>:
.globl vector52
vector52:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $52
8010620d:	6a 34                	push   $0x34
  jmp alltraps
8010620f:	e9 53 f9 ff ff       	jmp    80105b67 <alltraps>

80106214 <vector53>:
.globl vector53
vector53:
  pushl $0
80106214:	6a 00                	push   $0x0
  pushl $53
80106216:	6a 35                	push   $0x35
  jmp alltraps
80106218:	e9 4a f9 ff ff       	jmp    80105b67 <alltraps>

8010621d <vector54>:
.globl vector54
vector54:
  pushl $0
8010621d:	6a 00                	push   $0x0
  pushl $54
8010621f:	6a 36                	push   $0x36
  jmp alltraps
80106221:	e9 41 f9 ff ff       	jmp    80105b67 <alltraps>

80106226 <vector55>:
.globl vector55
vector55:
  pushl $0
80106226:	6a 00                	push   $0x0
  pushl $55
80106228:	6a 37                	push   $0x37
  jmp alltraps
8010622a:	e9 38 f9 ff ff       	jmp    80105b67 <alltraps>

8010622f <vector56>:
.globl vector56
vector56:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $56
80106231:	6a 38                	push   $0x38
  jmp alltraps
80106233:	e9 2f f9 ff ff       	jmp    80105b67 <alltraps>

80106238 <vector57>:
.globl vector57
vector57:
  pushl $0
80106238:	6a 00                	push   $0x0
  pushl $57
8010623a:	6a 39                	push   $0x39
  jmp alltraps
8010623c:	e9 26 f9 ff ff       	jmp    80105b67 <alltraps>

80106241 <vector58>:
.globl vector58
vector58:
  pushl $0
80106241:	6a 00                	push   $0x0
  pushl $58
80106243:	6a 3a                	push   $0x3a
  jmp alltraps
80106245:	e9 1d f9 ff ff       	jmp    80105b67 <alltraps>

8010624a <vector59>:
.globl vector59
vector59:
  pushl $0
8010624a:	6a 00                	push   $0x0
  pushl $59
8010624c:	6a 3b                	push   $0x3b
  jmp alltraps
8010624e:	e9 14 f9 ff ff       	jmp    80105b67 <alltraps>

80106253 <vector60>:
.globl vector60
vector60:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $60
80106255:	6a 3c                	push   $0x3c
  jmp alltraps
80106257:	e9 0b f9 ff ff       	jmp    80105b67 <alltraps>

8010625c <vector61>:
.globl vector61
vector61:
  pushl $0
8010625c:	6a 00                	push   $0x0
  pushl $61
8010625e:	6a 3d                	push   $0x3d
  jmp alltraps
80106260:	e9 02 f9 ff ff       	jmp    80105b67 <alltraps>

80106265 <vector62>:
.globl vector62
vector62:
  pushl $0
80106265:	6a 00                	push   $0x0
  pushl $62
80106267:	6a 3e                	push   $0x3e
  jmp alltraps
80106269:	e9 f9 f8 ff ff       	jmp    80105b67 <alltraps>

8010626e <vector63>:
.globl vector63
vector63:
  pushl $0
8010626e:	6a 00                	push   $0x0
  pushl $63
80106270:	6a 3f                	push   $0x3f
  jmp alltraps
80106272:	e9 f0 f8 ff ff       	jmp    80105b67 <alltraps>

80106277 <vector64>:
.globl vector64
vector64:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $64
80106279:	6a 40                	push   $0x40
  jmp alltraps
8010627b:	e9 e7 f8 ff ff       	jmp    80105b67 <alltraps>

80106280 <vector65>:
.globl vector65
vector65:
  pushl $0
80106280:	6a 00                	push   $0x0
  pushl $65
80106282:	6a 41                	push   $0x41
  jmp alltraps
80106284:	e9 de f8 ff ff       	jmp    80105b67 <alltraps>

80106289 <vector66>:
.globl vector66
vector66:
  pushl $0
80106289:	6a 00                	push   $0x0
  pushl $66
8010628b:	6a 42                	push   $0x42
  jmp alltraps
8010628d:	e9 d5 f8 ff ff       	jmp    80105b67 <alltraps>

80106292 <vector67>:
.globl vector67
vector67:
  pushl $0
80106292:	6a 00                	push   $0x0
  pushl $67
80106294:	6a 43                	push   $0x43
  jmp alltraps
80106296:	e9 cc f8 ff ff       	jmp    80105b67 <alltraps>

8010629b <vector68>:
.globl vector68
vector68:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $68
8010629d:	6a 44                	push   $0x44
  jmp alltraps
8010629f:	e9 c3 f8 ff ff       	jmp    80105b67 <alltraps>

801062a4 <vector69>:
.globl vector69
vector69:
  pushl $0
801062a4:	6a 00                	push   $0x0
  pushl $69
801062a6:	6a 45                	push   $0x45
  jmp alltraps
801062a8:	e9 ba f8 ff ff       	jmp    80105b67 <alltraps>

801062ad <vector70>:
.globl vector70
vector70:
  pushl $0
801062ad:	6a 00                	push   $0x0
  pushl $70
801062af:	6a 46                	push   $0x46
  jmp alltraps
801062b1:	e9 b1 f8 ff ff       	jmp    80105b67 <alltraps>

801062b6 <vector71>:
.globl vector71
vector71:
  pushl $0
801062b6:	6a 00                	push   $0x0
  pushl $71
801062b8:	6a 47                	push   $0x47
  jmp alltraps
801062ba:	e9 a8 f8 ff ff       	jmp    80105b67 <alltraps>

801062bf <vector72>:
.globl vector72
vector72:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $72
801062c1:	6a 48                	push   $0x48
  jmp alltraps
801062c3:	e9 9f f8 ff ff       	jmp    80105b67 <alltraps>

801062c8 <vector73>:
.globl vector73
vector73:
  pushl $0
801062c8:	6a 00                	push   $0x0
  pushl $73
801062ca:	6a 49                	push   $0x49
  jmp alltraps
801062cc:	e9 96 f8 ff ff       	jmp    80105b67 <alltraps>

801062d1 <vector74>:
.globl vector74
vector74:
  pushl $0
801062d1:	6a 00                	push   $0x0
  pushl $74
801062d3:	6a 4a                	push   $0x4a
  jmp alltraps
801062d5:	e9 8d f8 ff ff       	jmp    80105b67 <alltraps>

801062da <vector75>:
.globl vector75
vector75:
  pushl $0
801062da:	6a 00                	push   $0x0
  pushl $75
801062dc:	6a 4b                	push   $0x4b
  jmp alltraps
801062de:	e9 84 f8 ff ff       	jmp    80105b67 <alltraps>

801062e3 <vector76>:
.globl vector76
vector76:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $76
801062e5:	6a 4c                	push   $0x4c
  jmp alltraps
801062e7:	e9 7b f8 ff ff       	jmp    80105b67 <alltraps>

801062ec <vector77>:
.globl vector77
vector77:
  pushl $0
801062ec:	6a 00                	push   $0x0
  pushl $77
801062ee:	6a 4d                	push   $0x4d
  jmp alltraps
801062f0:	e9 72 f8 ff ff       	jmp    80105b67 <alltraps>

801062f5 <vector78>:
.globl vector78
vector78:
  pushl $0
801062f5:	6a 00                	push   $0x0
  pushl $78
801062f7:	6a 4e                	push   $0x4e
  jmp alltraps
801062f9:	e9 69 f8 ff ff       	jmp    80105b67 <alltraps>

801062fe <vector79>:
.globl vector79
vector79:
  pushl $0
801062fe:	6a 00                	push   $0x0
  pushl $79
80106300:	6a 4f                	push   $0x4f
  jmp alltraps
80106302:	e9 60 f8 ff ff       	jmp    80105b67 <alltraps>

80106307 <vector80>:
.globl vector80
vector80:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $80
80106309:	6a 50                	push   $0x50
  jmp alltraps
8010630b:	e9 57 f8 ff ff       	jmp    80105b67 <alltraps>

80106310 <vector81>:
.globl vector81
vector81:
  pushl $0
80106310:	6a 00                	push   $0x0
  pushl $81
80106312:	6a 51                	push   $0x51
  jmp alltraps
80106314:	e9 4e f8 ff ff       	jmp    80105b67 <alltraps>

80106319 <vector82>:
.globl vector82
vector82:
  pushl $0
80106319:	6a 00                	push   $0x0
  pushl $82
8010631b:	6a 52                	push   $0x52
  jmp alltraps
8010631d:	e9 45 f8 ff ff       	jmp    80105b67 <alltraps>

80106322 <vector83>:
.globl vector83
vector83:
  pushl $0
80106322:	6a 00                	push   $0x0
  pushl $83
80106324:	6a 53                	push   $0x53
  jmp alltraps
80106326:	e9 3c f8 ff ff       	jmp    80105b67 <alltraps>

8010632b <vector84>:
.globl vector84
vector84:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $84
8010632d:	6a 54                	push   $0x54
  jmp alltraps
8010632f:	e9 33 f8 ff ff       	jmp    80105b67 <alltraps>

80106334 <vector85>:
.globl vector85
vector85:
  pushl $0
80106334:	6a 00                	push   $0x0
  pushl $85
80106336:	6a 55                	push   $0x55
  jmp alltraps
80106338:	e9 2a f8 ff ff       	jmp    80105b67 <alltraps>

8010633d <vector86>:
.globl vector86
vector86:
  pushl $0
8010633d:	6a 00                	push   $0x0
  pushl $86
8010633f:	6a 56                	push   $0x56
  jmp alltraps
80106341:	e9 21 f8 ff ff       	jmp    80105b67 <alltraps>

80106346 <vector87>:
.globl vector87
vector87:
  pushl $0
80106346:	6a 00                	push   $0x0
  pushl $87
80106348:	6a 57                	push   $0x57
  jmp alltraps
8010634a:	e9 18 f8 ff ff       	jmp    80105b67 <alltraps>

8010634f <vector88>:
.globl vector88
vector88:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $88
80106351:	6a 58                	push   $0x58
  jmp alltraps
80106353:	e9 0f f8 ff ff       	jmp    80105b67 <alltraps>

80106358 <vector89>:
.globl vector89
vector89:
  pushl $0
80106358:	6a 00                	push   $0x0
  pushl $89
8010635a:	6a 59                	push   $0x59
  jmp alltraps
8010635c:	e9 06 f8 ff ff       	jmp    80105b67 <alltraps>

80106361 <vector90>:
.globl vector90
vector90:
  pushl $0
80106361:	6a 00                	push   $0x0
  pushl $90
80106363:	6a 5a                	push   $0x5a
  jmp alltraps
80106365:	e9 fd f7 ff ff       	jmp    80105b67 <alltraps>

8010636a <vector91>:
.globl vector91
vector91:
  pushl $0
8010636a:	6a 00                	push   $0x0
  pushl $91
8010636c:	6a 5b                	push   $0x5b
  jmp alltraps
8010636e:	e9 f4 f7 ff ff       	jmp    80105b67 <alltraps>

80106373 <vector92>:
.globl vector92
vector92:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $92
80106375:	6a 5c                	push   $0x5c
  jmp alltraps
80106377:	e9 eb f7 ff ff       	jmp    80105b67 <alltraps>

8010637c <vector93>:
.globl vector93
vector93:
  pushl $0
8010637c:	6a 00                	push   $0x0
  pushl $93
8010637e:	6a 5d                	push   $0x5d
  jmp alltraps
80106380:	e9 e2 f7 ff ff       	jmp    80105b67 <alltraps>

80106385 <vector94>:
.globl vector94
vector94:
  pushl $0
80106385:	6a 00                	push   $0x0
  pushl $94
80106387:	6a 5e                	push   $0x5e
  jmp alltraps
80106389:	e9 d9 f7 ff ff       	jmp    80105b67 <alltraps>

8010638e <vector95>:
.globl vector95
vector95:
  pushl $0
8010638e:	6a 00                	push   $0x0
  pushl $95
80106390:	6a 5f                	push   $0x5f
  jmp alltraps
80106392:	e9 d0 f7 ff ff       	jmp    80105b67 <alltraps>

80106397 <vector96>:
.globl vector96
vector96:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $96
80106399:	6a 60                	push   $0x60
  jmp alltraps
8010639b:	e9 c7 f7 ff ff       	jmp    80105b67 <alltraps>

801063a0 <vector97>:
.globl vector97
vector97:
  pushl $0
801063a0:	6a 00                	push   $0x0
  pushl $97
801063a2:	6a 61                	push   $0x61
  jmp alltraps
801063a4:	e9 be f7 ff ff       	jmp    80105b67 <alltraps>

801063a9 <vector98>:
.globl vector98
vector98:
  pushl $0
801063a9:	6a 00                	push   $0x0
  pushl $98
801063ab:	6a 62                	push   $0x62
  jmp alltraps
801063ad:	e9 b5 f7 ff ff       	jmp    80105b67 <alltraps>

801063b2 <vector99>:
.globl vector99
vector99:
  pushl $0
801063b2:	6a 00                	push   $0x0
  pushl $99
801063b4:	6a 63                	push   $0x63
  jmp alltraps
801063b6:	e9 ac f7 ff ff       	jmp    80105b67 <alltraps>

801063bb <vector100>:
.globl vector100
vector100:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $100
801063bd:	6a 64                	push   $0x64
  jmp alltraps
801063bf:	e9 a3 f7 ff ff       	jmp    80105b67 <alltraps>

801063c4 <vector101>:
.globl vector101
vector101:
  pushl $0
801063c4:	6a 00                	push   $0x0
  pushl $101
801063c6:	6a 65                	push   $0x65
  jmp alltraps
801063c8:	e9 9a f7 ff ff       	jmp    80105b67 <alltraps>

801063cd <vector102>:
.globl vector102
vector102:
  pushl $0
801063cd:	6a 00                	push   $0x0
  pushl $102
801063cf:	6a 66                	push   $0x66
  jmp alltraps
801063d1:	e9 91 f7 ff ff       	jmp    80105b67 <alltraps>

801063d6 <vector103>:
.globl vector103
vector103:
  pushl $0
801063d6:	6a 00                	push   $0x0
  pushl $103
801063d8:	6a 67                	push   $0x67
  jmp alltraps
801063da:	e9 88 f7 ff ff       	jmp    80105b67 <alltraps>

801063df <vector104>:
.globl vector104
vector104:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $104
801063e1:	6a 68                	push   $0x68
  jmp alltraps
801063e3:	e9 7f f7 ff ff       	jmp    80105b67 <alltraps>

801063e8 <vector105>:
.globl vector105
vector105:
  pushl $0
801063e8:	6a 00                	push   $0x0
  pushl $105
801063ea:	6a 69                	push   $0x69
  jmp alltraps
801063ec:	e9 76 f7 ff ff       	jmp    80105b67 <alltraps>

801063f1 <vector106>:
.globl vector106
vector106:
  pushl $0
801063f1:	6a 00                	push   $0x0
  pushl $106
801063f3:	6a 6a                	push   $0x6a
  jmp alltraps
801063f5:	e9 6d f7 ff ff       	jmp    80105b67 <alltraps>

801063fa <vector107>:
.globl vector107
vector107:
  pushl $0
801063fa:	6a 00                	push   $0x0
  pushl $107
801063fc:	6a 6b                	push   $0x6b
  jmp alltraps
801063fe:	e9 64 f7 ff ff       	jmp    80105b67 <alltraps>

80106403 <vector108>:
.globl vector108
vector108:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $108
80106405:	6a 6c                	push   $0x6c
  jmp alltraps
80106407:	e9 5b f7 ff ff       	jmp    80105b67 <alltraps>

8010640c <vector109>:
.globl vector109
vector109:
  pushl $0
8010640c:	6a 00                	push   $0x0
  pushl $109
8010640e:	6a 6d                	push   $0x6d
  jmp alltraps
80106410:	e9 52 f7 ff ff       	jmp    80105b67 <alltraps>

80106415 <vector110>:
.globl vector110
vector110:
  pushl $0
80106415:	6a 00                	push   $0x0
  pushl $110
80106417:	6a 6e                	push   $0x6e
  jmp alltraps
80106419:	e9 49 f7 ff ff       	jmp    80105b67 <alltraps>

8010641e <vector111>:
.globl vector111
vector111:
  pushl $0
8010641e:	6a 00                	push   $0x0
  pushl $111
80106420:	6a 6f                	push   $0x6f
  jmp alltraps
80106422:	e9 40 f7 ff ff       	jmp    80105b67 <alltraps>

80106427 <vector112>:
.globl vector112
vector112:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $112
80106429:	6a 70                	push   $0x70
  jmp alltraps
8010642b:	e9 37 f7 ff ff       	jmp    80105b67 <alltraps>

80106430 <vector113>:
.globl vector113
vector113:
  pushl $0
80106430:	6a 00                	push   $0x0
  pushl $113
80106432:	6a 71                	push   $0x71
  jmp alltraps
80106434:	e9 2e f7 ff ff       	jmp    80105b67 <alltraps>

80106439 <vector114>:
.globl vector114
vector114:
  pushl $0
80106439:	6a 00                	push   $0x0
  pushl $114
8010643b:	6a 72                	push   $0x72
  jmp alltraps
8010643d:	e9 25 f7 ff ff       	jmp    80105b67 <alltraps>

80106442 <vector115>:
.globl vector115
vector115:
  pushl $0
80106442:	6a 00                	push   $0x0
  pushl $115
80106444:	6a 73                	push   $0x73
  jmp alltraps
80106446:	e9 1c f7 ff ff       	jmp    80105b67 <alltraps>

8010644b <vector116>:
.globl vector116
vector116:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $116
8010644d:	6a 74                	push   $0x74
  jmp alltraps
8010644f:	e9 13 f7 ff ff       	jmp    80105b67 <alltraps>

80106454 <vector117>:
.globl vector117
vector117:
  pushl $0
80106454:	6a 00                	push   $0x0
  pushl $117
80106456:	6a 75                	push   $0x75
  jmp alltraps
80106458:	e9 0a f7 ff ff       	jmp    80105b67 <alltraps>

8010645d <vector118>:
.globl vector118
vector118:
  pushl $0
8010645d:	6a 00                	push   $0x0
  pushl $118
8010645f:	6a 76                	push   $0x76
  jmp alltraps
80106461:	e9 01 f7 ff ff       	jmp    80105b67 <alltraps>

80106466 <vector119>:
.globl vector119
vector119:
  pushl $0
80106466:	6a 00                	push   $0x0
  pushl $119
80106468:	6a 77                	push   $0x77
  jmp alltraps
8010646a:	e9 f8 f6 ff ff       	jmp    80105b67 <alltraps>

8010646f <vector120>:
.globl vector120
vector120:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $120
80106471:	6a 78                	push   $0x78
  jmp alltraps
80106473:	e9 ef f6 ff ff       	jmp    80105b67 <alltraps>

80106478 <vector121>:
.globl vector121
vector121:
  pushl $0
80106478:	6a 00                	push   $0x0
  pushl $121
8010647a:	6a 79                	push   $0x79
  jmp alltraps
8010647c:	e9 e6 f6 ff ff       	jmp    80105b67 <alltraps>

80106481 <vector122>:
.globl vector122
vector122:
  pushl $0
80106481:	6a 00                	push   $0x0
  pushl $122
80106483:	6a 7a                	push   $0x7a
  jmp alltraps
80106485:	e9 dd f6 ff ff       	jmp    80105b67 <alltraps>

8010648a <vector123>:
.globl vector123
vector123:
  pushl $0
8010648a:	6a 00                	push   $0x0
  pushl $123
8010648c:	6a 7b                	push   $0x7b
  jmp alltraps
8010648e:	e9 d4 f6 ff ff       	jmp    80105b67 <alltraps>

80106493 <vector124>:
.globl vector124
vector124:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $124
80106495:	6a 7c                	push   $0x7c
  jmp alltraps
80106497:	e9 cb f6 ff ff       	jmp    80105b67 <alltraps>

8010649c <vector125>:
.globl vector125
vector125:
  pushl $0
8010649c:	6a 00                	push   $0x0
  pushl $125
8010649e:	6a 7d                	push   $0x7d
  jmp alltraps
801064a0:	e9 c2 f6 ff ff       	jmp    80105b67 <alltraps>

801064a5 <vector126>:
.globl vector126
vector126:
  pushl $0
801064a5:	6a 00                	push   $0x0
  pushl $126
801064a7:	6a 7e                	push   $0x7e
  jmp alltraps
801064a9:	e9 b9 f6 ff ff       	jmp    80105b67 <alltraps>

801064ae <vector127>:
.globl vector127
vector127:
  pushl $0
801064ae:	6a 00                	push   $0x0
  pushl $127
801064b0:	6a 7f                	push   $0x7f
  jmp alltraps
801064b2:	e9 b0 f6 ff ff       	jmp    80105b67 <alltraps>

801064b7 <vector128>:
.globl vector128
vector128:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $128
801064b9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801064be:	e9 a4 f6 ff ff       	jmp    80105b67 <alltraps>

801064c3 <vector129>:
.globl vector129
vector129:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $129
801064c5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801064ca:	e9 98 f6 ff ff       	jmp    80105b67 <alltraps>

801064cf <vector130>:
.globl vector130
vector130:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $130
801064d1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801064d6:	e9 8c f6 ff ff       	jmp    80105b67 <alltraps>

801064db <vector131>:
.globl vector131
vector131:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $131
801064dd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801064e2:	e9 80 f6 ff ff       	jmp    80105b67 <alltraps>

801064e7 <vector132>:
.globl vector132
vector132:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $132
801064e9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801064ee:	e9 74 f6 ff ff       	jmp    80105b67 <alltraps>

801064f3 <vector133>:
.globl vector133
vector133:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $133
801064f5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801064fa:	e9 68 f6 ff ff       	jmp    80105b67 <alltraps>

801064ff <vector134>:
.globl vector134
vector134:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $134
80106501:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106506:	e9 5c f6 ff ff       	jmp    80105b67 <alltraps>

8010650b <vector135>:
.globl vector135
vector135:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $135
8010650d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106512:	e9 50 f6 ff ff       	jmp    80105b67 <alltraps>

80106517 <vector136>:
.globl vector136
vector136:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $136
80106519:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010651e:	e9 44 f6 ff ff       	jmp    80105b67 <alltraps>

80106523 <vector137>:
.globl vector137
vector137:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $137
80106525:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010652a:	e9 38 f6 ff ff       	jmp    80105b67 <alltraps>

8010652f <vector138>:
.globl vector138
vector138:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $138
80106531:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106536:	e9 2c f6 ff ff       	jmp    80105b67 <alltraps>

8010653b <vector139>:
.globl vector139
vector139:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $139
8010653d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106542:	e9 20 f6 ff ff       	jmp    80105b67 <alltraps>

80106547 <vector140>:
.globl vector140
vector140:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $140
80106549:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010654e:	e9 14 f6 ff ff       	jmp    80105b67 <alltraps>

80106553 <vector141>:
.globl vector141
vector141:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $141
80106555:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010655a:	e9 08 f6 ff ff       	jmp    80105b67 <alltraps>

8010655f <vector142>:
.globl vector142
vector142:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $142
80106561:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106566:	e9 fc f5 ff ff       	jmp    80105b67 <alltraps>

8010656b <vector143>:
.globl vector143
vector143:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $143
8010656d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106572:	e9 f0 f5 ff ff       	jmp    80105b67 <alltraps>

80106577 <vector144>:
.globl vector144
vector144:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $144
80106579:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010657e:	e9 e4 f5 ff ff       	jmp    80105b67 <alltraps>

80106583 <vector145>:
.globl vector145
vector145:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $145
80106585:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010658a:	e9 d8 f5 ff ff       	jmp    80105b67 <alltraps>

8010658f <vector146>:
.globl vector146
vector146:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $146
80106591:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106596:	e9 cc f5 ff ff       	jmp    80105b67 <alltraps>

8010659b <vector147>:
.globl vector147
vector147:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $147
8010659d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801065a2:	e9 c0 f5 ff ff       	jmp    80105b67 <alltraps>

801065a7 <vector148>:
.globl vector148
vector148:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $148
801065a9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801065ae:	e9 b4 f5 ff ff       	jmp    80105b67 <alltraps>

801065b3 <vector149>:
.globl vector149
vector149:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $149
801065b5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801065ba:	e9 a8 f5 ff ff       	jmp    80105b67 <alltraps>

801065bf <vector150>:
.globl vector150
vector150:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $150
801065c1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801065c6:	e9 9c f5 ff ff       	jmp    80105b67 <alltraps>

801065cb <vector151>:
.globl vector151
vector151:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $151
801065cd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801065d2:	e9 90 f5 ff ff       	jmp    80105b67 <alltraps>

801065d7 <vector152>:
.globl vector152
vector152:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $152
801065d9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801065de:	e9 84 f5 ff ff       	jmp    80105b67 <alltraps>

801065e3 <vector153>:
.globl vector153
vector153:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $153
801065e5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801065ea:	e9 78 f5 ff ff       	jmp    80105b67 <alltraps>

801065ef <vector154>:
.globl vector154
vector154:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $154
801065f1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801065f6:	e9 6c f5 ff ff       	jmp    80105b67 <alltraps>

801065fb <vector155>:
.globl vector155
vector155:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $155
801065fd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106602:	e9 60 f5 ff ff       	jmp    80105b67 <alltraps>

80106607 <vector156>:
.globl vector156
vector156:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $156
80106609:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010660e:	e9 54 f5 ff ff       	jmp    80105b67 <alltraps>

80106613 <vector157>:
.globl vector157
vector157:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $157
80106615:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010661a:	e9 48 f5 ff ff       	jmp    80105b67 <alltraps>

8010661f <vector158>:
.globl vector158
vector158:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $158
80106621:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106626:	e9 3c f5 ff ff       	jmp    80105b67 <alltraps>

8010662b <vector159>:
.globl vector159
vector159:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $159
8010662d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106632:	e9 30 f5 ff ff       	jmp    80105b67 <alltraps>

80106637 <vector160>:
.globl vector160
vector160:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $160
80106639:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010663e:	e9 24 f5 ff ff       	jmp    80105b67 <alltraps>

80106643 <vector161>:
.globl vector161
vector161:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $161
80106645:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010664a:	e9 18 f5 ff ff       	jmp    80105b67 <alltraps>

8010664f <vector162>:
.globl vector162
vector162:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $162
80106651:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106656:	e9 0c f5 ff ff       	jmp    80105b67 <alltraps>

8010665b <vector163>:
.globl vector163
vector163:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $163
8010665d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106662:	e9 00 f5 ff ff       	jmp    80105b67 <alltraps>

80106667 <vector164>:
.globl vector164
vector164:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $164
80106669:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010666e:	e9 f4 f4 ff ff       	jmp    80105b67 <alltraps>

80106673 <vector165>:
.globl vector165
vector165:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $165
80106675:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010667a:	e9 e8 f4 ff ff       	jmp    80105b67 <alltraps>

8010667f <vector166>:
.globl vector166
vector166:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $166
80106681:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106686:	e9 dc f4 ff ff       	jmp    80105b67 <alltraps>

8010668b <vector167>:
.globl vector167
vector167:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $167
8010668d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106692:	e9 d0 f4 ff ff       	jmp    80105b67 <alltraps>

80106697 <vector168>:
.globl vector168
vector168:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $168
80106699:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010669e:	e9 c4 f4 ff ff       	jmp    80105b67 <alltraps>

801066a3 <vector169>:
.globl vector169
vector169:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $169
801066a5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801066aa:	e9 b8 f4 ff ff       	jmp    80105b67 <alltraps>

801066af <vector170>:
.globl vector170
vector170:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $170
801066b1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801066b6:	e9 ac f4 ff ff       	jmp    80105b67 <alltraps>

801066bb <vector171>:
.globl vector171
vector171:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $171
801066bd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801066c2:	e9 a0 f4 ff ff       	jmp    80105b67 <alltraps>

801066c7 <vector172>:
.globl vector172
vector172:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $172
801066c9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801066ce:	e9 94 f4 ff ff       	jmp    80105b67 <alltraps>

801066d3 <vector173>:
.globl vector173
vector173:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $173
801066d5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801066da:	e9 88 f4 ff ff       	jmp    80105b67 <alltraps>

801066df <vector174>:
.globl vector174
vector174:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $174
801066e1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801066e6:	e9 7c f4 ff ff       	jmp    80105b67 <alltraps>

801066eb <vector175>:
.globl vector175
vector175:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $175
801066ed:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801066f2:	e9 70 f4 ff ff       	jmp    80105b67 <alltraps>

801066f7 <vector176>:
.globl vector176
vector176:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $176
801066f9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801066fe:	e9 64 f4 ff ff       	jmp    80105b67 <alltraps>

80106703 <vector177>:
.globl vector177
vector177:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $177
80106705:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010670a:	e9 58 f4 ff ff       	jmp    80105b67 <alltraps>

8010670f <vector178>:
.globl vector178
vector178:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $178
80106711:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106716:	e9 4c f4 ff ff       	jmp    80105b67 <alltraps>

8010671b <vector179>:
.globl vector179
vector179:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $179
8010671d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106722:	e9 40 f4 ff ff       	jmp    80105b67 <alltraps>

80106727 <vector180>:
.globl vector180
vector180:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $180
80106729:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010672e:	e9 34 f4 ff ff       	jmp    80105b67 <alltraps>

80106733 <vector181>:
.globl vector181
vector181:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $181
80106735:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010673a:	e9 28 f4 ff ff       	jmp    80105b67 <alltraps>

8010673f <vector182>:
.globl vector182
vector182:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $182
80106741:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106746:	e9 1c f4 ff ff       	jmp    80105b67 <alltraps>

8010674b <vector183>:
.globl vector183
vector183:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $183
8010674d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106752:	e9 10 f4 ff ff       	jmp    80105b67 <alltraps>

80106757 <vector184>:
.globl vector184
vector184:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $184
80106759:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010675e:	e9 04 f4 ff ff       	jmp    80105b67 <alltraps>

80106763 <vector185>:
.globl vector185
vector185:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $185
80106765:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010676a:	e9 f8 f3 ff ff       	jmp    80105b67 <alltraps>

8010676f <vector186>:
.globl vector186
vector186:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $186
80106771:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106776:	e9 ec f3 ff ff       	jmp    80105b67 <alltraps>

8010677b <vector187>:
.globl vector187
vector187:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $187
8010677d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106782:	e9 e0 f3 ff ff       	jmp    80105b67 <alltraps>

80106787 <vector188>:
.globl vector188
vector188:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $188
80106789:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010678e:	e9 d4 f3 ff ff       	jmp    80105b67 <alltraps>

80106793 <vector189>:
.globl vector189
vector189:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $189
80106795:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010679a:	e9 c8 f3 ff ff       	jmp    80105b67 <alltraps>

8010679f <vector190>:
.globl vector190
vector190:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $190
801067a1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801067a6:	e9 bc f3 ff ff       	jmp    80105b67 <alltraps>

801067ab <vector191>:
.globl vector191
vector191:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $191
801067ad:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801067b2:	e9 b0 f3 ff ff       	jmp    80105b67 <alltraps>

801067b7 <vector192>:
.globl vector192
vector192:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $192
801067b9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801067be:	e9 a4 f3 ff ff       	jmp    80105b67 <alltraps>

801067c3 <vector193>:
.globl vector193
vector193:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $193
801067c5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801067ca:	e9 98 f3 ff ff       	jmp    80105b67 <alltraps>

801067cf <vector194>:
.globl vector194
vector194:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $194
801067d1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801067d6:	e9 8c f3 ff ff       	jmp    80105b67 <alltraps>

801067db <vector195>:
.globl vector195
vector195:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $195
801067dd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801067e2:	e9 80 f3 ff ff       	jmp    80105b67 <alltraps>

801067e7 <vector196>:
.globl vector196
vector196:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $196
801067e9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801067ee:	e9 74 f3 ff ff       	jmp    80105b67 <alltraps>

801067f3 <vector197>:
.globl vector197
vector197:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $197
801067f5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801067fa:	e9 68 f3 ff ff       	jmp    80105b67 <alltraps>

801067ff <vector198>:
.globl vector198
vector198:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $198
80106801:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106806:	e9 5c f3 ff ff       	jmp    80105b67 <alltraps>

8010680b <vector199>:
.globl vector199
vector199:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $199
8010680d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106812:	e9 50 f3 ff ff       	jmp    80105b67 <alltraps>

80106817 <vector200>:
.globl vector200
vector200:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $200
80106819:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010681e:	e9 44 f3 ff ff       	jmp    80105b67 <alltraps>

80106823 <vector201>:
.globl vector201
vector201:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $201
80106825:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010682a:	e9 38 f3 ff ff       	jmp    80105b67 <alltraps>

8010682f <vector202>:
.globl vector202
vector202:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $202
80106831:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106836:	e9 2c f3 ff ff       	jmp    80105b67 <alltraps>

8010683b <vector203>:
.globl vector203
vector203:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $203
8010683d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106842:	e9 20 f3 ff ff       	jmp    80105b67 <alltraps>

80106847 <vector204>:
.globl vector204
vector204:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $204
80106849:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010684e:	e9 14 f3 ff ff       	jmp    80105b67 <alltraps>

80106853 <vector205>:
.globl vector205
vector205:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $205
80106855:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010685a:	e9 08 f3 ff ff       	jmp    80105b67 <alltraps>

8010685f <vector206>:
.globl vector206
vector206:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $206
80106861:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106866:	e9 fc f2 ff ff       	jmp    80105b67 <alltraps>

8010686b <vector207>:
.globl vector207
vector207:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $207
8010686d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106872:	e9 f0 f2 ff ff       	jmp    80105b67 <alltraps>

80106877 <vector208>:
.globl vector208
vector208:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $208
80106879:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010687e:	e9 e4 f2 ff ff       	jmp    80105b67 <alltraps>

80106883 <vector209>:
.globl vector209
vector209:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $209
80106885:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010688a:	e9 d8 f2 ff ff       	jmp    80105b67 <alltraps>

8010688f <vector210>:
.globl vector210
vector210:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $210
80106891:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106896:	e9 cc f2 ff ff       	jmp    80105b67 <alltraps>

8010689b <vector211>:
.globl vector211
vector211:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $211
8010689d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801068a2:	e9 c0 f2 ff ff       	jmp    80105b67 <alltraps>

801068a7 <vector212>:
.globl vector212
vector212:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $212
801068a9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801068ae:	e9 b4 f2 ff ff       	jmp    80105b67 <alltraps>

801068b3 <vector213>:
.globl vector213
vector213:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $213
801068b5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801068ba:	e9 a8 f2 ff ff       	jmp    80105b67 <alltraps>

801068bf <vector214>:
.globl vector214
vector214:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $214
801068c1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801068c6:	e9 9c f2 ff ff       	jmp    80105b67 <alltraps>

801068cb <vector215>:
.globl vector215
vector215:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $215
801068cd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801068d2:	e9 90 f2 ff ff       	jmp    80105b67 <alltraps>

801068d7 <vector216>:
.globl vector216
vector216:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $216
801068d9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801068de:	e9 84 f2 ff ff       	jmp    80105b67 <alltraps>

801068e3 <vector217>:
.globl vector217
vector217:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $217
801068e5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801068ea:	e9 78 f2 ff ff       	jmp    80105b67 <alltraps>

801068ef <vector218>:
.globl vector218
vector218:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $218
801068f1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801068f6:	e9 6c f2 ff ff       	jmp    80105b67 <alltraps>

801068fb <vector219>:
.globl vector219
vector219:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $219
801068fd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106902:	e9 60 f2 ff ff       	jmp    80105b67 <alltraps>

80106907 <vector220>:
.globl vector220
vector220:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $220
80106909:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010690e:	e9 54 f2 ff ff       	jmp    80105b67 <alltraps>

80106913 <vector221>:
.globl vector221
vector221:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $221
80106915:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010691a:	e9 48 f2 ff ff       	jmp    80105b67 <alltraps>

8010691f <vector222>:
.globl vector222
vector222:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $222
80106921:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106926:	e9 3c f2 ff ff       	jmp    80105b67 <alltraps>

8010692b <vector223>:
.globl vector223
vector223:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $223
8010692d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106932:	e9 30 f2 ff ff       	jmp    80105b67 <alltraps>

80106937 <vector224>:
.globl vector224
vector224:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $224
80106939:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010693e:	e9 24 f2 ff ff       	jmp    80105b67 <alltraps>

80106943 <vector225>:
.globl vector225
vector225:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $225
80106945:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010694a:	e9 18 f2 ff ff       	jmp    80105b67 <alltraps>

8010694f <vector226>:
.globl vector226
vector226:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $226
80106951:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106956:	e9 0c f2 ff ff       	jmp    80105b67 <alltraps>

8010695b <vector227>:
.globl vector227
vector227:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $227
8010695d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106962:	e9 00 f2 ff ff       	jmp    80105b67 <alltraps>

80106967 <vector228>:
.globl vector228
vector228:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $228
80106969:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010696e:	e9 f4 f1 ff ff       	jmp    80105b67 <alltraps>

80106973 <vector229>:
.globl vector229
vector229:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $229
80106975:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010697a:	e9 e8 f1 ff ff       	jmp    80105b67 <alltraps>

8010697f <vector230>:
.globl vector230
vector230:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $230
80106981:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106986:	e9 dc f1 ff ff       	jmp    80105b67 <alltraps>

8010698b <vector231>:
.globl vector231
vector231:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $231
8010698d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106992:	e9 d0 f1 ff ff       	jmp    80105b67 <alltraps>

80106997 <vector232>:
.globl vector232
vector232:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $232
80106999:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010699e:	e9 c4 f1 ff ff       	jmp    80105b67 <alltraps>

801069a3 <vector233>:
.globl vector233
vector233:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $233
801069a5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801069aa:	e9 b8 f1 ff ff       	jmp    80105b67 <alltraps>

801069af <vector234>:
.globl vector234
vector234:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $234
801069b1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801069b6:	e9 ac f1 ff ff       	jmp    80105b67 <alltraps>

801069bb <vector235>:
.globl vector235
vector235:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $235
801069bd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801069c2:	e9 a0 f1 ff ff       	jmp    80105b67 <alltraps>

801069c7 <vector236>:
.globl vector236
vector236:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $236
801069c9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801069ce:	e9 94 f1 ff ff       	jmp    80105b67 <alltraps>

801069d3 <vector237>:
.globl vector237
vector237:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $237
801069d5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801069da:	e9 88 f1 ff ff       	jmp    80105b67 <alltraps>

801069df <vector238>:
.globl vector238
vector238:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $238
801069e1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801069e6:	e9 7c f1 ff ff       	jmp    80105b67 <alltraps>

801069eb <vector239>:
.globl vector239
vector239:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $239
801069ed:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801069f2:	e9 70 f1 ff ff       	jmp    80105b67 <alltraps>

801069f7 <vector240>:
.globl vector240
vector240:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $240
801069f9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801069fe:	e9 64 f1 ff ff       	jmp    80105b67 <alltraps>

80106a03 <vector241>:
.globl vector241
vector241:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $241
80106a05:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106a0a:	e9 58 f1 ff ff       	jmp    80105b67 <alltraps>

80106a0f <vector242>:
.globl vector242
vector242:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $242
80106a11:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106a16:	e9 4c f1 ff ff       	jmp    80105b67 <alltraps>

80106a1b <vector243>:
.globl vector243
vector243:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $243
80106a1d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106a22:	e9 40 f1 ff ff       	jmp    80105b67 <alltraps>

80106a27 <vector244>:
.globl vector244
vector244:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $244
80106a29:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106a2e:	e9 34 f1 ff ff       	jmp    80105b67 <alltraps>

80106a33 <vector245>:
.globl vector245
vector245:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $245
80106a35:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106a3a:	e9 28 f1 ff ff       	jmp    80105b67 <alltraps>

80106a3f <vector246>:
.globl vector246
vector246:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $246
80106a41:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106a46:	e9 1c f1 ff ff       	jmp    80105b67 <alltraps>

80106a4b <vector247>:
.globl vector247
vector247:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $247
80106a4d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106a52:	e9 10 f1 ff ff       	jmp    80105b67 <alltraps>

80106a57 <vector248>:
.globl vector248
vector248:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $248
80106a59:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106a5e:	e9 04 f1 ff ff       	jmp    80105b67 <alltraps>

80106a63 <vector249>:
.globl vector249
vector249:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $249
80106a65:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106a6a:	e9 f8 f0 ff ff       	jmp    80105b67 <alltraps>

80106a6f <vector250>:
.globl vector250
vector250:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $250
80106a71:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106a76:	e9 ec f0 ff ff       	jmp    80105b67 <alltraps>

80106a7b <vector251>:
.globl vector251
vector251:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $251
80106a7d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106a82:	e9 e0 f0 ff ff       	jmp    80105b67 <alltraps>

80106a87 <vector252>:
.globl vector252
vector252:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $252
80106a89:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106a8e:	e9 d4 f0 ff ff       	jmp    80105b67 <alltraps>

80106a93 <vector253>:
.globl vector253
vector253:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $253
80106a95:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106a9a:	e9 c8 f0 ff ff       	jmp    80105b67 <alltraps>

80106a9f <vector254>:
.globl vector254
vector254:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $254
80106aa1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106aa6:	e9 bc f0 ff ff       	jmp    80105b67 <alltraps>

80106aab <vector255>:
.globl vector255
vector255:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $255
80106aad:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106ab2:	e9 b0 f0 ff ff       	jmp    80105b67 <alltraps>
80106ab7:	66 90                	xchg   %ax,%ax
80106ab9:	66 90                	xchg   %ax,%ax
80106abb:	66 90                	xchg   %ax,%ax
80106abd:	66 90                	xchg   %ax,%ax
80106abf:	90                   	nop

80106ac0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106ac0:	55                   	push   %ebp
80106ac1:	89 e5                	mov    %esp,%ebp
80106ac3:	57                   	push   %edi
80106ac4:	56                   	push   %esi
80106ac5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106ac7:	c1 ea 16             	shr    $0x16,%edx
{
80106aca:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
80106acb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
80106ace:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106ad1:	8b 07                	mov    (%edi),%eax
80106ad3:	a8 01                	test   $0x1,%al
80106ad5:	74 29                	je     80106b00 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106ad7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106adc:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106ae2:	c1 ee 0a             	shr    $0xa,%esi
}
80106ae5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106ae8:	89 f2                	mov    %esi,%edx
80106aea:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106af0:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106af3:	5b                   	pop    %ebx
80106af4:	5e                   	pop    %esi
80106af5:	5f                   	pop    %edi
80106af6:	5d                   	pop    %ebp
80106af7:	c3                   	ret    
80106af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106aff:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106b00:	85 c9                	test   %ecx,%ecx
80106b02:	74 2c                	je     80106b30 <walkpgdir+0x70>
80106b04:	e8 b7 ba ff ff       	call   801025c0 <kalloc>
80106b09:	89 c3                	mov    %eax,%ebx
80106b0b:	85 c0                	test   %eax,%eax
80106b0d:	74 21                	je     80106b30 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106b0f:	83 ec 04             	sub    $0x4,%esp
80106b12:	68 00 10 00 00       	push   $0x1000
80106b17:	6a 00                	push   $0x0
80106b19:	50                   	push   %eax
80106b1a:	e8 31 dd ff ff       	call   80104850 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106b1f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b25:	83 c4 10             	add    $0x10,%esp
80106b28:	83 c8 07             	or     $0x7,%eax
80106b2b:	89 07                	mov    %eax,(%edi)
80106b2d:	eb b3                	jmp    80106ae2 <walkpgdir+0x22>
80106b2f:	90                   	nop
}
80106b30:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106b33:	31 c0                	xor    %eax,%eax
}
80106b35:	5b                   	pop    %ebx
80106b36:	5e                   	pop    %esi
80106b37:	5f                   	pop    %edi
80106b38:	5d                   	pop    %ebp
80106b39:	c3                   	ret    
80106b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b40 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	57                   	push   %edi
80106b44:	56                   	push   %esi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106b45:	89 d6                	mov    %edx,%esi
{
80106b47:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106b48:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80106b4e:	83 ec 1c             	sub    $0x1c,%esp
80106b51:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106b54:	8b 7d 08             	mov    0x8(%ebp),%edi
80106b57:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106b5b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b60:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106b63:	29 f7                	sub    %esi,%edi
80106b65:	eb 21                	jmp    80106b88 <mappages+0x48>
80106b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b6e:	66 90                	xchg   %ax,%ax
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106b70:	f6 00 01             	testb  $0x1,(%eax)
80106b73:	75 45                	jne    80106bba <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106b75:	0b 5d 0c             	or     0xc(%ebp),%ebx
80106b78:	83 cb 01             	or     $0x1,%ebx
80106b7b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
80106b7d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80106b80:	74 2e                	je     80106bb0 <mappages+0x70>
      break;
    a += PGSIZE;
80106b82:	81 c6 00 10 00 00    	add    $0x1000,%esi
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106b88:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b8b:	b9 01 00 00 00       	mov    $0x1,%ecx
80106b90:	89 f2                	mov    %esi,%edx
80106b92:	8d 1c 3e             	lea    (%esi,%edi,1),%ebx
80106b95:	e8 26 ff ff ff       	call   80106ac0 <walkpgdir>
80106b9a:	85 c0                	test   %eax,%eax
80106b9c:	75 d2                	jne    80106b70 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106b9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106ba1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ba6:	5b                   	pop    %ebx
80106ba7:	5e                   	pop    %esi
80106ba8:	5f                   	pop    %edi
80106ba9:	5d                   	pop    %ebp
80106baa:	c3                   	ret    
80106bab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106baf:	90                   	nop
80106bb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106bb3:	31 c0                	xor    %eax,%eax
}
80106bb5:	5b                   	pop    %ebx
80106bb6:	5e                   	pop    %esi
80106bb7:	5f                   	pop    %edi
80106bb8:	5d                   	pop    %ebp
80106bb9:	c3                   	ret    
      panic("remap");
80106bba:	83 ec 0c             	sub    $0xc,%esp
80106bbd:	68 ac 7d 10 80       	push   $0x80107dac
80106bc2:	e8 c9 97 ff ff       	call   80100390 <panic>
80106bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bce:	66 90                	xchg   %ax,%ax

80106bd0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
80106bd4:	89 c7                	mov    %eax,%edi
80106bd6:	56                   	push   %esi
80106bd7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106bd8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106bde:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106be4:	83 ec 1c             	sub    $0x1c,%esp
80106be7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106bea:	39 d3                	cmp    %edx,%ebx
80106bec:	73 5a                	jae    80106c48 <deallocuvm.part.0+0x78>
80106bee:	89 d6                	mov    %edx,%esi
80106bf0:	eb 10                	jmp    80106c02 <deallocuvm.part.0+0x32>
80106bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106bf8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bfe:	39 de                	cmp    %ebx,%esi
80106c00:	76 46                	jbe    80106c48 <deallocuvm.part.0+0x78>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106c02:	31 c9                	xor    %ecx,%ecx
80106c04:	89 da                	mov    %ebx,%edx
80106c06:	89 f8                	mov    %edi,%eax
80106c08:	e8 b3 fe ff ff       	call   80106ac0 <walkpgdir>
    if(!pte)
80106c0d:	85 c0                	test   %eax,%eax
80106c0f:	74 47                	je     80106c58 <deallocuvm.part.0+0x88>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106c11:	8b 10                	mov    (%eax),%edx
80106c13:	f6 c2 01             	test   $0x1,%dl
80106c16:	74 e0                	je     80106bf8 <deallocuvm.part.0+0x28>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106c18:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106c1e:	74 46                	je     80106c66 <deallocuvm.part.0+0x96>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106c20:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106c23:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106c29:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106c2c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c32:	52                   	push   %edx
80106c33:	e8 c8 b7 ff ff       	call   80102400 <kfree>
      *pte = 0;
80106c38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c3b:	83 c4 10             	add    $0x10,%esp
80106c3e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106c44:	39 de                	cmp    %ebx,%esi
80106c46:	77 ba                	ja     80106c02 <deallocuvm.part.0+0x32>
    }
  }
  return newsz;
}
80106c48:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c4e:	5b                   	pop    %ebx
80106c4f:	5e                   	pop    %esi
80106c50:	5f                   	pop    %edi
80106c51:	5d                   	pop    %ebp
80106c52:	c3                   	ret    
80106c53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c57:	90                   	nop
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106c58:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106c5e:	81 c3 00 00 40 00    	add    $0x400000,%ebx
80106c64:	eb 98                	jmp    80106bfe <deallocuvm.part.0+0x2e>
        panic("kfree");
80106c66:	83 ec 0c             	sub    $0xc,%esp
80106c69:	68 46 76 10 80       	push   $0x80107646
80106c6e:	e8 1d 97 ff ff       	call   80100390 <panic>
80106c73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c80 <seginit>:
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106c86:	e8 65 cc ff ff       	call   801038f0 <cpuid>
  pd[0] = size-1;
80106c8b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106c90:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106c96:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c9a:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106ca1:	ff 00 00 
80106ca4:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
80106cab:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106cae:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106cb5:	ff 00 00 
80106cb8:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
80106cbf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106cc2:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106cc9:	ff 00 00 
80106ccc:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106cd3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106cd6:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
80106cdd:	ff 00 00 
80106ce0:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106ce7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106cea:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
80106cef:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106cf3:	c1 e8 10             	shr    $0x10,%eax
80106cf6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106cfa:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106cfd:	0f 01 10             	lgdtl  (%eax)
}
80106d00:	c9                   	leave  
80106d01:	c3                   	ret    
80106d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d10 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d10:	a1 a4 58 11 80       	mov    0x801158a4,%eax
80106d15:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d1a:	0f 22 d8             	mov    %eax,%cr3
}
80106d1d:	c3                   	ret    
80106d1e:	66 90                	xchg   %ax,%ax

80106d20 <switchuvm>:
{
80106d20:	55                   	push   %ebp
80106d21:	89 e5                	mov    %esp,%ebp
80106d23:	57                   	push   %edi
80106d24:	56                   	push   %esi
80106d25:	53                   	push   %ebx
80106d26:	83 ec 1c             	sub    $0x1c,%esp
80106d29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106d2c:	85 db                	test   %ebx,%ebx
80106d2e:	0f 84 cb 00 00 00    	je     80106dff <switchuvm+0xdf>
  if(p->kstack == 0)
80106d34:	8b 43 08             	mov    0x8(%ebx),%eax
80106d37:	85 c0                	test   %eax,%eax
80106d39:	0f 84 da 00 00 00    	je     80106e19 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106d3f:	8b 43 04             	mov    0x4(%ebx),%eax
80106d42:	85 c0                	test   %eax,%eax
80106d44:	0f 84 c2 00 00 00    	je     80106e0c <switchuvm+0xec>
  pushcli();
80106d4a:	e8 41 d9 ff ff       	call   80104690 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d4f:	e8 1c cb ff ff       	call   80103870 <mycpu>
80106d54:	89 c6                	mov    %eax,%esi
80106d56:	e8 15 cb ff ff       	call   80103870 <mycpu>
80106d5b:	89 c7                	mov    %eax,%edi
80106d5d:	e8 0e cb ff ff       	call   80103870 <mycpu>
80106d62:	83 c7 08             	add    $0x8,%edi
80106d65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d68:	e8 03 cb ff ff       	call   80103870 <mycpu>
80106d6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106d70:	ba 67 00 00 00       	mov    $0x67,%edx
80106d75:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106d7c:	83 c0 08             	add    $0x8,%eax
80106d7f:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d86:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d8b:	83 c1 08             	add    $0x8,%ecx
80106d8e:	c1 e8 18             	shr    $0x18,%eax
80106d91:	c1 e9 10             	shr    $0x10,%ecx
80106d94:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
80106d9a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106da0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106da5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106dac:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106db1:	e8 ba ca ff ff       	call   80103870 <mycpu>
80106db6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106dbd:	e8 ae ca ff ff       	call   80103870 <mycpu>
80106dc2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106dc6:	8b 73 08             	mov    0x8(%ebx),%esi
80106dc9:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106dcf:	e8 9c ca ff ff       	call   80103870 <mycpu>
80106dd4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106dd7:	e8 94 ca ff ff       	call   80103870 <mycpu>
80106ddc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106de0:	b8 28 00 00 00       	mov    $0x28,%eax
80106de5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106de8:	8b 43 04             	mov    0x4(%ebx),%eax
80106deb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106df0:	0f 22 d8             	mov    %eax,%cr3
}
80106df3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106df6:	5b                   	pop    %ebx
80106df7:	5e                   	pop    %esi
80106df8:	5f                   	pop    %edi
80106df9:	5d                   	pop    %ebp
  popcli();
80106dfa:	e9 a1 d9 ff ff       	jmp    801047a0 <popcli>
    panic("switchuvm: no process");
80106dff:	83 ec 0c             	sub    $0xc,%esp
80106e02:	68 b2 7d 10 80       	push   $0x80107db2
80106e07:	e8 84 95 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106e0c:	83 ec 0c             	sub    $0xc,%esp
80106e0f:	68 dd 7d 10 80       	push   $0x80107ddd
80106e14:	e8 77 95 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106e19:	83 ec 0c             	sub    $0xc,%esp
80106e1c:	68 c8 7d 10 80       	push   $0x80107dc8
80106e21:	e8 6a 95 ff ff       	call   80100390 <panic>
80106e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e2d:	8d 76 00             	lea    0x0(%esi),%esi

80106e30 <inituvm>:
{
80106e30:	55                   	push   %ebp
80106e31:	89 e5                	mov    %esp,%ebp
80106e33:	57                   	push   %edi
80106e34:	56                   	push   %esi
80106e35:	53                   	push   %ebx
80106e36:	83 ec 1c             	sub    $0x1c,%esp
80106e39:	8b 45 08             	mov    0x8(%ebp),%eax
80106e3c:	8b 75 10             	mov    0x10(%ebp),%esi
80106e3f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106e42:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106e45:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106e4b:	77 49                	ja     80106e96 <inituvm+0x66>
  mem = kalloc();
80106e4d:	e8 6e b7 ff ff       	call   801025c0 <kalloc>
  memset(mem, 0, PGSIZE);
80106e52:	83 ec 04             	sub    $0x4,%esp
80106e55:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106e5a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106e5c:	6a 00                	push   $0x0
80106e5e:	50                   	push   %eax
80106e5f:	e8 ec d9 ff ff       	call   80104850 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106e64:	58                   	pop    %eax
80106e65:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e6b:	5a                   	pop    %edx
80106e6c:	6a 06                	push   $0x6
80106e6e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e73:	31 d2                	xor    %edx,%edx
80106e75:	50                   	push   %eax
80106e76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e79:	e8 c2 fc ff ff       	call   80106b40 <mappages>
  memmove(mem, init, sz);
80106e7e:	89 75 10             	mov    %esi,0x10(%ebp)
80106e81:	83 c4 10             	add    $0x10,%esp
80106e84:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106e87:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106e8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e8d:	5b                   	pop    %ebx
80106e8e:	5e                   	pop    %esi
80106e8f:	5f                   	pop    %edi
80106e90:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106e91:	e9 5a da ff ff       	jmp    801048f0 <memmove>
    panic("inituvm: more than a page");
80106e96:	83 ec 0c             	sub    $0xc,%esp
80106e99:	68 f1 7d 10 80       	push   $0x80107df1
80106e9e:	e8 ed 94 ff ff       	call   80100390 <panic>
80106ea3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106eb0 <loaduvm>:
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	57                   	push   %edi
80106eb4:	56                   	push   %esi
80106eb5:	53                   	push   %ebx
80106eb6:	83 ec 1c             	sub    $0x1c,%esp
80106eb9:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ebc:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106ebf:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106ec4:	0f 85 8d 00 00 00    	jne    80106f57 <loaduvm+0xa7>
80106eca:	01 f0                	add    %esi,%eax
  for(i = 0; i < sz; i += PGSIZE){
80106ecc:	89 f3                	mov    %esi,%ebx
80106ece:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ed1:	8b 45 14             	mov    0x14(%ebp),%eax
80106ed4:	01 f0                	add    %esi,%eax
80106ed6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106ed9:	85 f6                	test   %esi,%esi
80106edb:	75 11                	jne    80106eee <loaduvm+0x3e>
80106edd:	eb 61                	jmp    80106f40 <loaduvm+0x90>
80106edf:	90                   	nop
80106ee0:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106ee6:	89 f0                	mov    %esi,%eax
80106ee8:	29 d8                	sub    %ebx,%eax
80106eea:	39 c6                	cmp    %eax,%esi
80106eec:	76 52                	jbe    80106f40 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106eee:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106ef1:	8b 45 08             	mov    0x8(%ebp),%eax
80106ef4:	31 c9                	xor    %ecx,%ecx
80106ef6:	29 da                	sub    %ebx,%edx
80106ef8:	e8 c3 fb ff ff       	call   80106ac0 <walkpgdir>
80106efd:	85 c0                	test   %eax,%eax
80106eff:	74 49                	je     80106f4a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106f01:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f03:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80106f06:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106f0b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106f10:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106f16:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f19:	29 d9                	sub    %ebx,%ecx
80106f1b:	05 00 00 00 80       	add    $0x80000000,%eax
80106f20:	57                   	push   %edi
80106f21:	51                   	push   %ecx
80106f22:	50                   	push   %eax
80106f23:	ff 75 10             	pushl  0x10(%ebp)
80106f26:	e8 e5 aa ff ff       	call   80101a10 <readi>
80106f2b:	83 c4 10             	add    $0x10,%esp
80106f2e:	39 f8                	cmp    %edi,%eax
80106f30:	74 ae                	je     80106ee0 <loaduvm+0x30>
}
80106f32:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f3a:	5b                   	pop    %ebx
80106f3b:	5e                   	pop    %esi
80106f3c:	5f                   	pop    %edi
80106f3d:	5d                   	pop    %ebp
80106f3e:	c3                   	ret    
80106f3f:	90                   	nop
80106f40:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f43:	31 c0                	xor    %eax,%eax
}
80106f45:	5b                   	pop    %ebx
80106f46:	5e                   	pop    %esi
80106f47:	5f                   	pop    %edi
80106f48:	5d                   	pop    %ebp
80106f49:	c3                   	ret    
      panic("loaduvm: address should exist");
80106f4a:	83 ec 0c             	sub    $0xc,%esp
80106f4d:	68 0b 7e 10 80       	push   $0x80107e0b
80106f52:	e8 39 94 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106f57:	83 ec 0c             	sub    $0xc,%esp
80106f5a:	68 ac 7e 10 80       	push   $0x80107eac
80106f5f:	e8 2c 94 ff ff       	call   80100390 <panic>
80106f64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f6f:	90                   	nop

80106f70 <allocuvm>:
{
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	57                   	push   %edi
80106f74:	56                   	push   %esi
80106f75:	53                   	push   %ebx
80106f76:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106f79:	8b 7d 10             	mov    0x10(%ebp),%edi
80106f7c:	85 ff                	test   %edi,%edi
80106f7e:	0f 88 bc 00 00 00    	js     80107040 <allocuvm+0xd0>
  if(newsz < oldsz)
80106f84:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106f87:	0f 82 a3 00 00 00    	jb     80107030 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106f8d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f90:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106f96:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106f9c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106f9f:	0f 86 8e 00 00 00    	jbe    80107033 <allocuvm+0xc3>
80106fa5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106fa8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106fab:	eb 42                	jmp    80106fef <allocuvm+0x7f>
80106fad:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106fb0:	83 ec 04             	sub    $0x4,%esp
80106fb3:	68 00 10 00 00       	push   $0x1000
80106fb8:	6a 00                	push   $0x0
80106fba:	50                   	push   %eax
80106fbb:	e8 90 d8 ff ff       	call   80104850 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106fc0:	58                   	pop    %eax
80106fc1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106fc7:	5a                   	pop    %edx
80106fc8:	6a 06                	push   $0x6
80106fca:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106fcf:	89 da                	mov    %ebx,%edx
80106fd1:	50                   	push   %eax
80106fd2:	89 f8                	mov    %edi,%eax
80106fd4:	e8 67 fb ff ff       	call   80106b40 <mappages>
80106fd9:	83 c4 10             	add    $0x10,%esp
80106fdc:	85 c0                	test   %eax,%eax
80106fde:	78 70                	js     80107050 <allocuvm+0xe0>
  for(; a < newsz; a += PGSIZE){
80106fe0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fe6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106fe9:	0f 86 a1 00 00 00    	jbe    80107090 <allocuvm+0x120>
    mem = kalloc();
80106fef:	e8 cc b5 ff ff       	call   801025c0 <kalloc>
80106ff4:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106ff6:	85 c0                	test   %eax,%eax
80106ff8:	75 b6                	jne    80106fb0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106ffa:	83 ec 0c             	sub    $0xc,%esp
80106ffd:	68 29 7e 10 80       	push   $0x80107e29
80107002:	e8 a9 96 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107007:	83 c4 10             	add    $0x10,%esp
8010700a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010700d:	39 45 10             	cmp    %eax,0x10(%ebp)
80107010:	74 2e                	je     80107040 <allocuvm+0xd0>
80107012:	89 c1                	mov    %eax,%ecx
80107014:	8b 55 10             	mov    0x10(%ebp),%edx
80107017:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
8010701a:	31 ff                	xor    %edi,%edi
8010701c:	e8 af fb ff ff       	call   80106bd0 <deallocuvm.part.0>
}
80107021:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107024:	89 f8                	mov    %edi,%eax
80107026:	5b                   	pop    %ebx
80107027:	5e                   	pop    %esi
80107028:	5f                   	pop    %edi
80107029:	5d                   	pop    %ebp
8010702a:	c3                   	ret    
8010702b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010702f:	90                   	nop
    return oldsz;
80107030:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107033:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107036:	89 f8                	mov    %edi,%eax
80107038:	5b                   	pop    %ebx
80107039:	5e                   	pop    %esi
8010703a:	5f                   	pop    %edi
8010703b:	5d                   	pop    %ebp
8010703c:	c3                   	ret    
8010703d:	8d 76 00             	lea    0x0(%esi),%esi
80107040:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107043:	31 ff                	xor    %edi,%edi
}
80107045:	5b                   	pop    %ebx
80107046:	89 f8                	mov    %edi,%eax
80107048:	5e                   	pop    %esi
80107049:	5f                   	pop    %edi
8010704a:	5d                   	pop    %ebp
8010704b:	c3                   	ret    
8010704c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
80107050:	83 ec 0c             	sub    $0xc,%esp
80107053:	68 41 7e 10 80       	push   $0x80107e41
80107058:	e8 53 96 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
8010705d:	83 c4 10             	add    $0x10,%esp
80107060:	8b 45 0c             	mov    0xc(%ebp),%eax
80107063:	39 45 10             	cmp    %eax,0x10(%ebp)
80107066:	74 0d                	je     80107075 <allocuvm+0x105>
80107068:	89 c1                	mov    %eax,%ecx
8010706a:	8b 55 10             	mov    0x10(%ebp),%edx
8010706d:	8b 45 08             	mov    0x8(%ebp),%eax
80107070:	e8 5b fb ff ff       	call   80106bd0 <deallocuvm.part.0>
      kfree(mem);
80107075:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107078:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010707a:	56                   	push   %esi
8010707b:	e8 80 b3 ff ff       	call   80102400 <kfree>
      return 0;
80107080:	83 c4 10             	add    $0x10,%esp
}
80107083:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107086:	89 f8                	mov    %edi,%eax
80107088:	5b                   	pop    %ebx
80107089:	5e                   	pop    %esi
8010708a:	5f                   	pop    %edi
8010708b:	5d                   	pop    %ebp
8010708c:	c3                   	ret    
8010708d:	8d 76 00             	lea    0x0(%esi),%esi
80107090:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107093:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107096:	5b                   	pop    %ebx
80107097:	5e                   	pop    %esi
80107098:	89 f8                	mov    %edi,%eax
8010709a:	5f                   	pop    %edi
8010709b:	5d                   	pop    %ebp
8010709c:	c3                   	ret    
8010709d:	8d 76 00             	lea    0x0(%esi),%esi

801070a0 <deallocuvm>:
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801070a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801070a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801070ac:	39 d1                	cmp    %edx,%ecx
801070ae:	73 10                	jae    801070c0 <deallocuvm+0x20>
}
801070b0:	5d                   	pop    %ebp
801070b1:	e9 1a fb ff ff       	jmp    80106bd0 <deallocuvm.part.0>
801070b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070bd:	8d 76 00             	lea    0x0(%esi),%esi
801070c0:	89 d0                	mov    %edx,%eax
801070c2:	5d                   	pop    %ebp
801070c3:	c3                   	ret    
801070c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801070cf:	90                   	nop

801070d0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	56                   	push   %esi
801070d5:	53                   	push   %ebx
801070d6:	83 ec 0c             	sub    $0xc,%esp
801070d9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801070dc:	85 f6                	test   %esi,%esi
801070de:	74 59                	je     80107139 <freevm+0x69>
  if(newsz >= oldsz)
801070e0:	31 c9                	xor    %ecx,%ecx
801070e2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801070e7:	89 f0                	mov    %esi,%eax
801070e9:	89 f3                	mov    %esi,%ebx
801070eb:	e8 e0 fa ff ff       	call   80106bd0 <deallocuvm.part.0>
freevm(pde_t *pgdir)
801070f0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801070f6:	eb 0f                	jmp    80107107 <freevm+0x37>
801070f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ff:	90                   	nop
80107100:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107103:	39 df                	cmp    %ebx,%edi
80107105:	74 23                	je     8010712a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107107:	8b 03                	mov    (%ebx),%eax
80107109:	a8 01                	test   $0x1,%al
8010710b:	74 f3                	je     80107100 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010710d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107112:	83 ec 0c             	sub    $0xc,%esp
80107115:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107118:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010711d:	50                   	push   %eax
8010711e:	e8 dd b2 ff ff       	call   80102400 <kfree>
80107123:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107126:	39 df                	cmp    %ebx,%edi
80107128:	75 dd                	jne    80107107 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010712a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010712d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107130:	5b                   	pop    %ebx
80107131:	5e                   	pop    %esi
80107132:	5f                   	pop    %edi
80107133:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107134:	e9 c7 b2 ff ff       	jmp    80102400 <kfree>
    panic("freevm: no pgdir");
80107139:	83 ec 0c             	sub    $0xc,%esp
8010713c:	68 5d 7e 10 80       	push   $0x80107e5d
80107141:	e8 4a 92 ff ff       	call   80100390 <panic>
80107146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010714d:	8d 76 00             	lea    0x0(%esi),%esi

80107150 <setupkvm>:
{
80107150:	55                   	push   %ebp
80107151:	89 e5                	mov    %esp,%ebp
80107153:	56                   	push   %esi
80107154:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107155:	e8 66 b4 ff ff       	call   801025c0 <kalloc>
8010715a:	89 c6                	mov    %eax,%esi
8010715c:	85 c0                	test   %eax,%eax
8010715e:	74 42                	je     801071a2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107160:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107163:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80107168:	68 00 10 00 00       	push   $0x1000
8010716d:	6a 00                	push   $0x0
8010716f:	50                   	push   %eax
80107170:	e8 db d6 ff ff       	call   80104850 <memset>
80107175:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107178:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010717b:	83 ec 08             	sub    $0x8,%esp
8010717e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107181:	ff 73 0c             	pushl  0xc(%ebx)
80107184:	8b 13                	mov    (%ebx),%edx
80107186:	50                   	push   %eax
80107187:	29 c1                	sub    %eax,%ecx
80107189:	89 f0                	mov    %esi,%eax
8010718b:	e8 b0 f9 ff ff       	call   80106b40 <mappages>
80107190:	83 c4 10             	add    $0x10,%esp
80107193:	85 c0                	test   %eax,%eax
80107195:	78 19                	js     801071b0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107197:	83 c3 10             	add    $0x10,%ebx
8010719a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
801071a0:	75 d6                	jne    80107178 <setupkvm+0x28>
}
801071a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801071a5:	89 f0                	mov    %esi,%eax
801071a7:	5b                   	pop    %ebx
801071a8:	5e                   	pop    %esi
801071a9:	5d                   	pop    %ebp
801071aa:	c3                   	ret    
801071ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801071af:	90                   	nop
      freevm(pgdir);
801071b0:	83 ec 0c             	sub    $0xc,%esp
801071b3:	56                   	push   %esi
      return 0;
801071b4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801071b6:	e8 15 ff ff ff       	call   801070d0 <freevm>
      return 0;
801071bb:	83 c4 10             	add    $0x10,%esp
}
801071be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801071c1:	89 f0                	mov    %esi,%eax
801071c3:	5b                   	pop    %ebx
801071c4:	5e                   	pop    %esi
801071c5:	5d                   	pop    %ebp
801071c6:	c3                   	ret    
801071c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071ce:	66 90                	xchg   %ax,%ax

801071d0 <kvmalloc>:
{
801071d0:	55                   	push   %ebp
801071d1:	89 e5                	mov    %esp,%ebp
801071d3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801071d6:	e8 75 ff ff ff       	call   80107150 <setupkvm>
801071db:	a3 a4 58 11 80       	mov    %eax,0x801158a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071e0:	05 00 00 00 80       	add    $0x80000000,%eax
801071e5:	0f 22 d8             	mov    %eax,%cr3
}
801071e8:	c9                   	leave  
801071e9:	c3                   	ret    
801071ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801071f0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801071f0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801071f1:	31 c9                	xor    %ecx,%ecx
{
801071f3:	89 e5                	mov    %esp,%ebp
801071f5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801071f8:	8b 55 0c             	mov    0xc(%ebp),%edx
801071fb:	8b 45 08             	mov    0x8(%ebp),%eax
801071fe:	e8 bd f8 ff ff       	call   80106ac0 <walkpgdir>
  if(pte == 0)
80107203:	85 c0                	test   %eax,%eax
80107205:	74 05                	je     8010720c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107207:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010720a:	c9                   	leave  
8010720b:	c3                   	ret    
    panic("clearpteu");
8010720c:	83 ec 0c             	sub    $0xc,%esp
8010720f:	68 6e 7e 10 80       	push   $0x80107e6e
80107214:	e8 77 91 ff ff       	call   80100390 <panic>
80107219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107220 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107220:	55                   	push   %ebp
80107221:	89 e5                	mov    %esp,%ebp
80107223:	57                   	push   %edi
80107224:	56                   	push   %esi
80107225:	53                   	push   %ebx
80107226:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107229:	e8 22 ff ff ff       	call   80107150 <setupkvm>
8010722e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107231:	85 c0                	test   %eax,%eax
80107233:	0f 84 a0 00 00 00    	je     801072d9 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107239:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010723c:	85 c9                	test   %ecx,%ecx
8010723e:	0f 84 95 00 00 00    	je     801072d9 <copyuvm+0xb9>
80107244:	31 f6                	xor    %esi,%esi
80107246:	eb 4e                	jmp    80107296 <copyuvm+0x76>
80107248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010724f:	90                   	nop
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107250:	83 ec 04             	sub    $0x4,%esp
80107253:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107259:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010725c:	68 00 10 00 00       	push   $0x1000
80107261:	57                   	push   %edi
80107262:	50                   	push   %eax
80107263:	e8 88 d6 ff ff       	call   801048f0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107268:	58                   	pop    %eax
80107269:	5a                   	pop    %edx
8010726a:	53                   	push   %ebx
8010726b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010726e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107271:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107276:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010727c:	52                   	push   %edx
8010727d:	89 f2                	mov    %esi,%edx
8010727f:	e8 bc f8 ff ff       	call   80106b40 <mappages>
80107284:	83 c4 10             	add    $0x10,%esp
80107287:	85 c0                	test   %eax,%eax
80107289:	78 39                	js     801072c4 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
8010728b:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107291:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107294:	76 43                	jbe    801072d9 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107296:	8b 45 08             	mov    0x8(%ebp),%eax
80107299:	31 c9                	xor    %ecx,%ecx
8010729b:	89 f2                	mov    %esi,%edx
8010729d:	e8 1e f8 ff ff       	call   80106ac0 <walkpgdir>
801072a2:	85 c0                	test   %eax,%eax
801072a4:	74 3e                	je     801072e4 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
801072a6:	8b 18                	mov    (%eax),%ebx
801072a8:	f6 c3 01             	test   $0x1,%bl
801072ab:	74 44                	je     801072f1 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
801072ad:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801072af:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801072b5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801072bb:	e8 00 b3 ff ff       	call   801025c0 <kalloc>
801072c0:	85 c0                	test   %eax,%eax
801072c2:	75 8c                	jne    80107250 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
801072c4:	83 ec 0c             	sub    $0xc,%esp
801072c7:	ff 75 e0             	pushl  -0x20(%ebp)
801072ca:	e8 01 fe ff ff       	call   801070d0 <freevm>
  return 0;
801072cf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801072d6:	83 c4 10             	add    $0x10,%esp
}
801072d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801072dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072df:	5b                   	pop    %ebx
801072e0:	5e                   	pop    %esi
801072e1:	5f                   	pop    %edi
801072e2:	5d                   	pop    %ebp
801072e3:	c3                   	ret    
      panic("copyuvm: pte should exist");
801072e4:	83 ec 0c             	sub    $0xc,%esp
801072e7:	68 78 7e 10 80       	push   $0x80107e78
801072ec:	e8 9f 90 ff ff       	call   80100390 <panic>
      panic("copyuvm: page not present");
801072f1:	83 ec 0c             	sub    $0xc,%esp
801072f4:	68 92 7e 10 80       	push   $0x80107e92
801072f9:	e8 92 90 ff ff       	call   80100390 <panic>
801072fe:	66 90                	xchg   %ax,%ax

80107300 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107300:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107301:	31 c9                	xor    %ecx,%ecx
{
80107303:	89 e5                	mov    %esp,%ebp
80107305:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107308:	8b 55 0c             	mov    0xc(%ebp),%edx
8010730b:	8b 45 08             	mov    0x8(%ebp),%eax
8010730e:	e8 ad f7 ff ff       	call   80106ac0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107313:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107315:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107316:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107318:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010731d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107320:	05 00 00 00 80       	add    $0x80000000,%eax
80107325:	83 fa 05             	cmp    $0x5,%edx
80107328:	ba 00 00 00 00       	mov    $0x0,%edx
8010732d:	0f 45 c2             	cmovne %edx,%eax
}
80107330:	c3                   	ret    
80107331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010733f:	90                   	nop

80107340 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	57                   	push   %edi
80107344:	56                   	push   %esi
80107345:	53                   	push   %ebx
80107346:	83 ec 0c             	sub    $0xc,%esp
80107349:	8b 75 14             	mov    0x14(%ebp),%esi
8010734c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010734f:	85 f6                	test   %esi,%esi
80107351:	75 38                	jne    8010738b <copyout+0x4b>
80107353:	eb 6b                	jmp    801073c0 <copyout+0x80>
80107355:	8d 76 00             	lea    0x0(%esi),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107358:	8b 55 0c             	mov    0xc(%ebp),%edx
8010735b:	89 fb                	mov    %edi,%ebx
8010735d:	29 d3                	sub    %edx,%ebx
8010735f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107365:	39 f3                	cmp    %esi,%ebx
80107367:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
8010736a:	29 fa                	sub    %edi,%edx
8010736c:	83 ec 04             	sub    $0x4,%esp
8010736f:	01 c2                	add    %eax,%edx
80107371:	53                   	push   %ebx
80107372:	ff 75 10             	pushl  0x10(%ebp)
80107375:	52                   	push   %edx
80107376:	e8 75 d5 ff ff       	call   801048f0 <memmove>
    len -= n;
    buf += n;
8010737b:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
8010737e:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107384:	83 c4 10             	add    $0x10,%esp
80107387:	29 de                	sub    %ebx,%esi
80107389:	74 35                	je     801073c0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
8010738b:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
8010738d:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107390:	89 55 0c             	mov    %edx,0xc(%ebp)
80107393:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107399:	57                   	push   %edi
8010739a:	ff 75 08             	pushl  0x8(%ebp)
8010739d:	e8 5e ff ff ff       	call   80107300 <uva2ka>
    if(pa0 == 0)
801073a2:	83 c4 10             	add    $0x10,%esp
801073a5:	85 c0                	test   %eax,%eax
801073a7:	75 af                	jne    80107358 <copyout+0x18>
  }
  return 0;
}
801073a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801073ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073b1:	5b                   	pop    %ebx
801073b2:	5e                   	pop    %esi
801073b3:	5f                   	pop    %edi
801073b4:	5d                   	pop    %ebp
801073b5:	c3                   	ret    
801073b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073bd:	8d 76 00             	lea    0x0(%esi),%esi
801073c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801073c3:	31 c0                	xor    %eax,%eax
}
801073c5:	5b                   	pop    %ebx
801073c6:	5e                   	pop    %esi
801073c7:	5f                   	pop    %edi
801073c8:	5d                   	pop    %ebp
801073c9:	c3                   	ret    
