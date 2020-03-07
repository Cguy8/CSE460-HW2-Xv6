
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
8010002d:	b8 80 2f 10 80       	mov    $0x80102f80,%eax
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
8010004c:	68 20 71 10 80       	push   $0x80107120
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 e5 43 00 00       	call   80104440 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 bc fc 10 80       	mov    $0x8010fcbc,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 27 71 10 80       	push   $0x80107127
80100097:	50                   	push   %eax
80100098:	e8 93 42 00 00       	call   80104330 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 60 fa 10 80    	cmp    $0x8010fa60,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
801000e4:	e8 57 44 00 00       	call   80104540 <acquire>
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
80100162:	e8 f9 44 00 00       	call   80104660 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 41 00 00       	call   80104370 <acquiresleep>
      return b;
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
8010018c:	e8 6f 20 00 00       	call   80102200 <iderw>
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
801001a3:	68 2e 71 10 80       	push   $0x8010712e
801001a8:	e8 d3 01 00 00       	call   80100380 <panic>
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
801001be:	e8 4d 42 00 00       	call   80104410 <holdingsleep>
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
801001d4:	e9 27 20 00 00       	jmp    80102200 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 3f 71 10 80       	push   $0x8010713f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
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
801001ff:	e8 0c 42 00 00       	call   80104410 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 bc 41 00 00       	call   801043d0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010021b:	e8 20 43 00 00       	call   80104540 <acquire>
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
8010026c:	e9 ef 43 00 00       	jmp    80104660 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 46 71 10 80       	push   $0x80107146
80100279:	e8 02 01 00 00       	call   80100380 <panic>
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
80100286:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100289:	ff 75 08             	pushl  0x8(%ebp)
{
8010028c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  target = n;
8010028f:	89 de                	mov    %ebx,%esi
  iunlock(ip);
80100291:	e8 6a 15 00 00       	call   80101800 <iunlock>
  acquire(&cons.lock);
80100296:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010029d:	e8 9e 42 00 00       	call   80104540 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002a2:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
    *dst++ = c;
801002a8:	01 df                	add    %ebx,%edi
  while(n > 0){
801002aa:	85 db                	test   %ebx,%ebx
801002ac:	0f 8e 9b 00 00 00    	jle    8010034d <consoleread+0xcd>
    while(input.r == input.w){
801002b2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002b7:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002bd:	74 2b                	je     801002ea <consoleread+0x6a>
801002bf:	eb 5f                	jmp    80100320 <consoleread+0xa0>
801002c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      sleep(&input.r, &cons.lock);
801002c8:	83 ec 08             	sub    $0x8,%esp
801002cb:	68 20 a5 10 80       	push   $0x8010a520
801002d0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002d5:	e8 66 3b 00 00       	call   80103e40 <sleep>
    while(input.r == input.w){
801002da:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002df:	83 c4 10             	add    $0x10,%esp
801002e2:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002e8:	75 36                	jne    80100320 <consoleread+0xa0>
      if(myproc()->killed){
801002ea:	e8 91 35 00 00       	call   80103880 <myproc>
801002ef:	8b 48 24             	mov    0x24(%eax),%ecx
801002f2:	85 c9                	test   %ecx,%ecx
801002f4:	74 d2                	je     801002c8 <consoleread+0x48>
        release(&cons.lock);
801002f6:	83 ec 0c             	sub    $0xc,%esp
801002f9:	68 20 a5 10 80       	push   $0x8010a520
801002fe:	e8 5d 43 00 00       	call   80104660 <release>
        ilock(ip);
80100303:	5a                   	pop    %edx
80100304:	ff 75 08             	pushl  0x8(%ebp)
80100307:	e8 14 14 00 00       	call   80101720 <ilock>
        return -1;
8010030c:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010030f:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100312:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100317:	5b                   	pop    %ebx
80100318:	5e                   	pop    %esi
80100319:	5f                   	pop    %edi
8010031a:	5d                   	pop    %ebp
8010031b:	c3                   	ret    
8010031c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100320:	8d 50 01             	lea    0x1(%eax),%edx
80100323:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100329:	89 c2                	mov    %eax,%edx
8010032b:	83 e2 7f             	and    $0x7f,%edx
8010032e:	0f be 8a 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%ecx
    if(c == C('D')){  // EOF
80100335:	80 f9 04             	cmp    $0x4,%cl
80100338:	74 38                	je     80100372 <consoleread+0xf2>
    *dst++ = c;
8010033a:	89 d8                	mov    %ebx,%eax
    --n;
8010033c:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010033f:	f7 d8                	neg    %eax
80100341:	88 0c 07             	mov    %cl,(%edi,%eax,1)
    if(c == '\n')
80100344:	83 f9 0a             	cmp    $0xa,%ecx
80100347:	0f 85 5d ff ff ff    	jne    801002aa <consoleread+0x2a>
  release(&cons.lock);
8010034d:	83 ec 0c             	sub    $0xc,%esp
80100350:	68 20 a5 10 80       	push   $0x8010a520
80100355:	e8 06 43 00 00       	call   80104660 <release>
  ilock(ip);
8010035a:	58                   	pop    %eax
8010035b:	ff 75 08             	pushl  0x8(%ebp)
8010035e:	e8 bd 13 00 00       	call   80101720 <ilock>
  return target - n;
80100363:	89 f0                	mov    %esi,%eax
80100365:	83 c4 10             	add    $0x10,%esp
}
80100368:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010036b:	29 d8                	sub    %ebx,%eax
}
8010036d:	5b                   	pop    %ebx
8010036e:	5e                   	pop    %esi
8010036f:	5f                   	pop    %edi
80100370:	5d                   	pop    %ebp
80100371:	c3                   	ret    
      if(n < target){
80100372:	39 f3                	cmp    %esi,%ebx
80100374:	73 d7                	jae    8010034d <consoleread+0xcd>
        input.r--;
80100376:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
8010037b:	eb d0                	jmp    8010034d <consoleread+0xcd>
8010037d:	8d 76 00             	lea    0x0(%esi),%esi

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 72 24 00 00       	call   80102810 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 4d 71 10 80       	push   $0x8010714d
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	pushl  0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 47 7b 10 80 	movl   $0x80107b47,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 93 40 00 00       	call   80104460 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	pushl  (%ebx)
801003d5:	83 c3 04             	add    $0x4,%ebx
801003d8:	68 61 71 10 80       	push   $0x80107161
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 21 59 00 00       	call   80105d40 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100434:	89 ca                	mov    %ecx,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c6                	mov    %eax,%esi
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 ca                	mov    %ecx,%edx
80100449:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 90 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	74 70                	je     801004d0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100460:	0f b6 db             	movzbl %bl,%ebx
80100463:	8d 70 01             	lea    0x1(%eax),%esi
80100466:	80 cf 07             	or     $0x7,%bh
80100469:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100470:	80 
  if(pos < 0 || pos > 25*80)
80100471:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100477:	0f 8f f9 00 00 00    	jg     80100576 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010047d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100483:	0f 8f a7 00 00 00    	jg     80100530 <consputc.part.0+0x130>
80100489:	89 f0                	mov    %esi,%eax
8010048b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
80100492:	88 45 e7             	mov    %al,-0x19(%ebp)
80100495:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100498:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049d:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a2:	89 da                	mov    %ebx,%edx
801004a4:	ee                   	out    %al,(%dx)
801004a5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004aa:	89 f8                	mov    %edi,%eax
801004ac:	89 ca                	mov    %ecx,%edx
801004ae:	ee                   	out    %al,(%dx)
801004af:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b4:	89 da                	mov    %ebx,%edx
801004b6:	ee                   	out    %al,(%dx)
801004b7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004bb:	89 ca                	mov    %ecx,%edx
801004bd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 06             	mov    %ax,(%esi)
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
801004ce:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 9a                	jne    80100471 <consputc.part.0+0x71>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b4                	jmp    80100498 <consputc.part.0+0x98>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 71 ff ff ff       	jmp    80100471 <consputc.part.0+0x71>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 36 58 00 00       	call   80105d40 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 2a 58 00 00       	call   80105d40 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 1e 58 00 00       	call   80105d40 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100530:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 fa 41 00 00       	call   80104750 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 45 41 00 00       	call   801046b0 <memset>
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 22 ff ff ff       	jmp    80100498 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 65 71 10 80       	push   $0x80107165
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <printint>:
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 2c             	sub    $0x2c,%esp
80100599:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
8010059c:	85 c9                	test   %ecx,%ecx
8010059e:	74 04                	je     801005a4 <printint+0x14>
801005a0:	85 c0                	test   %eax,%eax
801005a2:	78 6d                	js     80100611 <printint+0x81>
    x = xx;
801005a4:	89 c1                	mov    %eax,%ecx
801005a6:	31 f6                	xor    %esi,%esi
  i = 0;
801005a8:	89 75 cc             	mov    %esi,-0x34(%ebp)
801005ab:	31 db                	xor    %ebx,%ebx
801005ad:	8d 7d d7             	lea    -0x29(%ebp),%edi
    buf[i++] = digits[x % base];
801005b0:	89 c8                	mov    %ecx,%eax
801005b2:	31 d2                	xor    %edx,%edx
801005b4:	89 ce                	mov    %ecx,%esi
801005b6:	f7 75 d4             	divl   -0x2c(%ebp)
801005b9:	0f b6 92 90 71 10 80 	movzbl -0x7fef8e70(%edx),%edx
801005c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801005c3:	89 d8                	mov    %ebx,%eax
801005c5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
801005c8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801005cb:	89 75 d0             	mov    %esi,-0x30(%ebp)
    buf[i++] = digits[x % base];
801005ce:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  }while((x /= base) != 0);
801005d1:	8b 75 d4             	mov    -0x2c(%ebp),%esi
801005d4:	39 75 d0             	cmp    %esi,-0x30(%ebp)
801005d7:	73 d7                	jae    801005b0 <printint+0x20>
801005d9:	8b 75 cc             	mov    -0x34(%ebp),%esi
  if(sign)
801005dc:	85 f6                	test   %esi,%esi
801005de:	74 0c                	je     801005ec <printint+0x5c>
    buf[i++] = '-';
801005e0:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801005e5:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
801005e7:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
801005ec:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
801005f0:	0f be c2             	movsbl %dl,%eax
  if(panicked){
801005f3:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801005f9:	85 d2                	test   %edx,%edx
801005fb:	74 03                	je     80100600 <printint+0x70>
  asm volatile("cli");
801005fd:	fa                   	cli    
    for(;;)
801005fe:	eb fe                	jmp    801005fe <printint+0x6e>
80100600:	e8 fb fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
80100605:	39 fb                	cmp    %edi,%ebx
80100607:	74 10                	je     80100619 <printint+0x89>
80100609:	0f be 03             	movsbl (%ebx),%eax
8010060c:	83 eb 01             	sub    $0x1,%ebx
8010060f:	eb e2                	jmp    801005f3 <printint+0x63>
    x = -xx;
80100611:	f7 d8                	neg    %eax
80100613:	89 ce                	mov    %ecx,%esi
80100615:	89 c1                	mov    %eax,%ecx
80100617:	eb 8f                	jmp    801005a8 <printint+0x18>
}
80100619:	83 c4 2c             	add    $0x2c,%esp
8010061c:	5b                   	pop    %ebx
8010061d:	5e                   	pop    %esi
8010061e:	5f                   	pop    %edi
8010061f:	5d                   	pop    %ebp
80100620:	c3                   	ret    
80100621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010062f:	90                   	nop

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
  int i;

  iunlock(ip);
80100639:	ff 75 08             	pushl  0x8(%ebp)
{
8010063c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
8010063f:	e8 bc 11 00 00       	call   80101800 <iunlock>
  acquire(&cons.lock);
80100644:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010064b:	e8 f0 3e 00 00       	call   80104540 <acquire>
  for(i = 0; i < n; i++)
80100650:	83 c4 10             	add    $0x10,%esp
80100653:	85 db                	test   %ebx,%ebx
80100655:	7e 28                	jle    8010067f <consolewrite+0x4f>
80100657:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010065a:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
8010065d:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100663:	85 d2                	test   %edx,%edx
80100665:	74 09                	je     80100670 <consolewrite+0x40>
80100667:	fa                   	cli    
    for(;;)
80100668:	eb fe                	jmp    80100668 <consolewrite+0x38>
8010066a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100670:	0f b6 07             	movzbl (%edi),%eax
80100673:	83 c7 01             	add    $0x1,%edi
80100676:	e8 85 fd ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
8010067b:	39 fe                	cmp    %edi,%esi
8010067d:	75 de                	jne    8010065d <consolewrite+0x2d>
  release(&cons.lock);
8010067f:	83 ec 0c             	sub    $0xc,%esp
80100682:	68 20 a5 10 80       	push   $0x8010a520
80100687:	e8 d4 3f 00 00       	call   80104660 <release>
  ilock(ip);
8010068c:	58                   	pop    %eax
8010068d:	ff 75 08             	pushl  0x8(%ebp)
80100690:	e8 8b 10 00 00       	call   80101720 <ilock>

  return n;
}
80100695:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100698:	89 d8                	mov    %ebx,%eax
8010069a:	5b                   	pop    %ebx
8010069b:	5e                   	pop    %esi
8010069c:	5f                   	pop    %edi
8010069d:	5d                   	pop    %ebp
8010069e:	c3                   	ret    
8010069f:	90                   	nop

801006a0 <cprintf>:
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006a9:	a1 54 a5 10 80       	mov    0x8010a554,%eax
801006ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006b1:	85 c0                	test   %eax,%eax
801006b3:	0f 85 e4 00 00 00    	jne    8010079d <cprintf+0xfd>
  if (fmt == 0)
801006b9:	8b 45 08             	mov    0x8(%ebp),%eax
801006bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006bf:	85 c0                	test   %eax,%eax
801006c1:	0f 84 5e 01 00 00    	je     80100825 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c7:	0f b6 00             	movzbl (%eax),%eax
801006ca:	85 c0                	test   %eax,%eax
801006cc:	74 32                	je     80100700 <cprintf+0x60>
  argp = (uint*)(void*)(&fmt + 1);
801006ce:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d1:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801006d3:	83 f8 25             	cmp    $0x25,%eax
801006d6:	74 40                	je     80100718 <cprintf+0x78>
  if(panicked){
801006d8:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801006de:	85 c9                	test   %ecx,%ecx
801006e0:	74 0b                	je     801006ed <cprintf+0x4d>
801006e2:	fa                   	cli    
    for(;;)
801006e3:	eb fe                	jmp    801006e3 <cprintf+0x43>
801006e5:	8d 76 00             	lea    0x0(%esi),%esi
801006e8:	b8 25 00 00 00       	mov    $0x25,%eax
801006ed:	e8 0e fd ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006f5:	83 c6 01             	add    $0x1,%esi
801006f8:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
801006fc:	85 c0                	test   %eax,%eax
801006fe:	75 d3                	jne    801006d3 <cprintf+0x33>
  if(locking)
80100700:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100703:	85 c0                	test   %eax,%eax
80100705:	0f 85 05 01 00 00    	jne    80100810 <cprintf+0x170>
}
8010070b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010070e:	5b                   	pop    %ebx
8010070f:	5e                   	pop    %esi
80100710:	5f                   	pop    %edi
80100711:	5d                   	pop    %ebp
80100712:	c3                   	ret    
80100713:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100717:	90                   	nop
    c = fmt[++i] & 0xff;
80100718:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010071b:	83 c6 01             	add    $0x1,%esi
8010071e:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
80100722:	85 ff                	test   %edi,%edi
80100724:	74 da                	je     80100700 <cprintf+0x60>
    switch(c){
80100726:	83 ff 70             	cmp    $0x70,%edi
80100729:	74 5a                	je     80100785 <cprintf+0xe5>
8010072b:	7f 2a                	jg     80100757 <cprintf+0xb7>
8010072d:	83 ff 25             	cmp    $0x25,%edi
80100730:	0f 84 92 00 00 00    	je     801007c8 <cprintf+0x128>
80100736:	83 ff 64             	cmp    $0x64,%edi
80100739:	0f 85 a1 00 00 00    	jne    801007e0 <cprintf+0x140>
      printint(*argp++, 10, 1);
8010073f:	8b 03                	mov    (%ebx),%eax
80100741:	8d 7b 04             	lea    0x4(%ebx),%edi
80100744:	b9 01 00 00 00       	mov    $0x1,%ecx
80100749:	ba 0a 00 00 00       	mov    $0xa,%edx
8010074e:	89 fb                	mov    %edi,%ebx
80100750:	e8 3b fe ff ff       	call   80100590 <printint>
      break;
80100755:	eb 9b                	jmp    801006f2 <cprintf+0x52>
    switch(c){
80100757:	83 ff 73             	cmp    $0x73,%edi
8010075a:	75 24                	jne    80100780 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
8010075c:	8d 7b 04             	lea    0x4(%ebx),%edi
8010075f:	8b 1b                	mov    (%ebx),%ebx
80100761:	85 db                	test   %ebx,%ebx
80100763:	75 55                	jne    801007ba <cprintf+0x11a>
        s = "(null)";
80100765:	bb 78 71 10 80       	mov    $0x80107178,%ebx
      for(; *s; s++)
8010076a:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
8010076f:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100775:	85 d2                	test   %edx,%edx
80100777:	74 39                	je     801007b2 <cprintf+0x112>
80100779:	fa                   	cli    
    for(;;)
8010077a:	eb fe                	jmp    8010077a <cprintf+0xda>
8010077c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100780:	83 ff 78             	cmp    $0x78,%edi
80100783:	75 5b                	jne    801007e0 <cprintf+0x140>
      printint(*argp++, 16, 0);
80100785:	8b 03                	mov    (%ebx),%eax
80100787:	8d 7b 04             	lea    0x4(%ebx),%edi
8010078a:	31 c9                	xor    %ecx,%ecx
8010078c:	ba 10 00 00 00       	mov    $0x10,%edx
80100791:	89 fb                	mov    %edi,%ebx
80100793:	e8 f8 fd ff ff       	call   80100590 <printint>
      break;
80100798:	e9 55 ff ff ff       	jmp    801006f2 <cprintf+0x52>
    acquire(&cons.lock);
8010079d:	83 ec 0c             	sub    $0xc,%esp
801007a0:	68 20 a5 10 80       	push   $0x8010a520
801007a5:	e8 96 3d 00 00       	call   80104540 <acquire>
801007aa:	83 c4 10             	add    $0x10,%esp
801007ad:	e9 07 ff ff ff       	jmp    801006b9 <cprintf+0x19>
801007b2:	e8 49 fc ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
801007b7:	83 c3 01             	add    $0x1,%ebx
801007ba:	0f be 03             	movsbl (%ebx),%eax
801007bd:	84 c0                	test   %al,%al
801007bf:	75 ae                	jne    8010076f <cprintf+0xcf>
      if((s = (char*)*argp++) == 0)
801007c1:	89 fb                	mov    %edi,%ebx
801007c3:	e9 2a ff ff ff       	jmp    801006f2 <cprintf+0x52>
  if(panicked){
801007c8:	8b 3d 58 a5 10 80    	mov    0x8010a558,%edi
801007ce:	85 ff                	test   %edi,%edi
801007d0:	0f 84 12 ff ff ff    	je     801006e8 <cprintf+0x48>
801007d6:	fa                   	cli    
    for(;;)
801007d7:	eb fe                	jmp    801007d7 <cprintf+0x137>
801007d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801007e0:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801007e6:	85 c9                	test   %ecx,%ecx
801007e8:	74 06                	je     801007f0 <cprintf+0x150>
801007ea:	fa                   	cli    
    for(;;)
801007eb:	eb fe                	jmp    801007eb <cprintf+0x14b>
801007ed:	8d 76 00             	lea    0x0(%esi),%esi
801007f0:	b8 25 00 00 00       	mov    $0x25,%eax
801007f5:	e8 06 fc ff ff       	call   80100400 <consputc.part.0>
  if(panicked){
801007fa:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100800:	85 d2                	test   %edx,%edx
80100802:	74 34                	je     80100838 <cprintf+0x198>
80100804:	fa                   	cli    
    for(;;)
80100805:	eb fe                	jmp    80100805 <cprintf+0x165>
80100807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010080e:	66 90                	xchg   %ax,%ax
    release(&cons.lock);
80100810:	83 ec 0c             	sub    $0xc,%esp
80100813:	68 20 a5 10 80       	push   $0x8010a520
80100818:	e8 43 3e 00 00       	call   80104660 <release>
8010081d:	83 c4 10             	add    $0x10,%esp
}
80100820:	e9 e6 fe ff ff       	jmp    8010070b <cprintf+0x6b>
    panic("null fmt");
80100825:	83 ec 0c             	sub    $0xc,%esp
80100828:	68 7f 71 10 80       	push   $0x8010717f
8010082d:	e8 4e fb ff ff       	call   80100380 <panic>
80100832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100838:	89 f8                	mov    %edi,%eax
8010083a:	e8 c1 fb ff ff       	call   80100400 <consputc.part.0>
8010083f:	e9 ae fe ff ff       	jmp    801006f2 <cprintf+0x52>
80100844:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010084b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010084f:	90                   	nop

80100850 <consoleintr>:
{
80100850:	55                   	push   %ebp
80100851:	89 e5                	mov    %esp,%ebp
80100853:	57                   	push   %edi
80100854:	56                   	push   %esi
  int c, doprocdump = 0;
80100855:	31 f6                	xor    %esi,%esi
{
80100857:	53                   	push   %ebx
80100858:	83 ec 18             	sub    $0x18,%esp
8010085b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010085e:	68 20 a5 10 80       	push   $0x8010a520
80100863:	e8 d8 3c 00 00       	call   80104540 <acquire>
  while((c = getc()) >= 0){
80100868:	83 c4 10             	add    $0x10,%esp
8010086b:	eb 17                	jmp    80100884 <consoleintr+0x34>
    switch(c){
8010086d:	83 fb 08             	cmp    $0x8,%ebx
80100870:	0f 84 fa 00 00 00    	je     80100970 <consoleintr+0x120>
80100876:	83 fb 10             	cmp    $0x10,%ebx
80100879:	0f 85 19 01 00 00    	jne    80100998 <consoleintr+0x148>
8010087f:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
80100884:	ff d7                	call   *%edi
80100886:	89 c3                	mov    %eax,%ebx
80100888:	85 c0                	test   %eax,%eax
8010088a:	0f 88 27 01 00 00    	js     801009b7 <consoleintr+0x167>
    switch(c){
80100890:	83 fb 15             	cmp    $0x15,%ebx
80100893:	74 7b                	je     80100910 <consoleintr+0xc0>
80100895:	7e d6                	jle    8010086d <consoleintr+0x1d>
80100897:	83 fb 7f             	cmp    $0x7f,%ebx
8010089a:	0f 84 d0 00 00 00    	je     80100970 <consoleintr+0x120>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a0:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008a5:	89 c2                	mov    %eax,%edx
801008a7:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008ad:	83 fa 7f             	cmp    $0x7f,%edx
801008b0:	77 d2                	ja     80100884 <consoleintr+0x34>
        c = (c == '\r') ? '\n' : c;
801008b2:	8d 48 01             	lea    0x1(%eax),%ecx
801008b5:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801008bb:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
801008be:	89 0d a8 ff 10 80    	mov    %ecx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
801008c4:	83 fb 0d             	cmp    $0xd,%ebx
801008c7:	0f 84 06 01 00 00    	je     801009d3 <consoleintr+0x183>
        input.buf[input.e++ % INPUT_BUF] = c;
801008cd:	88 98 20 ff 10 80    	mov    %bl,-0x7fef00e0(%eax)
  if(panicked){
801008d3:	85 d2                	test   %edx,%edx
801008d5:	0f 85 03 01 00 00    	jne    801009de <consoleintr+0x18e>
801008db:	89 d8                	mov    %ebx,%eax
801008dd:	e8 1e fb ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e2:	83 fb 0a             	cmp    $0xa,%ebx
801008e5:	0f 84 13 01 00 00    	je     801009fe <consoleintr+0x1ae>
801008eb:	83 fb 04             	cmp    $0x4,%ebx
801008ee:	0f 84 0a 01 00 00    	je     801009fe <consoleintr+0x1ae>
801008f4:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008f9:	83 e8 80             	sub    $0xffffff80,%eax
801008fc:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
80100902:	75 80                	jne    80100884 <consoleintr+0x34>
80100904:	e9 fa 00 00 00       	jmp    80100a03 <consoleintr+0x1b3>
80100909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100910:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100915:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
8010091b:	0f 84 63 ff ff ff    	je     80100884 <consoleintr+0x34>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100921:	83 e8 01             	sub    $0x1,%eax
80100924:	89 c2                	mov    %eax,%edx
80100926:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100929:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100930:	0f 84 4e ff ff ff    	je     80100884 <consoleintr+0x34>
  if(panicked){
80100936:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
        input.e--;
8010093c:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
80100941:	85 d2                	test   %edx,%edx
80100943:	74 0b                	je     80100950 <consoleintr+0x100>
80100945:	fa                   	cli    
    for(;;)
80100946:	eb fe                	jmp    80100946 <consoleintr+0xf6>
80100948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010094f:	90                   	nop
80100950:	b8 00 01 00 00       	mov    $0x100,%eax
80100955:	e8 a6 fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
8010095a:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010095f:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100965:	75 ba                	jne    80100921 <consoleintr+0xd1>
80100967:	e9 18 ff ff ff       	jmp    80100884 <consoleintr+0x34>
8010096c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(input.e != input.w){
80100970:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100975:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010097b:	0f 84 03 ff ff ff    	je     80100884 <consoleintr+0x34>
        input.e--;
80100981:	83 e8 01             	sub    $0x1,%eax
80100984:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
80100989:	a1 58 a5 10 80       	mov    0x8010a558,%eax
8010098e:	85 c0                	test   %eax,%eax
80100990:	74 16                	je     801009a8 <consoleintr+0x158>
80100992:	fa                   	cli    
    for(;;)
80100993:	eb fe                	jmp    80100993 <consoleintr+0x143>
80100995:	8d 76 00             	lea    0x0(%esi),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100998:	85 db                	test   %ebx,%ebx
8010099a:	0f 84 e4 fe ff ff    	je     80100884 <consoleintr+0x34>
801009a0:	e9 fb fe ff ff       	jmp    801008a0 <consoleintr+0x50>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
801009b2:	e9 cd fe ff ff       	jmp    80100884 <consoleintr+0x34>
  release(&cons.lock);
801009b7:	83 ec 0c             	sub    $0xc,%esp
801009ba:	68 20 a5 10 80       	push   $0x8010a520
801009bf:	e8 9c 3c 00 00       	call   80104660 <release>
  if(doprocdump) {
801009c4:	83 c4 10             	add    $0x10,%esp
801009c7:	85 f6                	test   %esi,%esi
801009c9:	75 1d                	jne    801009e8 <consoleintr+0x198>
}
801009cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009ce:	5b                   	pop    %ebx
801009cf:	5e                   	pop    %esi
801009d0:	5f                   	pop    %edi
801009d1:	5d                   	pop    %ebp
801009d2:	c3                   	ret    
        input.buf[input.e++ % INPUT_BUF] = c;
801009d3:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
  if(panicked){
801009da:	85 d2                	test   %edx,%edx
801009dc:	74 16                	je     801009f4 <consoleintr+0x1a4>
801009de:	fa                   	cli    
    for(;;)
801009df:	eb fe                	jmp    801009df <consoleintr+0x18f>
801009e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801009e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009eb:	5b                   	pop    %ebx
801009ec:	5e                   	pop    %esi
801009ed:	5f                   	pop    %edi
801009ee:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
801009ef:	e9 dc 36 00 00       	jmp    801040d0 <procdump>
801009f4:	b8 0a 00 00 00       	mov    $0xa,%eax
801009f9:	e8 02 fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009fe:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
          wakeup(&input.r);
80100a03:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a06:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100a0b:	68 a0 ff 10 80       	push   $0x8010ffa0
80100a10:	e8 db 35 00 00       	call   80103ff0 <wakeup>
80100a15:	83 c4 10             	add    $0x10,%esp
80100a18:	e9 67 fe ff ff       	jmp    80100884 <consoleintr+0x34>
80100a1d:	8d 76 00             	lea    0x0(%esi),%esi

80100a20 <consoleinit>:

void
consoleinit(void)
{
80100a20:	55                   	push   %ebp
80100a21:	89 e5                	mov    %esp,%ebp
80100a23:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a26:	68 88 71 10 80       	push   $0x80107188
80100a2b:	68 20 a5 10 80       	push   $0x8010a520
80100a30:	e8 0b 3a 00 00       	call   80104440 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a35:	58                   	pop    %eax
80100a36:	5a                   	pop    %edx
80100a37:	6a 00                	push   $0x0
80100a39:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a3b:	c7 05 6c 09 11 80 30 	movl   $0x80100630,0x8011096c
80100a42:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a45:	c7 05 68 09 11 80 80 	movl   $0x80100280,0x80110968
80100a4c:	02 10 80 
  cons.locking = 1;
80100a4f:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100a56:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a59:	e8 42 19 00 00       	call   801023a0 <ioapicenable>
}
80100a5e:	83 c4 10             	add    $0x10,%esp
80100a61:	c9                   	leave  
80100a62:	c3                   	ret    
80100a63:	66 90                	xchg   %ax,%ax
80100a65:	66 90                	xchg   %ax,%ax
80100a67:	66 90                	xchg   %ax,%ax
80100a69:	66 90                	xchg   %ax,%ax
80100a6b:	66 90                	xchg   %ax,%ax
80100a6d:	66 90                	xchg   %ax,%ax
80100a6f:	90                   	nop

80100a70 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a70:	55                   	push   %ebp
80100a71:	89 e5                	mov    %esp,%ebp
80100a73:	57                   	push   %edi
80100a74:	56                   	push   %esi
80100a75:	53                   	push   %ebx
80100a76:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a7c:	e8 ff 2d 00 00       	call   80103880 <myproc>
80100a81:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100a87:	e8 f4 21 00 00       	call   80102c80 <begin_op>

  if((ip = namei(path)) == 0){
80100a8c:	83 ec 0c             	sub    $0xc,%esp
80100a8f:	ff 75 08             	pushl  0x8(%ebp)
80100a92:	e8 29 15 00 00       	call   80101fc0 <namei>
80100a97:	83 c4 10             	add    $0x10,%esp
80100a9a:	85 c0                	test   %eax,%eax
80100a9c:	0f 84 09 03 00 00    	je     80100dab <exec+0x33b>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100aa2:	83 ec 0c             	sub    $0xc,%esp
80100aa5:	89 c3                	mov    %eax,%ebx
80100aa7:	50                   	push   %eax
80100aa8:	e8 73 0c 00 00       	call   80101720 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aad:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100ab3:	6a 34                	push   $0x34
80100ab5:	6a 00                	push   $0x0
80100ab7:	50                   	push   %eax
80100ab8:	53                   	push   %ebx
80100ab9:	e8 42 0f 00 00       	call   80101a00 <readi>
80100abe:	83 c4 20             	add    $0x20,%esp
80100ac1:	83 f8 34             	cmp    $0x34,%eax
80100ac4:	74 22                	je     80100ae8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ac6:	83 ec 0c             	sub    $0xc,%esp
80100ac9:	53                   	push   %ebx
80100aca:	e8 e1 0e 00 00       	call   801019b0 <iunlockput>
    end_op();
80100acf:	e8 1c 22 00 00       	call   80102cf0 <end_op>
80100ad4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100ad7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100adc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100adf:	5b                   	pop    %ebx
80100ae0:	5e                   	pop    %esi
80100ae1:	5f                   	pop    %edi
80100ae2:	5d                   	pop    %ebp
80100ae3:	c3                   	ret    
80100ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100ae8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100aef:	45 4c 46 
80100af2:	75 d2                	jne    80100ac6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100af4:	e8 97 63 00 00       	call   80106e90 <setupkvm>
80100af9:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100aff:	85 c0                	test   %eax,%eax
80100b01:	74 c3                	je     80100ac6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b03:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b0a:	00 
80100b0b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b11:	0f 84 b3 02 00 00    	je     80100dca <exec+0x35a>
  sz = 0;
80100b17:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b1e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b21:	31 ff                	xor    %edi,%edi
80100b23:	e9 8e 00 00 00       	jmp    80100bb6 <exec+0x146>
80100b28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b2f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100b30:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b37:	75 6c                	jne    80100ba5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b39:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b3f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b45:	0f 82 87 00 00 00    	jb     80100bd2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b4b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b51:	72 7f                	jb     80100bd2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b53:	83 ec 04             	sub    $0x4,%esp
80100b56:	50                   	push   %eax
80100b57:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b5d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b63:	e8 48 61 00 00       	call   80106cb0 <allocuvm>
80100b68:	83 c4 10             	add    $0x10,%esp
80100b6b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b71:	85 c0                	test   %eax,%eax
80100b73:	74 5d                	je     80100bd2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100b75:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b7b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b80:	75 50                	jne    80100bd2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b82:	83 ec 0c             	sub    $0xc,%esp
80100b85:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b8b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b91:	53                   	push   %ebx
80100b92:	50                   	push   %eax
80100b93:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b99:	e8 52 60 00 00       	call   80106bf0 <loaduvm>
80100b9e:	83 c4 20             	add    $0x20,%esp
80100ba1:	85 c0                	test   %eax,%eax
80100ba3:	78 2d                	js     80100bd2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ba5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bac:	83 c7 01             	add    $0x1,%edi
80100baf:	83 c6 20             	add    $0x20,%esi
80100bb2:	39 f8                	cmp    %edi,%eax
80100bb4:	7e 3a                	jle    80100bf0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bb6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bbc:	6a 20                	push   $0x20
80100bbe:	56                   	push   %esi
80100bbf:	50                   	push   %eax
80100bc0:	53                   	push   %ebx
80100bc1:	e8 3a 0e 00 00       	call   80101a00 <readi>
80100bc6:	83 c4 10             	add    $0x10,%esp
80100bc9:	83 f8 20             	cmp    $0x20,%eax
80100bcc:	0f 84 5e ff ff ff    	je     80100b30 <exec+0xc0>
    freevm(pgdir);
80100bd2:	83 ec 0c             	sub    $0xc,%esp
80100bd5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bdb:	e8 30 62 00 00       	call   80106e10 <freevm>
  if(ip){
80100be0:	83 c4 10             	add    $0x10,%esp
80100be3:	e9 de fe ff ff       	jmp    80100ac6 <exec+0x56>
80100be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100bef:	90                   	nop
80100bf0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100bf6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100bfc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c02:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c08:	83 ec 0c             	sub    $0xc,%esp
80100c0b:	53                   	push   %ebx
80100c0c:	e8 9f 0d 00 00       	call   801019b0 <iunlockput>
  end_op();
80100c11:	e8 da 20 00 00       	call   80102cf0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c16:	83 c4 0c             	add    $0xc,%esp
80100c19:	56                   	push   %esi
80100c1a:	57                   	push   %edi
80100c1b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c21:	57                   	push   %edi
80100c22:	e8 89 60 00 00       	call   80106cb0 <allocuvm>
80100c27:	83 c4 10             	add    $0x10,%esp
80100c2a:	89 c6                	mov    %eax,%esi
80100c2c:	85 c0                	test   %eax,%eax
80100c2e:	0f 84 94 00 00 00    	je     80100cc8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c34:	83 ec 08             	sub    $0x8,%esp
80100c37:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c3d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c3f:	50                   	push   %eax
80100c40:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c41:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c43:	e8 e8 62 00 00       	call   80106f30 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c48:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4b:	83 c4 10             	add    $0x10,%esp
80100c4e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c54:	8b 00                	mov    (%eax),%eax
80100c56:	85 c0                	test   %eax,%eax
80100c58:	0f 84 8b 00 00 00    	je     80100ce9 <exec+0x279>
80100c5e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c64:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c6a:	eb 23                	jmp    80100c8f <exec+0x21f>
80100c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c70:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c73:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c7a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c83:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c86:	85 c0                	test   %eax,%eax
80100c88:	74 59                	je     80100ce3 <exec+0x273>
    if(argc >= MAXARG)
80100c8a:	83 ff 20             	cmp    $0x20,%edi
80100c8d:	74 39                	je     80100cc8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c8f:	83 ec 0c             	sub    $0xc,%esp
80100c92:	50                   	push   %eax
80100c93:	e8 18 3c 00 00       	call   801048b0 <strlen>
80100c98:	f7 d0                	not    %eax
80100c9a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c9c:	58                   	pop    %eax
80100c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ca0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ca3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100ca6:	e8 05 3c 00 00       	call   801048b0 <strlen>
80100cab:	83 c0 01             	add    $0x1,%eax
80100cae:	50                   	push   %eax
80100caf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cb2:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cb5:	53                   	push   %ebx
80100cb6:	56                   	push   %esi
80100cb7:	e8 c4 63 00 00       	call   80107080 <copyout>
80100cbc:	83 c4 20             	add    $0x20,%esp
80100cbf:	85 c0                	test   %eax,%eax
80100cc1:	79 ad                	jns    80100c70 <exec+0x200>
80100cc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cc7:	90                   	nop
    freevm(pgdir);
80100cc8:	83 ec 0c             	sub    $0xc,%esp
80100ccb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cd1:	e8 3a 61 00 00       	call   80106e10 <freevm>
80100cd6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100cd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cde:	e9 f9 fd ff ff       	jmp    80100adc <exec+0x6c>
80100ce3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ce9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100cf0:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100cf2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100cf9:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cfd:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cff:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d02:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d08:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d0a:	50                   	push   %eax
80100d0b:	52                   	push   %edx
80100d0c:	53                   	push   %ebx
80100d0d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d13:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d1a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d1d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d23:	e8 58 63 00 00       	call   80107080 <copyout>
80100d28:	83 c4 10             	add    $0x10,%esp
80100d2b:	85 c0                	test   %eax,%eax
80100d2d:	78 99                	js     80100cc8 <exec+0x258>
  for(last=s=path; *s; s++)
80100d2f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d32:	8b 55 08             	mov    0x8(%ebp),%edx
80100d35:	0f b6 00             	movzbl (%eax),%eax
80100d38:	84 c0                	test   %al,%al
80100d3a:	74 13                	je     80100d4f <exec+0x2df>
80100d3c:	89 d1                	mov    %edx,%ecx
80100d3e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80100d40:	83 c1 01             	add    $0x1,%ecx
80100d43:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d45:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80100d48:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d4b:	84 c0                	test   %al,%al
80100d4d:	75 f1                	jne    80100d40 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d4f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d55:	83 ec 04             	sub    $0x4,%esp
80100d58:	6a 10                	push   $0x10
80100d5a:	89 f8                	mov    %edi,%eax
80100d5c:	52                   	push   %edx
80100d5d:	83 c0 6c             	add    $0x6c,%eax
80100d60:	50                   	push   %eax
80100d61:	e8 0a 3b 00 00       	call   80104870 <safestrcpy>
  curproc->pgdir = pgdir;
80100d66:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d6c:	89 f8                	mov    %edi,%eax
80100d6e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100d71:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100d73:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100d76:	89 c1                	mov    %eax,%ecx
80100d78:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d7e:	8b 40 18             	mov    0x18(%eax),%eax
80100d81:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d84:	8b 41 18             	mov    0x18(%ecx),%eax
80100d87:	89 58 44             	mov    %ebx,0x44(%eax)
  curproc->priority = 2;	 // Added statement at line 102
80100d8a:	c7 41 7c 02 00 00 00 	movl   $0x2,0x7c(%ecx)
  switchuvm(curproc);
80100d91:	89 0c 24             	mov    %ecx,(%esp)
80100d94:	e8 c7 5c 00 00       	call   80106a60 <switchuvm>
  freevm(oldpgdir);
80100d99:	89 3c 24             	mov    %edi,(%esp)
80100d9c:	e8 6f 60 00 00       	call   80106e10 <freevm>
  return 0;
80100da1:	83 c4 10             	add    $0x10,%esp
80100da4:	31 c0                	xor    %eax,%eax
80100da6:	e9 31 fd ff ff       	jmp    80100adc <exec+0x6c>
    end_op();
80100dab:	e8 40 1f 00 00       	call   80102cf0 <end_op>
    cprintf("exec: fail\n");
80100db0:	83 ec 0c             	sub    $0xc,%esp
80100db3:	68 a1 71 10 80       	push   $0x801071a1
80100db8:	e8 e3 f8 ff ff       	call   801006a0 <cprintf>
    return -1;
80100dbd:	83 c4 10             	add    $0x10,%esp
80100dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dc5:	e9 12 fd ff ff       	jmp    80100adc <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dca:	31 ff                	xor    %edi,%edi
80100dcc:	be 00 20 00 00       	mov    $0x2000,%esi
80100dd1:	e9 32 fe ff ff       	jmp    80100c08 <exec+0x198>
80100dd6:	66 90                	xchg   %ax,%ax
80100dd8:	66 90                	xchg   %ax,%ax
80100dda:	66 90                	xchg   %ax,%ax
80100ddc:	66 90                	xchg   %ax,%ax
80100dde:	66 90                	xchg   %ax,%ax

80100de0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100de6:	68 ad 71 10 80       	push   $0x801071ad
80100deb:	68 c0 ff 10 80       	push   $0x8010ffc0
80100df0:	e8 4b 36 00 00       	call   80104440 <initlock>
}
80100df5:	83 c4 10             	add    $0x10,%esp
80100df8:	c9                   	leave  
80100df9:	c3                   	ret    
80100dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e00 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e04:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100e09:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e0c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e11:	e8 2a 37 00 00       	call   80104540 <acquire>
80100e16:	83 c4 10             	add    $0x10,%esp
80100e19:	eb 10                	jmp    80100e2b <filealloc+0x2b>
80100e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e1f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e20:	83 c3 18             	add    $0x18,%ebx
80100e23:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e29:	74 25                	je     80100e50 <filealloc+0x50>
    if(f->ref == 0){
80100e2b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e2e:	85 c0                	test   %eax,%eax
80100e30:	75 ee                	jne    80100e20 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e32:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e35:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e3c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e41:	e8 1a 38 00 00       	call   80104660 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e46:	89 d8                	mov    %ebx,%eax
      return f;
80100e48:	83 c4 10             	add    $0x10,%esp
}
80100e4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e4e:	c9                   	leave  
80100e4f:	c3                   	ret    
  release(&ftable.lock);
80100e50:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e53:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e55:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e5a:	e8 01 38 00 00       	call   80104660 <release>
}
80100e5f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e61:	83 c4 10             	add    $0x10,%esp
}
80100e64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e67:	c9                   	leave  
80100e68:	c3                   	ret    
80100e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e70 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e70:	55                   	push   %ebp
80100e71:	89 e5                	mov    %esp,%ebp
80100e73:	53                   	push   %ebx
80100e74:	83 ec 10             	sub    $0x10,%esp
80100e77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e7a:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e7f:	e8 bc 36 00 00       	call   80104540 <acquire>
  if(f->ref < 1)
80100e84:	8b 43 04             	mov    0x4(%ebx),%eax
80100e87:	83 c4 10             	add    $0x10,%esp
80100e8a:	85 c0                	test   %eax,%eax
80100e8c:	7e 1a                	jle    80100ea8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e8e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e91:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e94:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e97:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e9c:	e8 bf 37 00 00       	call   80104660 <release>
  return f;
}
80100ea1:	89 d8                	mov    %ebx,%eax
80100ea3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea6:	c9                   	leave  
80100ea7:	c3                   	ret    
    panic("filedup");
80100ea8:	83 ec 0c             	sub    $0xc,%esp
80100eab:	68 b4 71 10 80       	push   $0x801071b4
80100eb0:	e8 cb f4 ff ff       	call   80100380 <panic>
80100eb5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ec0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	57                   	push   %edi
80100ec4:	56                   	push   %esi
80100ec5:	53                   	push   %ebx
80100ec6:	83 ec 28             	sub    $0x28,%esp
80100ec9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100ecc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ed1:	e8 6a 36 00 00       	call   80104540 <acquire>
  if(f->ref < 1)
80100ed6:	8b 53 04             	mov    0x4(%ebx),%edx
80100ed9:	83 c4 10             	add    $0x10,%esp
80100edc:	85 d2                	test   %edx,%edx
80100ede:	0f 8e a5 00 00 00    	jle    80100f89 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100ee4:	83 ea 01             	sub    $0x1,%edx
80100ee7:	89 53 04             	mov    %edx,0x4(%ebx)
80100eea:	75 44                	jne    80100f30 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100eec:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ef0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ef3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100ef5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100efb:	8b 73 0c             	mov    0xc(%ebx),%esi
80100efe:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f01:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f04:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100f09:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f0c:	e8 4f 37 00 00       	call   80104660 <release>

  if(ff.type == FD_PIPE)
80100f11:	83 c4 10             	add    $0x10,%esp
80100f14:	83 ff 01             	cmp    $0x1,%edi
80100f17:	74 57                	je     80100f70 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f19:	83 ff 02             	cmp    $0x2,%edi
80100f1c:	74 2a                	je     80100f48 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f21:	5b                   	pop    %ebx
80100f22:	5e                   	pop    %esi
80100f23:	5f                   	pop    %edi
80100f24:	5d                   	pop    %ebp
80100f25:	c3                   	ret    
80100f26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f2d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f30:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
}
80100f37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f3a:	5b                   	pop    %ebx
80100f3b:	5e                   	pop    %esi
80100f3c:	5f                   	pop    %edi
80100f3d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f3e:	e9 1d 37 00 00       	jmp    80104660 <release>
80100f43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f47:	90                   	nop
    begin_op();
80100f48:	e8 33 1d 00 00       	call   80102c80 <begin_op>
    iput(ff.ip);
80100f4d:	83 ec 0c             	sub    $0xc,%esp
80100f50:	ff 75 e0             	pushl  -0x20(%ebp)
80100f53:	e8 f8 08 00 00       	call   80101850 <iput>
    end_op();
80100f58:	83 c4 10             	add    $0x10,%esp
}
80100f5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f5e:	5b                   	pop    %ebx
80100f5f:	5e                   	pop    %esi
80100f60:	5f                   	pop    %edi
80100f61:	5d                   	pop    %ebp
    end_op();
80100f62:	e9 89 1d 00 00       	jmp    80102cf0 <end_op>
80100f67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f6e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100f70:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f74:	83 ec 08             	sub    $0x8,%esp
80100f77:	53                   	push   %ebx
80100f78:	56                   	push   %esi
80100f79:	e8 a2 24 00 00       	call   80103420 <pipeclose>
80100f7e:	83 c4 10             	add    $0x10,%esp
}
80100f81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f84:	5b                   	pop    %ebx
80100f85:	5e                   	pop    %esi
80100f86:	5f                   	pop    %edi
80100f87:	5d                   	pop    %ebp
80100f88:	c3                   	ret    
    panic("fileclose");
80100f89:	83 ec 0c             	sub    $0xc,%esp
80100f8c:	68 bc 71 10 80       	push   $0x801071bc
80100f91:	e8 ea f3 ff ff       	call   80100380 <panic>
80100f96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f9d:	8d 76 00             	lea    0x0(%esi),%esi

80100fa0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	53                   	push   %ebx
80100fa4:	83 ec 04             	sub    $0x4,%esp
80100fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100faa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fad:	75 31                	jne    80100fe0 <filestat+0x40>
    ilock(f->ip);
80100faf:	83 ec 0c             	sub    $0xc,%esp
80100fb2:	ff 73 10             	pushl  0x10(%ebx)
80100fb5:	e8 66 07 00 00       	call   80101720 <ilock>
    stati(f->ip, st);
80100fba:	58                   	pop    %eax
80100fbb:	5a                   	pop    %edx
80100fbc:	ff 75 0c             	pushl  0xc(%ebp)
80100fbf:	ff 73 10             	pushl  0x10(%ebx)
80100fc2:	e8 09 0a 00 00       	call   801019d0 <stati>
    iunlock(f->ip);
80100fc7:	59                   	pop    %ecx
80100fc8:	ff 73 10             	pushl  0x10(%ebx)
80100fcb:	e8 30 08 00 00       	call   80101800 <iunlock>
    return 0;
  }
  return -1;
}
80100fd0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80100fd3:	83 c4 10             	add    $0x10,%esp
80100fd6:	31 c0                	xor    %eax,%eax
}
80100fd8:	c9                   	leave  
80100fd9:	c3                   	ret    
80100fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fe0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80100fe3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fe8:	c9                   	leave  
80100fe9:	c3                   	ret    
80100fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ff0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 0c             	sub    $0xc,%esp
80100ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100ffc:	8b 75 0c             	mov    0xc(%ebp),%esi
80100fff:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101002:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101006:	74 60                	je     80101068 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101008:	8b 03                	mov    (%ebx),%eax
8010100a:	83 f8 01             	cmp    $0x1,%eax
8010100d:	74 41                	je     80101050 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100f:	83 f8 02             	cmp    $0x2,%eax
80101012:	75 5b                	jne    8010106f <fileread+0x7f>
    ilock(f->ip);
80101014:	83 ec 0c             	sub    $0xc,%esp
80101017:	ff 73 10             	pushl  0x10(%ebx)
8010101a:	e8 01 07 00 00       	call   80101720 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010101f:	57                   	push   %edi
80101020:	ff 73 14             	pushl  0x14(%ebx)
80101023:	56                   	push   %esi
80101024:	ff 73 10             	pushl  0x10(%ebx)
80101027:	e8 d4 09 00 00       	call   80101a00 <readi>
8010102c:	83 c4 20             	add    $0x20,%esp
8010102f:	89 c6                	mov    %eax,%esi
80101031:	85 c0                	test   %eax,%eax
80101033:	7e 03                	jle    80101038 <fileread+0x48>
      f->off += r;
80101035:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101038:	83 ec 0c             	sub    $0xc,%esp
8010103b:	ff 73 10             	pushl  0x10(%ebx)
8010103e:	e8 bd 07 00 00       	call   80101800 <iunlock>
    return r;
80101043:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101046:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101049:	89 f0                	mov    %esi,%eax
8010104b:	5b                   	pop    %ebx
8010104c:	5e                   	pop    %esi
8010104d:	5f                   	pop    %edi
8010104e:	5d                   	pop    %ebp
8010104f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101050:	8b 43 0c             	mov    0xc(%ebx),%eax
80101053:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101056:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101059:	5b                   	pop    %ebx
8010105a:	5e                   	pop    %esi
8010105b:	5f                   	pop    %edi
8010105c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010105d:	e9 5e 25 00 00       	jmp    801035c0 <piperead>
80101062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101068:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010106d:	eb d7                	jmp    80101046 <fileread+0x56>
  panic("fileread");
8010106f:	83 ec 0c             	sub    $0xc,%esp
80101072:	68 c6 71 10 80       	push   $0x801071c6
80101077:	e8 04 f3 ff ff       	call   80100380 <panic>
8010107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101080 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101080:	55                   	push   %ebp
80101081:	89 e5                	mov    %esp,%ebp
80101083:	57                   	push   %edi
80101084:	56                   	push   %esi
80101085:	53                   	push   %ebx
80101086:	83 ec 1c             	sub    $0x1c,%esp
80101089:	8b 45 0c             	mov    0xc(%ebp),%eax
8010108c:	8b 75 08             	mov    0x8(%ebp),%esi
8010108f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101092:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101095:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101099:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010109c:	0f 84 bd 00 00 00    	je     8010115f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
801010a2:	8b 06                	mov    (%esi),%eax
801010a4:	83 f8 01             	cmp    $0x1,%eax
801010a7:	0f 84 bf 00 00 00    	je     8010116c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010ad:	83 f8 02             	cmp    $0x2,%eax
801010b0:	0f 85 c8 00 00 00    	jne    8010117e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010b9:	31 ff                	xor    %edi,%edi
    while(i < n){
801010bb:	85 c0                	test   %eax,%eax
801010bd:	7f 30                	jg     801010ef <filewrite+0x6f>
801010bf:	e9 94 00 00 00       	jmp    80101158 <filewrite+0xd8>
801010c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010c8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801010cb:	83 ec 0c             	sub    $0xc,%esp
801010ce:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801010d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801010d4:	e8 27 07 00 00       	call   80101800 <iunlock>
      end_op();
801010d9:	e8 12 1c 00 00       	call   80102cf0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801010de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010e1:	83 c4 10             	add    $0x10,%esp
801010e4:	39 c3                	cmp    %eax,%ebx
801010e6:	75 60                	jne    80101148 <filewrite+0xc8>
        panic("short filewrite");
      i += r;
801010e8:	01 df                	add    %ebx,%edi
    while(i < n){
801010ea:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010ed:	7e 69                	jle    80101158 <filewrite+0xd8>
      int n1 = n - i;
801010ef:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010f2:	b8 00 06 00 00       	mov    $0x600,%eax
801010f7:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
801010f9:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010ff:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101102:	e8 79 1b 00 00       	call   80102c80 <begin_op>
      ilock(f->ip);
80101107:	83 ec 0c             	sub    $0xc,%esp
8010110a:	ff 76 10             	pushl  0x10(%esi)
8010110d:	e8 0e 06 00 00       	call   80101720 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101112:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101115:	53                   	push   %ebx
80101116:	ff 76 14             	pushl  0x14(%esi)
80101119:	01 f8                	add    %edi,%eax
8010111b:	50                   	push   %eax
8010111c:	ff 76 10             	pushl  0x10(%esi)
8010111f:	e8 dc 09 00 00       	call   80101b00 <writei>
80101124:	83 c4 20             	add    $0x20,%esp
80101127:	85 c0                	test   %eax,%eax
80101129:	7f 9d                	jg     801010c8 <filewrite+0x48>
      iunlock(f->ip);
8010112b:	83 ec 0c             	sub    $0xc,%esp
8010112e:	ff 76 10             	pushl  0x10(%esi)
80101131:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101134:	e8 c7 06 00 00       	call   80101800 <iunlock>
      end_op();
80101139:	e8 b2 1b 00 00       	call   80102cf0 <end_op>
      if(r < 0)
8010113e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101141:	83 c4 10             	add    $0x10,%esp
80101144:	85 c0                	test   %eax,%eax
80101146:	75 17                	jne    8010115f <filewrite+0xdf>
        panic("short filewrite");
80101148:	83 ec 0c             	sub    $0xc,%esp
8010114b:	68 cf 71 10 80       	push   $0x801071cf
80101150:	e8 2b f2 ff ff       	call   80100380 <panic>
80101155:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101158:	89 f8                	mov    %edi,%eax
8010115a:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
8010115d:	74 05                	je     80101164 <filewrite+0xe4>
8010115f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101164:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101167:	5b                   	pop    %ebx
80101168:	5e                   	pop    %esi
80101169:	5f                   	pop    %edi
8010116a:	5d                   	pop    %ebp
8010116b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010116c:	8b 46 0c             	mov    0xc(%esi),%eax
8010116f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101172:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101175:	5b                   	pop    %ebx
80101176:	5e                   	pop    %esi
80101177:	5f                   	pop    %edi
80101178:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101179:	e9 42 23 00 00       	jmp    801034c0 <pipewrite>
  panic("filewrite");
8010117e:	83 ec 0c             	sub    $0xc,%esp
80101181:	68 d5 71 10 80       	push   $0x801071d5
80101186:	e8 f5 f1 ff ff       	call   80100380 <panic>
8010118b:	66 90                	xchg   %ax,%ax
8010118d:	66 90                	xchg   %ax,%ax
8010118f:	90                   	nop

80101190 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101190:	55                   	push   %ebp
80101191:	89 e5                	mov    %esp,%ebp
80101193:	57                   	push   %edi
80101194:	56                   	push   %esi
80101195:	53                   	push   %ebx
80101196:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101199:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
8010119f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011a2:	85 c9                	test   %ecx,%ecx
801011a4:	0f 84 87 00 00 00    	je     80101231 <balloc+0xa1>
801011aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011b1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011b4:	83 ec 08             	sub    $0x8,%esp
801011b7:	89 f0                	mov    %esi,%eax
801011b9:	c1 f8 0c             	sar    $0xc,%eax
801011bc:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011c2:	50                   	push   %eax
801011c3:	ff 75 d8             	pushl  -0x28(%ebp)
801011c6:	e8 05 ef ff ff       	call   801000d0 <bread>
801011cb:	83 c4 10             	add    $0x10,%esp
801011ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011d1:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011d9:	31 c0                	xor    %eax,%eax
801011db:	eb 2f                	jmp    8010120c <balloc+0x7c>
801011dd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011e0:	89 c1                	mov    %eax,%ecx
801011e2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011ea:	83 e1 07             	and    $0x7,%ecx
801011ed:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011ef:	89 c1                	mov    %eax,%ecx
801011f1:	c1 f9 03             	sar    $0x3,%ecx
801011f4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011f9:	89 fa                	mov    %edi,%edx
801011fb:	85 df                	test   %ebx,%edi
801011fd:	74 41                	je     80101240 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ff:	83 c0 01             	add    $0x1,%eax
80101202:	83 c6 01             	add    $0x1,%esi
80101205:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010120a:	74 05                	je     80101211 <balloc+0x81>
8010120c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010120f:	77 cf                	ja     801011e0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101211:	83 ec 0c             	sub    $0xc,%esp
80101214:	ff 75 e4             	pushl  -0x1c(%ebp)
80101217:	e8 d4 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010121c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101223:	83 c4 10             	add    $0x10,%esp
80101226:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101229:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010122f:	77 80                	ja     801011b1 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101231:	83 ec 0c             	sub    $0xc,%esp
80101234:	68 df 71 10 80       	push   $0x801071df
80101239:	e8 42 f1 ff ff       	call   80100380 <panic>
8010123e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101240:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101243:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101246:	09 da                	or     %ebx,%edx
80101248:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010124c:	57                   	push   %edi
8010124d:	e8 0e 1c 00 00       	call   80102e60 <log_write>
        brelse(bp);
80101252:	89 3c 24             	mov    %edi,(%esp)
80101255:	e8 96 ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010125a:	58                   	pop    %eax
8010125b:	5a                   	pop    %edx
8010125c:	56                   	push   %esi
8010125d:	ff 75 d8             	pushl  -0x28(%ebp)
80101260:	e8 6b ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101265:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101268:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010126a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010126d:	68 00 02 00 00       	push   $0x200
80101272:	6a 00                	push   $0x0
80101274:	50                   	push   %eax
80101275:	e8 36 34 00 00       	call   801046b0 <memset>
  log_write(bp);
8010127a:	89 1c 24             	mov    %ebx,(%esp)
8010127d:	e8 de 1b 00 00       	call   80102e60 <log_write>
  brelse(bp);
80101282:	89 1c 24             	mov    %ebx,(%esp)
80101285:	e8 66 ef ff ff       	call   801001f0 <brelse>
}
8010128a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010128d:	89 f0                	mov    %esi,%eax
8010128f:	5b                   	pop    %ebx
80101290:	5e                   	pop    %esi
80101291:	5f                   	pop    %edi
80101292:	5d                   	pop    %ebp
80101293:	c3                   	ret    
80101294:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010129b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010129f:	90                   	nop

801012a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012a0:	55                   	push   %ebp
801012a1:	89 e5                	mov    %esp,%ebp
801012a3:	57                   	push   %edi
801012a4:	89 c7                	mov    %eax,%edi
801012a6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012a7:	31 f6                	xor    %esi,%esi
{
801012a9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012aa:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
801012af:	83 ec 28             	sub    $0x28,%esp
801012b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012b5:	68 e0 09 11 80       	push   $0x801109e0
801012ba:	e8 81 32 00 00       	call   80104540 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012bf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801012c2:	83 c4 10             	add    $0x10,%esp
801012c5:	eb 1b                	jmp    801012e2 <iget+0x42>
801012c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012ce:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012d0:	39 3b                	cmp    %edi,(%ebx)
801012d2:	74 6c                	je     80101340 <iget+0xa0>
801012d4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012da:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012e0:	73 26                	jae    80101308 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012e2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012e5:	85 c9                	test   %ecx,%ecx
801012e7:	7f e7                	jg     801012d0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012e9:	85 f6                	test   %esi,%esi
801012eb:	75 e7                	jne    801012d4 <iget+0x34>
801012ed:	89 d8                	mov    %ebx,%eax
801012ef:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012f5:	85 c9                	test   %ecx,%ecx
801012f7:	75 6e                	jne    80101367 <iget+0xc7>
801012f9:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012fb:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101301:	72 df                	jb     801012e2 <iget+0x42>
80101303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101307:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101308:	85 f6                	test   %esi,%esi
8010130a:	74 73                	je     8010137f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010130c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010130f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101311:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101314:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010131b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101322:	68 e0 09 11 80       	push   $0x801109e0
80101327:	e8 34 33 00 00       	call   80104660 <release>

  return ip;
8010132c:	83 c4 10             	add    $0x10,%esp
}
8010132f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101332:	89 f0                	mov    %esi,%eax
80101334:	5b                   	pop    %ebx
80101335:	5e                   	pop    %esi
80101336:	5f                   	pop    %edi
80101337:	5d                   	pop    %ebp
80101338:	c3                   	ret    
80101339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101340:	39 53 04             	cmp    %edx,0x4(%ebx)
80101343:	75 8f                	jne    801012d4 <iget+0x34>
      release(&icache.lock);
80101345:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101348:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010134b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010134d:	68 e0 09 11 80       	push   $0x801109e0
      ip->ref++;
80101352:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101355:	e8 06 33 00 00       	call   80104660 <release>
      return ip;
8010135a:	83 c4 10             	add    $0x10,%esp
}
8010135d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101360:	89 f0                	mov    %esi,%eax
80101362:	5b                   	pop    %ebx
80101363:	5e                   	pop    %esi
80101364:	5f                   	pop    %edi
80101365:	5d                   	pop    %ebp
80101366:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101367:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
8010136d:	73 10                	jae    8010137f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010136f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101372:	85 c9                	test   %ecx,%ecx
80101374:	0f 8f 56 ff ff ff    	jg     801012d0 <iget+0x30>
8010137a:	e9 6e ff ff ff       	jmp    801012ed <iget+0x4d>
    panic("iget: no inodes");
8010137f:	83 ec 0c             	sub    $0xc,%esp
80101382:	68 f5 71 10 80       	push   $0x801071f5
80101387:	e8 f4 ef ff ff       	call   80100380 <panic>
8010138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101390 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	57                   	push   %edi
80101394:	56                   	push   %esi
80101395:	89 c6                	mov    %eax,%esi
80101397:	53                   	push   %ebx
80101398:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010139b:	83 fa 0b             	cmp    $0xb,%edx
8010139e:	0f 86 84 00 00 00    	jbe    80101428 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801013a4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801013a7:	83 fb 7f             	cmp    $0x7f,%ebx
801013aa:	0f 87 98 00 00 00    	ja     80101448 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801013b0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801013b6:	8b 16                	mov    (%esi),%edx
801013b8:	85 c0                	test   %eax,%eax
801013ba:	74 54                	je     80101410 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013bc:	83 ec 08             	sub    $0x8,%esp
801013bf:	50                   	push   %eax
801013c0:	52                   	push   %edx
801013c1:	e8 0a ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013c6:	83 c4 10             	add    $0x10,%esp
801013c9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
801013cd:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013cf:	8b 1a                	mov    (%edx),%ebx
801013d1:	85 db                	test   %ebx,%ebx
801013d3:	74 1b                	je     801013f0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013d5:	83 ec 0c             	sub    $0xc,%esp
801013d8:	57                   	push   %edi
801013d9:	e8 12 ee ff ff       	call   801001f0 <brelse>
    return addr;
801013de:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
801013e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e4:	89 d8                	mov    %ebx,%eax
801013e6:	5b                   	pop    %ebx
801013e7:	5e                   	pop    %esi
801013e8:	5f                   	pop    %edi
801013e9:	5d                   	pop    %ebp
801013ea:	c3                   	ret    
801013eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801013ef:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
801013f0:	8b 06                	mov    (%esi),%eax
801013f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013f5:	e8 96 fd ff ff       	call   80101190 <balloc>
801013fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013fd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101400:	89 c3                	mov    %eax,%ebx
80101402:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101404:	57                   	push   %edi
80101405:	e8 56 1a 00 00       	call   80102e60 <log_write>
8010140a:	83 c4 10             	add    $0x10,%esp
8010140d:	eb c6                	jmp    801013d5 <bmap+0x45>
8010140f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101410:	89 d0                	mov    %edx,%eax
80101412:	e8 79 fd ff ff       	call   80101190 <balloc>
80101417:	8b 16                	mov    (%esi),%edx
80101419:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010141f:	eb 9b                	jmp    801013bc <bmap+0x2c>
80101421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101428:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010142b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010142e:	85 db                	test   %ebx,%ebx
80101430:	75 af                	jne    801013e1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101432:	8b 00                	mov    (%eax),%eax
80101434:	e8 57 fd ff ff       	call   80101190 <balloc>
80101439:	89 47 5c             	mov    %eax,0x5c(%edi)
8010143c:	89 c3                	mov    %eax,%ebx
}
8010143e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101441:	89 d8                	mov    %ebx,%eax
80101443:	5b                   	pop    %ebx
80101444:	5e                   	pop    %esi
80101445:	5f                   	pop    %edi
80101446:	5d                   	pop    %ebp
80101447:	c3                   	ret    
  panic("bmap: out of range");
80101448:	83 ec 0c             	sub    $0xc,%esp
8010144b:	68 05 72 10 80       	push   $0x80107205
80101450:	e8 2b ef ff ff       	call   80100380 <panic>
80101455:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010145c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101460 <readsb>:
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	56                   	push   %esi
80101464:	53                   	push   %ebx
80101465:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101468:	83 ec 08             	sub    $0x8,%esp
8010146b:	6a 01                	push   $0x1
8010146d:	ff 75 08             	pushl  0x8(%ebp)
80101470:	e8 5b ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101475:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101478:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010147a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010147d:	6a 1c                	push   $0x1c
8010147f:	50                   	push   %eax
80101480:	56                   	push   %esi
80101481:	e8 ca 32 00 00       	call   80104750 <memmove>
  brelse(bp);
80101486:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101489:	83 c4 10             	add    $0x10,%esp
}
8010148c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010148f:	5b                   	pop    %ebx
80101490:	5e                   	pop    %esi
80101491:	5d                   	pop    %ebp
  brelse(bp);
80101492:	e9 59 ed ff ff       	jmp    801001f0 <brelse>
80101497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010149e:	66 90                	xchg   %ax,%ax

801014a0 <bfree>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	56                   	push   %esi
801014a4:	89 c6                	mov    %eax,%esi
801014a6:	53                   	push   %ebx
801014a7:	89 d3                	mov    %edx,%ebx
  readsb(dev, &sb);
801014a9:	83 ec 08             	sub    $0x8,%esp
801014ac:	68 c0 09 11 80       	push   $0x801109c0
801014b1:	50                   	push   %eax
801014b2:	e8 a9 ff ff ff       	call   80101460 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014b7:	58                   	pop    %eax
801014b8:	89 d8                	mov    %ebx,%eax
801014ba:	5a                   	pop    %edx
801014bb:	c1 e8 0c             	shr    $0xc,%eax
801014be:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801014c4:	50                   	push   %eax
801014c5:	56                   	push   %esi
801014c6:	e8 05 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014cb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014cd:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801014d0:	ba 01 00 00 00       	mov    $0x1,%edx
801014d5:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801014d8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801014de:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801014e1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801014e3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801014e8:	85 d1                	test   %edx,%ecx
801014ea:	74 25                	je     80101511 <bfree+0x71>
  bp->data[bi/8] &= ~m;
801014ec:	f7 d2                	not    %edx
  log_write(bp);
801014ee:	83 ec 0c             	sub    $0xc,%esp
801014f1:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
801014f3:	21 ca                	and    %ecx,%edx
801014f5:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
801014f9:	50                   	push   %eax
801014fa:	e8 61 19 00 00       	call   80102e60 <log_write>
  brelse(bp);
801014ff:	89 34 24             	mov    %esi,(%esp)
80101502:	e8 e9 ec ff ff       	call   801001f0 <brelse>
}
80101507:	83 c4 10             	add    $0x10,%esp
8010150a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010150d:	5b                   	pop    %ebx
8010150e:	5e                   	pop    %esi
8010150f:	5d                   	pop    %ebp
80101510:	c3                   	ret    
    panic("freeing free block");
80101511:	83 ec 0c             	sub    $0xc,%esp
80101514:	68 18 72 10 80       	push   $0x80107218
80101519:	e8 62 ee ff ff       	call   80100380 <panic>
8010151e:	66 90                	xchg   %ax,%ax

80101520 <iinit>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	53                   	push   %ebx
80101524:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101529:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010152c:	68 2b 72 10 80       	push   $0x8010722b
80101531:	68 e0 09 11 80       	push   $0x801109e0
80101536:	e8 05 2f 00 00       	call   80104440 <initlock>
  for(i = 0; i < NINODE; i++) {
8010153b:	83 c4 10             	add    $0x10,%esp
8010153e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101540:	83 ec 08             	sub    $0x8,%esp
80101543:	68 32 72 10 80       	push   $0x80107232
80101548:	53                   	push   %ebx
80101549:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010154f:	e8 dc 2d 00 00       	call   80104330 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101554:	83 c4 10             	add    $0x10,%esp
80101557:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010155d:	75 e1                	jne    80101540 <iinit+0x20>
  readsb(dev, &sb);
8010155f:	83 ec 08             	sub    $0x8,%esp
80101562:	68 c0 09 11 80       	push   $0x801109c0
80101567:	ff 75 08             	pushl  0x8(%ebp)
8010156a:	e8 f1 fe ff ff       	call   80101460 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010156f:	ff 35 d8 09 11 80    	pushl  0x801109d8
80101575:	ff 35 d4 09 11 80    	pushl  0x801109d4
8010157b:	ff 35 d0 09 11 80    	pushl  0x801109d0
80101581:	ff 35 cc 09 11 80    	pushl  0x801109cc
80101587:	ff 35 c8 09 11 80    	pushl  0x801109c8
8010158d:	ff 35 c4 09 11 80    	pushl  0x801109c4
80101593:	ff 35 c0 09 11 80    	pushl  0x801109c0
80101599:	68 98 72 10 80       	push   $0x80107298
8010159e:	e8 fd f0 ff ff       	call   801006a0 <cprintf>
}
801015a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015a6:	83 c4 30             	add    $0x30,%esp
801015a9:	c9                   	leave  
801015aa:	c3                   	ret    
801015ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015af:	90                   	nop

801015b0 <ialloc>:
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	57                   	push   %edi
801015b4:	56                   	push   %esi
801015b5:	53                   	push   %ebx
801015b6:	83 ec 1c             	sub    $0x1c,%esp
801015b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801015bc:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
801015c3:	8b 75 08             	mov    0x8(%ebp),%esi
801015c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015c9:	0f 86 91 00 00 00    	jbe    80101660 <ialloc+0xb0>
801015cf:	bf 01 00 00 00       	mov    $0x1,%edi
801015d4:	eb 21                	jmp    801015f7 <ialloc+0x47>
801015d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015dd:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
801015e0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015e3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801015e6:	53                   	push   %ebx
801015e7:	e8 04 ec ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801015ec:	83 c4 10             	add    $0x10,%esp
801015ef:	3b 3d c8 09 11 80    	cmp    0x801109c8,%edi
801015f5:	73 69                	jae    80101660 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801015f7:	89 f8                	mov    %edi,%eax
801015f9:	83 ec 08             	sub    $0x8,%esp
801015fc:	c1 e8 03             	shr    $0x3,%eax
801015ff:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101605:	50                   	push   %eax
80101606:	56                   	push   %esi
80101607:	e8 c4 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010160c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010160f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101611:	89 f8                	mov    %edi,%eax
80101613:	83 e0 07             	and    $0x7,%eax
80101616:	c1 e0 06             	shl    $0x6,%eax
80101619:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010161d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101621:	75 bd                	jne    801015e0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101623:	83 ec 04             	sub    $0x4,%esp
80101626:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101629:	6a 40                	push   $0x40
8010162b:	6a 00                	push   $0x0
8010162d:	51                   	push   %ecx
8010162e:	e8 7d 30 00 00       	call   801046b0 <memset>
      dip->type = type;
80101633:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101637:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010163a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010163d:	89 1c 24             	mov    %ebx,(%esp)
80101640:	e8 1b 18 00 00       	call   80102e60 <log_write>
      brelse(bp);
80101645:	89 1c 24             	mov    %ebx,(%esp)
80101648:	e8 a3 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010164d:	83 c4 10             	add    $0x10,%esp
}
80101650:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101653:	89 fa                	mov    %edi,%edx
}
80101655:	5b                   	pop    %ebx
      return iget(dev, inum);
80101656:	89 f0                	mov    %esi,%eax
}
80101658:	5e                   	pop    %esi
80101659:	5f                   	pop    %edi
8010165a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010165b:	e9 40 fc ff ff       	jmp    801012a0 <iget>
  panic("ialloc: no inodes");
80101660:	83 ec 0c             	sub    $0xc,%esp
80101663:	68 38 72 10 80       	push   $0x80107238
80101668:	e8 13 ed ff ff       	call   80100380 <panic>
8010166d:	8d 76 00             	lea    0x0(%esi),%esi

80101670 <iupdate>:
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	56                   	push   %esi
80101674:	53                   	push   %ebx
80101675:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101678:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010167b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010167e:	83 ec 08             	sub    $0x8,%esp
80101681:	c1 e8 03             	shr    $0x3,%eax
80101684:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010168a:	50                   	push   %eax
8010168b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010168e:	e8 3d ea ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101693:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101697:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010169a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010169c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010169f:	83 e0 07             	and    $0x7,%eax
801016a2:	c1 e0 06             	shl    $0x6,%eax
801016a5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016a9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016ac:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016b0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016b3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016b7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016bb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016bf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016c3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016c7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016ca:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016cd:	6a 34                	push   $0x34
801016cf:	53                   	push   %ebx
801016d0:	50                   	push   %eax
801016d1:	e8 7a 30 00 00       	call   80104750 <memmove>
  log_write(bp);
801016d6:	89 34 24             	mov    %esi,(%esp)
801016d9:	e8 82 17 00 00       	call   80102e60 <log_write>
  brelse(bp);
801016de:	89 75 08             	mov    %esi,0x8(%ebp)
801016e1:	83 c4 10             	add    $0x10,%esp
}
801016e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016e7:	5b                   	pop    %ebx
801016e8:	5e                   	pop    %esi
801016e9:	5d                   	pop    %ebp
  brelse(bp);
801016ea:	e9 01 eb ff ff       	jmp    801001f0 <brelse>
801016ef:	90                   	nop

801016f0 <idup>:
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	53                   	push   %ebx
801016f4:	83 ec 10             	sub    $0x10,%esp
801016f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016fa:	68 e0 09 11 80       	push   $0x801109e0
801016ff:	e8 3c 2e 00 00       	call   80104540 <acquire>
  ip->ref++;
80101704:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101708:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010170f:	e8 4c 2f 00 00       	call   80104660 <release>
}
80101714:	89 d8                	mov    %ebx,%eax
80101716:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101719:	c9                   	leave  
8010171a:	c3                   	ret    
8010171b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010171f:	90                   	nop

80101720 <ilock>:
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	56                   	push   %esi
80101724:	53                   	push   %ebx
80101725:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101728:	85 db                	test   %ebx,%ebx
8010172a:	0f 84 b7 00 00 00    	je     801017e7 <ilock+0xc7>
80101730:	8b 53 08             	mov    0x8(%ebx),%edx
80101733:	85 d2                	test   %edx,%edx
80101735:	0f 8e ac 00 00 00    	jle    801017e7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010173b:	83 ec 0c             	sub    $0xc,%esp
8010173e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101741:	50                   	push   %eax
80101742:	e8 29 2c 00 00       	call   80104370 <acquiresleep>
  if(ip->valid == 0){
80101747:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010174a:	83 c4 10             	add    $0x10,%esp
8010174d:	85 c0                	test   %eax,%eax
8010174f:	74 0f                	je     80101760 <ilock+0x40>
}
80101751:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101754:	5b                   	pop    %ebx
80101755:	5e                   	pop    %esi
80101756:	5d                   	pop    %ebp
80101757:	c3                   	ret    
80101758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010175f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101760:	8b 43 04             	mov    0x4(%ebx),%eax
80101763:	83 ec 08             	sub    $0x8,%esp
80101766:	c1 e8 03             	shr    $0x3,%eax
80101769:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010176f:	50                   	push   %eax
80101770:	ff 33                	pushl  (%ebx)
80101772:	e8 59 e9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101777:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010177a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010177c:	8b 43 04             	mov    0x4(%ebx),%eax
8010177f:	83 e0 07             	and    $0x7,%eax
80101782:	c1 e0 06             	shl    $0x6,%eax
80101785:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101789:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010178c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010178f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101793:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101797:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010179b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010179f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017a3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017a7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017ab:	8b 50 fc             	mov    -0x4(%eax),%edx
801017ae:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017b1:	6a 34                	push   $0x34
801017b3:	50                   	push   %eax
801017b4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017b7:	50                   	push   %eax
801017b8:	e8 93 2f 00 00       	call   80104750 <memmove>
    brelse(bp);
801017bd:	89 34 24             	mov    %esi,(%esp)
801017c0:	e8 2b ea ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
801017c5:	83 c4 10             	add    $0x10,%esp
801017c8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017cd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017d4:	0f 85 77 ff ff ff    	jne    80101751 <ilock+0x31>
      panic("ilock: no type");
801017da:	83 ec 0c             	sub    $0xc,%esp
801017dd:	68 50 72 10 80       	push   $0x80107250
801017e2:	e8 99 eb ff ff       	call   80100380 <panic>
    panic("ilock");
801017e7:	83 ec 0c             	sub    $0xc,%esp
801017ea:	68 4a 72 10 80       	push   $0x8010724a
801017ef:	e8 8c eb ff ff       	call   80100380 <panic>
801017f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801017ff:	90                   	nop

80101800 <iunlock>:
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	56                   	push   %esi
80101804:	53                   	push   %ebx
80101805:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101808:	85 db                	test   %ebx,%ebx
8010180a:	74 28                	je     80101834 <iunlock+0x34>
8010180c:	83 ec 0c             	sub    $0xc,%esp
8010180f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101812:	56                   	push   %esi
80101813:	e8 f8 2b 00 00       	call   80104410 <holdingsleep>
80101818:	83 c4 10             	add    $0x10,%esp
8010181b:	85 c0                	test   %eax,%eax
8010181d:	74 15                	je     80101834 <iunlock+0x34>
8010181f:	8b 43 08             	mov    0x8(%ebx),%eax
80101822:	85 c0                	test   %eax,%eax
80101824:	7e 0e                	jle    80101834 <iunlock+0x34>
  releasesleep(&ip->lock);
80101826:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101829:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010182c:	5b                   	pop    %ebx
8010182d:	5e                   	pop    %esi
8010182e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010182f:	e9 9c 2b 00 00       	jmp    801043d0 <releasesleep>
    panic("iunlock");
80101834:	83 ec 0c             	sub    $0xc,%esp
80101837:	68 5f 72 10 80       	push   $0x8010725f
8010183c:	e8 3f eb ff ff       	call   80100380 <panic>
80101841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010184f:	90                   	nop

80101850 <iput>:
{
80101850:	55                   	push   %ebp
80101851:	89 e5                	mov    %esp,%ebp
80101853:	57                   	push   %edi
80101854:	56                   	push   %esi
80101855:	53                   	push   %ebx
80101856:	83 ec 28             	sub    $0x28,%esp
80101859:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010185c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010185f:	57                   	push   %edi
80101860:	e8 0b 2b 00 00       	call   80104370 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101865:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101868:	83 c4 10             	add    $0x10,%esp
8010186b:	85 d2                	test   %edx,%edx
8010186d:	74 07                	je     80101876 <iput+0x26>
8010186f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101874:	74 32                	je     801018a8 <iput+0x58>
  releasesleep(&ip->lock);
80101876:	83 ec 0c             	sub    $0xc,%esp
80101879:	57                   	push   %edi
8010187a:	e8 51 2b 00 00       	call   801043d0 <releasesleep>
  acquire(&icache.lock);
8010187f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101886:	e8 b5 2c 00 00       	call   80104540 <acquire>
  ip->ref--;
8010188b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010188f:	83 c4 10             	add    $0x10,%esp
80101892:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101899:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010189c:	5b                   	pop    %ebx
8010189d:	5e                   	pop    %esi
8010189e:	5f                   	pop    %edi
8010189f:	5d                   	pop    %ebp
  release(&icache.lock);
801018a0:	e9 bb 2d 00 00       	jmp    80104660 <release>
801018a5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018a8:	83 ec 0c             	sub    $0xc,%esp
801018ab:	68 e0 09 11 80       	push   $0x801109e0
801018b0:	e8 8b 2c 00 00       	call   80104540 <acquire>
    int r = ip->ref;
801018b5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018b8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018bf:	e8 9c 2d 00 00       	call   80104660 <release>
    if(r == 1){
801018c4:	83 c4 10             	add    $0x10,%esp
801018c7:	83 fe 01             	cmp    $0x1,%esi
801018ca:	75 aa                	jne    80101876 <iput+0x26>
801018cc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801018d2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018d5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018d8:	89 cf                	mov    %ecx,%edi
801018da:	eb 0b                	jmp    801018e7 <iput+0x97>
801018dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018e0:	83 c6 04             	add    $0x4,%esi
801018e3:	39 fe                	cmp    %edi,%esi
801018e5:	74 19                	je     80101900 <iput+0xb0>
    if(ip->addrs[i]){
801018e7:	8b 16                	mov    (%esi),%edx
801018e9:	85 d2                	test   %edx,%edx
801018eb:	74 f3                	je     801018e0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801018ed:	8b 03                	mov    (%ebx),%eax
801018ef:	e8 ac fb ff ff       	call   801014a0 <bfree>
      ip->addrs[i] = 0;
801018f4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018fa:	eb e4                	jmp    801018e0 <iput+0x90>
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101900:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101906:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101909:	85 c0                	test   %eax,%eax
8010190b:	75 33                	jne    80101940 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010190d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101910:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101917:	53                   	push   %ebx
80101918:	e8 53 fd ff ff       	call   80101670 <iupdate>
      ip->type = 0;
8010191d:	31 c0                	xor    %eax,%eax
8010191f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101923:	89 1c 24             	mov    %ebx,(%esp)
80101926:	e8 45 fd ff ff       	call   80101670 <iupdate>
      ip->valid = 0;
8010192b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101932:	83 c4 10             	add    $0x10,%esp
80101935:	e9 3c ff ff ff       	jmp    80101876 <iput+0x26>
8010193a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101940:	83 ec 08             	sub    $0x8,%esp
80101943:	50                   	push   %eax
80101944:	ff 33                	pushl  (%ebx)
80101946:	e8 85 e7 ff ff       	call   801000d0 <bread>
8010194b:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010194e:	83 c4 10             	add    $0x10,%esp
80101951:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101957:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
8010195a:	8d 70 5c             	lea    0x5c(%eax),%esi
8010195d:	89 cf                	mov    %ecx,%edi
8010195f:	eb 0e                	jmp    8010196f <iput+0x11f>
80101961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101968:	83 c6 04             	add    $0x4,%esi
8010196b:	39 f7                	cmp    %esi,%edi
8010196d:	74 11                	je     80101980 <iput+0x130>
      if(a[j])
8010196f:	8b 16                	mov    (%esi),%edx
80101971:	85 d2                	test   %edx,%edx
80101973:	74 f3                	je     80101968 <iput+0x118>
        bfree(ip->dev, a[j]);
80101975:	8b 03                	mov    (%ebx),%eax
80101977:	e8 24 fb ff ff       	call   801014a0 <bfree>
8010197c:	eb ea                	jmp    80101968 <iput+0x118>
8010197e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101980:	83 ec 0c             	sub    $0xc,%esp
80101983:	ff 75 e4             	pushl  -0x1c(%ebp)
80101986:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101989:	e8 62 e8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010198e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101994:	8b 03                	mov    (%ebx),%eax
80101996:	e8 05 fb ff ff       	call   801014a0 <bfree>
    ip->addrs[NDIRECT] = 0;
8010199b:	83 c4 10             	add    $0x10,%esp
8010199e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019a5:	00 00 00 
801019a8:	e9 60 ff ff ff       	jmp    8010190d <iput+0xbd>
801019ad:	8d 76 00             	lea    0x0(%esi),%esi

801019b0 <iunlockput>:
{
801019b0:	55                   	push   %ebp
801019b1:	89 e5                	mov    %esp,%ebp
801019b3:	53                   	push   %ebx
801019b4:	83 ec 10             	sub    $0x10,%esp
801019b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019ba:	53                   	push   %ebx
801019bb:	e8 40 fe ff ff       	call   80101800 <iunlock>
  iput(ip);
801019c0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019c3:	83 c4 10             	add    $0x10,%esp
}
801019c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019c9:	c9                   	leave  
  iput(ip);
801019ca:	e9 81 fe ff ff       	jmp    80101850 <iput>
801019cf:	90                   	nop

801019d0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	8b 55 08             	mov    0x8(%ebp),%edx
801019d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801019d9:	8b 0a                	mov    (%edx),%ecx
801019db:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801019de:	8b 4a 04             	mov    0x4(%edx),%ecx
801019e1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801019e4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801019e8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801019eb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801019ef:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801019f3:	8b 52 58             	mov    0x58(%edx),%edx
801019f6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019f9:	5d                   	pop    %ebp
801019fa:	c3                   	ret    
801019fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019ff:	90                   	nop

80101a00 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	57                   	push   %edi
80101a04:	56                   	push   %esi
80101a05:	53                   	push   %ebx
80101a06:	83 ec 1c             	sub    $0x1c,%esp
80101a09:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a0c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a0f:	8b 75 10             	mov    0x10(%ebp),%esi
80101a12:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a15:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a18:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a1d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a20:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a23:	0f 84 a7 00 00 00    	je     80101ad0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a2c:	8b 40 58             	mov    0x58(%eax),%eax
80101a2f:	39 c6                	cmp    %eax,%esi
80101a31:	0f 87 ba 00 00 00    	ja     80101af1 <readi+0xf1>
80101a37:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a3a:	31 c9                	xor    %ecx,%ecx
80101a3c:	89 da                	mov    %ebx,%edx
80101a3e:	01 f2                	add    %esi,%edx
80101a40:	0f 92 c1             	setb   %cl
80101a43:	89 cf                	mov    %ecx,%edi
80101a45:	0f 82 a6 00 00 00    	jb     80101af1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a4b:	89 c1                	mov    %eax,%ecx
80101a4d:	29 f1                	sub    %esi,%ecx
80101a4f:	39 d0                	cmp    %edx,%eax
80101a51:	0f 43 cb             	cmovae %ebx,%ecx
80101a54:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a57:	85 c9                	test   %ecx,%ecx
80101a59:	74 67                	je     80101ac2 <readi+0xc2>
80101a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a5f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a60:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a63:	89 f2                	mov    %esi,%edx
80101a65:	c1 ea 09             	shr    $0x9,%edx
80101a68:	89 d8                	mov    %ebx,%eax
80101a6a:	e8 21 f9 ff ff       	call   80101390 <bmap>
80101a6f:	83 ec 08             	sub    $0x8,%esp
80101a72:	50                   	push   %eax
80101a73:	ff 33                	pushl  (%ebx)
80101a75:	e8 56 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a7a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a7d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a82:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a85:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a87:	89 f0                	mov    %esi,%eax
80101a89:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a8e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a90:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a93:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a95:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a99:	39 d9                	cmp    %ebx,%ecx
80101a9b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a9e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a9f:	01 df                	add    %ebx,%edi
80101aa1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101aa3:	50                   	push   %eax
80101aa4:	ff 75 e0             	pushl  -0x20(%ebp)
80101aa7:	e8 a4 2c 00 00       	call   80104750 <memmove>
    brelse(bp);
80101aac:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101aaf:	89 14 24             	mov    %edx,(%esp)
80101ab2:	e8 39 e7 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ab7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101aba:	83 c4 10             	add    $0x10,%esp
80101abd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101ac0:	77 9e                	ja     80101a60 <readi+0x60>
  }
  return n;
80101ac2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101ac5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ac8:	5b                   	pop    %ebx
80101ac9:	5e                   	pop    %esi
80101aca:	5f                   	pop    %edi
80101acb:	5d                   	pop    %ebp
80101acc:	c3                   	ret    
80101acd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ad0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ad4:	66 83 f8 09          	cmp    $0x9,%ax
80101ad8:	77 17                	ja     80101af1 <readi+0xf1>
80101ada:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101ae1:	85 c0                	test   %eax,%eax
80101ae3:	74 0c                	je     80101af1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101ae5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ae8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101aeb:	5b                   	pop    %ebx
80101aec:	5e                   	pop    %esi
80101aed:	5f                   	pop    %edi
80101aee:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101aef:	ff e0                	jmp    *%eax
      return -1;
80101af1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101af6:	eb cd                	jmp    80101ac5 <readi+0xc5>
80101af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101aff:	90                   	nop

80101b00 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	57                   	push   %edi
80101b04:	56                   	push   %esi
80101b05:	53                   	push   %ebx
80101b06:	83 ec 1c             	sub    $0x1c,%esp
80101b09:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b0f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b12:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b17:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b1a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b1d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b20:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b23:	0f 84 b7 00 00 00    	je     80101be0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b2f:	0f 82 e7 00 00 00    	jb     80101c1c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b35:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b38:	89 f8                	mov    %edi,%eax
80101b3a:	01 f0                	add    %esi,%eax
80101b3c:	0f 82 da 00 00 00    	jb     80101c1c <writei+0x11c>
80101b42:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b47:	0f 87 cf 00 00 00    	ja     80101c1c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b4d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b54:	85 ff                	test   %edi,%edi
80101b56:	74 79                	je     80101bd1 <writei+0xd1>
80101b58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b5f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b60:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b63:	89 f2                	mov    %esi,%edx
80101b65:	c1 ea 09             	shr    $0x9,%edx
80101b68:	89 f8                	mov    %edi,%eax
80101b6a:	e8 21 f8 ff ff       	call   80101390 <bmap>
80101b6f:	83 ec 08             	sub    $0x8,%esp
80101b72:	50                   	push   %eax
80101b73:	ff 37                	pushl  (%edi)
80101b75:	e8 56 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b7f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b82:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b85:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b87:	89 f0                	mov    %esi,%eax
80101b89:	83 c4 0c             	add    $0xc,%esp
80101b8c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b91:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b93:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b97:	39 d9                	cmp    %ebx,%ecx
80101b99:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b9c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b9d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b9f:	ff 75 dc             	pushl  -0x24(%ebp)
80101ba2:	50                   	push   %eax
80101ba3:	e8 a8 2b 00 00       	call   80104750 <memmove>
    log_write(bp);
80101ba8:	89 3c 24             	mov    %edi,(%esp)
80101bab:	e8 b0 12 00 00       	call   80102e60 <log_write>
    brelse(bp);
80101bb0:	89 3c 24             	mov    %edi,(%esp)
80101bb3:	e8 38 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bb8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bbb:	83 c4 10             	add    $0x10,%esp
80101bbe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bc1:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bc4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101bc7:	77 97                	ja     80101b60 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101bc9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bcc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bcf:	77 37                	ja     80101c08 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101bd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bd7:	5b                   	pop    %ebx
80101bd8:	5e                   	pop    %esi
80101bd9:	5f                   	pop    %edi
80101bda:	5d                   	pop    %ebp
80101bdb:	c3                   	ret    
80101bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101be0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101be4:	66 83 f8 09          	cmp    $0x9,%ax
80101be8:	77 32                	ja     80101c1c <writei+0x11c>
80101bea:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101bf1:	85 c0                	test   %eax,%eax
80101bf3:	74 27                	je     80101c1c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101bf5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101bf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bfb:	5b                   	pop    %ebx
80101bfc:	5e                   	pop    %esi
80101bfd:	5f                   	pop    %edi
80101bfe:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101bff:	ff e0                	jmp    *%eax
80101c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c08:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c0b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c0e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c11:	50                   	push   %eax
80101c12:	e8 59 fa ff ff       	call   80101670 <iupdate>
80101c17:	83 c4 10             	add    $0x10,%esp
80101c1a:	eb b5                	jmp    80101bd1 <writei+0xd1>
      return -1;
80101c1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c21:	eb b1                	jmp    80101bd4 <writei+0xd4>
80101c23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c30 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c30:	55                   	push   %ebp
80101c31:	89 e5                	mov    %esp,%ebp
80101c33:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c36:	6a 0e                	push   $0xe
80101c38:	ff 75 0c             	pushl  0xc(%ebp)
80101c3b:	ff 75 08             	pushl  0x8(%ebp)
80101c3e:	e8 7d 2b 00 00       	call   801047c0 <strncmp>
}
80101c43:	c9                   	leave  
80101c44:	c3                   	ret    
80101c45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c50 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	83 ec 1c             	sub    $0x1c,%esp
80101c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c5c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c61:	0f 85 85 00 00 00    	jne    80101cec <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c67:	8b 53 58             	mov    0x58(%ebx),%edx
80101c6a:	31 ff                	xor    %edi,%edi
80101c6c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c6f:	85 d2                	test   %edx,%edx
80101c71:	74 3e                	je     80101cb1 <dirlookup+0x61>
80101c73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c77:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c78:	6a 10                	push   $0x10
80101c7a:	57                   	push   %edi
80101c7b:	56                   	push   %esi
80101c7c:	53                   	push   %ebx
80101c7d:	e8 7e fd ff ff       	call   80101a00 <readi>
80101c82:	83 c4 10             	add    $0x10,%esp
80101c85:	83 f8 10             	cmp    $0x10,%eax
80101c88:	75 55                	jne    80101cdf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c8f:	74 18                	je     80101ca9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c91:	83 ec 04             	sub    $0x4,%esp
80101c94:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c97:	6a 0e                	push   $0xe
80101c99:	50                   	push   %eax
80101c9a:	ff 75 0c             	pushl  0xc(%ebp)
80101c9d:	e8 1e 2b 00 00       	call   801047c0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101ca2:	83 c4 10             	add    $0x10,%esp
80101ca5:	85 c0                	test   %eax,%eax
80101ca7:	74 17                	je     80101cc0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ca9:	83 c7 10             	add    $0x10,%edi
80101cac:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101caf:	72 c7                	jb     80101c78 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101cb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101cb4:	31 c0                	xor    %eax,%eax
}
80101cb6:	5b                   	pop    %ebx
80101cb7:	5e                   	pop    %esi
80101cb8:	5f                   	pop    %edi
80101cb9:	5d                   	pop    %ebp
80101cba:	c3                   	ret    
80101cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101cbf:	90                   	nop
      if(poff)
80101cc0:	8b 45 10             	mov    0x10(%ebp),%eax
80101cc3:	85 c0                	test   %eax,%eax
80101cc5:	74 05                	je     80101ccc <dirlookup+0x7c>
        *poff = off;
80101cc7:	8b 45 10             	mov    0x10(%ebp),%eax
80101cca:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101ccc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101cd0:	8b 03                	mov    (%ebx),%eax
80101cd2:	e8 c9 f5 ff ff       	call   801012a0 <iget>
}
80101cd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cda:	5b                   	pop    %ebx
80101cdb:	5e                   	pop    %esi
80101cdc:	5f                   	pop    %edi
80101cdd:	5d                   	pop    %ebp
80101cde:	c3                   	ret    
      panic("dirlookup read");
80101cdf:	83 ec 0c             	sub    $0xc,%esp
80101ce2:	68 79 72 10 80       	push   $0x80107279
80101ce7:	e8 94 e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101cec:	83 ec 0c             	sub    $0xc,%esp
80101cef:	68 67 72 10 80       	push   $0x80107267
80101cf4:	e8 87 e6 ff ff       	call   80100380 <panic>
80101cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d00 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	57                   	push   %edi
80101d04:	56                   	push   %esi
80101d05:	53                   	push   %ebx
80101d06:	89 c3                	mov    %eax,%ebx
80101d08:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d0b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d0e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101d11:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101d14:	0f 84 86 01 00 00    	je     80101ea0 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d1a:	e8 61 1b 00 00       	call   80103880 <myproc>
  acquire(&icache.lock);
80101d1f:	83 ec 0c             	sub    $0xc,%esp
80101d22:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80101d24:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d27:	68 e0 09 11 80       	push   $0x801109e0
80101d2c:	e8 0f 28 00 00       	call   80104540 <acquire>
  ip->ref++;
80101d31:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d35:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101d3c:	e8 1f 29 00 00       	call   80104660 <release>
80101d41:	83 c4 10             	add    $0x10,%esp
80101d44:	eb 0d                	jmp    80101d53 <namex+0x53>
80101d46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d4d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101d50:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101d53:	0f b6 07             	movzbl (%edi),%eax
80101d56:	3c 2f                	cmp    $0x2f,%al
80101d58:	74 f6                	je     80101d50 <namex+0x50>
  if(*path == 0)
80101d5a:	84 c0                	test   %al,%al
80101d5c:	0f 84 ee 00 00 00    	je     80101e50 <namex+0x150>
  while(*path != '/' && *path != 0)
80101d62:	0f b6 07             	movzbl (%edi),%eax
80101d65:	84 c0                	test   %al,%al
80101d67:	0f 84 fb 00 00 00    	je     80101e68 <namex+0x168>
80101d6d:	89 fb                	mov    %edi,%ebx
80101d6f:	3c 2f                	cmp    $0x2f,%al
80101d71:	0f 84 f1 00 00 00    	je     80101e68 <namex+0x168>
80101d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d7e:	66 90                	xchg   %ax,%ax
80101d80:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
80101d84:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80101d87:	3c 2f                	cmp    $0x2f,%al
80101d89:	74 04                	je     80101d8f <namex+0x8f>
80101d8b:	84 c0                	test   %al,%al
80101d8d:	75 f1                	jne    80101d80 <namex+0x80>
  len = path - s;
80101d8f:	89 d8                	mov    %ebx,%eax
80101d91:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80101d93:	83 f8 0d             	cmp    $0xd,%eax
80101d96:	0f 8e 84 00 00 00    	jle    80101e20 <namex+0x120>
    memmove(name, s, DIRSIZ);
80101d9c:	83 ec 04             	sub    $0x4,%esp
80101d9f:	6a 0e                	push   $0xe
80101da1:	57                   	push   %edi
    path++;
80101da2:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80101da4:	ff 75 e4             	pushl  -0x1c(%ebp)
80101da7:	e8 a4 29 00 00       	call   80104750 <memmove>
80101dac:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101daf:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101db2:	75 0c                	jne    80101dc0 <namex+0xc0>
80101db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101db8:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101dbb:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101dbe:	74 f8                	je     80101db8 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101dc0:	83 ec 0c             	sub    $0xc,%esp
80101dc3:	56                   	push   %esi
80101dc4:	e8 57 f9 ff ff       	call   80101720 <ilock>
    if(ip->type != T_DIR){
80101dc9:	83 c4 10             	add    $0x10,%esp
80101dcc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101dd1:	0f 85 a1 00 00 00    	jne    80101e78 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101dd7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101dda:	85 d2                	test   %edx,%edx
80101ddc:	74 09                	je     80101de7 <namex+0xe7>
80101dde:	80 3f 00             	cmpb   $0x0,(%edi)
80101de1:	0f 84 d9 00 00 00    	je     80101ec0 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101de7:	83 ec 04             	sub    $0x4,%esp
80101dea:	6a 00                	push   $0x0
80101dec:	ff 75 e4             	pushl  -0x1c(%ebp)
80101def:	56                   	push   %esi
80101df0:	e8 5b fe ff ff       	call   80101c50 <dirlookup>
80101df5:	83 c4 10             	add    $0x10,%esp
80101df8:	89 c3                	mov    %eax,%ebx
80101dfa:	85 c0                	test   %eax,%eax
80101dfc:	74 7a                	je     80101e78 <namex+0x178>
  iunlock(ip);
80101dfe:	83 ec 0c             	sub    $0xc,%esp
80101e01:	56                   	push   %esi
80101e02:	e8 f9 f9 ff ff       	call   80101800 <iunlock>
  iput(ip);
80101e07:	89 34 24             	mov    %esi,(%esp)
80101e0a:	89 de                	mov    %ebx,%esi
80101e0c:	e8 3f fa ff ff       	call   80101850 <iput>
80101e11:	83 c4 10             	add    $0x10,%esp
80101e14:	e9 3a ff ff ff       	jmp    80101d53 <namex+0x53>
80101e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e23:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80101e26:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80101e29:	83 ec 04             	sub    $0x4,%esp
80101e2c:	50                   	push   %eax
80101e2d:	57                   	push   %edi
    name[len] = 0;
80101e2e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80101e30:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e33:	e8 18 29 00 00       	call   80104750 <memmove>
    name[len] = 0;
80101e38:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e3b:	83 c4 10             	add    $0x10,%esp
80101e3e:	c6 00 00             	movb   $0x0,(%eax)
80101e41:	e9 69 ff ff ff       	jmp    80101daf <namex+0xaf>
80101e46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e4d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e50:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e53:	85 c0                	test   %eax,%eax
80101e55:	0f 85 85 00 00 00    	jne    80101ee0 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e5e:	89 f0                	mov    %esi,%eax
80101e60:	5b                   	pop    %ebx
80101e61:	5e                   	pop    %esi
80101e62:	5f                   	pop    %edi
80101e63:	5d                   	pop    %ebp
80101e64:	c3                   	ret    
80101e65:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80101e68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e6b:	89 fb                	mov    %edi,%ebx
80101e6d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101e70:	31 c0                	xor    %eax,%eax
80101e72:	eb b5                	jmp    80101e29 <namex+0x129>
80101e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e78:	83 ec 0c             	sub    $0xc,%esp
80101e7b:	56                   	push   %esi
80101e7c:	e8 7f f9 ff ff       	call   80101800 <iunlock>
  iput(ip);
80101e81:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e84:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e86:	e8 c5 f9 ff ff       	call   80101850 <iput>
      return 0;
80101e8b:	83 c4 10             	add    $0x10,%esp
}
80101e8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e91:	89 f0                	mov    %esi,%eax
80101e93:	5b                   	pop    %ebx
80101e94:	5e                   	pop    %esi
80101e95:	5f                   	pop    %edi
80101e96:	5d                   	pop    %ebp
80101e97:	c3                   	ret    
80101e98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e9f:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80101ea0:	ba 01 00 00 00       	mov    $0x1,%edx
80101ea5:	b8 01 00 00 00       	mov    $0x1,%eax
80101eaa:	89 df                	mov    %ebx,%edi
80101eac:	e8 ef f3 ff ff       	call   801012a0 <iget>
80101eb1:	89 c6                	mov    %eax,%esi
80101eb3:	e9 9b fe ff ff       	jmp    80101d53 <namex+0x53>
80101eb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ebf:	90                   	nop
      iunlock(ip);
80101ec0:	83 ec 0c             	sub    $0xc,%esp
80101ec3:	56                   	push   %esi
80101ec4:	e8 37 f9 ff ff       	call   80101800 <iunlock>
      return ip;
80101ec9:	83 c4 10             	add    $0x10,%esp
}
80101ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ecf:	89 f0                	mov    %esi,%eax
80101ed1:	5b                   	pop    %ebx
80101ed2:	5e                   	pop    %esi
80101ed3:	5f                   	pop    %edi
80101ed4:	5d                   	pop    %ebp
80101ed5:	c3                   	ret    
80101ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101edd:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80101ee0:	83 ec 0c             	sub    $0xc,%esp
80101ee3:	56                   	push   %esi
    return 0;
80101ee4:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ee6:	e8 65 f9 ff ff       	call   80101850 <iput>
    return 0;
80101eeb:	83 c4 10             	add    $0x10,%esp
80101eee:	e9 68 ff ff ff       	jmp    80101e5b <namex+0x15b>
80101ef3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f00 <dirlink>:
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	57                   	push   %edi
80101f04:	56                   	push   %esi
80101f05:	53                   	push   %ebx
80101f06:	83 ec 20             	sub    $0x20,%esp
80101f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f0c:	6a 00                	push   $0x0
80101f0e:	ff 75 0c             	pushl  0xc(%ebp)
80101f11:	53                   	push   %ebx
80101f12:	e8 39 fd ff ff       	call   80101c50 <dirlookup>
80101f17:	83 c4 10             	add    $0x10,%esp
80101f1a:	85 c0                	test   %eax,%eax
80101f1c:	75 67                	jne    80101f85 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f24:	85 ff                	test   %edi,%edi
80101f26:	74 29                	je     80101f51 <dirlink+0x51>
80101f28:	31 ff                	xor    %edi,%edi
80101f2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f2d:	eb 09                	jmp    80101f38 <dirlink+0x38>
80101f2f:	90                   	nop
80101f30:	83 c7 10             	add    $0x10,%edi
80101f33:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f36:	73 19                	jae    80101f51 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f38:	6a 10                	push   $0x10
80101f3a:	57                   	push   %edi
80101f3b:	56                   	push   %esi
80101f3c:	53                   	push   %ebx
80101f3d:	e8 be fa ff ff       	call   80101a00 <readi>
80101f42:	83 c4 10             	add    $0x10,%esp
80101f45:	83 f8 10             	cmp    $0x10,%eax
80101f48:	75 4e                	jne    80101f98 <dirlink+0x98>
    if(de.inum == 0)
80101f4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f4f:	75 df                	jne    80101f30 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101f51:	83 ec 04             	sub    $0x4,%esp
80101f54:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f57:	6a 0e                	push   $0xe
80101f59:	ff 75 0c             	pushl  0xc(%ebp)
80101f5c:	50                   	push   %eax
80101f5d:	e8 ae 28 00 00       	call   80104810 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f62:	6a 10                	push   $0x10
  de.inum = inum;
80101f64:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f67:	57                   	push   %edi
80101f68:	56                   	push   %esi
80101f69:	53                   	push   %ebx
  de.inum = inum;
80101f6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f6e:	e8 8d fb ff ff       	call   80101b00 <writei>
80101f73:	83 c4 20             	add    $0x20,%esp
80101f76:	83 f8 10             	cmp    $0x10,%eax
80101f79:	75 2a                	jne    80101fa5 <dirlink+0xa5>
  return 0;
80101f7b:	31 c0                	xor    %eax,%eax
}
80101f7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f80:	5b                   	pop    %ebx
80101f81:	5e                   	pop    %esi
80101f82:	5f                   	pop    %edi
80101f83:	5d                   	pop    %ebp
80101f84:	c3                   	ret    
    iput(ip);
80101f85:	83 ec 0c             	sub    $0xc,%esp
80101f88:	50                   	push   %eax
80101f89:	e8 c2 f8 ff ff       	call   80101850 <iput>
    return -1;
80101f8e:	83 c4 10             	add    $0x10,%esp
80101f91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f96:	eb e5                	jmp    80101f7d <dirlink+0x7d>
      panic("dirlink read");
80101f98:	83 ec 0c             	sub    $0xc,%esp
80101f9b:	68 88 72 10 80       	push   $0x80107288
80101fa0:	e8 db e3 ff ff       	call   80100380 <panic>
    panic("dirlink");
80101fa5:	83 ec 0c             	sub    $0xc,%esp
80101fa8:	68 2e 79 10 80       	push   $0x8010792e
80101fad:	e8 ce e3 ff ff       	call   80100380 <panic>
80101fb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fc0 <namei>:

struct inode*
namei(char *path)
{
80101fc0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fc1:	31 d2                	xor    %edx,%edx
{
80101fc3:	89 e5                	mov    %esp,%ebp
80101fc5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fc8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fce:	e8 2d fd ff ff       	call   80101d00 <namex>
}
80101fd3:	c9                   	leave  
80101fd4:	c3                   	ret    
80101fd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101fe0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fe0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fe1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101fe6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fe8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101feb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fee:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fef:	e9 0c fd ff ff       	jmp    80101d00 <namex>
80101ff4:	66 90                	xchg   %ax,%ax
80101ff6:	66 90                	xchg   %ax,%ax
80101ff8:	66 90                	xchg   %ax,%ax
80101ffa:	66 90                	xchg   %ax,%ax
80101ffc:	66 90                	xchg   %ax,%ax
80101ffe:	66 90                	xchg   %ax,%ax

80102000 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	57                   	push   %edi
80102004:	56                   	push   %esi
80102005:	53                   	push   %ebx
80102006:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102009:	85 c0                	test   %eax,%eax
8010200b:	0f 84 b4 00 00 00    	je     801020c5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102011:	8b 70 08             	mov    0x8(%eax),%esi
80102014:	89 c3                	mov    %eax,%ebx
80102016:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010201c:	0f 87 96 00 00 00    	ja     801020b8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102022:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102027:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010202e:	66 90                	xchg   %ax,%ax
80102030:	89 ca                	mov    %ecx,%edx
80102032:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102033:	83 e0 c0             	and    $0xffffffc0,%eax
80102036:	3c 40                	cmp    $0x40,%al
80102038:	75 f6                	jne    80102030 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010203a:	31 ff                	xor    %edi,%edi
8010203c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102041:	89 f8                	mov    %edi,%eax
80102043:	ee                   	out    %al,(%dx)
80102044:	b8 01 00 00 00       	mov    $0x1,%eax
80102049:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010204e:	ee                   	out    %al,(%dx)
8010204f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102054:	89 f0                	mov    %esi,%eax
80102056:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102057:	89 f0                	mov    %esi,%eax
80102059:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010205e:	c1 f8 08             	sar    $0x8,%eax
80102061:	ee                   	out    %al,(%dx)
80102062:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102067:	89 f8                	mov    %edi,%eax
80102069:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010206a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010206e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102073:	c1 e0 04             	shl    $0x4,%eax
80102076:	83 e0 10             	and    $0x10,%eax
80102079:	83 c8 e0             	or     $0xffffffe0,%eax
8010207c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010207d:	f6 03 04             	testb  $0x4,(%ebx)
80102080:	75 16                	jne    80102098 <idestart+0x98>
80102082:	b8 20 00 00 00       	mov    $0x20,%eax
80102087:	89 ca                	mov    %ecx,%edx
80102089:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010208a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010208d:	5b                   	pop    %ebx
8010208e:	5e                   	pop    %esi
8010208f:	5f                   	pop    %edi
80102090:	5d                   	pop    %ebp
80102091:	c3                   	ret    
80102092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102098:	b8 30 00 00 00       	mov    $0x30,%eax
8010209d:	89 ca                	mov    %ecx,%edx
8010209f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801020a0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801020a5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801020a8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020ad:	fc                   	cld    
801020ae:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801020b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b3:	5b                   	pop    %ebx
801020b4:	5e                   	pop    %esi
801020b5:	5f                   	pop    %edi
801020b6:	5d                   	pop    %ebp
801020b7:	c3                   	ret    
    panic("incorrect blockno");
801020b8:	83 ec 0c             	sub    $0xc,%esp
801020bb:	68 f4 72 10 80       	push   $0x801072f4
801020c0:	e8 bb e2 ff ff       	call   80100380 <panic>
    panic("idestart");
801020c5:	83 ec 0c             	sub    $0xc,%esp
801020c8:	68 eb 72 10 80       	push   $0x801072eb
801020cd:	e8 ae e2 ff ff       	call   80100380 <panic>
801020d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020e6:	68 06 73 10 80       	push   $0x80107306
801020eb:	68 80 a5 10 80       	push   $0x8010a580
801020f0:	e8 4b 23 00 00       	call   80104440 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020f5:	58                   	pop    %eax
801020f6:	a1 00 2d 11 80       	mov    0x80112d00,%eax
801020fb:	5a                   	pop    %edx
801020fc:	83 e8 01             	sub    $0x1,%eax
801020ff:	50                   	push   %eax
80102100:	6a 0e                	push   $0xe
80102102:	e8 99 02 00 00       	call   801023a0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102107:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010210a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010210f:	90                   	nop
80102110:	ec                   	in     (%dx),%al
80102111:	83 e0 c0             	and    $0xffffffc0,%eax
80102114:	3c 40                	cmp    $0x40,%al
80102116:	75 f8                	jne    80102110 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102118:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010211d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102122:	ee                   	out    %al,(%dx)
80102123:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102128:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010212d:	eb 06                	jmp    80102135 <ideinit+0x55>
8010212f:	90                   	nop
  for(i=0; i<1000; i++){
80102130:	83 e9 01             	sub    $0x1,%ecx
80102133:	74 0f                	je     80102144 <ideinit+0x64>
80102135:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102136:	84 c0                	test   %al,%al
80102138:	74 f6                	je     80102130 <ideinit+0x50>
      havedisk1 = 1;
8010213a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102141:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102144:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102149:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010214e:	ee                   	out    %al,(%dx)
}
8010214f:	c9                   	leave  
80102150:	c3                   	ret    
80102151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102158:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010215f:	90                   	nop

80102160 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	57                   	push   %edi
80102164:	56                   	push   %esi
80102165:	53                   	push   %ebx
80102166:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102169:	68 80 a5 10 80       	push   $0x8010a580
8010216e:	e8 cd 23 00 00       	call   80104540 <acquire>

  if((b = idequeue) == 0){
80102173:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102179:	83 c4 10             	add    $0x10,%esp
8010217c:	85 db                	test   %ebx,%ebx
8010217e:	74 63                	je     801021e3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102180:	8b 43 58             	mov    0x58(%ebx),%eax
80102183:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102188:	8b 33                	mov    (%ebx),%esi
8010218a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102190:	75 2f                	jne    801021c1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102192:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010219e:	66 90                	xchg   %ax,%ax
801021a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021a1:	89 c1                	mov    %eax,%ecx
801021a3:	83 e1 c0             	and    $0xffffffc0,%ecx
801021a6:	80 f9 40             	cmp    $0x40,%cl
801021a9:	75 f5                	jne    801021a0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021ab:	a8 21                	test   $0x21,%al
801021ad:	75 12                	jne    801021c1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801021af:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021b2:	b9 80 00 00 00       	mov    $0x80,%ecx
801021b7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021bc:	fc                   	cld    
801021bd:	f3 6d                	rep insl (%dx),%es:(%edi)
801021bf:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021c1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801021c4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801021c7:	83 ce 02             	or     $0x2,%esi
801021ca:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801021cc:	53                   	push   %ebx
801021cd:	e8 1e 1e 00 00       	call   80103ff0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d2:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801021d7:	83 c4 10             	add    $0x10,%esp
801021da:	85 c0                	test   %eax,%eax
801021dc:	74 05                	je     801021e3 <ideintr+0x83>
    idestart(idequeue);
801021de:	e8 1d fe ff ff       	call   80102000 <idestart>
    release(&idelock);
801021e3:	83 ec 0c             	sub    $0xc,%esp
801021e6:	68 80 a5 10 80       	push   $0x8010a580
801021eb:	e8 70 24 00 00       	call   80104660 <release>

  release(&idelock);
}
801021f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021f3:	5b                   	pop    %ebx
801021f4:	5e                   	pop    %esi
801021f5:	5f                   	pop    %edi
801021f6:	5d                   	pop    %ebp
801021f7:	c3                   	ret    
801021f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ff:	90                   	nop

80102200 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	53                   	push   %ebx
80102204:	83 ec 10             	sub    $0x10,%esp
80102207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010220a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010220d:	50                   	push   %eax
8010220e:	e8 fd 21 00 00       	call   80104410 <holdingsleep>
80102213:	83 c4 10             	add    $0x10,%esp
80102216:	85 c0                	test   %eax,%eax
80102218:	0f 84 c3 00 00 00    	je     801022e1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010221e:	8b 03                	mov    (%ebx),%eax
80102220:	83 e0 06             	and    $0x6,%eax
80102223:	83 f8 02             	cmp    $0x2,%eax
80102226:	0f 84 a8 00 00 00    	je     801022d4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010222c:	8b 53 04             	mov    0x4(%ebx),%edx
8010222f:	85 d2                	test   %edx,%edx
80102231:	74 0d                	je     80102240 <iderw+0x40>
80102233:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102238:	85 c0                	test   %eax,%eax
8010223a:	0f 84 87 00 00 00    	je     801022c7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102240:	83 ec 0c             	sub    $0xc,%esp
80102243:	68 80 a5 10 80       	push   $0x8010a580
80102248:	e8 f3 22 00 00       	call   80104540 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224d:	a1 64 a5 10 80       	mov    0x8010a564,%eax
  b->qnext = 0;
80102252:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102259:	83 c4 10             	add    $0x10,%esp
8010225c:	85 c0                	test   %eax,%eax
8010225e:	74 60                	je     801022c0 <iderw+0xc0>
80102260:	89 c2                	mov    %eax,%edx
80102262:	8b 40 58             	mov    0x58(%eax),%eax
80102265:	85 c0                	test   %eax,%eax
80102267:	75 f7                	jne    80102260 <iderw+0x60>
80102269:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010226c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010226e:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
80102274:	74 3a                	je     801022b0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102276:	8b 03                	mov    (%ebx),%eax
80102278:	83 e0 06             	and    $0x6,%eax
8010227b:	83 f8 02             	cmp    $0x2,%eax
8010227e:	74 1b                	je     8010229b <iderw+0x9b>
    sleep(b, &idelock);
80102280:	83 ec 08             	sub    $0x8,%esp
80102283:	68 80 a5 10 80       	push   $0x8010a580
80102288:	53                   	push   %ebx
80102289:	e8 b2 1b 00 00       	call   80103e40 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010228e:	8b 03                	mov    (%ebx),%eax
80102290:	83 c4 10             	add    $0x10,%esp
80102293:	83 e0 06             	and    $0x6,%eax
80102296:	83 f8 02             	cmp    $0x2,%eax
80102299:	75 e5                	jne    80102280 <iderw+0x80>
  }


  release(&idelock);
8010229b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801022a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022a5:	c9                   	leave  
  release(&idelock);
801022a6:	e9 b5 23 00 00       	jmp    80104660 <release>
801022ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022af:	90                   	nop
    idestart(b);
801022b0:	89 d8                	mov    %ebx,%eax
801022b2:	e8 49 fd ff ff       	call   80102000 <idestart>
801022b7:	eb bd                	jmp    80102276 <iderw+0x76>
801022b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022c0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801022c5:	eb a5                	jmp    8010226c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801022c7:	83 ec 0c             	sub    $0xc,%esp
801022ca:	68 35 73 10 80       	push   $0x80107335
801022cf:	e8 ac e0 ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801022d4:	83 ec 0c             	sub    $0xc,%esp
801022d7:	68 20 73 10 80       	push   $0x80107320
801022dc:	e8 9f e0 ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801022e1:	83 ec 0c             	sub    $0xc,%esp
801022e4:	68 0a 73 10 80       	push   $0x8010730a
801022e9:	e8 92 e0 ff ff       	call   80100380 <panic>
801022ee:	66 90                	xchg   %ax,%ax

801022f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022f1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801022f8:	00 c0 fe 
{
801022fb:	89 e5                	mov    %esp,%ebp
801022fd:	56                   	push   %esi
801022fe:	53                   	push   %ebx
  ioapic->reg = reg;
801022ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102306:	00 00 00 
  return ioapic->data;
80102309:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010230f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102312:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102318:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010231e:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102325:	c1 ee 10             	shr    $0x10,%esi
80102328:	89 f0                	mov    %esi,%eax
8010232a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010232d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102330:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102333:	39 c2                	cmp    %eax,%edx
80102335:	74 16                	je     8010234d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102337:	83 ec 0c             	sub    $0xc,%esp
8010233a:	68 54 73 10 80       	push   $0x80107354
8010233f:	e8 5c e3 ff ff       	call   801006a0 <cprintf>
80102344:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010234a:	83 c4 10             	add    $0x10,%esp
8010234d:	83 c6 21             	add    $0x21,%esi
{
80102350:	ba 10 00 00 00       	mov    $0x10,%edx
80102355:	b8 20 00 00 00       	mov    $0x20,%eax
8010235a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102360:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102362:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102364:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010236a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010236d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102373:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102376:	8d 5a 01             	lea    0x1(%edx),%ebx
80102379:	83 c2 02             	add    $0x2,%edx
8010237c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010237e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102384:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010238b:	39 f0                	cmp    %esi,%eax
8010238d:	75 d1                	jne    80102360 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010238f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102392:	5b                   	pop    %ebx
80102393:	5e                   	pop    %esi
80102394:	5d                   	pop    %ebp
80102395:	c3                   	ret    
80102396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010239d:	8d 76 00             	lea    0x0(%esi),%esi

801023a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023a0:	55                   	push   %ebp
  ioapic->reg = reg;
801023a1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801023a7:	89 e5                	mov    %esp,%ebp
801023a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023ac:	8d 50 20             	lea    0x20(%eax),%edx
801023af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023b3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023b5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023be:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023c4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023cb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023ce:	89 50 10             	mov    %edx,0x10(%eax)
}
801023d1:	5d                   	pop    %ebp
801023d2:	c3                   	ret    
801023d3:	66 90                	xchg   %ax,%ax
801023d5:	66 90                	xchg   %ax,%ax
801023d7:	66 90                	xchg   %ax,%ax
801023d9:	66 90                	xchg   %ax,%ax
801023db:	66 90                	xchg   %ax,%ax
801023dd:	66 90                	xchg   %ax,%ax
801023df:	90                   	nop

801023e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	53                   	push   %ebx
801023e4:	83 ec 04             	sub    $0x4,%esp
801023e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023f0:	75 76                	jne    80102468 <kfree+0x88>
801023f2:	81 fb a8 55 11 80    	cmp    $0x801155a8,%ebx
801023f8:	72 6e                	jb     80102468 <kfree+0x88>
801023fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102400:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102405:	77 61                	ja     80102468 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102407:	83 ec 04             	sub    $0x4,%esp
8010240a:	68 00 10 00 00       	push   $0x1000
8010240f:	6a 01                	push   $0x1
80102411:	53                   	push   %ebx
80102412:	e8 99 22 00 00       	call   801046b0 <memset>

  if(kmem.use_lock)
80102417:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010241d:	83 c4 10             	add    $0x10,%esp
80102420:	85 d2                	test   %edx,%edx
80102422:	75 1c                	jne    80102440 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102424:	a1 78 26 11 80       	mov    0x80112678,%eax
80102429:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010242b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102430:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102436:	85 c0                	test   %eax,%eax
80102438:	75 1e                	jne    80102458 <kfree+0x78>
    release(&kmem.lock);
}
8010243a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010243d:	c9                   	leave  
8010243e:	c3                   	ret    
8010243f:	90                   	nop
    acquire(&kmem.lock);
80102440:	83 ec 0c             	sub    $0xc,%esp
80102443:	68 40 26 11 80       	push   $0x80112640
80102448:	e8 f3 20 00 00       	call   80104540 <acquire>
8010244d:	83 c4 10             	add    $0x10,%esp
80102450:	eb d2                	jmp    80102424 <kfree+0x44>
80102452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102458:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010245f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102462:	c9                   	leave  
    release(&kmem.lock);
80102463:	e9 f8 21 00 00       	jmp    80104660 <release>
    panic("kfree");
80102468:	83 ec 0c             	sub    $0xc,%esp
8010246b:	68 86 73 10 80       	push   $0x80107386
80102470:	e8 0b df ff ff       	call   80100380 <panic>
80102475:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010247c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102480 <freerange>:
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102484:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102487:	8b 75 0c             	mov    0xc(%ebp),%esi
8010248a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010248b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102491:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102497:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010249d:	39 de                	cmp    %ebx,%esi
8010249f:	72 23                	jb     801024c4 <freerange+0x44>
801024a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024a8:	83 ec 0c             	sub    $0xc,%esp
801024ab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024b7:	50                   	push   %eax
801024b8:	e8 23 ff ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	39 f3                	cmp    %esi,%ebx
801024c2:	76 e4                	jbe    801024a8 <freerange+0x28>
}
801024c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024c7:	5b                   	pop    %ebx
801024c8:	5e                   	pop    %esi
801024c9:	5d                   	pop    %ebp
801024ca:	c3                   	ret    
801024cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024cf:	90                   	nop

801024d0 <kinit1>:
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	56                   	push   %esi
801024d4:	53                   	push   %ebx
801024d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024d8:	83 ec 08             	sub    $0x8,%esp
801024db:	68 8c 73 10 80       	push   $0x8010738c
801024e0:	68 40 26 11 80       	push   $0x80112640
801024e5:	e8 56 1f 00 00       	call   80104440 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801024ea:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ed:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801024f0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801024f7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801024fa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102500:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102506:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010250c:	39 de                	cmp    %ebx,%esi
8010250e:	72 1c                	jb     8010252c <kinit1+0x5c>
    kfree(p);
80102510:	83 ec 0c             	sub    $0xc,%esp
80102513:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102519:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010251f:	50                   	push   %eax
80102520:	e8 bb fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102525:	83 c4 10             	add    $0x10,%esp
80102528:	39 de                	cmp    %ebx,%esi
8010252a:	73 e4                	jae    80102510 <kinit1+0x40>
}
8010252c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010252f:	5b                   	pop    %ebx
80102530:	5e                   	pop    %esi
80102531:	5d                   	pop    %ebp
80102532:	c3                   	ret    
80102533:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010253a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102540 <kinit2>:
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102544:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102547:	8b 75 0c             	mov    0xc(%ebp),%esi
8010254a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010254b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102551:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102557:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010255d:	39 de                	cmp    %ebx,%esi
8010255f:	72 23                	jb     80102584 <kinit2+0x44>
80102561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102568:	83 ec 0c             	sub    $0xc,%esp
8010256b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102571:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102577:	50                   	push   %eax
80102578:	e8 63 fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010257d:	83 c4 10             	add    $0x10,%esp
80102580:	39 de                	cmp    %ebx,%esi
80102582:	73 e4                	jae    80102568 <kinit2+0x28>
  kmem.use_lock = 1;
80102584:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010258b:	00 00 00 
}
8010258e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102591:	5b                   	pop    %ebx
80102592:	5e                   	pop    %esi
80102593:	5d                   	pop    %ebp
80102594:	c3                   	ret    
80102595:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010259c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025a0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801025a0:	a1 74 26 11 80       	mov    0x80112674,%eax
801025a5:	85 c0                	test   %eax,%eax
801025a7:	75 1f                	jne    801025c8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025a9:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801025ae:	85 c0                	test   %eax,%eax
801025b0:	74 0e                	je     801025c0 <kalloc+0x20>
    kmem.freelist = r->next;
801025b2:	8b 10                	mov    (%eax),%edx
801025b4:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801025ba:	c3                   	ret    
801025bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025bf:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801025c0:	c3                   	ret    
801025c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801025c8:	55                   	push   %ebp
801025c9:	89 e5                	mov    %esp,%ebp
801025cb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801025ce:	68 40 26 11 80       	push   $0x80112640
801025d3:	e8 68 1f 00 00       	call   80104540 <acquire>
  r = kmem.freelist;
801025d8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801025dd:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801025e3:	83 c4 10             	add    $0x10,%esp
801025e6:	85 c0                	test   %eax,%eax
801025e8:	74 08                	je     801025f2 <kalloc+0x52>
    kmem.freelist = r->next;
801025ea:	8b 08                	mov    (%eax),%ecx
801025ec:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801025f2:	85 d2                	test   %edx,%edx
801025f4:	74 16                	je     8010260c <kalloc+0x6c>
    release(&kmem.lock);
801025f6:	83 ec 0c             	sub    $0xc,%esp
801025f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801025fc:	68 40 26 11 80       	push   $0x80112640
80102601:	e8 5a 20 00 00       	call   80104660 <release>
  return (char*)r;
80102606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102609:	83 c4 10             	add    $0x10,%esp
}
8010260c:	c9                   	leave  
8010260d:	c3                   	ret    
8010260e:	66 90                	xchg   %ax,%ax

80102610 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102610:	ba 64 00 00 00       	mov    $0x64,%edx
80102615:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102616:	a8 01                	test   $0x1,%al
80102618:	0f 84 c2 00 00 00    	je     801026e0 <kbdgetc+0xd0>
{
8010261e:	55                   	push   %ebp
8010261f:	ba 60 00 00 00       	mov    $0x60,%edx
80102624:	89 e5                	mov    %esp,%ebp
80102626:	53                   	push   %ebx
80102627:	ec                   	in     (%dx),%al
  return data;
80102628:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
    return -1;
  data = inb(KBDATAP);
8010262e:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102631:	3c e0                	cmp    $0xe0,%al
80102633:	74 5b                	je     80102690 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102635:	89 d9                	mov    %ebx,%ecx
80102637:	83 e1 40             	and    $0x40,%ecx
8010263a:	84 c0                	test   %al,%al
8010263c:	78 62                	js     801026a0 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010263e:	85 c9                	test   %ecx,%ecx
80102640:	74 09                	je     8010264b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102642:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102645:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102648:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
8010264b:	0f b6 8a c0 74 10 80 	movzbl -0x7fef8b40(%edx),%ecx
  shift ^= togglecode[data];
80102652:	0f b6 82 c0 73 10 80 	movzbl -0x7fef8c40(%edx),%eax
  shift |= shiftcode[data];
80102659:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010265b:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010265d:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
8010265f:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102665:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102668:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010266b:	8b 04 85 a0 73 10 80 	mov    -0x7fef8c60(,%eax,4),%eax
80102672:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102676:	74 0b                	je     80102683 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102678:	8d 50 9f             	lea    -0x61(%eax),%edx
8010267b:	83 fa 19             	cmp    $0x19,%edx
8010267e:	77 48                	ja     801026c8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102680:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102683:	5b                   	pop    %ebx
80102684:	5d                   	pop    %ebp
80102685:	c3                   	ret    
80102686:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010268d:	8d 76 00             	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102690:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102693:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102695:	89 1d b4 a5 10 80    	mov    %ebx,0x8010a5b4
}
8010269b:	5b                   	pop    %ebx
8010269c:	5d                   	pop    %ebp
8010269d:	c3                   	ret    
8010269e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801026a0:	83 e0 7f             	and    $0x7f,%eax
801026a3:	85 c9                	test   %ecx,%ecx
801026a5:	0f 44 d0             	cmove  %eax,%edx
    return 0;
801026a8:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026aa:	0f b6 8a c0 74 10 80 	movzbl -0x7fef8b40(%edx),%ecx
801026b1:	83 c9 40             	or     $0x40,%ecx
801026b4:	0f b6 c9             	movzbl %cl,%ecx
801026b7:	f7 d1                	not    %ecx
801026b9:	21 d9                	and    %ebx,%ecx
}
801026bb:	5b                   	pop    %ebx
801026bc:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
801026bd:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801026c3:	c3                   	ret    
801026c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801026c8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026cb:	8d 50 20             	lea    0x20(%eax),%edx
}
801026ce:	5b                   	pop    %ebx
801026cf:	5d                   	pop    %ebp
      c += 'a' - 'A';
801026d0:	83 f9 1a             	cmp    $0x1a,%ecx
801026d3:	0f 42 c2             	cmovb  %edx,%eax
}
801026d6:	c3                   	ret    
801026d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026de:	66 90                	xchg   %ax,%ax
    return -1;
801026e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801026e5:	c3                   	ret    
801026e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026ed:	8d 76 00             	lea    0x0(%esi),%esi

801026f0 <kbdintr>:

void
kbdintr(void)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801026f6:	68 10 26 10 80       	push   $0x80102610
801026fb:	e8 50 e1 ff ff       	call   80100850 <consoleintr>
}
80102700:	83 c4 10             	add    $0x10,%esp
80102703:	c9                   	leave  
80102704:	c3                   	ret    
80102705:	66 90                	xchg   %ax,%ax
80102707:	66 90                	xchg   %ax,%ax
80102709:	66 90                	xchg   %ax,%ax
8010270b:	66 90                	xchg   %ax,%ax
8010270d:	66 90                	xchg   %ax,%ax
8010270f:	90                   	nop

80102710 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102710:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102715:	85 c0                	test   %eax,%eax
80102717:	0f 84 cb 00 00 00    	je     801027e8 <lapicinit+0xd8>
  lapic[index] = value;
8010271d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102724:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102727:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010272a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102731:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102734:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102737:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010273e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102741:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102744:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010274b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010274e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102751:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102758:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010275b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010275e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102765:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102768:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010276b:	8b 50 30             	mov    0x30(%eax),%edx
8010276e:	c1 ea 10             	shr    $0x10,%edx
80102771:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102777:	75 77                	jne    801027f0 <lapicinit+0xe0>
  lapic[index] = value;
80102779:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102780:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102783:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102786:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010278d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102790:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102793:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010279a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010279d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027a0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027a7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027aa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ad:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027b4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ba:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027c1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027c4:	8b 50 20             	mov    0x20(%eax),%edx
801027c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ce:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027d0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027d6:	80 e6 10             	and    $0x10,%dh
801027d9:	75 f5                	jne    801027d0 <lapicinit+0xc0>
  lapic[index] = value;
801027db:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027e2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027e8:	c3                   	ret    
801027e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801027f0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801027f7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027fa:	8b 50 20             	mov    0x20(%eax),%edx
}
801027fd:	e9 77 ff ff ff       	jmp    80102779 <lapicinit+0x69>
80102802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102810 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102810:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102815:	85 c0                	test   %eax,%eax
80102817:	74 07                	je     80102820 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102819:	8b 40 20             	mov    0x20(%eax),%eax
8010281c:	c1 e8 18             	shr    $0x18,%eax
8010281f:	c3                   	ret    
    return 0;
80102820:	31 c0                	xor    %eax,%eax
}
80102822:	c3                   	ret    
80102823:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010282a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102830 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102830:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102835:	85 c0                	test   %eax,%eax
80102837:	74 0d                	je     80102846 <lapiceoi+0x16>
  lapic[index] = value;
80102839:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102840:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102843:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102846:	c3                   	ret    
80102847:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010284e:	66 90                	xchg   %ax,%ax

80102850 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102850:	c3                   	ret    
80102851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010285f:	90                   	nop

80102860 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102860:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102861:	b8 0f 00 00 00       	mov    $0xf,%eax
80102866:	ba 70 00 00 00       	mov    $0x70,%edx
8010286b:	89 e5                	mov    %esp,%ebp
8010286d:	53                   	push   %ebx
8010286e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102871:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102874:	ee                   	out    %al,(%dx)
80102875:	b8 0a 00 00 00       	mov    $0xa,%eax
8010287a:	ba 71 00 00 00       	mov    $0x71,%edx
8010287f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102880:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102882:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102885:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010288b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010288d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102890:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102892:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102895:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102898:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010289e:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801028a3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028a9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028ac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028b3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028b9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028c0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028c6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028cc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028cf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028d8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028de:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028e1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
801028e7:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
801028e8:	8b 40 20             	mov    0x20(%eax),%eax
}
801028eb:	5d                   	pop    %ebp
801028ec:	c3                   	ret    
801028ed:	8d 76 00             	lea    0x0(%esi),%esi

801028f0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801028f0:	55                   	push   %ebp
801028f1:	b8 0b 00 00 00       	mov    $0xb,%eax
801028f6:	ba 70 00 00 00       	mov    $0x70,%edx
801028fb:	89 e5                	mov    %esp,%ebp
801028fd:	57                   	push   %edi
801028fe:	56                   	push   %esi
801028ff:	53                   	push   %ebx
80102900:	83 ec 4c             	sub    $0x4c,%esp
80102903:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102904:	ba 71 00 00 00       	mov    $0x71,%edx
80102909:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010290a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010290d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102912:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102915:	8d 76 00             	lea    0x0(%esi),%esi
80102918:	31 c0                	xor    %eax,%eax
8010291a:	89 da                	mov    %ebx,%edx
8010291c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102922:	89 ca                	mov    %ecx,%edx
80102924:	ec                   	in     (%dx),%al
80102925:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102928:	89 da                	mov    %ebx,%edx
8010292a:	b8 02 00 00 00       	mov    $0x2,%eax
8010292f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102930:	89 ca                	mov    %ecx,%edx
80102932:	ec                   	in     (%dx),%al
80102933:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102936:	89 da                	mov    %ebx,%edx
80102938:	b8 04 00 00 00       	mov    $0x4,%eax
8010293d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293e:	89 ca                	mov    %ecx,%edx
80102940:	ec                   	in     (%dx),%al
80102941:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102944:	89 da                	mov    %ebx,%edx
80102946:	b8 07 00 00 00       	mov    $0x7,%eax
8010294b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294c:	89 ca                	mov    %ecx,%edx
8010294e:	ec                   	in     (%dx),%al
8010294f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102952:	89 da                	mov    %ebx,%edx
80102954:	b8 08 00 00 00       	mov    $0x8,%eax
80102959:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295a:	89 ca                	mov    %ecx,%edx
8010295c:	ec                   	in     (%dx),%al
8010295d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295f:	89 da                	mov    %ebx,%edx
80102961:	b8 09 00 00 00       	mov    $0x9,%eax
80102966:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102967:	89 ca                	mov    %ecx,%edx
80102969:	ec                   	in     (%dx),%al
8010296a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010296c:	89 da                	mov    %ebx,%edx
8010296e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102973:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102974:	89 ca                	mov    %ecx,%edx
80102976:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102977:	84 c0                	test   %al,%al
80102979:	78 9d                	js     80102918 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010297b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010297f:	89 fa                	mov    %edi,%edx
80102981:	0f b6 fa             	movzbl %dl,%edi
80102984:	89 f2                	mov    %esi,%edx
80102986:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102989:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
8010298d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102990:	89 da                	mov    %ebx,%edx
80102992:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102995:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102998:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010299c:	89 75 cc             	mov    %esi,-0x34(%ebp)
8010299f:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029a2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801029a6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801029a9:	31 c0                	xor    %eax,%eax
801029ab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ac:	89 ca                	mov    %ecx,%edx
801029ae:	ec                   	in     (%dx),%al
801029af:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b2:	89 da                	mov    %ebx,%edx
801029b4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029b7:	b8 02 00 00 00       	mov    $0x2,%eax
801029bc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bd:	89 ca                	mov    %ecx,%edx
801029bf:	ec                   	in     (%dx),%al
801029c0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c3:	89 da                	mov    %ebx,%edx
801029c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029c8:	b8 04 00 00 00       	mov    $0x4,%eax
801029cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ce:	89 ca                	mov    %ecx,%edx
801029d0:	ec                   	in     (%dx),%al
801029d1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d4:	89 da                	mov    %ebx,%edx
801029d6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029d9:	b8 07 00 00 00       	mov    $0x7,%eax
801029de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029df:	89 ca                	mov    %ecx,%edx
801029e1:	ec                   	in     (%dx),%al
801029e2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e5:	89 da                	mov    %ebx,%edx
801029e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029ea:	b8 08 00 00 00       	mov    $0x8,%eax
801029ef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f0:	89 ca                	mov    %ecx,%edx
801029f2:	ec                   	in     (%dx),%al
801029f3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f6:	89 da                	mov    %ebx,%edx
801029f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029fb:	b8 09 00 00 00       	mov    $0x9,%eax
80102a00:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a01:	89 ca                	mov    %ecx,%edx
80102a03:	ec                   	in     (%dx),%al
80102a04:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a07:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102a0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a0d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102a10:	6a 18                	push   $0x18
80102a12:	50                   	push   %eax
80102a13:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a16:	50                   	push   %eax
80102a17:	e8 e4 1c 00 00       	call   80104700 <memcmp>
80102a1c:	83 c4 10             	add    $0x10,%esp
80102a1f:	85 c0                	test   %eax,%eax
80102a21:	0f 85 f1 fe ff ff    	jne    80102918 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a27:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a2b:	75 78                	jne    80102aa5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a2d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a30:	89 c2                	mov    %eax,%edx
80102a32:	83 e0 0f             	and    $0xf,%eax
80102a35:	c1 ea 04             	shr    $0x4,%edx
80102a38:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a3b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a3e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a41:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a44:	89 c2                	mov    %eax,%edx
80102a46:	83 e0 0f             	and    $0xf,%eax
80102a49:	c1 ea 04             	shr    $0x4,%edx
80102a4c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a4f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a52:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a55:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a58:	89 c2                	mov    %eax,%edx
80102a5a:	83 e0 0f             	and    $0xf,%eax
80102a5d:	c1 ea 04             	shr    $0x4,%edx
80102a60:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a63:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a66:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a69:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a6c:	89 c2                	mov    %eax,%edx
80102a6e:	83 e0 0f             	and    $0xf,%eax
80102a71:	c1 ea 04             	shr    $0x4,%edx
80102a74:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a77:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a7a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a7d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a80:	89 c2                	mov    %eax,%edx
80102a82:	83 e0 0f             	and    $0xf,%eax
80102a85:	c1 ea 04             	shr    $0x4,%edx
80102a88:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a8b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a8e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a91:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a94:	89 c2                	mov    %eax,%edx
80102a96:	83 e0 0f             	and    $0xf,%eax
80102a99:	c1 ea 04             	shr    $0x4,%edx
80102a9c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a9f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aa2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102aa5:	8b 75 08             	mov    0x8(%ebp),%esi
80102aa8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102aab:	89 06                	mov    %eax,(%esi)
80102aad:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ab0:	89 46 04             	mov    %eax,0x4(%esi)
80102ab3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ab6:	89 46 08             	mov    %eax,0x8(%esi)
80102ab9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102abc:	89 46 0c             	mov    %eax,0xc(%esi)
80102abf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ac2:	89 46 10             	mov    %eax,0x10(%esi)
80102ac5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ac8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102acb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ad2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ad5:	5b                   	pop    %ebx
80102ad6:	5e                   	pop    %esi
80102ad7:	5f                   	pop    %edi
80102ad8:	5d                   	pop    %ebp
80102ad9:	c3                   	ret    
80102ada:	66 90                	xchg   %ax,%ax
80102adc:	66 90                	xchg   %ax,%ax
80102ade:	66 90                	xchg   %ax,%ax

80102ae0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ae0:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102ae6:	85 c9                	test   %ecx,%ecx
80102ae8:	0f 8e 8a 00 00 00    	jle    80102b78 <install_trans+0x98>
{
80102aee:	55                   	push   %ebp
80102aef:	89 e5                	mov    %esp,%ebp
80102af1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102af2:	31 ff                	xor    %edi,%edi
{
80102af4:	56                   	push   %esi
80102af5:	53                   	push   %ebx
80102af6:	83 ec 0c             	sub    $0xc,%esp
80102af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b00:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102b05:	83 ec 08             	sub    $0x8,%esp
80102b08:	01 f8                	add    %edi,%eax
80102b0a:	83 c0 01             	add    $0x1,%eax
80102b0d:	50                   	push   %eax
80102b0e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102b14:	e8 b7 d5 ff ff       	call   801000d0 <bread>
80102b19:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b1b:	58                   	pop    %eax
80102b1c:	5a                   	pop    %edx
80102b1d:	ff 34 bd cc 26 11 80 	pushl  -0x7feed934(,%edi,4)
80102b24:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b2a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b2d:	e8 9e d5 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b32:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b35:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b37:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b3a:	68 00 02 00 00       	push   $0x200
80102b3f:	50                   	push   %eax
80102b40:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102b43:	50                   	push   %eax
80102b44:	e8 07 1c 00 00       	call   80104750 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b49:	89 1c 24             	mov    %ebx,(%esp)
80102b4c:	e8 5f d6 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102b51:	89 34 24             	mov    %esi,(%esp)
80102b54:	e8 97 d6 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102b59:	89 1c 24             	mov    %ebx,(%esp)
80102b5c:	e8 8f d6 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b61:	83 c4 10             	add    $0x10,%esp
80102b64:	39 3d c8 26 11 80    	cmp    %edi,0x801126c8
80102b6a:	7f 94                	jg     80102b00 <install_trans+0x20>
  }
}
80102b6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b6f:	5b                   	pop    %ebx
80102b70:	5e                   	pop    %esi
80102b71:	5f                   	pop    %edi
80102b72:	5d                   	pop    %ebp
80102b73:	c3                   	ret    
80102b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b78:	c3                   	ret    
80102b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102b80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	53                   	push   %ebx
80102b84:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b87:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102b8d:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102b93:	e8 38 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b98:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b9b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102b9d:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102ba2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102ba5:	85 c0                	test   %eax,%eax
80102ba7:	7e 19                	jle    80102bc2 <write_head+0x42>
80102ba9:	31 d2                	xor    %edx,%edx
80102bab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102baf:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102bb0:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102bb7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102bbb:	83 c2 01             	add    $0x1,%edx
80102bbe:	39 d0                	cmp    %edx,%eax
80102bc0:	75 ee                	jne    80102bb0 <write_head+0x30>
  }
  bwrite(buf);
80102bc2:	83 ec 0c             	sub    $0xc,%esp
80102bc5:	53                   	push   %ebx
80102bc6:	e8 e5 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102bcb:	89 1c 24             	mov    %ebx,(%esp)
80102bce:	e8 1d d6 ff ff       	call   801001f0 <brelse>
}
80102bd3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bd6:	83 c4 10             	add    $0x10,%esp
80102bd9:	c9                   	leave  
80102bda:	c3                   	ret    
80102bdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102bdf:	90                   	nop

80102be0 <initlog>:
{
80102be0:	55                   	push   %ebp
80102be1:	89 e5                	mov    %esp,%ebp
80102be3:	53                   	push   %ebx
80102be4:	83 ec 2c             	sub    $0x2c,%esp
80102be7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bea:	68 c0 75 10 80       	push   $0x801075c0
80102bef:	68 80 26 11 80       	push   $0x80112680
80102bf4:	e8 47 18 00 00       	call   80104440 <initlock>
  readsb(dev, &sb);
80102bf9:	58                   	pop    %eax
80102bfa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bfd:	5a                   	pop    %edx
80102bfe:	50                   	push   %eax
80102bff:	53                   	push   %ebx
80102c00:	e8 5b e8 ff ff       	call   80101460 <readsb>
  log.start = sb.logstart;
80102c05:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102c08:	59                   	pop    %ecx
  log.dev = dev;
80102c09:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102c0f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102c12:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  log.size = sb.nlog;
80102c17:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  struct buf *buf = bread(log.dev, log.start);
80102c1d:	5a                   	pop    %edx
80102c1e:	50                   	push   %eax
80102c1f:	53                   	push   %ebx
80102c20:	e8 ab d4 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102c25:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102c28:	8b 48 5c             	mov    0x5c(%eax),%ecx
80102c2b:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102c31:	85 c9                	test   %ecx,%ecx
80102c33:	7e 1d                	jle    80102c52 <initlog+0x72>
80102c35:	31 d2                	xor    %edx,%edx
80102c37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c3e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102c40:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80102c44:	89 1c 95 cc 26 11 80 	mov    %ebx,-0x7feed934(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c4b:	83 c2 01             	add    $0x1,%edx
80102c4e:	39 d1                	cmp    %edx,%ecx
80102c50:	75 ee                	jne    80102c40 <initlog+0x60>
  brelse(buf);
80102c52:	83 ec 0c             	sub    $0xc,%esp
80102c55:	50                   	push   %eax
80102c56:	e8 95 d5 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c5b:	e8 80 fe ff ff       	call   80102ae0 <install_trans>
  log.lh.n = 0;
80102c60:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c67:	00 00 00 
  write_head(); // clear the log
80102c6a:	e8 11 ff ff ff       	call   80102b80 <write_head>
}
80102c6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c72:	83 c4 10             	add    $0x10,%esp
80102c75:	c9                   	leave  
80102c76:	c3                   	ret    
80102c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c7e:	66 90                	xchg   %ax,%ax

80102c80 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c80:	55                   	push   %ebp
80102c81:	89 e5                	mov    %esp,%ebp
80102c83:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c86:	68 80 26 11 80       	push   $0x80112680
80102c8b:	e8 b0 18 00 00       	call   80104540 <acquire>
80102c90:	83 c4 10             	add    $0x10,%esp
80102c93:	eb 18                	jmp    80102cad <begin_op+0x2d>
80102c95:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c98:	83 ec 08             	sub    $0x8,%esp
80102c9b:	68 80 26 11 80       	push   $0x80112680
80102ca0:	68 80 26 11 80       	push   $0x80112680
80102ca5:	e8 96 11 00 00       	call   80103e40 <sleep>
80102caa:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102cad:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102cb2:	85 c0                	test   %eax,%eax
80102cb4:	75 e2                	jne    80102c98 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cb6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102cbb:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102cc1:	83 c0 01             	add    $0x1,%eax
80102cc4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cc7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cca:	83 fa 1e             	cmp    $0x1e,%edx
80102ccd:	7f c9                	jg     80102c98 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102ccf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102cd2:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102cd7:	68 80 26 11 80       	push   $0x80112680
80102cdc:	e8 7f 19 00 00       	call   80104660 <release>
      break;
    }
  }
}
80102ce1:	83 c4 10             	add    $0x10,%esp
80102ce4:	c9                   	leave  
80102ce5:	c3                   	ret    
80102ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ced:	8d 76 00             	lea    0x0(%esi),%esi

80102cf0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102cf0:	55                   	push   %ebp
80102cf1:	89 e5                	mov    %esp,%ebp
80102cf3:	57                   	push   %edi
80102cf4:	56                   	push   %esi
80102cf5:	53                   	push   %ebx
80102cf6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102cf9:	68 80 26 11 80       	push   $0x80112680
80102cfe:	e8 3d 18 00 00       	call   80104540 <acquire>
  log.outstanding -= 1;
80102d03:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102d08:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102d0e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102d11:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102d14:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102d1a:	85 f6                	test   %esi,%esi
80102d1c:	0f 85 22 01 00 00    	jne    80102e44 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102d22:	85 db                	test   %ebx,%ebx
80102d24:	0f 85 f6 00 00 00    	jne    80102e20 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102d2a:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102d31:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d34:	83 ec 0c             	sub    $0xc,%esp
80102d37:	68 80 26 11 80       	push   $0x80112680
80102d3c:	e8 1f 19 00 00       	call   80104660 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d41:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102d47:	83 c4 10             	add    $0x10,%esp
80102d4a:	85 c9                	test   %ecx,%ecx
80102d4c:	7f 42                	jg     80102d90 <end_op+0xa0>
    acquire(&log.lock);
80102d4e:	83 ec 0c             	sub    $0xc,%esp
80102d51:	68 80 26 11 80       	push   $0x80112680
80102d56:	e8 e5 17 00 00       	call   80104540 <acquire>
    wakeup(&log);
80102d5b:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102d62:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d69:	00 00 00 
    wakeup(&log);
80102d6c:	e8 7f 12 00 00       	call   80103ff0 <wakeup>
    release(&log.lock);
80102d71:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d78:	e8 e3 18 00 00       	call   80104660 <release>
80102d7d:	83 c4 10             	add    $0x10,%esp
}
80102d80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d83:	5b                   	pop    %ebx
80102d84:	5e                   	pop    %esi
80102d85:	5f                   	pop    %edi
80102d86:	5d                   	pop    %ebp
80102d87:	c3                   	ret    
80102d88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d8f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d90:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102d95:	83 ec 08             	sub    $0x8,%esp
80102d98:	01 d8                	add    %ebx,%eax
80102d9a:	83 c0 01             	add    $0x1,%eax
80102d9d:	50                   	push   %eax
80102d9e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102da4:	e8 27 d3 ff ff       	call   801000d0 <bread>
80102da9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102dab:	58                   	pop    %eax
80102dac:	5a                   	pop    %edx
80102dad:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102db4:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102dba:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102dbd:	e8 0e d3 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102dc2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102dc5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102dc7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102dca:	68 00 02 00 00       	push   $0x200
80102dcf:	50                   	push   %eax
80102dd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102dd3:	50                   	push   %eax
80102dd4:	e8 77 19 00 00       	call   80104750 <memmove>
    bwrite(to);  // write the log
80102dd9:	89 34 24             	mov    %esi,(%esp)
80102ddc:	e8 cf d3 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102de1:	89 3c 24             	mov    %edi,(%esp)
80102de4:	e8 07 d4 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102de9:	89 34 24             	mov    %esi,(%esp)
80102dec:	e8 ff d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102df1:	83 c4 10             	add    $0x10,%esp
80102df4:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102dfa:	7c 94                	jl     80102d90 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dfc:	e8 7f fd ff ff       	call   80102b80 <write_head>
    install_trans(); // Now install writes to home locations
80102e01:	e8 da fc ff ff       	call   80102ae0 <install_trans>
    log.lh.n = 0;
80102e06:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102e0d:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e10:	e8 6b fd ff ff       	call   80102b80 <write_head>
80102e15:	e9 34 ff ff ff       	jmp    80102d4e <end_op+0x5e>
80102e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102e20:	83 ec 0c             	sub    $0xc,%esp
80102e23:	68 80 26 11 80       	push   $0x80112680
80102e28:	e8 c3 11 00 00       	call   80103ff0 <wakeup>
  release(&log.lock);
80102e2d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e34:	e8 27 18 00 00       	call   80104660 <release>
80102e39:	83 c4 10             	add    $0x10,%esp
}
80102e3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e3f:	5b                   	pop    %ebx
80102e40:	5e                   	pop    %esi
80102e41:	5f                   	pop    %edi
80102e42:	5d                   	pop    %ebp
80102e43:	c3                   	ret    
    panic("log.committing");
80102e44:	83 ec 0c             	sub    $0xc,%esp
80102e47:	68 c4 75 10 80       	push   $0x801075c4
80102e4c:	e8 2f d5 ff ff       	call   80100380 <panic>
80102e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e5f:	90                   	nop

80102e60 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e67:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102e6d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e70:	83 fa 1d             	cmp    $0x1d,%edx
80102e73:	0f 8f 85 00 00 00    	jg     80102efe <log_write+0x9e>
80102e79:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102e7e:	83 e8 01             	sub    $0x1,%eax
80102e81:	39 c2                	cmp    %eax,%edx
80102e83:	7d 79                	jge    80102efe <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e85:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102e8a:	85 c0                	test   %eax,%eax
80102e8c:	7e 7d                	jle    80102f0b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e8e:	83 ec 0c             	sub    $0xc,%esp
80102e91:	68 80 26 11 80       	push   $0x80112680
80102e96:	e8 a5 16 00 00       	call   80104540 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e9b:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102ea1:	83 c4 10             	add    $0x10,%esp
80102ea4:	85 d2                	test   %edx,%edx
80102ea6:	7e 4a                	jle    80102ef2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ea8:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102eab:	31 c0                	xor    %eax,%eax
80102ead:	eb 08                	jmp    80102eb7 <log_write+0x57>
80102eaf:	90                   	nop
80102eb0:	83 c0 01             	add    $0x1,%eax
80102eb3:	39 c2                	cmp    %eax,%edx
80102eb5:	74 29                	je     80102ee0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102eb7:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102ebe:	75 f0                	jne    80102eb0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102ec0:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102ec7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102eca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102ecd:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102ed4:	c9                   	leave  
  release(&log.lock);
80102ed5:	e9 86 17 00 00       	jmp    80104660 <release>
80102eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102ee0:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
    log.lh.n++;
80102ee7:	83 c2 01             	add    $0x1,%edx
80102eea:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
80102ef0:	eb d5                	jmp    80102ec7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80102ef2:	8b 43 08             	mov    0x8(%ebx),%eax
80102ef5:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102efa:	75 cb                	jne    80102ec7 <log_write+0x67>
80102efc:	eb e9                	jmp    80102ee7 <log_write+0x87>
    panic("too big a transaction");
80102efe:	83 ec 0c             	sub    $0xc,%esp
80102f01:	68 d3 75 10 80       	push   $0x801075d3
80102f06:	e8 75 d4 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102f0b:	83 ec 0c             	sub    $0xc,%esp
80102f0e:	68 e9 75 10 80       	push   $0x801075e9
80102f13:	e8 68 d4 ff ff       	call   80100380 <panic>
80102f18:	66 90                	xchg   %ax,%ax
80102f1a:	66 90                	xchg   %ax,%ax
80102f1c:	66 90                	xchg   %ax,%ax
80102f1e:	66 90                	xchg   %ax,%ax

80102f20 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	53                   	push   %ebx
80102f24:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f27:	e8 34 09 00 00       	call   80103860 <cpuid>
80102f2c:	89 c3                	mov    %eax,%ebx
80102f2e:	e8 2d 09 00 00       	call   80103860 <cpuid>
80102f33:	83 ec 04             	sub    $0x4,%esp
80102f36:	53                   	push   %ebx
80102f37:	50                   	push   %eax
80102f38:	68 04 76 10 80       	push   $0x80107604
80102f3d:	e8 5e d7 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80102f42:	e8 39 2a 00 00       	call   80105980 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f47:	e8 a4 08 00 00       	call   801037f0 <mycpu>
80102f4c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f4e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f5a:	e8 e1 0b 00 00       	call   80103b40 <scheduler>
80102f5f:	90                   	nop

80102f60 <mpenter>:
{
80102f60:	55                   	push   %ebp
80102f61:	89 e5                	mov    %esp,%ebp
80102f63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f66:	e8 e5 3a 00 00       	call   80106a50 <switchkvm>
  seginit();
80102f6b:	e8 50 3a 00 00       	call   801069c0 <seginit>
  lapicinit();
80102f70:	e8 9b f7 ff ff       	call   80102710 <lapicinit>
  mpmain();
80102f75:	e8 a6 ff ff ff       	call   80102f20 <mpmain>
80102f7a:	66 90                	xchg   %ax,%ax
80102f7c:	66 90                	xchg   %ax,%ax
80102f7e:	66 90                	xchg   %ax,%ax

80102f80 <main>:
{
80102f80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f84:	83 e4 f0             	and    $0xfffffff0,%esp
80102f87:	ff 71 fc             	pushl  -0x4(%ecx)
80102f8a:	55                   	push   %ebp
80102f8b:	89 e5                	mov    %esp,%ebp
80102f8d:	53                   	push   %ebx
80102f8e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f8f:	83 ec 08             	sub    $0x8,%esp
80102f92:	68 00 00 40 80       	push   $0x80400000
80102f97:	68 a8 55 11 80       	push   $0x801155a8
80102f9c:	e8 2f f5 ff ff       	call   801024d0 <kinit1>
  kvmalloc();      // kernel page table
80102fa1:	e8 6a 3f 00 00       	call   80106f10 <kvmalloc>
  mpinit();        // detect other processors
80102fa6:	e8 85 01 00 00       	call   80103130 <mpinit>
  lapicinit();     // interrupt controller
80102fab:	e8 60 f7 ff ff       	call   80102710 <lapicinit>
  seginit();       // segment descriptors
80102fb0:	e8 0b 3a 00 00       	call   801069c0 <seginit>
  picinit();       // disable pic
80102fb5:	e8 46 03 00 00       	call   80103300 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
  consoleinit();   // console hardware
80102fbf:	e8 5c da ff ff       	call   80100a20 <consoleinit>
  uartinit();      // serial port
80102fc4:	e8 b7 2c 00 00       	call   80105c80 <uartinit>
  pinit();         // process table
80102fc9:	e8 02 08 00 00       	call   801037d0 <pinit>
  tvinit();        // trap vectors
80102fce:	e8 2d 29 00 00       	call   80105900 <tvinit>
  binit();         // buffer cache
80102fd3:	e8 68 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fd8:	e8 03 de ff ff       	call   80100de0 <fileinit>
  ideinit();       // disk 
80102fdd:	e8 fe f0 ff ff       	call   801020e0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fe2:	83 c4 0c             	add    $0xc,%esp
80102fe5:	68 8a 00 00 00       	push   $0x8a
80102fea:	68 8c a4 10 80       	push   $0x8010a48c
80102fef:	68 00 70 00 80       	push   $0x80007000
80102ff4:	e8 57 17 00 00       	call   80104750 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102ff9:	83 c4 10             	add    $0x10,%esp
80102ffc:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103003:	00 00 00 
80103006:	05 80 27 11 80       	add    $0x80112780,%eax
8010300b:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80103010:	76 7e                	jbe    80103090 <main+0x110>
80103012:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80103017:	eb 20                	jmp    80103039 <main+0xb9>
80103019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103020:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103027:	00 00 00 
8010302a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103030:	05 80 27 11 80       	add    $0x80112780,%eax
80103035:	39 c3                	cmp    %eax,%ebx
80103037:	73 57                	jae    80103090 <main+0x110>
    if(c == mycpu())  // We've started already.
80103039:	e8 b2 07 00 00       	call   801037f0 <mycpu>
8010303e:	39 c3                	cmp    %eax,%ebx
80103040:	74 de                	je     80103020 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103042:	e8 59 f5 ff ff       	call   801025a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103047:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
8010304a:	c7 05 f8 6f 00 80 60 	movl   $0x80102f60,0x80006ff8
80103051:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103054:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010305b:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010305e:	05 00 10 00 00       	add    $0x1000,%eax
80103063:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103068:	0f b6 03             	movzbl (%ebx),%eax
8010306b:	68 00 70 00 00       	push   $0x7000
80103070:	50                   	push   %eax
80103071:	e8 ea f7 ff ff       	call   80102860 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103076:	83 c4 10             	add    $0x10,%esp
80103079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103080:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103086:	85 c0                	test   %eax,%eax
80103088:	74 f6                	je     80103080 <main+0x100>
8010308a:	eb 94                	jmp    80103020 <main+0xa0>
8010308c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103090:	83 ec 08             	sub    $0x8,%esp
80103093:	68 00 00 00 8e       	push   $0x8e000000
80103098:	68 00 00 40 80       	push   $0x80400000
8010309d:	e8 9e f4 ff ff       	call   80102540 <kinit2>
  userinit();      // first user process
801030a2:	e8 09 08 00 00       	call   801038b0 <userinit>
  mpmain();        // finish this processor's setup
801030a7:	e8 74 fe ff ff       	call   80102f20 <mpmain>
801030ac:	66 90                	xchg   %ax,%ax
801030ae:	66 90                	xchg   %ax,%ax

801030b0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030b0:	55                   	push   %ebp
801030b1:	89 e5                	mov    %esp,%ebp
801030b3:	57                   	push   %edi
801030b4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030b5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801030bb:	53                   	push   %ebx
  e = addr+len;
801030bc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801030bf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801030c2:	39 de                	cmp    %ebx,%esi
801030c4:	72 10                	jb     801030d6 <mpsearch1+0x26>
801030c6:	eb 50                	jmp    80103118 <mpsearch1+0x68>
801030c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030cf:	90                   	nop
801030d0:	89 fe                	mov    %edi,%esi
801030d2:	39 fb                	cmp    %edi,%ebx
801030d4:	76 42                	jbe    80103118 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030d6:	83 ec 04             	sub    $0x4,%esp
801030d9:	8d 7e 10             	lea    0x10(%esi),%edi
801030dc:	6a 04                	push   $0x4
801030de:	68 18 76 10 80       	push   $0x80107618
801030e3:	56                   	push   %esi
801030e4:	e8 17 16 00 00       	call   80104700 <memcmp>
801030e9:	83 c4 10             	add    $0x10,%esp
801030ec:	85 c0                	test   %eax,%eax
801030ee:	75 e0                	jne    801030d0 <mpsearch1+0x20>
801030f0:	89 f2                	mov    %esi,%edx
801030f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801030f8:	0f b6 0a             	movzbl (%edx),%ecx
801030fb:	83 c2 01             	add    $0x1,%edx
801030fe:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103100:	39 fa                	cmp    %edi,%edx
80103102:	75 f4                	jne    801030f8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103104:	84 c0                	test   %al,%al
80103106:	75 c8                	jne    801030d0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103108:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010310b:	89 f0                	mov    %esi,%eax
8010310d:	5b                   	pop    %ebx
8010310e:	5e                   	pop    %esi
8010310f:	5f                   	pop    %edi
80103110:	5d                   	pop    %ebp
80103111:	c3                   	ret    
80103112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103118:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010311b:	31 f6                	xor    %esi,%esi
}
8010311d:	5b                   	pop    %ebx
8010311e:	89 f0                	mov    %esi,%eax
80103120:	5e                   	pop    %esi
80103121:	5f                   	pop    %edi
80103122:	5d                   	pop    %ebp
80103123:	c3                   	ret    
80103124:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010312b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010312f:	90                   	nop

80103130 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	57                   	push   %edi
80103134:	56                   	push   %esi
80103135:	53                   	push   %ebx
80103136:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103139:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103140:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103147:	c1 e0 08             	shl    $0x8,%eax
8010314a:	09 d0                	or     %edx,%eax
8010314c:	c1 e0 04             	shl    $0x4,%eax
8010314f:	75 1b                	jne    8010316c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103151:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103158:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010315f:	c1 e0 08             	shl    $0x8,%eax
80103162:	09 d0                	or     %edx,%eax
80103164:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103167:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010316c:	ba 00 04 00 00       	mov    $0x400,%edx
80103171:	e8 3a ff ff ff       	call   801030b0 <mpsearch1>
80103176:	89 c6                	mov    %eax,%esi
80103178:	85 c0                	test   %eax,%eax
8010317a:	0f 84 40 01 00 00    	je     801032c0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103180:	8b 5e 04             	mov    0x4(%esi),%ebx
80103183:	85 db                	test   %ebx,%ebx
80103185:	0f 84 55 01 00 00    	je     801032e0 <mpinit+0x1b0>
  if(memcmp(conf, "PCMP", 4) != 0)
8010318b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010318e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103194:	6a 04                	push   $0x4
80103196:	68 1d 76 10 80       	push   $0x8010761d
8010319b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010319c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010319f:	e8 5c 15 00 00       	call   80104700 <memcmp>
801031a4:	83 c4 10             	add    $0x10,%esp
801031a7:	85 c0                	test   %eax,%eax
801031a9:	0f 85 31 01 00 00    	jne    801032e0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801031af:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031b6:	3c 01                	cmp    $0x1,%al
801031b8:	74 08                	je     801031c2 <mpinit+0x92>
801031ba:	3c 04                	cmp    $0x4,%al
801031bc:	0f 85 1e 01 00 00    	jne    801032e0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801031c2:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
801031c9:	66 85 d2             	test   %dx,%dx
801031cc:	74 22                	je     801031f0 <mpinit+0xc0>
801031ce:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
801031d1:	89 d8                	mov    %ebx,%eax
  sum = 0;
801031d3:	31 d2                	xor    %edx,%edx
801031d5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801031d8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
801031df:	83 c0 01             	add    $0x1,%eax
801031e2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801031e4:	39 f8                	cmp    %edi,%eax
801031e6:	75 f0                	jne    801031d8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801031e8:	84 d2                	test   %dl,%dl
801031ea:	0f 85 f0 00 00 00    	jne    801032e0 <mpinit+0x1b0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031f0:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031f6:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031fb:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103201:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
80103208:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010320d:	03 55 e4             	add    -0x1c(%ebp),%edx
80103210:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103213:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103217:	90                   	nop
80103218:	39 c2                	cmp    %eax,%edx
8010321a:	76 15                	jbe    80103231 <mpinit+0x101>
    switch(*p){
8010321c:	0f b6 08             	movzbl (%eax),%ecx
8010321f:	80 f9 02             	cmp    $0x2,%cl
80103222:	74 54                	je     80103278 <mpinit+0x148>
80103224:	77 3a                	ja     80103260 <mpinit+0x130>
80103226:	84 c9                	test   %cl,%cl
80103228:	74 66                	je     80103290 <mpinit+0x160>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010322a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010322d:	39 c2                	cmp    %eax,%edx
8010322f:	77 eb                	ja     8010321c <mpinit+0xec>
80103231:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103234:	85 db                	test   %ebx,%ebx
80103236:	0f 84 b1 00 00 00    	je     801032ed <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010323c:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103240:	74 15                	je     80103257 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103242:	b8 70 00 00 00       	mov    $0x70,%eax
80103247:	ba 22 00 00 00       	mov    $0x22,%edx
8010324c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010324d:	ba 23 00 00 00       	mov    $0x23,%edx
80103252:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103253:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103256:	ee                   	out    %al,(%dx)
  }
}
80103257:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010325a:	5b                   	pop    %ebx
8010325b:	5e                   	pop    %esi
8010325c:	5f                   	pop    %edi
8010325d:	5d                   	pop    %ebp
8010325e:	c3                   	ret    
8010325f:	90                   	nop
    switch(*p){
80103260:	83 e9 03             	sub    $0x3,%ecx
80103263:	80 f9 01             	cmp    $0x1,%cl
80103266:	76 c2                	jbe    8010322a <mpinit+0xfa>
80103268:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010326f:	eb a7                	jmp    80103218 <mpinit+0xe8>
80103271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103278:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
8010327c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010327f:	88 0d 60 27 11 80    	mov    %cl,0x80112760
      continue;
80103285:	eb 91                	jmp    80103218 <mpinit+0xe8>
80103287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010328e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103290:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
80103296:	83 f9 07             	cmp    $0x7,%ecx
80103299:	7f 19                	jg     801032b4 <mpinit+0x184>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010329b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
801032a1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
801032a5:	83 c1 01             	add    $0x1,%ecx
801032a8:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801032ae:	88 9f 80 27 11 80    	mov    %bl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
801032b4:	83 c0 14             	add    $0x14,%eax
      continue;
801032b7:	e9 5c ff ff ff       	jmp    80103218 <mpinit+0xe8>
801032bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
801032c0:	ba 00 00 01 00       	mov    $0x10000,%edx
801032c5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032ca:	e8 e1 fd ff ff       	call   801030b0 <mpsearch1>
801032cf:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032d1:	85 c0                	test   %eax,%eax
801032d3:	0f 85 a7 fe ff ff    	jne    80103180 <mpinit+0x50>
801032d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801032e0:	83 ec 0c             	sub    $0xc,%esp
801032e3:	68 22 76 10 80       	push   $0x80107622
801032e8:	e8 93 d0 ff ff       	call   80100380 <panic>
    panic("Didn't find a suitable machine");
801032ed:	83 ec 0c             	sub    $0xc,%esp
801032f0:	68 3c 76 10 80       	push   $0x8010763c
801032f5:	e8 86 d0 ff ff       	call   80100380 <panic>
801032fa:	66 90                	xchg   %ax,%ax
801032fc:	66 90                	xchg   %ax,%ax
801032fe:	66 90                	xchg   %ax,%ax

80103300 <picinit>:
80103300:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103305:	ba 21 00 00 00       	mov    $0x21,%edx
8010330a:	ee                   	out    %al,(%dx)
8010330b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103310:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103311:	c3                   	ret    
80103312:	66 90                	xchg   %ax,%ax
80103314:	66 90                	xchg   %ax,%ax
80103316:	66 90                	xchg   %ax,%ax
80103318:	66 90                	xchg   %ax,%ax
8010331a:	66 90                	xchg   %ax,%ax
8010331c:	66 90                	xchg   %ax,%ax
8010331e:	66 90                	xchg   %ax,%ax

80103320 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103320:	55                   	push   %ebp
80103321:	89 e5                	mov    %esp,%ebp
80103323:	57                   	push   %edi
80103324:	56                   	push   %esi
80103325:	53                   	push   %ebx
80103326:	83 ec 0c             	sub    $0xc,%esp
80103329:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010332c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010332f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103335:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010333b:	e8 c0 da ff ff       	call   80100e00 <filealloc>
80103340:	89 03                	mov    %eax,(%ebx)
80103342:	85 c0                	test   %eax,%eax
80103344:	0f 84 a8 00 00 00    	je     801033f2 <pipealloc+0xd2>
8010334a:	e8 b1 da ff ff       	call   80100e00 <filealloc>
8010334f:	89 06                	mov    %eax,(%esi)
80103351:	85 c0                	test   %eax,%eax
80103353:	0f 84 87 00 00 00    	je     801033e0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103359:	e8 42 f2 ff ff       	call   801025a0 <kalloc>
8010335e:	89 c7                	mov    %eax,%edi
80103360:	85 c0                	test   %eax,%eax
80103362:	0f 84 b0 00 00 00    	je     80103418 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103368:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010336f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103372:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103375:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010337c:	00 00 00 
  p->nwrite = 0;
8010337f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103386:	00 00 00 
  p->nread = 0;
80103389:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103390:	00 00 00 
  initlock(&p->lock, "pipe");
80103393:	68 5b 76 10 80       	push   $0x8010765b
80103398:	50                   	push   %eax
80103399:	e8 a2 10 00 00       	call   80104440 <initlock>
  (*f0)->type = FD_PIPE;
8010339e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033a0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801033a3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033a9:	8b 03                	mov    (%ebx),%eax
801033ab:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033af:	8b 03                	mov    (%ebx),%eax
801033b1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033b5:	8b 03                	mov    (%ebx),%eax
801033b7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033ba:	8b 06                	mov    (%esi),%eax
801033bc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033c2:	8b 06                	mov    (%esi),%eax
801033c4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801033c8:	8b 06                	mov    (%esi),%eax
801033ca:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801033ce:	8b 06                	mov    (%esi),%eax
801033d0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801033d6:	31 c0                	xor    %eax,%eax
}
801033d8:	5b                   	pop    %ebx
801033d9:	5e                   	pop    %esi
801033da:	5f                   	pop    %edi
801033db:	5d                   	pop    %ebp
801033dc:	c3                   	ret    
801033dd:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
801033e0:	8b 03                	mov    (%ebx),%eax
801033e2:	85 c0                	test   %eax,%eax
801033e4:	74 1e                	je     80103404 <pipealloc+0xe4>
    fileclose(*f0);
801033e6:	83 ec 0c             	sub    $0xc,%esp
801033e9:	50                   	push   %eax
801033ea:	e8 d1 da ff ff       	call   80100ec0 <fileclose>
801033ef:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801033f2:	8b 06                	mov    (%esi),%eax
801033f4:	85 c0                	test   %eax,%eax
801033f6:	74 0c                	je     80103404 <pipealloc+0xe4>
    fileclose(*f1);
801033f8:	83 ec 0c             	sub    $0xc,%esp
801033fb:	50                   	push   %eax
801033fc:	e8 bf da ff ff       	call   80100ec0 <fileclose>
80103401:	83 c4 10             	add    $0x10,%esp
}
80103404:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103407:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010340c:	5b                   	pop    %ebx
8010340d:	5e                   	pop    %esi
8010340e:	5f                   	pop    %edi
8010340f:	5d                   	pop    %ebp
80103410:	c3                   	ret    
80103411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103418:	8b 03                	mov    (%ebx),%eax
8010341a:	85 c0                	test   %eax,%eax
8010341c:	75 c8                	jne    801033e6 <pipealloc+0xc6>
8010341e:	eb d2                	jmp    801033f2 <pipealloc+0xd2>

80103420 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103420:	55                   	push   %ebp
80103421:	89 e5                	mov    %esp,%ebp
80103423:	56                   	push   %esi
80103424:	53                   	push   %ebx
80103425:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103428:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010342b:	83 ec 0c             	sub    $0xc,%esp
8010342e:	53                   	push   %ebx
8010342f:	e8 0c 11 00 00       	call   80104540 <acquire>
  if(writable){
80103434:	83 c4 10             	add    $0x10,%esp
80103437:	85 f6                	test   %esi,%esi
80103439:	74 45                	je     80103480 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010343b:	83 ec 0c             	sub    $0xc,%esp
8010343e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103444:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010344b:	00 00 00 
    wakeup(&p->nread);
8010344e:	50                   	push   %eax
8010344f:	e8 9c 0b 00 00       	call   80103ff0 <wakeup>
80103454:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103457:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010345d:	85 d2                	test   %edx,%edx
8010345f:	75 0a                	jne    8010346b <pipeclose+0x4b>
80103461:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103467:	85 c0                	test   %eax,%eax
80103469:	74 35                	je     801034a0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010346b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010346e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103471:	5b                   	pop    %ebx
80103472:	5e                   	pop    %esi
80103473:	5d                   	pop    %ebp
    release(&p->lock);
80103474:	e9 e7 11 00 00       	jmp    80104660 <release>
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103480:	83 ec 0c             	sub    $0xc,%esp
80103483:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103489:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103490:	00 00 00 
    wakeup(&p->nwrite);
80103493:	50                   	push   %eax
80103494:	e8 57 0b 00 00       	call   80103ff0 <wakeup>
80103499:	83 c4 10             	add    $0x10,%esp
8010349c:	eb b9                	jmp    80103457 <pipeclose+0x37>
8010349e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801034a0:	83 ec 0c             	sub    $0xc,%esp
801034a3:	53                   	push   %ebx
801034a4:	e8 b7 11 00 00       	call   80104660 <release>
    kfree((char*)p);
801034a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034ac:	83 c4 10             	add    $0x10,%esp
}
801034af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034b2:	5b                   	pop    %ebx
801034b3:	5e                   	pop    %esi
801034b4:	5d                   	pop    %ebp
    kfree((char*)p);
801034b5:	e9 26 ef ff ff       	jmp    801023e0 <kfree>
801034ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034c0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	57                   	push   %edi
801034c4:	56                   	push   %esi
801034c5:	53                   	push   %ebx
801034c6:	83 ec 28             	sub    $0x28,%esp
801034c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034cc:	53                   	push   %ebx
801034cd:	e8 6e 10 00 00       	call   80104540 <acquire>
  for(i = 0; i < n; i++){
801034d2:	8b 45 10             	mov    0x10(%ebp),%eax
801034d5:	83 c4 10             	add    $0x10,%esp
801034d8:	85 c0                	test   %eax,%eax
801034da:	0f 8e c0 00 00 00    	jle    801035a0 <pipewrite+0xe0>
801034e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801034e3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034e9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801034ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801034f2:	03 45 10             	add    0x10(%ebp),%eax
801034f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034f8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034fe:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103504:	89 ca                	mov    %ecx,%edx
80103506:	05 00 02 00 00       	add    $0x200,%eax
8010350b:	39 c1                	cmp    %eax,%ecx
8010350d:	74 3f                	je     8010354e <pipewrite+0x8e>
8010350f:	eb 67                	jmp    80103578 <pipewrite+0xb8>
80103511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103518:	e8 63 03 00 00       	call   80103880 <myproc>
8010351d:	8b 48 24             	mov    0x24(%eax),%ecx
80103520:	85 c9                	test   %ecx,%ecx
80103522:	75 34                	jne    80103558 <pipewrite+0x98>
      wakeup(&p->nread);
80103524:	83 ec 0c             	sub    $0xc,%esp
80103527:	57                   	push   %edi
80103528:	e8 c3 0a 00 00       	call   80103ff0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010352d:	58                   	pop    %eax
8010352e:	5a                   	pop    %edx
8010352f:	53                   	push   %ebx
80103530:	56                   	push   %esi
80103531:	e8 0a 09 00 00       	call   80103e40 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103536:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010353c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103542:	83 c4 10             	add    $0x10,%esp
80103545:	05 00 02 00 00       	add    $0x200,%eax
8010354a:	39 c2                	cmp    %eax,%edx
8010354c:	75 2a                	jne    80103578 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010354e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103554:	85 c0                	test   %eax,%eax
80103556:	75 c0                	jne    80103518 <pipewrite+0x58>
        release(&p->lock);
80103558:	83 ec 0c             	sub    $0xc,%esp
8010355b:	53                   	push   %ebx
8010355c:	e8 ff 10 00 00       	call   80104660 <release>
        return -1;
80103561:	83 c4 10             	add    $0x10,%esp
80103564:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103569:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010356c:	5b                   	pop    %ebx
8010356d:	5e                   	pop    %esi
8010356e:	5f                   	pop    %edi
8010356f:	5d                   	pop    %ebp
80103570:	c3                   	ret    
80103571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103578:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010357b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010357e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103584:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010358a:	0f b6 06             	movzbl (%esi),%eax
8010358d:	83 c6 01             	add    $0x1,%esi
80103590:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103593:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103597:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010359a:	0f 85 58 ff ff ff    	jne    801034f8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035a0:	83 ec 0c             	sub    $0xc,%esp
801035a3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801035a9:	50                   	push   %eax
801035aa:	e8 41 0a 00 00       	call   80103ff0 <wakeup>
  release(&p->lock);
801035af:	89 1c 24             	mov    %ebx,(%esp)
801035b2:	e8 a9 10 00 00       	call   80104660 <release>
  return n;
801035b7:	8b 45 10             	mov    0x10(%ebp),%eax
801035ba:	83 c4 10             	add    $0x10,%esp
801035bd:	eb aa                	jmp    80103569 <pipewrite+0xa9>
801035bf:	90                   	nop

801035c0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801035c0:	55                   	push   %ebp
801035c1:	89 e5                	mov    %esp,%ebp
801035c3:	57                   	push   %edi
801035c4:	56                   	push   %esi
801035c5:	53                   	push   %ebx
801035c6:	83 ec 18             	sub    $0x18,%esp
801035c9:	8b 75 08             	mov    0x8(%ebp),%esi
801035cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035cf:	56                   	push   %esi
801035d0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801035d6:	e8 65 0f 00 00       	call   80104540 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035db:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801035e1:	83 c4 10             	add    $0x10,%esp
801035e4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801035ea:	74 2f                	je     8010361b <piperead+0x5b>
801035ec:	eb 37                	jmp    80103625 <piperead+0x65>
801035ee:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801035f0:	e8 8b 02 00 00       	call   80103880 <myproc>
801035f5:	8b 48 24             	mov    0x24(%eax),%ecx
801035f8:	85 c9                	test   %ecx,%ecx
801035fa:	0f 85 80 00 00 00    	jne    80103680 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103600:	83 ec 08             	sub    $0x8,%esp
80103603:	56                   	push   %esi
80103604:	53                   	push   %ebx
80103605:	e8 36 08 00 00       	call   80103e40 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010360a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103610:	83 c4 10             	add    $0x10,%esp
80103613:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103619:	75 0a                	jne    80103625 <piperead+0x65>
8010361b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103621:	85 c0                	test   %eax,%eax
80103623:	75 cb                	jne    801035f0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103625:	8b 55 10             	mov    0x10(%ebp),%edx
80103628:	31 db                	xor    %ebx,%ebx
8010362a:	85 d2                	test   %edx,%edx
8010362c:	7f 20                	jg     8010364e <piperead+0x8e>
8010362e:	eb 2c                	jmp    8010365c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103630:	8d 48 01             	lea    0x1(%eax),%ecx
80103633:	25 ff 01 00 00       	and    $0x1ff,%eax
80103638:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010363e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103643:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103646:	83 c3 01             	add    $0x1,%ebx
80103649:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010364c:	74 0e                	je     8010365c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010364e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103654:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010365a:	75 d4                	jne    80103630 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010365c:	83 ec 0c             	sub    $0xc,%esp
8010365f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103665:	50                   	push   %eax
80103666:	e8 85 09 00 00       	call   80103ff0 <wakeup>
  release(&p->lock);
8010366b:	89 34 24             	mov    %esi,(%esp)
8010366e:	e8 ed 0f 00 00       	call   80104660 <release>
  return i;
80103673:	83 c4 10             	add    $0x10,%esp
}
80103676:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103679:	89 d8                	mov    %ebx,%eax
8010367b:	5b                   	pop    %ebx
8010367c:	5e                   	pop    %esi
8010367d:	5f                   	pop    %edi
8010367e:	5d                   	pop    %ebp
8010367f:	c3                   	ret    
      release(&p->lock);
80103680:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103683:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103688:	56                   	push   %esi
80103689:	e8 d2 0f 00 00       	call   80104660 <release>
      return -1;
8010368e:	83 c4 10             	add    $0x10,%esp
}
80103691:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103694:	89 d8                	mov    %ebx,%eax
80103696:	5b                   	pop    %ebx
80103697:	5e                   	pop    %esi
80103698:	5f                   	pop    %edi
80103699:	5d                   	pop    %ebp
8010369a:	c3                   	ret    
8010369b:	66 90                	xchg   %ax,%ax
8010369d:	66 90                	xchg   %ax,%ax
8010369f:	90                   	nop

801036a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036a4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801036a9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801036ac:	68 20 2d 11 80       	push   $0x80112d20
801036b1:	e8 8a 0e 00 00       	call   80104540 <acquire>
801036b6:	83 c4 10             	add    $0x10,%esp
801036b9:	eb 14                	jmp    801036cf <allocproc+0x2f>
801036bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036bf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036c0:	83 eb 80             	sub    $0xffffff80,%ebx
801036c3:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
801036c9:	0f 84 81 00 00 00    	je     80103750 <allocproc+0xb0>
    if(p->state == UNUSED)
801036cf:	8b 43 0c             	mov    0xc(%ebx),%eax
801036d2:	85 c0                	test   %eax,%eax
801036d4:	75 ea                	jne    801036c0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801036d6:	a1 04 a0 10 80       	mov    0x8010a004,%eax
  p->priority = 10;	//default priority

  release(&ptable.lock);
801036db:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801036de:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority = 10;	//default priority
801036e5:	c7 43 7c 0a 00 00 00 	movl   $0xa,0x7c(%ebx)
  p->pid = nextpid++;
801036ec:	89 43 10             	mov    %eax,0x10(%ebx)
801036ef:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801036f2:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
801036f7:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
801036fd:	e8 5e 0f 00 00       	call   80104660 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103702:	e8 99 ee ff ff       	call   801025a0 <kalloc>
80103707:	83 c4 10             	add    $0x10,%esp
8010370a:	89 43 08             	mov    %eax,0x8(%ebx)
8010370d:	85 c0                	test   %eax,%eax
8010370f:	74 58                	je     80103769 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103711:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103717:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010371a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010371f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103722:	c7 40 14 ef 58 10 80 	movl   $0x801058ef,0x14(%eax)
  p->context = (struct context*)sp;
80103729:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010372c:	6a 14                	push   $0x14
8010372e:	6a 00                	push   $0x0
80103730:	50                   	push   %eax
80103731:	e8 7a 0f 00 00       	call   801046b0 <memset>
  p->context->eip = (uint)forkret;
80103736:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103739:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010373c:	c7 40 10 80 37 10 80 	movl   $0x80103780,0x10(%eax)
}
80103743:	89 d8                	mov    %ebx,%eax
80103745:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103748:	c9                   	leave  
80103749:	c3                   	ret    
8010374a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103750:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103753:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103755:	68 20 2d 11 80       	push   $0x80112d20
8010375a:	e8 01 0f 00 00       	call   80104660 <release>
}
8010375f:	89 d8                	mov    %ebx,%eax
  return 0;
80103761:	83 c4 10             	add    $0x10,%esp
}
80103764:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103767:	c9                   	leave  
80103768:	c3                   	ret    
    p->state = UNUSED;
80103769:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103770:	31 db                	xor    %ebx,%ebx
}
80103772:	89 d8                	mov    %ebx,%eax
80103774:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103777:	c9                   	leave  
80103778:	c3                   	ret    
80103779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103780 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103786:	68 20 2d 11 80       	push   $0x80112d20
8010378b:	e8 d0 0e 00 00       	call   80104660 <release>

  if (first) {
80103790:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103795:	83 c4 10             	add    $0x10,%esp
80103798:	85 c0                	test   %eax,%eax
8010379a:	75 04                	jne    801037a0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010379c:	c9                   	leave  
8010379d:	c3                   	ret    
8010379e:	66 90                	xchg   %ax,%ax
    first = 0;
801037a0:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801037a7:	00 00 00 
    iinit(ROOTDEV);
801037aa:	83 ec 0c             	sub    $0xc,%esp
801037ad:	6a 01                	push   $0x1
801037af:	e8 6c dd ff ff       	call   80101520 <iinit>
    initlog(ROOTDEV);
801037b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037bb:	e8 20 f4 ff ff       	call   80102be0 <initlog>
}
801037c0:	83 c4 10             	add    $0x10,%esp
801037c3:	c9                   	leave  
801037c4:	c3                   	ret    
801037c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037d0 <pinit>:
{
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp
801037d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801037d6:	68 60 76 10 80       	push   $0x80107660
801037db:	68 20 2d 11 80       	push   $0x80112d20
801037e0:	e8 5b 0c 00 00       	call   80104440 <initlock>
}
801037e5:	83 c4 10             	add    $0x10,%esp
801037e8:	c9                   	leave  
801037e9:	c3                   	ret    
801037ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801037f0 <mycpu>:
{
801037f0:	55                   	push   %ebp
801037f1:	89 e5                	mov    %esp,%ebp
801037f3:	56                   	push   %esi
801037f4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801037f5:	9c                   	pushf  
801037f6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801037f7:	f6 c4 02             	test   $0x2,%ah
801037fa:	75 4e                	jne    8010384a <mycpu+0x5a>
  apicid = lapicid();
801037fc:	e8 0f f0 ff ff       	call   80102810 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103801:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
  apicid = lapicid();
80103807:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103809:	85 f6                	test   %esi,%esi
8010380b:	7e 30                	jle    8010383d <mycpu+0x4d>
8010380d:	31 d2                	xor    %edx,%edx
8010380f:	eb 0e                	jmp    8010381f <mycpu+0x2f>
80103811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103818:	83 c2 01             	add    $0x1,%edx
8010381b:	39 f2                	cmp    %esi,%edx
8010381d:	74 1e                	je     8010383d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
8010381f:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103825:	0f b6 81 80 27 11 80 	movzbl -0x7feed880(%ecx),%eax
8010382c:	39 d8                	cmp    %ebx,%eax
8010382e:	75 e8                	jne    80103818 <mycpu+0x28>
}
80103830:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103833:	8d 81 80 27 11 80    	lea    -0x7feed880(%ecx),%eax
}
80103839:	5b                   	pop    %ebx
8010383a:	5e                   	pop    %esi
8010383b:	5d                   	pop    %ebp
8010383c:	c3                   	ret    
  panic("unknown apicid\n");
8010383d:	83 ec 0c             	sub    $0xc,%esp
80103840:	68 67 76 10 80       	push   $0x80107667
80103845:	e8 36 cb ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
8010384a:	83 ec 0c             	sub    $0xc,%esp
8010384d:	68 cc 77 10 80       	push   $0x801077cc
80103852:	e8 29 cb ff ff       	call   80100380 <panic>
80103857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010385e:	66 90                	xchg   %ax,%ax

80103860 <cpuid>:
cpuid() {
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103866:	e8 85 ff ff ff       	call   801037f0 <mycpu>
}
8010386b:	c9                   	leave  
  return mycpu()-cpus;
8010386c:	2d 80 27 11 80       	sub    $0x80112780,%eax
80103871:	c1 f8 04             	sar    $0x4,%eax
80103874:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010387a:	c3                   	ret    
8010387b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010387f:	90                   	nop

80103880 <myproc>:
myproc(void) {
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	53                   	push   %ebx
80103884:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103887:	e8 64 0c 00 00       	call   801044f0 <pushcli>
  c = mycpu();
8010388c:	e8 5f ff ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103891:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103897:	e8 64 0d 00 00       	call   80104600 <popcli>
}
8010389c:	83 c4 04             	add    $0x4,%esp
8010389f:	89 d8                	mov    %ebx,%eax
801038a1:	5b                   	pop    %ebx
801038a2:	5d                   	pop    %ebp
801038a3:	c3                   	ret    
801038a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038af:	90                   	nop

801038b0 <userinit>:
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	53                   	push   %ebx
801038b4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038b7:	e8 e4 fd ff ff       	call   801036a0 <allocproc>
801038bc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038be:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801038c3:	e8 c8 35 00 00       	call   80106e90 <setupkvm>
801038c8:	89 43 04             	mov    %eax,0x4(%ebx)
801038cb:	85 c0                	test   %eax,%eax
801038cd:	0f 84 bd 00 00 00    	je     80103990 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038d3:	83 ec 04             	sub    $0x4,%esp
801038d6:	68 2c 00 00 00       	push   $0x2c
801038db:	68 60 a4 10 80       	push   $0x8010a460
801038e0:	50                   	push   %eax
801038e1:	e8 8a 32 00 00       	call   80106b70 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801038e6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801038e9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801038ef:	6a 4c                	push   $0x4c
801038f1:	6a 00                	push   $0x0
801038f3:	ff 73 18             	pushl  0x18(%ebx)
801038f6:	e8 b5 0d 00 00       	call   801046b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038fb:	8b 43 18             	mov    0x18(%ebx),%eax
801038fe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103903:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103906:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010390b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010390f:	8b 43 18             	mov    0x18(%ebx),%eax
80103912:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103916:	8b 43 18             	mov    0x18(%ebx),%eax
80103919:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010391d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103921:	8b 43 18             	mov    0x18(%ebx),%eax
80103924:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103928:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010392c:	8b 43 18             	mov    0x18(%ebx),%eax
8010392f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103936:	8b 43 18             	mov    0x18(%ebx),%eax
80103939:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103940:	8b 43 18             	mov    0x18(%ebx),%eax
80103943:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010394a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010394d:	6a 10                	push   $0x10
8010394f:	68 90 76 10 80       	push   $0x80107690
80103954:	50                   	push   %eax
80103955:	e8 16 0f 00 00       	call   80104870 <safestrcpy>
  p->cwd = namei("/");
8010395a:	c7 04 24 99 76 10 80 	movl   $0x80107699,(%esp)
80103961:	e8 5a e6 ff ff       	call   80101fc0 <namei>
80103966:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103969:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103970:	e8 cb 0b 00 00       	call   80104540 <acquire>
  p->state = RUNNABLE;
80103975:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010397c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103983:	e8 d8 0c 00 00       	call   80104660 <release>
}
80103988:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010398b:	83 c4 10             	add    $0x10,%esp
8010398e:	c9                   	leave  
8010398f:	c3                   	ret    
    panic("userinit: out of memory?");
80103990:	83 ec 0c             	sub    $0xc,%esp
80103993:	68 77 76 10 80       	push   $0x80107677
80103998:	e8 e3 c9 ff ff       	call   80100380 <panic>
8010399d:	8d 76 00             	lea    0x0(%esi),%esi

801039a0 <growproc>:
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	56                   	push   %esi
801039a4:	53                   	push   %ebx
801039a5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039a8:	e8 43 0b 00 00       	call   801044f0 <pushcli>
  c = mycpu();
801039ad:	e8 3e fe ff ff       	call   801037f0 <mycpu>
  p = c->proc;
801039b2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039b8:	e8 43 0c 00 00       	call   80104600 <popcli>
  sz = curproc->sz;
801039bd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801039bf:	85 f6                	test   %esi,%esi
801039c1:	7f 1d                	jg     801039e0 <growproc+0x40>
  } else if(n < 0){
801039c3:	75 3b                	jne    80103a00 <growproc+0x60>
  switchuvm(curproc);
801039c5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801039c8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039ca:	53                   	push   %ebx
801039cb:	e8 90 30 00 00       	call   80106a60 <switchuvm>
  return 0;
801039d0:	83 c4 10             	add    $0x10,%esp
801039d3:	31 c0                	xor    %eax,%eax
}
801039d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039d8:	5b                   	pop    %ebx
801039d9:	5e                   	pop    %esi
801039da:	5d                   	pop    %ebp
801039db:	c3                   	ret    
801039dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801039e0:	83 ec 04             	sub    $0x4,%esp
801039e3:	01 c6                	add    %eax,%esi
801039e5:	56                   	push   %esi
801039e6:	50                   	push   %eax
801039e7:	ff 73 04             	pushl  0x4(%ebx)
801039ea:	e8 c1 32 00 00       	call   80106cb0 <allocuvm>
801039ef:	83 c4 10             	add    $0x10,%esp
801039f2:	85 c0                	test   %eax,%eax
801039f4:	75 cf                	jne    801039c5 <growproc+0x25>
      return -1;
801039f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039fb:	eb d8                	jmp    801039d5 <growproc+0x35>
801039fd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a00:	83 ec 04             	sub    $0x4,%esp
80103a03:	01 c6                	add    %eax,%esi
80103a05:	56                   	push   %esi
80103a06:	50                   	push   %eax
80103a07:	ff 73 04             	pushl  0x4(%ebx)
80103a0a:	e8 d1 33 00 00       	call   80106de0 <deallocuvm>
80103a0f:	83 c4 10             	add    $0x10,%esp
80103a12:	85 c0                	test   %eax,%eax
80103a14:	75 af                	jne    801039c5 <growproc+0x25>
80103a16:	eb de                	jmp    801039f6 <growproc+0x56>
80103a18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a1f:	90                   	nop

80103a20 <fork>:
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	57                   	push   %edi
80103a24:	56                   	push   %esi
80103a25:	53                   	push   %ebx
80103a26:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a29:	e8 c2 0a 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103a2e:	e8 bd fd ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103a33:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a39:	e8 c2 0b 00 00       	call   80104600 <popcli>
  if((np = allocproc()) == 0){
80103a3e:	e8 5d fc ff ff       	call   801036a0 <allocproc>
80103a43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a46:	85 c0                	test   %eax,%eax
80103a48:	0f 84 b7 00 00 00    	je     80103b05 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a4e:	83 ec 08             	sub    $0x8,%esp
80103a51:	ff 33                	pushl  (%ebx)
80103a53:	89 c7                	mov    %eax,%edi
80103a55:	ff 73 04             	pushl  0x4(%ebx)
80103a58:	e8 03 35 00 00       	call   80106f60 <copyuvm>
80103a5d:	83 c4 10             	add    $0x10,%esp
80103a60:	89 47 04             	mov    %eax,0x4(%edi)
80103a63:	85 c0                	test   %eax,%eax
80103a65:	0f 84 a1 00 00 00    	je     80103b0c <fork+0xec>
  np->sz = curproc->sz;
80103a6b:	8b 03                	mov    (%ebx),%eax
80103a6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103a70:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103a72:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103a75:	89 c8                	mov    %ecx,%eax
80103a77:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103a7a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103a7f:	8b 73 18             	mov    0x18(%ebx),%esi
80103a82:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103a84:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103a86:	8b 40 18             	mov    0x18(%eax),%eax
80103a89:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103a90:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103a94:	85 c0                	test   %eax,%eax
80103a96:	74 13                	je     80103aab <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103a98:	83 ec 0c             	sub    $0xc,%esp
80103a9b:	50                   	push   %eax
80103a9c:	e8 cf d3 ff ff       	call   80100e70 <filedup>
80103aa1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103aa4:	83 c4 10             	add    $0x10,%esp
80103aa7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103aab:	83 c6 01             	add    $0x1,%esi
80103aae:	83 fe 10             	cmp    $0x10,%esi
80103ab1:	75 dd                	jne    80103a90 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ab3:	83 ec 0c             	sub    $0xc,%esp
80103ab6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ab9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103abc:	e8 2f dc ff ff       	call   801016f0 <idup>
80103ac1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ac4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ac7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103aca:	8d 47 6c             	lea    0x6c(%edi),%eax
80103acd:	6a 10                	push   $0x10
80103acf:	53                   	push   %ebx
80103ad0:	50                   	push   %eax
80103ad1:	e8 9a 0d 00 00       	call   80104870 <safestrcpy>
  pid = np->pid;
80103ad6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103ad9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ae0:	e8 5b 0a 00 00       	call   80104540 <acquire>
  np->state = RUNNABLE;
80103ae5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103aec:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103af3:	e8 68 0b 00 00       	call   80104660 <release>
  return pid;
80103af8:	83 c4 10             	add    $0x10,%esp
}
80103afb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103afe:	89 d8                	mov    %ebx,%eax
80103b00:	5b                   	pop    %ebx
80103b01:	5e                   	pop    %esi
80103b02:	5f                   	pop    %edi
80103b03:	5d                   	pop    %ebp
80103b04:	c3                   	ret    
    return -1;
80103b05:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b0a:	eb ef                	jmp    80103afb <fork+0xdb>
    kfree(np->kstack);
80103b0c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103b0f:	83 ec 0c             	sub    $0xc,%esp
80103b12:	ff 73 08             	pushl  0x8(%ebx)
80103b15:	e8 c6 e8 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103b1a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103b21:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103b24:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103b2b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b30:	eb c9                	jmp    80103afb <fork+0xdb>
80103b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b40 <scheduler>:
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	57                   	push   %edi
80103b44:	56                   	push   %esi
80103b45:	53                   	push   %ebx
80103b46:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103b49:	e8 a2 fc ff ff       	call   801037f0 <mycpu>
  c->proc = 0;
80103b4e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b55:	00 00 00 
  struct cpu *c = mycpu();
80103b58:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103b5a:	8d 70 04             	lea    0x4(%eax),%esi
80103b5d:	eb 1c                	jmp    80103b7b <scheduler+0x3b>
80103b5f:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b60:	83 ef 80             	sub    $0xffffff80,%edi
80103b63:	81 ff 54 4d 11 80    	cmp    $0x80114d54,%edi
80103b69:	72 26                	jb     80103b91 <scheduler+0x51>
    release(&ptable.lock);
80103b6b:	83 ec 0c             	sub    $0xc,%esp
80103b6e:	68 20 2d 11 80       	push   $0x80112d20
80103b73:	e8 e8 0a 00 00       	call   80104660 <release>
  for(;;){
80103b78:	83 c4 10             	add    $0x10,%esp
  asm volatile("sti");
80103b7b:	fb                   	sti    
    acquire(&ptable.lock);
80103b7c:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b7f:	bf 54 2d 11 80       	mov    $0x80112d54,%edi
    acquire(&ptable.lock);
80103b84:	68 20 2d 11 80       	push   $0x80112d20
80103b89:	e8 b2 09 00 00       	call   80104540 <acquire>
80103b8e:	83 c4 10             	add    $0x10,%esp
      if(p->state != RUNNABLE)
80103b91:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
80103b95:	75 c9                	jne    80103b60 <scheduler+0x20>
      for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103b97:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(p1->state != RUNNABLE)
80103ba0:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103ba4:	75 09                	jne    80103baf <scheduler+0x6f>
        if ( highP->priority > p1->priority )   // larger value, lower priority 
80103ba6:	8b 50 7c             	mov    0x7c(%eax),%edx
80103ba9:	39 57 7c             	cmp    %edx,0x7c(%edi)
80103bac:	0f 4f f8             	cmovg  %eax,%edi
      for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103baf:	83 e8 80             	sub    $0xffffff80,%eax
80103bb2:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103bb7:	75 e7                	jne    80103ba0 <scheduler+0x60>
      switchuvm(p);
80103bb9:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103bbc:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
      switchuvm(p);
80103bc2:	57                   	push   %edi
80103bc3:	e8 98 2e 00 00       	call   80106a60 <switchuvm>
      p->state = RUNNING;
80103bc8:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
      swtch(&(c->scheduler), p->context);
80103bcf:	58                   	pop    %eax
80103bd0:	5a                   	pop    %edx
80103bd1:	ff 77 1c             	pushl  0x1c(%edi)
80103bd4:	56                   	push   %esi
80103bd5:	e8 f1 0c 00 00       	call   801048cb <swtch>
      switchkvm();
80103bda:	e8 71 2e 00 00       	call   80106a50 <switchkvm>
      c->proc = 0;
80103bdf:	83 c4 10             	add    $0x10,%esp
80103be2:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103be9:	00 00 00 
80103bec:	e9 6f ff ff ff       	jmp    80103b60 <scheduler+0x20>
80103bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bff:	90                   	nop

80103c00 <sched>:
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	56                   	push   %esi
80103c04:	53                   	push   %ebx
  pushcli();
80103c05:	e8 e6 08 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103c0a:	e8 e1 fb ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103c0f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c15:	e8 e6 09 00 00       	call   80104600 <popcli>
  if(!holding(&ptable.lock))
80103c1a:	83 ec 0c             	sub    $0xc,%esp
80103c1d:	68 20 2d 11 80       	push   $0x80112d20
80103c22:	e8 89 08 00 00       	call   801044b0 <holding>
80103c27:	83 c4 10             	add    $0x10,%esp
80103c2a:	85 c0                	test   %eax,%eax
80103c2c:	74 4f                	je     80103c7d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c2e:	e8 bd fb ff ff       	call   801037f0 <mycpu>
80103c33:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c3a:	75 68                	jne    80103ca4 <sched+0xa4>
  if(p->state == RUNNING)
80103c3c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c40:	74 55                	je     80103c97 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c42:	9c                   	pushf  
80103c43:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c44:	f6 c4 02             	test   $0x2,%ah
80103c47:	75 41                	jne    80103c8a <sched+0x8a>
  intena = mycpu()->intena;
80103c49:	e8 a2 fb ff ff       	call   801037f0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c4e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103c51:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c57:	e8 94 fb ff ff       	call   801037f0 <mycpu>
80103c5c:	83 ec 08             	sub    $0x8,%esp
80103c5f:	ff 70 04             	pushl  0x4(%eax)
80103c62:	53                   	push   %ebx
80103c63:	e8 63 0c 00 00       	call   801048cb <swtch>
  mycpu()->intena = intena;
80103c68:	e8 83 fb ff ff       	call   801037f0 <mycpu>
}
80103c6d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103c70:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c79:	5b                   	pop    %ebx
80103c7a:	5e                   	pop    %esi
80103c7b:	5d                   	pop    %ebp
80103c7c:	c3                   	ret    
    panic("sched ptable.lock");
80103c7d:	83 ec 0c             	sub    $0xc,%esp
80103c80:	68 9b 76 10 80       	push   $0x8010769b
80103c85:	e8 f6 c6 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103c8a:	83 ec 0c             	sub    $0xc,%esp
80103c8d:	68 c7 76 10 80       	push   $0x801076c7
80103c92:	e8 e9 c6 ff ff       	call   80100380 <panic>
    panic("sched running");
80103c97:	83 ec 0c             	sub    $0xc,%esp
80103c9a:	68 b9 76 10 80       	push   $0x801076b9
80103c9f:	e8 dc c6 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103ca4:	83 ec 0c             	sub    $0xc,%esp
80103ca7:	68 ad 76 10 80       	push   $0x801076ad
80103cac:	e8 cf c6 ff ff       	call   80100380 <panic>
80103cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cbf:	90                   	nop

80103cc0 <exit>:
{
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	57                   	push   %edi
80103cc4:	56                   	push   %esi
80103cc5:	53                   	push   %ebx
80103cc6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103cc9:	e8 22 08 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103cce:	e8 1d fb ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103cd3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103cd9:	e8 22 09 00 00       	call   80104600 <popcli>
  if(curproc == initproc)
80103cde:	8d 5e 28             	lea    0x28(%esi),%ebx
80103ce1:	8d 7e 68             	lea    0x68(%esi),%edi
80103ce4:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103cea:	0f 84 e7 00 00 00    	je     80103dd7 <exit+0x117>
    if(curproc->ofile[fd]){
80103cf0:	8b 03                	mov    (%ebx),%eax
80103cf2:	85 c0                	test   %eax,%eax
80103cf4:	74 12                	je     80103d08 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103cf6:	83 ec 0c             	sub    $0xc,%esp
80103cf9:	50                   	push   %eax
80103cfa:	e8 c1 d1 ff ff       	call   80100ec0 <fileclose>
      curproc->ofile[fd] = 0;
80103cff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d05:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103d08:	83 c3 04             	add    $0x4,%ebx
80103d0b:	39 df                	cmp    %ebx,%edi
80103d0d:	75 e1                	jne    80103cf0 <exit+0x30>
  begin_op();
80103d0f:	e8 6c ef ff ff       	call   80102c80 <begin_op>
  iput(curproc->cwd);
80103d14:	83 ec 0c             	sub    $0xc,%esp
80103d17:	ff 76 68             	pushl  0x68(%esi)
80103d1a:	e8 31 db ff ff       	call   80101850 <iput>
  end_op();
80103d1f:	e8 cc ef ff ff       	call   80102cf0 <end_op>
  curproc->cwd = 0;
80103d24:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103d2b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d32:	e8 09 08 00 00       	call   80104540 <acquire>
  wakeup1(curproc->parent);
80103d37:	8b 56 14             	mov    0x14(%esi),%edx
80103d3a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d3d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d42:	eb 0e                	jmp    80103d52 <exit+0x92>
80103d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d48:	83 e8 80             	sub    $0xffffff80,%eax
80103d4b:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103d50:	74 1c                	je     80103d6e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103d52:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d56:	75 f0                	jne    80103d48 <exit+0x88>
80103d58:	3b 50 20             	cmp    0x20(%eax),%edx
80103d5b:	75 eb                	jne    80103d48 <exit+0x88>
      p->state = RUNNABLE;
80103d5d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d64:	83 e8 80             	sub    $0xffffff80,%eax
80103d67:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103d6c:	75 e4                	jne    80103d52 <exit+0x92>
      p->parent = initproc;
80103d6e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d74:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103d79:	eb 10                	jmp    80103d8b <exit+0xcb>
80103d7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d7f:	90                   	nop
80103d80:	83 ea 80             	sub    $0xffffff80,%edx
80103d83:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80103d89:	74 33                	je     80103dbe <exit+0xfe>
    if(p->parent == curproc){
80103d8b:	39 72 14             	cmp    %esi,0x14(%edx)
80103d8e:	75 f0                	jne    80103d80 <exit+0xc0>
      if(p->state == ZOMBIE)
80103d90:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103d94:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d97:	75 e7                	jne    80103d80 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d99:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d9e:	eb 0a                	jmp    80103daa <exit+0xea>
80103da0:	83 e8 80             	sub    $0xffffff80,%eax
80103da3:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103da8:	74 d6                	je     80103d80 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103daa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dae:	75 f0                	jne    80103da0 <exit+0xe0>
80103db0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103db3:	75 eb                	jne    80103da0 <exit+0xe0>
      p->state = RUNNABLE;
80103db5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103dbc:	eb e2                	jmp    80103da0 <exit+0xe0>
  curproc->state = ZOMBIE;
80103dbe:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103dc5:	e8 36 fe ff ff       	call   80103c00 <sched>
  panic("zombie exit");
80103dca:	83 ec 0c             	sub    $0xc,%esp
80103dcd:	68 e8 76 10 80       	push   $0x801076e8
80103dd2:	e8 a9 c5 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103dd7:	83 ec 0c             	sub    $0xc,%esp
80103dda:	68 db 76 10 80       	push   $0x801076db
80103ddf:	e8 9c c5 ff ff       	call   80100380 <panic>
80103de4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103def:	90                   	nop

80103df0 <yield>:
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	53                   	push   %ebx
80103df4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103df7:	68 20 2d 11 80       	push   $0x80112d20
80103dfc:	e8 3f 07 00 00       	call   80104540 <acquire>
  pushcli();
80103e01:	e8 ea 06 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103e06:	e8 e5 f9 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103e0b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e11:	e8 ea 07 00 00       	call   80104600 <popcli>
  myproc()->state = RUNNABLE;
80103e16:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e1d:	e8 de fd ff ff       	call   80103c00 <sched>
  release(&ptable.lock);
80103e22:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e29:	e8 32 08 00 00       	call   80104660 <release>
}
80103e2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e31:	83 c4 10             	add    $0x10,%esp
80103e34:	c9                   	leave  
80103e35:	c3                   	ret    
80103e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e3d:	8d 76 00             	lea    0x0(%esi),%esi

80103e40 <sleep>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	57                   	push   %edi
80103e44:	56                   	push   %esi
80103e45:	53                   	push   %ebx
80103e46:	83 ec 0c             	sub    $0xc,%esp
80103e49:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e4c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e4f:	e8 9c 06 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103e54:	e8 97 f9 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103e59:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e5f:	e8 9c 07 00 00       	call   80104600 <popcli>
  if(p == 0)
80103e64:	85 db                	test   %ebx,%ebx
80103e66:	0f 84 87 00 00 00    	je     80103ef3 <sleep+0xb3>
  if(lk == 0)
80103e6c:	85 f6                	test   %esi,%esi
80103e6e:	74 76                	je     80103ee6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e70:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103e76:	74 50                	je     80103ec8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e78:	83 ec 0c             	sub    $0xc,%esp
80103e7b:	68 20 2d 11 80       	push   $0x80112d20
80103e80:	e8 bb 06 00 00       	call   80104540 <acquire>
    release(lk);
80103e85:	89 34 24             	mov    %esi,(%esp)
80103e88:	e8 d3 07 00 00       	call   80104660 <release>
  p->chan = chan;
80103e8d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e90:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e97:	e8 64 fd ff ff       	call   80103c00 <sched>
  p->chan = 0;
80103e9c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103ea3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103eaa:	e8 b1 07 00 00       	call   80104660 <release>
    acquire(lk);
80103eaf:	89 75 08             	mov    %esi,0x8(%ebp)
80103eb2:	83 c4 10             	add    $0x10,%esp
}
80103eb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103eb8:	5b                   	pop    %ebx
80103eb9:	5e                   	pop    %esi
80103eba:	5f                   	pop    %edi
80103ebb:	5d                   	pop    %ebp
    acquire(lk);
80103ebc:	e9 7f 06 00 00       	jmp    80104540 <acquire>
80103ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103ec8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ecb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ed2:	e8 29 fd ff ff       	call   80103c00 <sched>
  p->chan = 0;
80103ed7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103ede:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ee1:	5b                   	pop    %ebx
80103ee2:	5e                   	pop    %esi
80103ee3:	5f                   	pop    %edi
80103ee4:	5d                   	pop    %ebp
80103ee5:	c3                   	ret    
    panic("sleep without lk");
80103ee6:	83 ec 0c             	sub    $0xc,%esp
80103ee9:	68 fa 76 10 80       	push   $0x801076fa
80103eee:	e8 8d c4 ff ff       	call   80100380 <panic>
    panic("sleep");
80103ef3:	83 ec 0c             	sub    $0xc,%esp
80103ef6:	68 f4 76 10 80       	push   $0x801076f4
80103efb:	e8 80 c4 ff ff       	call   80100380 <panic>

80103f00 <wait>:
{
80103f00:	55                   	push   %ebp
80103f01:	89 e5                	mov    %esp,%ebp
80103f03:	56                   	push   %esi
80103f04:	53                   	push   %ebx
  pushcli();
80103f05:	e8 e6 05 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103f0a:	e8 e1 f8 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103f0f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f15:	e8 e6 06 00 00       	call   80104600 <popcli>
  acquire(&ptable.lock);
80103f1a:	83 ec 0c             	sub    $0xc,%esp
80103f1d:	68 20 2d 11 80       	push   $0x80112d20
80103f22:	e8 19 06 00 00       	call   80104540 <acquire>
80103f27:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f2a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f2c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f31:	eb 10                	jmp    80103f43 <wait+0x43>
80103f33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f37:	90                   	nop
80103f38:	83 eb 80             	sub    $0xffffff80,%ebx
80103f3b:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103f41:	74 1b                	je     80103f5e <wait+0x5e>
      if(p->parent != curproc)
80103f43:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f46:	75 f0                	jne    80103f38 <wait+0x38>
      if(p->state == ZOMBIE){
80103f48:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f4c:	74 32                	je     80103f80 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f4e:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80103f51:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f56:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103f5c:	75 e5                	jne    80103f43 <wait+0x43>
    if(!havekids || curproc->killed){
80103f5e:	85 c0                	test   %eax,%eax
80103f60:	74 74                	je     80103fd6 <wait+0xd6>
80103f62:	8b 46 24             	mov    0x24(%esi),%eax
80103f65:	85 c0                	test   %eax,%eax
80103f67:	75 6d                	jne    80103fd6 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f69:	83 ec 08             	sub    $0x8,%esp
80103f6c:	68 20 2d 11 80       	push   $0x80112d20
80103f71:	56                   	push   %esi
80103f72:	e8 c9 fe ff ff       	call   80103e40 <sleep>
    havekids = 0;
80103f77:	83 c4 10             	add    $0x10,%esp
80103f7a:	eb ae                	jmp    80103f2a <wait+0x2a>
80103f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103f80:	83 ec 0c             	sub    $0xc,%esp
80103f83:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103f86:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f89:	e8 52 e4 ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
80103f8e:	5a                   	pop    %edx
80103f8f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103f92:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f99:	e8 72 2e 00 00       	call   80106e10 <freevm>
        release(&ptable.lock);
80103f9e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
80103fa5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fac:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103fb3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fb7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fbe:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fc5:	e8 96 06 00 00       	call   80104660 <release>
        return pid;
80103fca:	83 c4 10             	add    $0x10,%esp
}
80103fcd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fd0:	89 f0                	mov    %esi,%eax
80103fd2:	5b                   	pop    %ebx
80103fd3:	5e                   	pop    %esi
80103fd4:	5d                   	pop    %ebp
80103fd5:	c3                   	ret    
      release(&ptable.lock);
80103fd6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fd9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103fde:	68 20 2d 11 80       	push   $0x80112d20
80103fe3:	e8 78 06 00 00       	call   80104660 <release>
      return -1;
80103fe8:	83 c4 10             	add    $0x10,%esp
80103feb:	eb e0                	jmp    80103fcd <wait+0xcd>
80103fed:	8d 76 00             	lea    0x0(%esi),%esi

80103ff0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	53                   	push   %ebx
80103ff4:	83 ec 10             	sub    $0x10,%esp
80103ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103ffa:	68 20 2d 11 80       	push   $0x80112d20
80103fff:	e8 3c 05 00 00       	call   80104540 <acquire>
80104004:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104007:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010400c:	eb 0c                	jmp    8010401a <wakeup+0x2a>
8010400e:	66 90                	xchg   %ax,%ax
80104010:	83 e8 80             	sub    $0xffffff80,%eax
80104013:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80104018:	74 1c                	je     80104036 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010401a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010401e:	75 f0                	jne    80104010 <wakeup+0x20>
80104020:	3b 58 20             	cmp    0x20(%eax),%ebx
80104023:	75 eb                	jne    80104010 <wakeup+0x20>
      p->state = RUNNABLE;
80104025:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010402c:	83 e8 80             	sub    $0xffffff80,%eax
8010402f:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80104034:	75 e4                	jne    8010401a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104036:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
8010403d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104040:	c9                   	leave  
  release(&ptable.lock);
80104041:	e9 1a 06 00 00       	jmp    80104660 <release>
80104046:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010404d:	8d 76 00             	lea    0x0(%esi),%esi

80104050 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 10             	sub    $0x10,%esp
80104057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010405a:	68 20 2d 11 80       	push   $0x80112d20
8010405f:	e8 dc 04 00 00       	call   80104540 <acquire>
80104064:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104067:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010406c:	eb 0c                	jmp    8010407a <kill+0x2a>
8010406e:	66 90                	xchg   %ax,%ax
80104070:	83 e8 80             	sub    $0xffffff80,%eax
80104073:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80104078:	74 36                	je     801040b0 <kill+0x60>
    if(p->pid == pid){
8010407a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010407d:	75 f1                	jne    80104070 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010407f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104083:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010408a:	75 07                	jne    80104093 <kill+0x43>
        p->state = RUNNABLE;
8010408c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104093:	83 ec 0c             	sub    $0xc,%esp
80104096:	68 20 2d 11 80       	push   $0x80112d20
8010409b:	e8 c0 05 00 00       	call   80104660 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801040a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801040a3:	83 c4 10             	add    $0x10,%esp
801040a6:	31 c0                	xor    %eax,%eax
}
801040a8:	c9                   	leave  
801040a9:	c3                   	ret    
801040aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801040b0:	83 ec 0c             	sub    $0xc,%esp
801040b3:	68 20 2d 11 80       	push   $0x80112d20
801040b8:	e8 a3 05 00 00       	call   80104660 <release>
}
801040bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801040c0:	83 c4 10             	add    $0x10,%esp
801040c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040c8:	c9                   	leave  
801040c9:	c3                   	ret    
801040ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040d0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	57                   	push   %edi
801040d4:	56                   	push   %esi
801040d5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801040d8:	53                   	push   %ebx
801040d9:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
801040de:	83 ec 3c             	sub    $0x3c,%esp
801040e1:	eb 24                	jmp    80104107 <procdump+0x37>
801040e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040e7:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801040e8:	83 ec 0c             	sub    $0xc,%esp
801040eb:	68 47 7b 10 80       	push   $0x80107b47
801040f0:	e8 ab c5 ff ff       	call   801006a0 <cprintf>
801040f5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040f8:	83 eb 80             	sub    $0xffffff80,%ebx
801040fb:	81 fb c0 4d 11 80    	cmp    $0x80114dc0,%ebx
80104101:	0f 84 81 00 00 00    	je     80104188 <procdump+0xb8>
    if(p->state == UNUSED)
80104107:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010410a:	85 c0                	test   %eax,%eax
8010410c:	74 ea                	je     801040f8 <procdump+0x28>
      state = "???";
8010410e:	ba 0b 77 10 80       	mov    $0x8010770b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104113:	83 f8 05             	cmp    $0x5,%eax
80104116:	77 11                	ja     80104129 <procdump+0x59>
80104118:	8b 14 85 18 78 10 80 	mov    -0x7fef87e8(,%eax,4),%edx
      state = "???";
8010411f:	b8 0b 77 10 80       	mov    $0x8010770b,%eax
80104124:	85 d2                	test   %edx,%edx
80104126:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104129:	53                   	push   %ebx
8010412a:	52                   	push   %edx
8010412b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010412e:	68 0f 77 10 80       	push   $0x8010770f
80104133:	e8 68 c5 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
80104138:	83 c4 10             	add    $0x10,%esp
8010413b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010413f:	75 a7                	jne    801040e8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104141:	83 ec 08             	sub    $0x8,%esp
80104144:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104147:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010414a:	50                   	push   %eax
8010414b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010414e:	8b 40 0c             	mov    0xc(%eax),%eax
80104151:	83 c0 08             	add    $0x8,%eax
80104154:	50                   	push   %eax
80104155:	e8 06 03 00 00       	call   80104460 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010415a:	83 c4 10             	add    $0x10,%esp
8010415d:	8d 76 00             	lea    0x0(%esi),%esi
80104160:	8b 17                	mov    (%edi),%edx
80104162:	85 d2                	test   %edx,%edx
80104164:	74 82                	je     801040e8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104166:	83 ec 08             	sub    $0x8,%esp
80104169:	83 c7 04             	add    $0x4,%edi
8010416c:	52                   	push   %edx
8010416d:	68 61 71 10 80       	push   $0x80107161
80104172:	e8 29 c5 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104177:	83 c4 10             	add    $0x10,%esp
8010417a:	39 fe                	cmp    %edi,%esi
8010417c:	75 e2                	jne    80104160 <procdump+0x90>
8010417e:	e9 65 ff ff ff       	jmp    801040e8 <procdump+0x18>
80104183:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104187:	90                   	nop
  }
}
80104188:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010418b:	5b                   	pop    %ebx
8010418c:	5e                   	pop    %esi
8010418d:	5f                   	pop    %edi
8010418e:	5d                   	pop    %ebp
8010418f:	c3                   	ret    

80104190 <cps>:

//current process status
int
cps()
{
80104190:	55                   	push   %ebp
80104191:	89 e5                	mov    %esp,%ebp
80104193:	53                   	push   %ebx
80104194:	83 ec 10             	sub    $0x10,%esp
  asm volatile("sti");
80104197:	fb                   	sti    

  // Enable interrupts on this processor.
  sti();

  // Loop over process table looking for process with pid.
  acquire(&ptable.lock);
80104198:	68 20 2d 11 80       	push   $0x80112d20
  cprintf("name \t pid \t state \t \t priority \n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010419d:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  acquire(&ptable.lock);
801041a2:	e8 99 03 00 00       	call   80104540 <acquire>
  cprintf("name \t pid \t state \t \t priority \n");
801041a7:	c7 04 24 f4 77 10 80 	movl   $0x801077f4,(%esp)
801041ae:	e8 ed c4 ff ff       	call   801006a0 <cprintf>
801041b3:	83 c4 10             	add    $0x10,%esp
801041b6:	eb 1d                	jmp    801041d5 <cps+0x45>
801041b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041bf:	90                   	nop
      if ( p->state == SLEEPING ) {
        cprintf("%s \t %d  \t SLEEPING \t %d\n ", p->name, p->pid, p->priority );
      }
      else if ( p->state == RUNNING ) {
801041c0:	83 f8 04             	cmp    $0x4,%eax
801041c3:	74 5b                	je     80104220 <cps+0x90>
        cprintf("%s \t %d  \t RUNNING \t %d\n", p->name, p->pid, p->priority );
      }
      else if (p->state == RUNNABLE){
801041c5:	83 f8 03             	cmp    $0x3,%eax
801041c8:	74 76                	je     80104240 <cps+0xb0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041ca:	83 eb 80             	sub    $0xffffff80,%ebx
801041cd:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
801041d3:	74 2a                	je     801041ff <cps+0x6f>
      if ( p->state == SLEEPING ) {
801041d5:	8b 43 0c             	mov    0xc(%ebx),%eax
801041d8:	83 f8 02             	cmp    $0x2,%eax
801041db:	75 e3                	jne    801041c0 <cps+0x30>
        cprintf("%s \t %d  \t SLEEPING \t %d\n ", p->name, p->pid, p->priority );
801041dd:	8d 43 6c             	lea    0x6c(%ebx),%eax
801041e0:	ff 73 7c             	pushl  0x7c(%ebx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041e3:	83 eb 80             	sub    $0xffffff80,%ebx
        cprintf("%s \t %d  \t SLEEPING \t %d\n ", p->name, p->pid, p->priority );
801041e6:	ff 73 90             	pushl  -0x70(%ebx)
801041e9:	50                   	push   %eax
801041ea:	68 18 77 10 80       	push   $0x80107718
801041ef:	e8 ac c4 ff ff       	call   801006a0 <cprintf>
801041f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041f7:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
801041fd:	75 d6                	jne    801041d5 <cps+0x45>
        cprintf("%s \t %d  \t RUNNABLE \t %d\n ", p->name, p->pid, p->priority );
      }
  }
  
  release(&ptable.lock);
801041ff:	83 ec 0c             	sub    $0xc,%esp
80104202:	68 20 2d 11 80       	push   $0x80112d20
80104207:	e8 54 04 00 00       	call   80104660 <release>
  
  return 22;
}
8010420c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010420f:	b8 16 00 00 00       	mov    $0x16,%eax
80104214:	c9                   	leave  
80104215:	c3                   	ret    
80104216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010421d:	8d 76 00             	lea    0x0(%esi),%esi
        cprintf("%s \t %d  \t RUNNING \t %d\n", p->name, p->pid, p->priority );
80104220:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104223:	ff 73 7c             	pushl  0x7c(%ebx)
80104226:	ff 73 10             	pushl  0x10(%ebx)
80104229:	50                   	push   %eax
8010422a:	68 33 77 10 80       	push   $0x80107733
8010422f:	e8 6c c4 ff ff       	call   801006a0 <cprintf>
80104234:	83 c4 10             	add    $0x10,%esp
80104237:	eb 91                	jmp    801041ca <cps+0x3a>
80104239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        cprintf("%s \t %d  \t RUNNABLE \t %d\n ", p->name, p->pid, p->priority );
80104240:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104243:	ff 73 7c             	pushl  0x7c(%ebx)
80104246:	ff 73 10             	pushl  0x10(%ebx)
80104249:	50                   	push   %eax
8010424a:	68 4c 77 10 80       	push   $0x8010774c
8010424f:	e8 4c c4 ff ff       	call   801006a0 <cprintf>
80104254:	83 c4 10             	add    $0x10,%esp
80104257:	e9 6e ff ff ff       	jmp    801041ca <cps+0x3a>
8010425c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104260 <nps>:
//number of processes
//Seems like it would've been a lot more efficient to include this
//as a part of cps, but whatever.
int
nps()
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	53                   	push   %ebx
80104264:	83 ec 10             	sub    $0x10,%esp
80104267:	fb                   	sti    

  // Enable interrupts on this processor.
  sti();

  // Loop over process table looking for process with pid.
  acquire(&ptable.lock);
80104268:	68 20 2d 11 80       	push   $0x80112d20
	runTotal = 0;
8010426d:	31 db                	xor    %ebx,%ebx
  acquire(&ptable.lock);
8010426f:	e8 cc 02 00 00       	call   80104540 <acquire>
80104274:	83 c4 10             	add    $0x10,%esp
  int sleepTotal = 0,
80104277:	31 c9                	xor    %ecx,%ecx

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104279:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010427e:	eb 15                	jmp    80104295 <nps+0x35>
      if ( p->state == SLEEPING ) {
	sleepTotal += 1;

      }
      else if ( p->state == RUNNING ) {
	runTotal += 1;
80104280:	83 fa 04             	cmp    $0x4,%edx
80104283:	0f 94 c2             	sete   %dl
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104286:	83 e8 80             	sub    $0xffffff80,%eax
	runTotal += 1;
80104289:	0f b6 d2             	movzbl %dl,%edx
8010428c:	01 d3                	add    %edx,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010428e:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80104293:	74 15                	je     801042aa <nps+0x4a>
      if ( p->state == SLEEPING ) {
80104295:	8b 50 0c             	mov    0xc(%eax),%edx
80104298:	83 fa 02             	cmp    $0x2,%edx
8010429b:	75 e3                	jne    80104280 <nps+0x20>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010429d:	83 e8 80             	sub    $0xffffff80,%eax
	sleepTotal += 1;
801042a0:	83 c1 01             	add    $0x1,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042a3:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
801042a8:	75 eb                	jne    80104295 <nps+0x35>

      }
  }

  cprintf("Total SLEEPING processes: %d\n", sleepTotal);
801042aa:	83 ec 08             	sub    $0x8,%esp
801042ad:	51                   	push   %ecx
801042ae:	68 67 77 10 80       	push   $0x80107767
801042b3:	e8 e8 c3 ff ff       	call   801006a0 <cprintf>
  cprintf("Total RUNNING processes: %d\n", runTotal);
801042b8:	58                   	pop    %eax
801042b9:	5a                   	pop    %edx
801042ba:	53                   	push   %ebx
801042bb:	68 85 77 10 80       	push   $0x80107785
801042c0:	e8 db c3 ff ff       	call   801006a0 <cprintf>
  
  release(&ptable.lock);
801042c5:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801042cc:	e8 8f 03 00 00       	call   80104660 <release>

  return 22;
}
801042d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042d4:	b8 16 00 00 00       	mov    $0x16,%eax
801042d9:	c9                   	leave  
801042da:	c3                   	ret    
801042db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042df:	90                   	nop

801042e0 <chpr>:

//change priority
int
chpr( int pid, int priority )
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	53                   	push   %ebx
801042e4:	83 ec 10             	sub    $0x10,%esp
801042e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  
  acquire(&ptable.lock);
801042ea:	68 20 2d 11 80       	push   $0x80112d20
801042ef:	e8 4c 02 00 00       	call   80104540 <acquire>
801042f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042f7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801042fc:	eb 0c                	jmp    8010430a <chpr+0x2a>
801042fe:	66 90                	xchg   %ax,%ax
80104300:	83 e8 80             	sub    $0xffffff80,%eax
80104303:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80104308:	74 0b                	je     80104315 <chpr+0x35>
    if(p->pid == pid ) {
8010430a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010430d:	75 f1                	jne    80104300 <chpr+0x20>
        p->priority = priority;
8010430f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104312:	89 50 7c             	mov    %edx,0x7c(%eax)
        break;
    }
  }
  release(&ptable.lock);
80104315:	83 ec 0c             	sub    $0xc,%esp
80104318:	68 20 2d 11 80       	push   $0x80112d20
8010431d:	e8 3e 03 00 00       	call   80104660 <release>

  return pid;
}
80104322:	89 d8                	mov    %ebx,%eax
80104324:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104327:	c9                   	leave  
80104328:	c3                   	ret    
80104329:	66 90                	xchg   %ax,%ax
8010432b:	66 90                	xchg   %ax,%ax
8010432d:	66 90                	xchg   %ax,%ax
8010432f:	90                   	nop

80104330 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	53                   	push   %ebx
80104334:	83 ec 0c             	sub    $0xc,%esp
80104337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010433a:	68 30 78 10 80       	push   $0x80107830
8010433f:	8d 43 04             	lea    0x4(%ebx),%eax
80104342:	50                   	push   %eax
80104343:	e8 f8 00 00 00       	call   80104440 <initlock>
  lk->name = name;
80104348:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010434b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104351:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104354:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010435b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010435e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104361:	c9                   	leave  
80104362:	c3                   	ret    
80104363:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010436a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104370 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	56                   	push   %esi
80104374:	53                   	push   %ebx
80104375:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104378:	8d 73 04             	lea    0x4(%ebx),%esi
8010437b:	83 ec 0c             	sub    $0xc,%esp
8010437e:	56                   	push   %esi
8010437f:	e8 bc 01 00 00       	call   80104540 <acquire>
  while (lk->locked) {
80104384:	8b 13                	mov    (%ebx),%edx
80104386:	83 c4 10             	add    $0x10,%esp
80104389:	85 d2                	test   %edx,%edx
8010438b:	74 16                	je     801043a3 <acquiresleep+0x33>
8010438d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104390:	83 ec 08             	sub    $0x8,%esp
80104393:	56                   	push   %esi
80104394:	53                   	push   %ebx
80104395:	e8 a6 fa ff ff       	call   80103e40 <sleep>
  while (lk->locked) {
8010439a:	8b 03                	mov    (%ebx),%eax
8010439c:	83 c4 10             	add    $0x10,%esp
8010439f:	85 c0                	test   %eax,%eax
801043a1:	75 ed                	jne    80104390 <acquiresleep+0x20>
  }
  lk->locked = 1;
801043a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801043a9:	e8 d2 f4 ff ff       	call   80103880 <myproc>
801043ae:	8b 40 10             	mov    0x10(%eax),%eax
801043b1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801043b4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043ba:	5b                   	pop    %ebx
801043bb:	5e                   	pop    %esi
801043bc:	5d                   	pop    %ebp
  release(&lk->lk);
801043bd:	e9 9e 02 00 00       	jmp    80104660 <release>
801043c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043d0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	56                   	push   %esi
801043d4:	53                   	push   %ebx
801043d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043d8:	8d 73 04             	lea    0x4(%ebx),%esi
801043db:	83 ec 0c             	sub    $0xc,%esp
801043de:	56                   	push   %esi
801043df:	e8 5c 01 00 00       	call   80104540 <acquire>
  lk->locked = 0;
801043e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043f1:	89 1c 24             	mov    %ebx,(%esp)
801043f4:	e8 f7 fb ff ff       	call   80103ff0 <wakeup>
  release(&lk->lk);
801043f9:	89 75 08             	mov    %esi,0x8(%ebp)
801043fc:	83 c4 10             	add    $0x10,%esp
}
801043ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104402:	5b                   	pop    %ebx
80104403:	5e                   	pop    %esi
80104404:	5d                   	pop    %ebp
  release(&lk->lk);
80104405:	e9 56 02 00 00       	jmp    80104660 <release>
8010440a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104410 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	56                   	push   %esi
80104414:	53                   	push   %ebx
80104415:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104418:	8d 5e 04             	lea    0x4(%esi),%ebx
8010441b:	83 ec 0c             	sub    $0xc,%esp
8010441e:	53                   	push   %ebx
8010441f:	e8 1c 01 00 00       	call   80104540 <acquire>
  r = lk->locked;
80104424:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104426:	89 1c 24             	mov    %ebx,(%esp)
80104429:	e8 32 02 00 00       	call   80104660 <release>
  return r;
}
8010442e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104431:	89 f0                	mov    %esi,%eax
80104433:	5b                   	pop    %ebx
80104434:	5e                   	pop    %esi
80104435:	5d                   	pop    %ebp
80104436:	c3                   	ret    
80104437:	66 90                	xchg   %ax,%ax
80104439:	66 90                	xchg   %ax,%ax
8010443b:	66 90                	xchg   %ax,%ax
8010443d:	66 90                	xchg   %ax,%ax
8010443f:	90                   	nop

80104440 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104446:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104449:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010444f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104452:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104459:	5d                   	pop    %ebp
8010445a:	c3                   	ret    
8010445b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010445f:	90                   	nop

80104460 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104460:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104461:	31 d2                	xor    %edx,%edx
{
80104463:	89 e5                	mov    %esp,%ebp
80104465:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104466:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104469:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010446c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010446f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104470:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104476:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010447c:	77 1a                	ja     80104498 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010447e:	8b 58 04             	mov    0x4(%eax),%ebx
80104481:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104484:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104487:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104489:	83 fa 0a             	cmp    $0xa,%edx
8010448c:	75 e2                	jne    80104470 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010448e:	5b                   	pop    %ebx
8010448f:	5d                   	pop    %ebp
80104490:	c3                   	ret    
80104491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104498:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010449b:	8d 51 28             	lea    0x28(%ecx),%edx
8010449e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801044a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801044a6:	83 c0 04             	add    $0x4,%eax
801044a9:	39 d0                	cmp    %edx,%eax
801044ab:	75 f3                	jne    801044a0 <getcallerpcs+0x40>
}
801044ad:	5b                   	pop    %ebx
801044ae:	5d                   	pop    %ebp
801044af:	c3                   	ret    

801044b0 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	53                   	push   %ebx
801044b4:	83 ec 04             	sub    $0x4,%esp
801044b7:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
801044ba:	8b 02                	mov    (%edx),%eax
801044bc:	85 c0                	test   %eax,%eax
801044be:	75 10                	jne    801044d0 <holding+0x20>
}
801044c0:	83 c4 04             	add    $0x4,%esp
801044c3:	31 c0                	xor    %eax,%eax
801044c5:	5b                   	pop    %ebx
801044c6:	5d                   	pop    %ebp
801044c7:	c3                   	ret    
801044c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044cf:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
801044d0:	8b 5a 08             	mov    0x8(%edx),%ebx
801044d3:	e8 18 f3 ff ff       	call   801037f0 <mycpu>
801044d8:	39 c3                	cmp    %eax,%ebx
801044da:	0f 94 c0             	sete   %al
}
801044dd:	83 c4 04             	add    $0x4,%esp
  return lock->locked && lock->cpu == mycpu();
801044e0:	0f b6 c0             	movzbl %al,%eax
}
801044e3:	5b                   	pop    %ebx
801044e4:	5d                   	pop    %ebp
801044e5:	c3                   	ret    
801044e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044ed:	8d 76 00             	lea    0x0(%esi),%esi

801044f0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	53                   	push   %ebx
801044f4:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044f7:	9c                   	pushf  
801044f8:	5b                   	pop    %ebx
  asm volatile("cli");
801044f9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801044fa:	e8 f1 f2 ff ff       	call   801037f0 <mycpu>
801044ff:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104505:	85 c0                	test   %eax,%eax
80104507:	74 17                	je     80104520 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104509:	e8 e2 f2 ff ff       	call   801037f0 <mycpu>
8010450e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104515:	83 c4 04             	add    $0x4,%esp
80104518:	5b                   	pop    %ebx
80104519:	5d                   	pop    %ebp
8010451a:	c3                   	ret    
8010451b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010451f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104520:	e8 cb f2 ff ff       	call   801037f0 <mycpu>
80104525:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010452b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104531:	eb d6                	jmp    80104509 <pushcli+0x19>
80104533:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010453a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104540 <acquire>:
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104545:	e8 a6 ff ff ff       	call   801044f0 <pushcli>
  if(holding(lk))
8010454a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
8010454d:	8b 03                	mov    (%ebx),%eax
8010454f:	85 c0                	test   %eax,%eax
80104551:	0f 85 81 00 00 00    	jne    801045d8 <acquire+0x98>
  asm volatile("lock; xchgl %0, %1" :
80104557:	ba 01 00 00 00       	mov    $0x1,%edx
8010455c:	eb 05                	jmp    80104563 <acquire+0x23>
8010455e:	66 90                	xchg   %ax,%ax
80104560:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104563:	89 d0                	mov    %edx,%eax
80104565:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104568:	85 c0                	test   %eax,%eax
8010456a:	75 f4                	jne    80104560 <acquire+0x20>
  __sync_synchronize();
8010456c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104571:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104574:	e8 77 f2 ff ff       	call   801037f0 <mycpu>
  ebp = (uint*)v - 2;
80104579:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
8010457b:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
8010457e:	31 c0                	xor    %eax,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104580:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
80104586:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
8010458c:	77 22                	ja     801045b0 <acquire+0x70>
    pcs[i] = ebp[1];     // saved %eip
8010458e:	8b 4a 04             	mov    0x4(%edx),%ecx
80104591:	89 4c 83 0c          	mov    %ecx,0xc(%ebx,%eax,4)
  for(i = 0; i < 10; i++){
80104595:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104598:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010459a:	83 f8 0a             	cmp    $0xa,%eax
8010459d:	75 e1                	jne    80104580 <acquire+0x40>
}
8010459f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045a2:	5b                   	pop    %ebx
801045a3:	5e                   	pop    %esi
801045a4:	5d                   	pop    %ebp
801045a5:	c3                   	ret    
801045a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
801045b0:	8d 44 83 0c          	lea    0xc(%ebx,%eax,4),%eax
801045b4:	83 c3 34             	add    $0x34,%ebx
801045b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045be:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801045c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801045c6:	83 c0 04             	add    $0x4,%eax
801045c9:	39 d8                	cmp    %ebx,%eax
801045cb:	75 f3                	jne    801045c0 <acquire+0x80>
}
801045cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045d0:	5b                   	pop    %ebx
801045d1:	5e                   	pop    %esi
801045d2:	5d                   	pop    %ebp
801045d3:	c3                   	ret    
801045d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return lock->locked && lock->cpu == mycpu();
801045d8:	8b 73 08             	mov    0x8(%ebx),%esi
801045db:	e8 10 f2 ff ff       	call   801037f0 <mycpu>
801045e0:	39 c6                	cmp    %eax,%esi
801045e2:	0f 85 6f ff ff ff    	jne    80104557 <acquire+0x17>
    panic("acquire");
801045e8:	83 ec 0c             	sub    $0xc,%esp
801045eb:	68 3b 78 10 80       	push   $0x8010783b
801045f0:	e8 8b bd ff ff       	call   80100380 <panic>
801045f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104600 <popcli>:

void
popcli(void)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104606:	9c                   	pushf  
80104607:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104608:	f6 c4 02             	test   $0x2,%ah
8010460b:	75 35                	jne    80104642 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010460d:	e8 de f1 ff ff       	call   801037f0 <mycpu>
80104612:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104619:	78 34                	js     8010464f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010461b:	e8 d0 f1 ff ff       	call   801037f0 <mycpu>
80104620:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104626:	85 d2                	test   %edx,%edx
80104628:	74 06                	je     80104630 <popcli+0x30>
    sti();
}
8010462a:	c9                   	leave  
8010462b:	c3                   	ret    
8010462c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104630:	e8 bb f1 ff ff       	call   801037f0 <mycpu>
80104635:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010463b:	85 c0                	test   %eax,%eax
8010463d:	74 eb                	je     8010462a <popcli+0x2a>
  asm volatile("sti");
8010463f:	fb                   	sti    
}
80104640:	c9                   	leave  
80104641:	c3                   	ret    
    panic("popcli - interruptible");
80104642:	83 ec 0c             	sub    $0xc,%esp
80104645:	68 43 78 10 80       	push   $0x80107843
8010464a:	e8 31 bd ff ff       	call   80100380 <panic>
    panic("popcli");
8010464f:	83 ec 0c             	sub    $0xc,%esp
80104652:	68 5a 78 10 80       	push   $0x8010785a
80104657:	e8 24 bd ff ff       	call   80100380 <panic>
8010465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104660 <release>:
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	56                   	push   %esi
80104664:	53                   	push   %ebx
80104665:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
80104668:	8b 03                	mov    (%ebx),%eax
8010466a:	85 c0                	test   %eax,%eax
8010466c:	75 12                	jne    80104680 <release+0x20>
    panic("release");
8010466e:	83 ec 0c             	sub    $0xc,%esp
80104671:	68 61 78 10 80       	push   $0x80107861
80104676:	e8 05 bd ff ff       	call   80100380 <panic>
8010467b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010467f:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
80104680:	8b 73 08             	mov    0x8(%ebx),%esi
80104683:	e8 68 f1 ff ff       	call   801037f0 <mycpu>
80104688:	39 c6                	cmp    %eax,%esi
8010468a:	75 e2                	jne    8010466e <release+0xe>
  lk->pcs[0] = 0;
8010468c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104693:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
8010469a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010469f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801046a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046a8:	5b                   	pop    %ebx
801046a9:	5e                   	pop    %esi
801046aa:	5d                   	pop    %ebp
  popcli();
801046ab:	e9 50 ff ff ff       	jmp    80104600 <popcli>

801046b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	57                   	push   %edi
801046b4:	8b 55 08             	mov    0x8(%ebp),%edx
801046b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801046ba:	53                   	push   %ebx
801046bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
801046be:	89 d7                	mov    %edx,%edi
801046c0:	09 cf                	or     %ecx,%edi
801046c2:	83 e7 03             	and    $0x3,%edi
801046c5:	75 29                	jne    801046f0 <memset+0x40>
    c &= 0xFF;
801046c7:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801046ca:	c1 e0 18             	shl    $0x18,%eax
801046cd:	89 fb                	mov    %edi,%ebx
801046cf:	c1 e9 02             	shr    $0x2,%ecx
801046d2:	c1 e3 10             	shl    $0x10,%ebx
801046d5:	09 d8                	or     %ebx,%eax
801046d7:	09 f8                	or     %edi,%eax
801046d9:	c1 e7 08             	shl    $0x8,%edi
801046dc:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801046de:	89 d7                	mov    %edx,%edi
801046e0:	fc                   	cld    
801046e1:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801046e3:	5b                   	pop    %ebx
801046e4:	89 d0                	mov    %edx,%eax
801046e6:	5f                   	pop    %edi
801046e7:	5d                   	pop    %ebp
801046e8:	c3                   	ret    
801046e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801046f0:	89 d7                	mov    %edx,%edi
801046f2:	fc                   	cld    
801046f3:	f3 aa                	rep stos %al,%es:(%edi)
801046f5:	5b                   	pop    %ebx
801046f6:	89 d0                	mov    %edx,%eax
801046f8:	5f                   	pop    %edi
801046f9:	5d                   	pop    %ebp
801046fa:	c3                   	ret    
801046fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046ff:	90                   	nop

80104700 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	56                   	push   %esi
80104704:	8b 75 10             	mov    0x10(%ebp),%esi
80104707:	8b 55 08             	mov    0x8(%ebp),%edx
8010470a:	53                   	push   %ebx
8010470b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010470e:	85 f6                	test   %esi,%esi
80104710:	74 2e                	je     80104740 <memcmp+0x40>
80104712:	01 c6                	add    %eax,%esi
80104714:	eb 14                	jmp    8010472a <memcmp+0x2a>
80104716:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010471d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104720:	83 c0 01             	add    $0x1,%eax
80104723:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104726:	39 f0                	cmp    %esi,%eax
80104728:	74 16                	je     80104740 <memcmp+0x40>
    if(*s1 != *s2)
8010472a:	0f b6 0a             	movzbl (%edx),%ecx
8010472d:	0f b6 18             	movzbl (%eax),%ebx
80104730:	38 d9                	cmp    %bl,%cl
80104732:	74 ec                	je     80104720 <memcmp+0x20>
      return *s1 - *s2;
80104734:	0f b6 c1             	movzbl %cl,%eax
80104737:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104739:	5b                   	pop    %ebx
8010473a:	5e                   	pop    %esi
8010473b:	5d                   	pop    %ebp
8010473c:	c3                   	ret    
8010473d:	8d 76 00             	lea    0x0(%esi),%esi
80104740:	5b                   	pop    %ebx
  return 0;
80104741:	31 c0                	xor    %eax,%eax
}
80104743:	5e                   	pop    %esi
80104744:	5d                   	pop    %ebp
80104745:	c3                   	ret    
80104746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010474d:	8d 76 00             	lea    0x0(%esi),%esi

80104750 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	57                   	push   %edi
80104754:	8b 55 08             	mov    0x8(%ebp),%edx
80104757:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010475a:	56                   	push   %esi
8010475b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010475e:	39 d6                	cmp    %edx,%esi
80104760:	73 26                	jae    80104788 <memmove+0x38>
80104762:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104765:	39 fa                	cmp    %edi,%edx
80104767:	73 1f                	jae    80104788 <memmove+0x38>
80104769:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
8010476c:	85 c9                	test   %ecx,%ecx
8010476e:	74 0f                	je     8010477f <memmove+0x2f>
      *--d = *--s;
80104770:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104774:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104777:	83 e8 01             	sub    $0x1,%eax
8010477a:	83 f8 ff             	cmp    $0xffffffff,%eax
8010477d:	75 f1                	jne    80104770 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010477f:	5e                   	pop    %esi
80104780:	89 d0                	mov    %edx,%eax
80104782:	5f                   	pop    %edi
80104783:	5d                   	pop    %ebp
80104784:	c3                   	ret    
80104785:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80104788:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
8010478b:	89 d7                	mov    %edx,%edi
8010478d:	85 c9                	test   %ecx,%ecx
8010478f:	74 ee                	je     8010477f <memmove+0x2f>
80104791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104798:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104799:	39 f0                	cmp    %esi,%eax
8010479b:	75 fb                	jne    80104798 <memmove+0x48>
}
8010479d:	5e                   	pop    %esi
8010479e:	89 d0                	mov    %edx,%eax
801047a0:	5f                   	pop    %edi
801047a1:	5d                   	pop    %ebp
801047a2:	c3                   	ret    
801047a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047b0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801047b0:	eb 9e                	jmp    80104750 <memmove>
801047b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047c0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	56                   	push   %esi
801047c4:	8b 75 10             	mov    0x10(%ebp),%esi
801047c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
801047ca:	53                   	push   %ebx
801047cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
801047ce:	85 f6                	test   %esi,%esi
801047d0:	74 36                	je     80104808 <strncmp+0x48>
801047d2:	01 c6                	add    %eax,%esi
801047d4:	eb 18                	jmp    801047ee <strncmp+0x2e>
801047d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047dd:	8d 76 00             	lea    0x0(%esi),%esi
801047e0:	38 da                	cmp    %bl,%dl
801047e2:	75 14                	jne    801047f8 <strncmp+0x38>
    n--, p++, q++;
801047e4:	83 c0 01             	add    $0x1,%eax
801047e7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801047ea:	39 f0                	cmp    %esi,%eax
801047ec:	74 1a                	je     80104808 <strncmp+0x48>
801047ee:	0f b6 11             	movzbl (%ecx),%edx
801047f1:	0f b6 18             	movzbl (%eax),%ebx
801047f4:	84 d2                	test   %dl,%dl
801047f6:	75 e8                	jne    801047e0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801047f8:	0f b6 c2             	movzbl %dl,%eax
801047fb:	29 d8                	sub    %ebx,%eax
}
801047fd:	5b                   	pop    %ebx
801047fe:	5e                   	pop    %esi
801047ff:	5d                   	pop    %ebp
80104800:	c3                   	ret    
80104801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104808:	5b                   	pop    %ebx
    return 0;
80104809:	31 c0                	xor    %eax,%eax
}
8010480b:	5e                   	pop    %esi
8010480c:	5d                   	pop    %ebp
8010480d:	c3                   	ret    
8010480e:	66 90                	xchg   %ax,%ax

80104810 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	57                   	push   %edi
80104814:	56                   	push   %esi
80104815:	8b 75 08             	mov    0x8(%ebp),%esi
80104818:	53                   	push   %ebx
80104819:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010481c:	89 f2                	mov    %esi,%edx
8010481e:	eb 17                	jmp    80104837 <strncpy+0x27>
80104820:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104824:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104827:	83 c2 01             	add    $0x1,%edx
8010482a:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
8010482e:	89 f9                	mov    %edi,%ecx
80104830:	88 4a ff             	mov    %cl,-0x1(%edx)
80104833:	84 c9                	test   %cl,%cl
80104835:	74 09                	je     80104840 <strncpy+0x30>
80104837:	89 c3                	mov    %eax,%ebx
80104839:	83 e8 01             	sub    $0x1,%eax
8010483c:	85 db                	test   %ebx,%ebx
8010483e:	7f e0                	jg     80104820 <strncpy+0x10>
    ;
  while(n-- > 0)
80104840:	89 d1                	mov    %edx,%ecx
80104842:	85 c0                	test   %eax,%eax
80104844:	7e 1d                	jle    80104863 <strncpy+0x53>
80104846:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010484d:	8d 76 00             	lea    0x0(%esi),%esi
    *s++ = 0;
80104850:	83 c1 01             	add    $0x1,%ecx
80104853:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104857:	89 c8                	mov    %ecx,%eax
80104859:	f7 d0                	not    %eax
8010485b:	01 d0                	add    %edx,%eax
8010485d:	01 d8                	add    %ebx,%eax
8010485f:	85 c0                	test   %eax,%eax
80104861:	7f ed                	jg     80104850 <strncpy+0x40>
  return os;
}
80104863:	5b                   	pop    %ebx
80104864:	89 f0                	mov    %esi,%eax
80104866:	5e                   	pop    %esi
80104867:	5f                   	pop    %edi
80104868:	5d                   	pop    %ebp
80104869:	c3                   	ret    
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104870 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	56                   	push   %esi
80104874:	8b 55 10             	mov    0x10(%ebp),%edx
80104877:	8b 75 08             	mov    0x8(%ebp),%esi
8010487a:	53                   	push   %ebx
8010487b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010487e:	85 d2                	test   %edx,%edx
80104880:	7e 25                	jle    801048a7 <safestrcpy+0x37>
80104882:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104886:	89 f2                	mov    %esi,%edx
80104888:	eb 16                	jmp    801048a0 <safestrcpy+0x30>
8010488a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104890:	0f b6 08             	movzbl (%eax),%ecx
80104893:	83 c0 01             	add    $0x1,%eax
80104896:	83 c2 01             	add    $0x1,%edx
80104899:	88 4a ff             	mov    %cl,-0x1(%edx)
8010489c:	84 c9                	test   %cl,%cl
8010489e:	74 04                	je     801048a4 <safestrcpy+0x34>
801048a0:	39 d8                	cmp    %ebx,%eax
801048a2:	75 ec                	jne    80104890 <safestrcpy+0x20>
    ;
  *s = 0;
801048a4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801048a7:	89 f0                	mov    %esi,%eax
801048a9:	5b                   	pop    %ebx
801048aa:	5e                   	pop    %esi
801048ab:	5d                   	pop    %ebp
801048ac:	c3                   	ret    
801048ad:	8d 76 00             	lea    0x0(%esi),%esi

801048b0 <strlen>:

int
strlen(const char *s)
{
801048b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801048b1:	31 c0                	xor    %eax,%eax
{
801048b3:	89 e5                	mov    %esp,%ebp
801048b5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801048b8:	80 3a 00             	cmpb   $0x0,(%edx)
801048bb:	74 0c                	je     801048c9 <strlen+0x19>
801048bd:	8d 76 00             	lea    0x0(%esi),%esi
801048c0:	83 c0 01             	add    $0x1,%eax
801048c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801048c7:	75 f7                	jne    801048c0 <strlen+0x10>
    ;
  return n;
}
801048c9:	5d                   	pop    %ebp
801048ca:	c3                   	ret    

801048cb <swtch>:
801048cb:	8b 44 24 04          	mov    0x4(%esp),%eax
801048cf:	8b 54 24 08          	mov    0x8(%esp),%edx
801048d3:	55                   	push   %ebp
801048d4:	53                   	push   %ebx
801048d5:	56                   	push   %esi
801048d6:	57                   	push   %edi
801048d7:	89 20                	mov    %esp,(%eax)
801048d9:	89 d4                	mov    %edx,%esp
801048db:	5f                   	pop    %edi
801048dc:	5e                   	pop    %esi
801048dd:	5b                   	pop    %ebx
801048de:	5d                   	pop    %ebp
801048df:	c3                   	ret    

801048e0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	53                   	push   %ebx
801048e4:	83 ec 04             	sub    $0x4,%esp
801048e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801048ea:	e8 91 ef ff ff       	call   80103880 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048ef:	8b 00                	mov    (%eax),%eax
801048f1:	39 d8                	cmp    %ebx,%eax
801048f3:	76 1b                	jbe    80104910 <fetchint+0x30>
801048f5:	8d 53 04             	lea    0x4(%ebx),%edx
801048f8:	39 d0                	cmp    %edx,%eax
801048fa:	72 14                	jb     80104910 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801048fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ff:	8b 13                	mov    (%ebx),%edx
80104901:	89 10                	mov    %edx,(%eax)
  return 0;
80104903:	31 c0                	xor    %eax,%eax
}
80104905:	83 c4 04             	add    $0x4,%esp
80104908:	5b                   	pop    %ebx
80104909:	5d                   	pop    %ebp
8010490a:	c3                   	ret    
8010490b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010490f:	90                   	nop
    return -1;
80104910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104915:	eb ee                	jmp    80104905 <fetchint+0x25>
80104917:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010491e:	66 90                	xchg   %ax,%ax

80104920 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	53                   	push   %ebx
80104924:	83 ec 04             	sub    $0x4,%esp
80104927:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010492a:	e8 51 ef ff ff       	call   80103880 <myproc>

  if(addr >= curproc->sz)
8010492f:	39 18                	cmp    %ebx,(%eax)
80104931:	76 2d                	jbe    80104960 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104933:	8b 55 0c             	mov    0xc(%ebp),%edx
80104936:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104938:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010493a:	39 d3                	cmp    %edx,%ebx
8010493c:	73 22                	jae    80104960 <fetchstr+0x40>
8010493e:	89 d8                	mov    %ebx,%eax
80104940:	eb 0d                	jmp    8010494f <fetchstr+0x2f>
80104942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104948:	83 c0 01             	add    $0x1,%eax
8010494b:	39 c2                	cmp    %eax,%edx
8010494d:	76 11                	jbe    80104960 <fetchstr+0x40>
    if(*s == 0)
8010494f:	80 38 00             	cmpb   $0x0,(%eax)
80104952:	75 f4                	jne    80104948 <fetchstr+0x28>
      return s - *pp;
  }
  return -1;
}
80104954:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
80104957:	29 d8                	sub    %ebx,%eax
}
80104959:	5b                   	pop    %ebx
8010495a:	5d                   	pop    %ebp
8010495b:	c3                   	ret    
8010495c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104960:	83 c4 04             	add    $0x4,%esp
    return -1;
80104963:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104968:	5b                   	pop    %ebx
80104969:	5d                   	pop    %ebp
8010496a:	c3                   	ret    
8010496b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010496f:	90                   	nop

80104970 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104975:	e8 06 ef ff ff       	call   80103880 <myproc>
8010497a:	8b 55 08             	mov    0x8(%ebp),%edx
8010497d:	8b 40 18             	mov    0x18(%eax),%eax
80104980:	8b 40 44             	mov    0x44(%eax),%eax
80104983:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104986:	e8 f5 ee ff ff       	call   80103880 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010498b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010498e:	8b 00                	mov    (%eax),%eax
80104990:	39 c6                	cmp    %eax,%esi
80104992:	73 1c                	jae    801049b0 <argint+0x40>
80104994:	8d 53 08             	lea    0x8(%ebx),%edx
80104997:	39 d0                	cmp    %edx,%eax
80104999:	72 15                	jb     801049b0 <argint+0x40>
  *ip = *(int*)(addr);
8010499b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010499e:	8b 53 04             	mov    0x4(%ebx),%edx
801049a1:	89 10                	mov    %edx,(%eax)
  return 0;
801049a3:	31 c0                	xor    %eax,%eax
}
801049a5:	5b                   	pop    %ebx
801049a6:	5e                   	pop    %esi
801049a7:	5d                   	pop    %ebp
801049a8:	c3                   	ret    
801049a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049b5:	eb ee                	jmp    801049a5 <argint+0x35>
801049b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049be:	66 90                	xchg   %ax,%ax

801049c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	56                   	push   %esi
801049c4:	53                   	push   %ebx
801049c5:	83 ec 10             	sub    $0x10,%esp
801049c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801049cb:	e8 b0 ee ff ff       	call   80103880 <myproc>
 
  if(argint(n, &i) < 0)
801049d0:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
801049d3:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
801049d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049d8:	50                   	push   %eax
801049d9:	ff 75 08             	pushl  0x8(%ebp)
801049dc:	e8 8f ff ff ff       	call   80104970 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801049e1:	83 c4 10             	add    $0x10,%esp
801049e4:	85 c0                	test   %eax,%eax
801049e6:	78 28                	js     80104a10 <argptr+0x50>
801049e8:	85 db                	test   %ebx,%ebx
801049ea:	78 24                	js     80104a10 <argptr+0x50>
801049ec:	8b 16                	mov    (%esi),%edx
801049ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f1:	39 c2                	cmp    %eax,%edx
801049f3:	76 1b                	jbe    80104a10 <argptr+0x50>
801049f5:	01 c3                	add    %eax,%ebx
801049f7:	39 da                	cmp    %ebx,%edx
801049f9:	72 15                	jb     80104a10 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801049fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801049fe:	89 02                	mov    %eax,(%edx)
  return 0;
80104a00:	31 c0                	xor    %eax,%eax
}
80104a02:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a05:	5b                   	pop    %ebx
80104a06:	5e                   	pop    %esi
80104a07:	5d                   	pop    %ebp
80104a08:	c3                   	ret    
80104a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a15:	eb eb                	jmp    80104a02 <argptr+0x42>
80104a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a1e:	66 90                	xchg   %ax,%ax

80104a20 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a29:	50                   	push   %eax
80104a2a:	ff 75 08             	pushl  0x8(%ebp)
80104a2d:	e8 3e ff ff ff       	call   80104970 <argint>
80104a32:	83 c4 10             	add    $0x10,%esp
80104a35:	85 c0                	test   %eax,%eax
80104a37:	78 17                	js     80104a50 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104a39:	83 ec 08             	sub    $0x8,%esp
80104a3c:	ff 75 0c             	pushl  0xc(%ebp)
80104a3f:	ff 75 f4             	pushl  -0xc(%ebp)
80104a42:	e8 d9 fe ff ff       	call   80104920 <fetchstr>
80104a47:	83 c4 10             	add    $0x10,%esp
}
80104a4a:	c9                   	leave  
80104a4b:	c3                   	ret    
80104a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a50:	c9                   	leave  
    return -1;
80104a51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a56:	c3                   	ret    
80104a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a5e:	66 90                	xchg   %ax,%ax

80104a60 <syscall>:
[SYS_date]    sys_date,
};

void
syscall(void)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	53                   	push   %ebx
80104a64:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104a67:	e8 14 ee ff ff       	call   80103880 <myproc>
80104a6c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104a6e:	8b 40 18             	mov    0x18(%eax),%eax
80104a71:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a74:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a77:	83 fa 18             	cmp    $0x18,%edx
80104a7a:	77 24                	ja     80104aa0 <syscall+0x40>
80104a7c:	8b 14 85 a0 78 10 80 	mov    -0x7fef8760(,%eax,4),%edx
80104a83:	85 d2                	test   %edx,%edx
80104a85:	74 19                	je     80104aa0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104a87:	ff d2                	call   *%edx
80104a89:	89 c2                	mov    %eax,%edx
80104a8b:	8b 43 18             	mov    0x18(%ebx),%eax
80104a8e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104a91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a94:	c9                   	leave  
80104a95:	c3                   	ret    
80104a96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a9d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104aa0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104aa1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104aa4:	50                   	push   %eax
80104aa5:	ff 73 10             	pushl  0x10(%ebx)
80104aa8:	68 69 78 10 80       	push   $0x80107869
80104aad:	e8 ee bb ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
80104ab2:	8b 43 18             	mov    0x18(%ebx),%eax
80104ab5:	83 c4 10             	add    $0x10,%esp
80104ab8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104abf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ac2:	c9                   	leave  
80104ac3:	c3                   	ret    
80104ac4:	66 90                	xchg   %ax,%ax
80104ac6:	66 90                	xchg   %ax,%ax
80104ac8:	66 90                	xchg   %ax,%ax
80104aca:	66 90                	xchg   %ax,%ax
80104acc:	66 90                	xchg   %ax,%ax
80104ace:	66 90                	xchg   %ax,%ax

80104ad0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	57                   	push   %edi
80104ad4:	56                   	push   %esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ad5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104ad8:	53                   	push   %ebx
80104ad9:	83 ec 44             	sub    $0x44,%esp
80104adc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104adf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104ae2:	57                   	push   %edi
80104ae3:	50                   	push   %eax
{
80104ae4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104ae7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104aea:	e8 f1 d4 ff ff       	call   80101fe0 <nameiparent>
80104aef:	83 c4 10             	add    $0x10,%esp
80104af2:	85 c0                	test   %eax,%eax
80104af4:	0f 84 46 01 00 00    	je     80104c40 <create+0x170>
    return 0;
  ilock(dp);
80104afa:	83 ec 0c             	sub    $0xc,%esp
80104afd:	89 c3                	mov    %eax,%ebx
80104aff:	50                   	push   %eax
80104b00:	e8 1b cc ff ff       	call   80101720 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104b05:	83 c4 0c             	add    $0xc,%esp
80104b08:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b0b:	50                   	push   %eax
80104b0c:	57                   	push   %edi
80104b0d:	53                   	push   %ebx
80104b0e:	e8 3d d1 ff ff       	call   80101c50 <dirlookup>
80104b13:	83 c4 10             	add    $0x10,%esp
80104b16:	89 c6                	mov    %eax,%esi
80104b18:	85 c0                	test   %eax,%eax
80104b1a:	74 54                	je     80104b70 <create+0xa0>
    iunlockput(dp);
80104b1c:	83 ec 0c             	sub    $0xc,%esp
80104b1f:	53                   	push   %ebx
80104b20:	e8 8b ce ff ff       	call   801019b0 <iunlockput>
    ilock(ip);
80104b25:	89 34 24             	mov    %esi,(%esp)
80104b28:	e8 f3 cb ff ff       	call   80101720 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b2d:	83 c4 10             	add    $0x10,%esp
80104b30:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104b35:	75 19                	jne    80104b50 <create+0x80>
80104b37:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104b3c:	75 12                	jne    80104b50 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b41:	89 f0                	mov    %esi,%eax
80104b43:	5b                   	pop    %ebx
80104b44:	5e                   	pop    %esi
80104b45:	5f                   	pop    %edi
80104b46:	5d                   	pop    %ebp
80104b47:	c3                   	ret    
80104b48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b4f:	90                   	nop
    iunlockput(ip);
80104b50:	83 ec 0c             	sub    $0xc,%esp
80104b53:	56                   	push   %esi
    return 0;
80104b54:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104b56:	e8 55 ce ff ff       	call   801019b0 <iunlockput>
    return 0;
80104b5b:	83 c4 10             	add    $0x10,%esp
}
80104b5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b61:	89 f0                	mov    %esi,%eax
80104b63:	5b                   	pop    %ebx
80104b64:	5e                   	pop    %esi
80104b65:	5f                   	pop    %edi
80104b66:	5d                   	pop    %ebp
80104b67:	c3                   	ret    
80104b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b6f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104b70:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104b74:	83 ec 08             	sub    $0x8,%esp
80104b77:	50                   	push   %eax
80104b78:	ff 33                	pushl  (%ebx)
80104b7a:	e8 31 ca ff ff       	call   801015b0 <ialloc>
80104b7f:	83 c4 10             	add    $0x10,%esp
80104b82:	89 c6                	mov    %eax,%esi
80104b84:	85 c0                	test   %eax,%eax
80104b86:	0f 84 cd 00 00 00    	je     80104c59 <create+0x189>
  ilock(ip);
80104b8c:	83 ec 0c             	sub    $0xc,%esp
80104b8f:	50                   	push   %eax
80104b90:	e8 8b cb ff ff       	call   80101720 <ilock>
  ip->major = major;
80104b95:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104b99:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104b9d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104ba1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104ba5:	b8 01 00 00 00       	mov    $0x1,%eax
80104baa:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104bae:	89 34 24             	mov    %esi,(%esp)
80104bb1:	e8 ba ca ff ff       	call   80101670 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104bb6:	83 c4 10             	add    $0x10,%esp
80104bb9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104bbe:	74 30                	je     80104bf0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104bc0:	83 ec 04             	sub    $0x4,%esp
80104bc3:	ff 76 04             	pushl  0x4(%esi)
80104bc6:	57                   	push   %edi
80104bc7:	53                   	push   %ebx
80104bc8:	e8 33 d3 ff ff       	call   80101f00 <dirlink>
80104bcd:	83 c4 10             	add    $0x10,%esp
80104bd0:	85 c0                	test   %eax,%eax
80104bd2:	78 78                	js     80104c4c <create+0x17c>
  iunlockput(dp);
80104bd4:	83 ec 0c             	sub    $0xc,%esp
80104bd7:	53                   	push   %ebx
80104bd8:	e8 d3 cd ff ff       	call   801019b0 <iunlockput>
  return ip;
80104bdd:	83 c4 10             	add    $0x10,%esp
}
80104be0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104be3:	89 f0                	mov    %esi,%eax
80104be5:	5b                   	pop    %ebx
80104be6:	5e                   	pop    %esi
80104be7:	5f                   	pop    %edi
80104be8:	5d                   	pop    %ebp
80104be9:	c3                   	ret    
80104bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104bf0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104bf3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104bf8:	53                   	push   %ebx
80104bf9:	e8 72 ca ff ff       	call   80101670 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bfe:	83 c4 0c             	add    $0xc,%esp
80104c01:	ff 76 04             	pushl  0x4(%esi)
80104c04:	68 24 79 10 80       	push   $0x80107924
80104c09:	56                   	push   %esi
80104c0a:	e8 f1 d2 ff ff       	call   80101f00 <dirlink>
80104c0f:	83 c4 10             	add    $0x10,%esp
80104c12:	85 c0                	test   %eax,%eax
80104c14:	78 18                	js     80104c2e <create+0x15e>
80104c16:	83 ec 04             	sub    $0x4,%esp
80104c19:	ff 73 04             	pushl  0x4(%ebx)
80104c1c:	68 23 79 10 80       	push   $0x80107923
80104c21:	56                   	push   %esi
80104c22:	e8 d9 d2 ff ff       	call   80101f00 <dirlink>
80104c27:	83 c4 10             	add    $0x10,%esp
80104c2a:	85 c0                	test   %eax,%eax
80104c2c:	79 92                	jns    80104bc0 <create+0xf0>
      panic("create dots");
80104c2e:	83 ec 0c             	sub    $0xc,%esp
80104c31:	68 17 79 10 80       	push   $0x80107917
80104c36:	e8 45 b7 ff ff       	call   80100380 <panic>
80104c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c3f:	90                   	nop
}
80104c40:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104c43:	31 f6                	xor    %esi,%esi
}
80104c45:	5b                   	pop    %ebx
80104c46:	89 f0                	mov    %esi,%eax
80104c48:	5e                   	pop    %esi
80104c49:	5f                   	pop    %edi
80104c4a:	5d                   	pop    %ebp
80104c4b:	c3                   	ret    
    panic("create: dirlink");
80104c4c:	83 ec 0c             	sub    $0xc,%esp
80104c4f:	68 26 79 10 80       	push   $0x80107926
80104c54:	e8 27 b7 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104c59:	83 ec 0c             	sub    $0xc,%esp
80104c5c:	68 08 79 10 80       	push   $0x80107908
80104c61:	e8 1a b7 ff ff       	call   80100380 <panic>
80104c66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c6d:	8d 76 00             	lea    0x0(%esi),%esi

80104c70 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	56                   	push   %esi
80104c74:	89 d6                	mov    %edx,%esi
80104c76:	53                   	push   %ebx
80104c77:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104c79:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104c7c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104c7f:	50                   	push   %eax
80104c80:	6a 00                	push   $0x0
80104c82:	e8 e9 fc ff ff       	call   80104970 <argint>
80104c87:	83 c4 10             	add    $0x10,%esp
80104c8a:	85 c0                	test   %eax,%eax
80104c8c:	78 2a                	js     80104cb8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c8e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c92:	77 24                	ja     80104cb8 <argfd.constprop.0+0x48>
80104c94:	e8 e7 eb ff ff       	call   80103880 <myproc>
80104c99:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c9c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104ca0:	85 c0                	test   %eax,%eax
80104ca2:	74 14                	je     80104cb8 <argfd.constprop.0+0x48>
  if(pfd)
80104ca4:	85 db                	test   %ebx,%ebx
80104ca6:	74 02                	je     80104caa <argfd.constprop.0+0x3a>
    *pfd = fd;
80104ca8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104caa:	89 06                	mov    %eax,(%esi)
  return 0;
80104cac:	31 c0                	xor    %eax,%eax
}
80104cae:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cb1:	5b                   	pop    %ebx
80104cb2:	5e                   	pop    %esi
80104cb3:	5d                   	pop    %ebp
80104cb4:	c3                   	ret    
80104cb5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104cb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cbd:	eb ef                	jmp    80104cae <argfd.constprop.0+0x3e>
80104cbf:	90                   	nop

80104cc0 <sys_dup>:
{
80104cc0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104cc1:	31 c0                	xor    %eax,%eax
{
80104cc3:	89 e5                	mov    %esp,%ebp
80104cc5:	56                   	push   %esi
80104cc6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104cc7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104cca:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104ccd:	e8 9e ff ff ff       	call   80104c70 <argfd.constprop.0>
80104cd2:	85 c0                	test   %eax,%eax
80104cd4:	78 1a                	js     80104cf0 <sys_dup+0x30>
  if((fd=fdalloc(f)) < 0)
80104cd6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104cd9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104cdb:	e8 a0 eb ff ff       	call   80103880 <myproc>
    if(curproc->ofile[fd] == 0){
80104ce0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ce4:	85 d2                	test   %edx,%edx
80104ce6:	74 18                	je     80104d00 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
80104ce8:	83 c3 01             	add    $0x1,%ebx
80104ceb:	83 fb 10             	cmp    $0x10,%ebx
80104cee:	75 f0                	jne    80104ce0 <sys_dup+0x20>
}
80104cf0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104cf3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104cf8:	89 d8                	mov    %ebx,%eax
80104cfa:	5b                   	pop    %ebx
80104cfb:	5e                   	pop    %esi
80104cfc:	5d                   	pop    %ebp
80104cfd:	c3                   	ret    
80104cfe:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80104d00:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104d04:	83 ec 0c             	sub    $0xc,%esp
80104d07:	ff 75 f4             	pushl  -0xc(%ebp)
80104d0a:	e8 61 c1 ff ff       	call   80100e70 <filedup>
  return fd;
80104d0f:	83 c4 10             	add    $0x10,%esp
}
80104d12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d15:	89 d8                	mov    %ebx,%eax
80104d17:	5b                   	pop    %ebx
80104d18:	5e                   	pop    %esi
80104d19:	5d                   	pop    %ebp
80104d1a:	c3                   	ret    
80104d1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d1f:	90                   	nop

80104d20 <sys_read>:
{
80104d20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d21:	31 c0                	xor    %eax,%eax
{
80104d23:	89 e5                	mov    %esp,%ebp
80104d25:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d2b:	e8 40 ff ff ff       	call   80104c70 <argfd.constprop.0>
80104d30:	85 c0                	test   %eax,%eax
80104d32:	78 4c                	js     80104d80 <sys_read+0x60>
80104d34:	83 ec 08             	sub    $0x8,%esp
80104d37:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d3a:	50                   	push   %eax
80104d3b:	6a 02                	push   $0x2
80104d3d:	e8 2e fc ff ff       	call   80104970 <argint>
80104d42:	83 c4 10             	add    $0x10,%esp
80104d45:	85 c0                	test   %eax,%eax
80104d47:	78 37                	js     80104d80 <sys_read+0x60>
80104d49:	83 ec 04             	sub    $0x4,%esp
80104d4c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d52:	50                   	push   %eax
80104d53:	6a 01                	push   $0x1
80104d55:	e8 66 fc ff ff       	call   801049c0 <argptr>
80104d5a:	83 c4 10             	add    $0x10,%esp
80104d5d:	85 c0                	test   %eax,%eax
80104d5f:	78 1f                	js     80104d80 <sys_read+0x60>
  return fileread(f, p, n);
80104d61:	83 ec 04             	sub    $0x4,%esp
80104d64:	ff 75 f0             	pushl  -0x10(%ebp)
80104d67:	ff 75 f4             	pushl  -0xc(%ebp)
80104d6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d6d:	e8 7e c2 ff ff       	call   80100ff0 <fileread>
80104d72:	83 c4 10             	add    $0x10,%esp
}
80104d75:	c9                   	leave  
80104d76:	c3                   	ret    
80104d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d7e:	66 90                	xchg   %ax,%ax
80104d80:	c9                   	leave  
    return -1;
80104d81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d86:	c3                   	ret    
80104d87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d8e:	66 90                	xchg   %ax,%ax

80104d90 <sys_write>:
{
80104d90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d91:	31 c0                	xor    %eax,%eax
{
80104d93:	89 e5                	mov    %esp,%ebp
80104d95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d9b:	e8 d0 fe ff ff       	call   80104c70 <argfd.constprop.0>
80104da0:	85 c0                	test   %eax,%eax
80104da2:	78 4c                	js     80104df0 <sys_write+0x60>
80104da4:	83 ec 08             	sub    $0x8,%esp
80104da7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104daa:	50                   	push   %eax
80104dab:	6a 02                	push   $0x2
80104dad:	e8 be fb ff ff       	call   80104970 <argint>
80104db2:	83 c4 10             	add    $0x10,%esp
80104db5:	85 c0                	test   %eax,%eax
80104db7:	78 37                	js     80104df0 <sys_write+0x60>
80104db9:	83 ec 04             	sub    $0x4,%esp
80104dbc:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc2:	50                   	push   %eax
80104dc3:	6a 01                	push   $0x1
80104dc5:	e8 f6 fb ff ff       	call   801049c0 <argptr>
80104dca:	83 c4 10             	add    $0x10,%esp
80104dcd:	85 c0                	test   %eax,%eax
80104dcf:	78 1f                	js     80104df0 <sys_write+0x60>
  return filewrite(f, p, n);
80104dd1:	83 ec 04             	sub    $0x4,%esp
80104dd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104dd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dda:	ff 75 ec             	pushl  -0x14(%ebp)
80104ddd:	e8 9e c2 ff ff       	call   80101080 <filewrite>
80104de2:	83 c4 10             	add    $0x10,%esp
}
80104de5:	c9                   	leave  
80104de6:	c3                   	ret    
80104de7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dee:	66 90                	xchg   %ax,%ax
80104df0:	c9                   	leave  
    return -1;
80104df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104df6:	c3                   	ret    
80104df7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dfe:	66 90                	xchg   %ax,%ax

80104e00 <sys_close>:
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104e06:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e09:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e0c:	e8 5f fe ff ff       	call   80104c70 <argfd.constprop.0>
80104e11:	85 c0                	test   %eax,%eax
80104e13:	78 2b                	js     80104e40 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104e15:	e8 66 ea ff ff       	call   80103880 <myproc>
80104e1a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e1d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104e20:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104e27:	00 
  fileclose(f);
80104e28:	ff 75 f4             	pushl  -0xc(%ebp)
80104e2b:	e8 90 c0 ff ff       	call   80100ec0 <fileclose>
  return 0;
80104e30:	83 c4 10             	add    $0x10,%esp
80104e33:	31 c0                	xor    %eax,%eax
}
80104e35:	c9                   	leave  
80104e36:	c3                   	ret    
80104e37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e3e:	66 90                	xchg   %ax,%ax
80104e40:	c9                   	leave  
    return -1;
80104e41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e46:	c3                   	ret    
80104e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e4e:	66 90                	xchg   %ax,%ax

80104e50 <sys_fstat>:
{
80104e50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e51:	31 c0                	xor    %eax,%eax
{
80104e53:	89 e5                	mov    %esp,%ebp
80104e55:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e58:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e5b:	e8 10 fe ff ff       	call   80104c70 <argfd.constprop.0>
80104e60:	85 c0                	test   %eax,%eax
80104e62:	78 2c                	js     80104e90 <sys_fstat+0x40>
80104e64:	83 ec 04             	sub    $0x4,%esp
80104e67:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e6a:	6a 14                	push   $0x14
80104e6c:	50                   	push   %eax
80104e6d:	6a 01                	push   $0x1
80104e6f:	e8 4c fb ff ff       	call   801049c0 <argptr>
80104e74:	83 c4 10             	add    $0x10,%esp
80104e77:	85 c0                	test   %eax,%eax
80104e79:	78 15                	js     80104e90 <sys_fstat+0x40>
  return filestat(f, st);
80104e7b:	83 ec 08             	sub    $0x8,%esp
80104e7e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e81:	ff 75 f0             	pushl  -0x10(%ebp)
80104e84:	e8 17 c1 ff ff       	call   80100fa0 <filestat>
80104e89:	83 c4 10             	add    $0x10,%esp
}
80104e8c:	c9                   	leave  
80104e8d:	c3                   	ret    
80104e8e:	66 90                	xchg   %ax,%ax
80104e90:	c9                   	leave  
    return -1;
80104e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e96:	c3                   	ret    
80104e97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e9e:	66 90                	xchg   %ax,%ax

80104ea0 <sys_link>:
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	57                   	push   %edi
80104ea4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ea5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104ea8:	53                   	push   %ebx
80104ea9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104eac:	50                   	push   %eax
80104ead:	6a 00                	push   $0x0
80104eaf:	e8 6c fb ff ff       	call   80104a20 <argstr>
80104eb4:	83 c4 10             	add    $0x10,%esp
80104eb7:	85 c0                	test   %eax,%eax
80104eb9:	0f 88 fb 00 00 00    	js     80104fba <sys_link+0x11a>
80104ebf:	83 ec 08             	sub    $0x8,%esp
80104ec2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104ec5:	50                   	push   %eax
80104ec6:	6a 01                	push   $0x1
80104ec8:	e8 53 fb ff ff       	call   80104a20 <argstr>
80104ecd:	83 c4 10             	add    $0x10,%esp
80104ed0:	85 c0                	test   %eax,%eax
80104ed2:	0f 88 e2 00 00 00    	js     80104fba <sys_link+0x11a>
  begin_op();
80104ed8:	e8 a3 dd ff ff       	call   80102c80 <begin_op>
  if((ip = namei(old)) == 0){
80104edd:	83 ec 0c             	sub    $0xc,%esp
80104ee0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104ee3:	e8 d8 d0 ff ff       	call   80101fc0 <namei>
80104ee8:	83 c4 10             	add    $0x10,%esp
80104eeb:	89 c3                	mov    %eax,%ebx
80104eed:	85 c0                	test   %eax,%eax
80104eef:	0f 84 e4 00 00 00    	je     80104fd9 <sys_link+0x139>
  ilock(ip);
80104ef5:	83 ec 0c             	sub    $0xc,%esp
80104ef8:	50                   	push   %eax
80104ef9:	e8 22 c8 ff ff       	call   80101720 <ilock>
  if(ip->type == T_DIR){
80104efe:	83 c4 10             	add    $0x10,%esp
80104f01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f06:	0f 84 b5 00 00 00    	je     80104fc1 <sys_link+0x121>
  iupdate(ip);
80104f0c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80104f0f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80104f14:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104f17:	53                   	push   %ebx
80104f18:	e8 53 c7 ff ff       	call   80101670 <iupdate>
  iunlock(ip);
80104f1d:	89 1c 24             	mov    %ebx,(%esp)
80104f20:	e8 db c8 ff ff       	call   80101800 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104f25:	58                   	pop    %eax
80104f26:	5a                   	pop    %edx
80104f27:	57                   	push   %edi
80104f28:	ff 75 d0             	pushl  -0x30(%ebp)
80104f2b:	e8 b0 d0 ff ff       	call   80101fe0 <nameiparent>
80104f30:	83 c4 10             	add    $0x10,%esp
80104f33:	89 c6                	mov    %eax,%esi
80104f35:	85 c0                	test   %eax,%eax
80104f37:	74 5b                	je     80104f94 <sys_link+0xf4>
  ilock(dp);
80104f39:	83 ec 0c             	sub    $0xc,%esp
80104f3c:	50                   	push   %eax
80104f3d:	e8 de c7 ff ff       	call   80101720 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f42:	8b 03                	mov    (%ebx),%eax
80104f44:	83 c4 10             	add    $0x10,%esp
80104f47:	39 06                	cmp    %eax,(%esi)
80104f49:	75 3d                	jne    80104f88 <sys_link+0xe8>
80104f4b:	83 ec 04             	sub    $0x4,%esp
80104f4e:	ff 73 04             	pushl  0x4(%ebx)
80104f51:	57                   	push   %edi
80104f52:	56                   	push   %esi
80104f53:	e8 a8 cf ff ff       	call   80101f00 <dirlink>
80104f58:	83 c4 10             	add    $0x10,%esp
80104f5b:	85 c0                	test   %eax,%eax
80104f5d:	78 29                	js     80104f88 <sys_link+0xe8>
  iunlockput(dp);
80104f5f:	83 ec 0c             	sub    $0xc,%esp
80104f62:	56                   	push   %esi
80104f63:	e8 48 ca ff ff       	call   801019b0 <iunlockput>
  iput(ip);
80104f68:	89 1c 24             	mov    %ebx,(%esp)
80104f6b:	e8 e0 c8 ff ff       	call   80101850 <iput>
  end_op();
80104f70:	e8 7b dd ff ff       	call   80102cf0 <end_op>
  return 0;
80104f75:	83 c4 10             	add    $0x10,%esp
80104f78:	31 c0                	xor    %eax,%eax
}
80104f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f7d:	5b                   	pop    %ebx
80104f7e:	5e                   	pop    %esi
80104f7f:	5f                   	pop    %edi
80104f80:	5d                   	pop    %ebp
80104f81:	c3                   	ret    
80104f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104f88:	83 ec 0c             	sub    $0xc,%esp
80104f8b:	56                   	push   %esi
80104f8c:	e8 1f ca ff ff       	call   801019b0 <iunlockput>
    goto bad;
80104f91:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104f94:	83 ec 0c             	sub    $0xc,%esp
80104f97:	53                   	push   %ebx
80104f98:	e8 83 c7 ff ff       	call   80101720 <ilock>
  ip->nlink--;
80104f9d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fa2:	89 1c 24             	mov    %ebx,(%esp)
80104fa5:	e8 c6 c6 ff ff       	call   80101670 <iupdate>
  iunlockput(ip);
80104faa:	89 1c 24             	mov    %ebx,(%esp)
80104fad:	e8 fe c9 ff ff       	call   801019b0 <iunlockput>
  end_op();
80104fb2:	e8 39 dd ff ff       	call   80102cf0 <end_op>
  return -1;
80104fb7:	83 c4 10             	add    $0x10,%esp
80104fba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fbf:	eb b9                	jmp    80104f7a <sys_link+0xda>
    iunlockput(ip);
80104fc1:	83 ec 0c             	sub    $0xc,%esp
80104fc4:	53                   	push   %ebx
80104fc5:	e8 e6 c9 ff ff       	call   801019b0 <iunlockput>
    end_op();
80104fca:	e8 21 dd ff ff       	call   80102cf0 <end_op>
    return -1;
80104fcf:	83 c4 10             	add    $0x10,%esp
80104fd2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fd7:	eb a1                	jmp    80104f7a <sys_link+0xda>
    end_op();
80104fd9:	e8 12 dd ff ff       	call   80102cf0 <end_op>
    return -1;
80104fde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fe3:	eb 95                	jmp    80104f7a <sys_link+0xda>
80104fe5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ff0 <sys_unlink>:
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	57                   	push   %edi
80104ff4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80104ff5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104ff8:	53                   	push   %ebx
80104ff9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80104ffc:	50                   	push   %eax
80104ffd:	6a 00                	push   $0x0
80104fff:	e8 1c fa ff ff       	call   80104a20 <argstr>
80105004:	83 c4 10             	add    $0x10,%esp
80105007:	85 c0                	test   %eax,%eax
80105009:	0f 88 91 01 00 00    	js     801051a0 <sys_unlink+0x1b0>
  begin_op();
8010500f:	e8 6c dc ff ff       	call   80102c80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105014:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105017:	83 ec 08             	sub    $0x8,%esp
8010501a:	53                   	push   %ebx
8010501b:	ff 75 c0             	pushl  -0x40(%ebp)
8010501e:	e8 bd cf ff ff       	call   80101fe0 <nameiparent>
80105023:	83 c4 10             	add    $0x10,%esp
80105026:	89 c6                	mov    %eax,%esi
80105028:	85 c0                	test   %eax,%eax
8010502a:	0f 84 7a 01 00 00    	je     801051aa <sys_unlink+0x1ba>
  ilock(dp);
80105030:	83 ec 0c             	sub    $0xc,%esp
80105033:	50                   	push   %eax
80105034:	e8 e7 c6 ff ff       	call   80101720 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105039:	58                   	pop    %eax
8010503a:	5a                   	pop    %edx
8010503b:	68 24 79 10 80       	push   $0x80107924
80105040:	53                   	push   %ebx
80105041:	e8 ea cb ff ff       	call   80101c30 <namecmp>
80105046:	83 c4 10             	add    $0x10,%esp
80105049:	85 c0                	test   %eax,%eax
8010504b:	0f 84 0f 01 00 00    	je     80105160 <sys_unlink+0x170>
80105051:	83 ec 08             	sub    $0x8,%esp
80105054:	68 23 79 10 80       	push   $0x80107923
80105059:	53                   	push   %ebx
8010505a:	e8 d1 cb ff ff       	call   80101c30 <namecmp>
8010505f:	83 c4 10             	add    $0x10,%esp
80105062:	85 c0                	test   %eax,%eax
80105064:	0f 84 f6 00 00 00    	je     80105160 <sys_unlink+0x170>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010506a:	83 ec 04             	sub    $0x4,%esp
8010506d:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105070:	50                   	push   %eax
80105071:	53                   	push   %ebx
80105072:	56                   	push   %esi
80105073:	e8 d8 cb ff ff       	call   80101c50 <dirlookup>
80105078:	83 c4 10             	add    $0x10,%esp
8010507b:	89 c3                	mov    %eax,%ebx
8010507d:	85 c0                	test   %eax,%eax
8010507f:	0f 84 db 00 00 00    	je     80105160 <sys_unlink+0x170>
  ilock(ip);
80105085:	83 ec 0c             	sub    $0xc,%esp
80105088:	50                   	push   %eax
80105089:	e8 92 c6 ff ff       	call   80101720 <ilock>
  if(ip->nlink < 1)
8010508e:	83 c4 10             	add    $0x10,%esp
80105091:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105096:	0f 8e 37 01 00 00    	jle    801051d3 <sys_unlink+0x1e3>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010509c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050a1:	8d 7d d8             	lea    -0x28(%ebp),%edi
801050a4:	74 6a                	je     80105110 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801050a6:	83 ec 04             	sub    $0x4,%esp
801050a9:	6a 10                	push   $0x10
801050ab:	6a 00                	push   $0x0
801050ad:	57                   	push   %edi
801050ae:	e8 fd f5 ff ff       	call   801046b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050b3:	6a 10                	push   $0x10
801050b5:	ff 75 c4             	pushl  -0x3c(%ebp)
801050b8:	57                   	push   %edi
801050b9:	56                   	push   %esi
801050ba:	e8 41 ca ff ff       	call   80101b00 <writei>
801050bf:	83 c4 20             	add    $0x20,%esp
801050c2:	83 f8 10             	cmp    $0x10,%eax
801050c5:	0f 85 fb 00 00 00    	jne    801051c6 <sys_unlink+0x1d6>
  if(ip->type == T_DIR){
801050cb:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050d0:	0f 84 aa 00 00 00    	je     80105180 <sys_unlink+0x190>
  iunlockput(dp);
801050d6:	83 ec 0c             	sub    $0xc,%esp
801050d9:	56                   	push   %esi
801050da:	e8 d1 c8 ff ff       	call   801019b0 <iunlockput>
  ip->nlink--;
801050df:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050e4:	89 1c 24             	mov    %ebx,(%esp)
801050e7:	e8 84 c5 ff ff       	call   80101670 <iupdate>
  iunlockput(ip);
801050ec:	89 1c 24             	mov    %ebx,(%esp)
801050ef:	e8 bc c8 ff ff       	call   801019b0 <iunlockput>
  end_op();
801050f4:	e8 f7 db ff ff       	call   80102cf0 <end_op>
  return 0;
801050f9:	83 c4 10             	add    $0x10,%esp
801050fc:	31 c0                	xor    %eax,%eax
}
801050fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105101:	5b                   	pop    %ebx
80105102:	5e                   	pop    %esi
80105103:	5f                   	pop    %edi
80105104:	5d                   	pop    %ebp
80105105:	c3                   	ret    
80105106:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010510d:	8d 76 00             	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105110:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105114:	76 90                	jbe    801050a6 <sys_unlink+0xb6>
80105116:	ba 20 00 00 00       	mov    $0x20,%edx
8010511b:	eb 0f                	jmp    8010512c <sys_unlink+0x13c>
8010511d:	8d 76 00             	lea    0x0(%esi),%esi
80105120:	83 c2 10             	add    $0x10,%edx
80105123:	39 53 58             	cmp    %edx,0x58(%ebx)
80105126:	0f 86 7a ff ff ff    	jbe    801050a6 <sys_unlink+0xb6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010512c:	6a 10                	push   $0x10
8010512e:	52                   	push   %edx
8010512f:	57                   	push   %edi
80105130:	53                   	push   %ebx
80105131:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105134:	e8 c7 c8 ff ff       	call   80101a00 <readi>
80105139:	83 c4 10             	add    $0x10,%esp
8010513c:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010513f:	83 f8 10             	cmp    $0x10,%eax
80105142:	75 75                	jne    801051b9 <sys_unlink+0x1c9>
    if(de.inum != 0)
80105144:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105149:	74 d5                	je     80105120 <sys_unlink+0x130>
    iunlockput(ip);
8010514b:	83 ec 0c             	sub    $0xc,%esp
8010514e:	53                   	push   %ebx
8010514f:	e8 5c c8 ff ff       	call   801019b0 <iunlockput>
    goto bad;
80105154:	83 c4 10             	add    $0x10,%esp
80105157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010515e:	66 90                	xchg   %ax,%ax
  iunlockput(dp);
80105160:	83 ec 0c             	sub    $0xc,%esp
80105163:	56                   	push   %esi
80105164:	e8 47 c8 ff ff       	call   801019b0 <iunlockput>
  end_op();
80105169:	e8 82 db ff ff       	call   80102cf0 <end_op>
  return -1;
8010516e:	83 c4 10             	add    $0x10,%esp
80105171:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105176:	eb 86                	jmp    801050fe <sys_unlink+0x10e>
80105178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010517f:	90                   	nop
    iupdate(dp);
80105180:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105183:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105188:	56                   	push   %esi
80105189:	e8 e2 c4 ff ff       	call   80101670 <iupdate>
8010518e:	83 c4 10             	add    $0x10,%esp
80105191:	e9 40 ff ff ff       	jmp    801050d6 <sys_unlink+0xe6>
80105196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010519d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801051a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051a5:	e9 54 ff ff ff       	jmp    801050fe <sys_unlink+0x10e>
    end_op();
801051aa:	e8 41 db ff ff       	call   80102cf0 <end_op>
    return -1;
801051af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051b4:	e9 45 ff ff ff       	jmp    801050fe <sys_unlink+0x10e>
      panic("isdirempty: readi");
801051b9:	83 ec 0c             	sub    $0xc,%esp
801051bc:	68 48 79 10 80       	push   $0x80107948
801051c1:	e8 ba b1 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
801051c6:	83 ec 0c             	sub    $0xc,%esp
801051c9:	68 5a 79 10 80       	push   $0x8010795a
801051ce:	e8 ad b1 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
801051d3:	83 ec 0c             	sub    $0xc,%esp
801051d6:	68 36 79 10 80       	push   $0x80107936
801051db:	e8 a0 b1 ff ff       	call   80100380 <panic>

801051e0 <sys_open>:

int
sys_open(void)
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	57                   	push   %edi
801051e4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051e5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801051e8:	53                   	push   %ebx
801051e9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051ec:	50                   	push   %eax
801051ed:	6a 00                	push   $0x0
801051ef:	e8 2c f8 ff ff       	call   80104a20 <argstr>
801051f4:	83 c4 10             	add    $0x10,%esp
801051f7:	85 c0                	test   %eax,%eax
801051f9:	0f 88 8e 00 00 00    	js     8010528d <sys_open+0xad>
801051ff:	83 ec 08             	sub    $0x8,%esp
80105202:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105205:	50                   	push   %eax
80105206:	6a 01                	push   $0x1
80105208:	e8 63 f7 ff ff       	call   80104970 <argint>
8010520d:	83 c4 10             	add    $0x10,%esp
80105210:	85 c0                	test   %eax,%eax
80105212:	78 79                	js     8010528d <sys_open+0xad>
    return -1;

  begin_op();
80105214:	e8 67 da ff ff       	call   80102c80 <begin_op>

  if(omode & O_CREATE){
80105219:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010521d:	75 79                	jne    80105298 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010521f:	83 ec 0c             	sub    $0xc,%esp
80105222:	ff 75 e0             	pushl  -0x20(%ebp)
80105225:	e8 96 cd ff ff       	call   80101fc0 <namei>
8010522a:	83 c4 10             	add    $0x10,%esp
8010522d:	89 c6                	mov    %eax,%esi
8010522f:	85 c0                	test   %eax,%eax
80105231:	0f 84 7e 00 00 00    	je     801052b5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105237:	83 ec 0c             	sub    $0xc,%esp
8010523a:	50                   	push   %eax
8010523b:	e8 e0 c4 ff ff       	call   80101720 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105240:	83 c4 10             	add    $0x10,%esp
80105243:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105248:	0f 84 c2 00 00 00    	je     80105310 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010524e:	e8 ad bb ff ff       	call   80100e00 <filealloc>
80105253:	89 c7                	mov    %eax,%edi
80105255:	85 c0                	test   %eax,%eax
80105257:	74 23                	je     8010527c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105259:	e8 22 e6 ff ff       	call   80103880 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010525e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105260:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105264:	85 d2                	test   %edx,%edx
80105266:	74 60                	je     801052c8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105268:	83 c3 01             	add    $0x1,%ebx
8010526b:	83 fb 10             	cmp    $0x10,%ebx
8010526e:	75 f0                	jne    80105260 <sys_open+0x80>
    if(f)
      fileclose(f);
80105270:	83 ec 0c             	sub    $0xc,%esp
80105273:	57                   	push   %edi
80105274:	e8 47 bc ff ff       	call   80100ec0 <fileclose>
80105279:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010527c:	83 ec 0c             	sub    $0xc,%esp
8010527f:	56                   	push   %esi
80105280:	e8 2b c7 ff ff       	call   801019b0 <iunlockput>
    end_op();
80105285:	e8 66 da ff ff       	call   80102cf0 <end_op>
    return -1;
8010528a:	83 c4 10             	add    $0x10,%esp
8010528d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105292:	eb 6d                	jmp    80105301 <sys_open+0x121>
80105294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105298:	83 ec 0c             	sub    $0xc,%esp
8010529b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010529e:	31 c9                	xor    %ecx,%ecx
801052a0:	ba 02 00 00 00       	mov    $0x2,%edx
801052a5:	6a 00                	push   $0x0
801052a7:	e8 24 f8 ff ff       	call   80104ad0 <create>
    if(ip == 0){
801052ac:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801052af:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801052b1:	85 c0                	test   %eax,%eax
801052b3:	75 99                	jne    8010524e <sys_open+0x6e>
      end_op();
801052b5:	e8 36 da ff ff       	call   80102cf0 <end_op>
      return -1;
801052ba:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052bf:	eb 40                	jmp    80105301 <sys_open+0x121>
801052c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801052c8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801052cb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801052cf:	56                   	push   %esi
801052d0:	e8 2b c5 ff ff       	call   80101800 <iunlock>
  end_op();
801052d5:	e8 16 da ff ff       	call   80102cf0 <end_op>

  f->type = FD_INODE;
801052da:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052e3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801052e6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801052e9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801052eb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801052f2:	f7 d0                	not    %eax
801052f4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052f7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801052fa:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052fd:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105301:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105304:	89 d8                	mov    %ebx,%eax
80105306:	5b                   	pop    %ebx
80105307:	5e                   	pop    %esi
80105308:	5f                   	pop    %edi
80105309:	5d                   	pop    %ebp
8010530a:	c3                   	ret    
8010530b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010530f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105310:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105313:	85 c9                	test   %ecx,%ecx
80105315:	0f 84 33 ff ff ff    	je     8010524e <sys_open+0x6e>
8010531b:	e9 5c ff ff ff       	jmp    8010527c <sys_open+0x9c>

80105320 <sys_mkdir>:

int
sys_mkdir(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105326:	e8 55 d9 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010532b:	83 ec 08             	sub    $0x8,%esp
8010532e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105331:	50                   	push   %eax
80105332:	6a 00                	push   $0x0
80105334:	e8 e7 f6 ff ff       	call   80104a20 <argstr>
80105339:	83 c4 10             	add    $0x10,%esp
8010533c:	85 c0                	test   %eax,%eax
8010533e:	78 30                	js     80105370 <sys_mkdir+0x50>
80105340:	83 ec 0c             	sub    $0xc,%esp
80105343:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105346:	31 c9                	xor    %ecx,%ecx
80105348:	ba 01 00 00 00       	mov    $0x1,%edx
8010534d:	6a 00                	push   $0x0
8010534f:	e8 7c f7 ff ff       	call   80104ad0 <create>
80105354:	83 c4 10             	add    $0x10,%esp
80105357:	85 c0                	test   %eax,%eax
80105359:	74 15                	je     80105370 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010535b:	83 ec 0c             	sub    $0xc,%esp
8010535e:	50                   	push   %eax
8010535f:	e8 4c c6 ff ff       	call   801019b0 <iunlockput>
  end_op();
80105364:	e8 87 d9 ff ff       	call   80102cf0 <end_op>
  return 0;
80105369:	83 c4 10             	add    $0x10,%esp
8010536c:	31 c0                	xor    %eax,%eax
}
8010536e:	c9                   	leave  
8010536f:	c3                   	ret    
    end_op();
80105370:	e8 7b d9 ff ff       	call   80102cf0 <end_op>
    return -1;
80105375:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010537a:	c9                   	leave  
8010537b:	c3                   	ret    
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_mknod>:

int
sys_mknod(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105386:	e8 f5 d8 ff ff       	call   80102c80 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010538b:	83 ec 08             	sub    $0x8,%esp
8010538e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105391:	50                   	push   %eax
80105392:	6a 00                	push   $0x0
80105394:	e8 87 f6 ff ff       	call   80104a20 <argstr>
80105399:	83 c4 10             	add    $0x10,%esp
8010539c:	85 c0                	test   %eax,%eax
8010539e:	78 60                	js     80105400 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801053a0:	83 ec 08             	sub    $0x8,%esp
801053a3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053a6:	50                   	push   %eax
801053a7:	6a 01                	push   $0x1
801053a9:	e8 c2 f5 ff ff       	call   80104970 <argint>
  if((argstr(0, &path)) < 0 ||
801053ae:	83 c4 10             	add    $0x10,%esp
801053b1:	85 c0                	test   %eax,%eax
801053b3:	78 4b                	js     80105400 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801053b5:	83 ec 08             	sub    $0x8,%esp
801053b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053bb:	50                   	push   %eax
801053bc:	6a 02                	push   $0x2
801053be:	e8 ad f5 ff ff       	call   80104970 <argint>
     argint(1, &major) < 0 ||
801053c3:	83 c4 10             	add    $0x10,%esp
801053c6:	85 c0                	test   %eax,%eax
801053c8:	78 36                	js     80105400 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801053ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801053ce:	83 ec 0c             	sub    $0xc,%esp
801053d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801053d5:	ba 03 00 00 00       	mov    $0x3,%edx
801053da:	50                   	push   %eax
801053db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801053de:	e8 ed f6 ff ff       	call   80104ad0 <create>
     argint(2, &minor) < 0 ||
801053e3:	83 c4 10             	add    $0x10,%esp
801053e6:	85 c0                	test   %eax,%eax
801053e8:	74 16                	je     80105400 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053ea:	83 ec 0c             	sub    $0xc,%esp
801053ed:	50                   	push   %eax
801053ee:	e8 bd c5 ff ff       	call   801019b0 <iunlockput>
  end_op();
801053f3:	e8 f8 d8 ff ff       	call   80102cf0 <end_op>
  return 0;
801053f8:	83 c4 10             	add    $0x10,%esp
801053fb:	31 c0                	xor    %eax,%eax
}
801053fd:	c9                   	leave  
801053fe:	c3                   	ret    
801053ff:	90                   	nop
    end_op();
80105400:	e8 eb d8 ff ff       	call   80102cf0 <end_op>
    return -1;
80105405:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010540a:	c9                   	leave  
8010540b:	c3                   	ret    
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105410 <sys_chdir>:

int
sys_chdir(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	56                   	push   %esi
80105414:	53                   	push   %ebx
80105415:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105418:	e8 63 e4 ff ff       	call   80103880 <myproc>
8010541d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010541f:	e8 5c d8 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105424:	83 ec 08             	sub    $0x8,%esp
80105427:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010542a:	50                   	push   %eax
8010542b:	6a 00                	push   $0x0
8010542d:	e8 ee f5 ff ff       	call   80104a20 <argstr>
80105432:	83 c4 10             	add    $0x10,%esp
80105435:	85 c0                	test   %eax,%eax
80105437:	78 77                	js     801054b0 <sys_chdir+0xa0>
80105439:	83 ec 0c             	sub    $0xc,%esp
8010543c:	ff 75 f4             	pushl  -0xc(%ebp)
8010543f:	e8 7c cb ff ff       	call   80101fc0 <namei>
80105444:	83 c4 10             	add    $0x10,%esp
80105447:	89 c3                	mov    %eax,%ebx
80105449:	85 c0                	test   %eax,%eax
8010544b:	74 63                	je     801054b0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010544d:	83 ec 0c             	sub    $0xc,%esp
80105450:	50                   	push   %eax
80105451:	e8 ca c2 ff ff       	call   80101720 <ilock>
  if(ip->type != T_DIR){
80105456:	83 c4 10             	add    $0x10,%esp
80105459:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010545e:	75 30                	jne    80105490 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105460:	83 ec 0c             	sub    $0xc,%esp
80105463:	53                   	push   %ebx
80105464:	e8 97 c3 ff ff       	call   80101800 <iunlock>
  iput(curproc->cwd);
80105469:	58                   	pop    %eax
8010546a:	ff 76 68             	pushl  0x68(%esi)
8010546d:	e8 de c3 ff ff       	call   80101850 <iput>
  end_op();
80105472:	e8 79 d8 ff ff       	call   80102cf0 <end_op>
  curproc->cwd = ip;
80105477:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010547a:	83 c4 10             	add    $0x10,%esp
8010547d:	31 c0                	xor    %eax,%eax
}
8010547f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105482:	5b                   	pop    %ebx
80105483:	5e                   	pop    %esi
80105484:	5d                   	pop    %ebp
80105485:	c3                   	ret    
80105486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010548d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105490:	83 ec 0c             	sub    $0xc,%esp
80105493:	53                   	push   %ebx
80105494:	e8 17 c5 ff ff       	call   801019b0 <iunlockput>
    end_op();
80105499:	e8 52 d8 ff ff       	call   80102cf0 <end_op>
    return -1;
8010549e:	83 c4 10             	add    $0x10,%esp
801054a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054a6:	eb d7                	jmp    8010547f <sys_chdir+0x6f>
801054a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054af:	90                   	nop
    end_op();
801054b0:	e8 3b d8 ff ff       	call   80102cf0 <end_op>
    return -1;
801054b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ba:	eb c3                	jmp    8010547f <sys_chdir+0x6f>
801054bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054c0 <sys_exec>:

int
sys_exec(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	57                   	push   %edi
801054c4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054c5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801054cb:	53                   	push   %ebx
801054cc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054d2:	50                   	push   %eax
801054d3:	6a 00                	push   $0x0
801054d5:	e8 46 f5 ff ff       	call   80104a20 <argstr>
801054da:	83 c4 10             	add    $0x10,%esp
801054dd:	85 c0                	test   %eax,%eax
801054df:	0f 88 87 00 00 00    	js     8010556c <sys_exec+0xac>
801054e5:	83 ec 08             	sub    $0x8,%esp
801054e8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801054ee:	50                   	push   %eax
801054ef:	6a 01                	push   $0x1
801054f1:	e8 7a f4 ff ff       	call   80104970 <argint>
801054f6:	83 c4 10             	add    $0x10,%esp
801054f9:	85 c0                	test   %eax,%eax
801054fb:	78 6f                	js     8010556c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801054fd:	83 ec 04             	sub    $0x4,%esp
80105500:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80105506:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105508:	68 80 00 00 00       	push   $0x80
8010550d:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105513:	6a 00                	push   $0x0
80105515:	50                   	push   %eax
80105516:	e8 95 f1 ff ff       	call   801046b0 <memset>
8010551b:	83 c4 10             	add    $0x10,%esp
8010551e:	66 90                	xchg   %ax,%ax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105520:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105526:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
8010552d:	83 ec 08             	sub    $0x8,%esp
80105530:	57                   	push   %edi
80105531:	01 f0                	add    %esi,%eax
80105533:	50                   	push   %eax
80105534:	e8 a7 f3 ff ff       	call   801048e0 <fetchint>
80105539:	83 c4 10             	add    $0x10,%esp
8010553c:	85 c0                	test   %eax,%eax
8010553e:	78 2c                	js     8010556c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105540:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105546:	85 c0                	test   %eax,%eax
80105548:	74 36                	je     80105580 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010554a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105550:	83 ec 08             	sub    $0x8,%esp
80105553:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105556:	52                   	push   %edx
80105557:	50                   	push   %eax
80105558:	e8 c3 f3 ff ff       	call   80104920 <fetchstr>
8010555d:	83 c4 10             	add    $0x10,%esp
80105560:	85 c0                	test   %eax,%eax
80105562:	78 08                	js     8010556c <sys_exec+0xac>
  for(i=0;; i++){
80105564:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105567:	83 fb 20             	cmp    $0x20,%ebx
8010556a:	75 b4                	jne    80105520 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010556c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010556f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105574:	5b                   	pop    %ebx
80105575:	5e                   	pop    %esi
80105576:	5f                   	pop    %edi
80105577:	5d                   	pop    %ebp
80105578:	c3                   	ret    
80105579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105580:	83 ec 08             	sub    $0x8,%esp
80105583:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105589:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105590:	00 00 00 00 
  return exec(path, argv);
80105594:	50                   	push   %eax
80105595:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010559b:	e8 d0 b4 ff ff       	call   80100a70 <exec>
801055a0:	83 c4 10             	add    $0x10,%esp
}
801055a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055a6:	5b                   	pop    %ebx
801055a7:	5e                   	pop    %esi
801055a8:	5f                   	pop    %edi
801055a9:	5d                   	pop    %ebp
801055aa:	c3                   	ret    
801055ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055af:	90                   	nop

801055b0 <sys_pipe>:

int
sys_pipe(void)
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	57                   	push   %edi
801055b4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055b5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801055b8:	53                   	push   %ebx
801055b9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055bc:	6a 08                	push   $0x8
801055be:	50                   	push   %eax
801055bf:	6a 00                	push   $0x0
801055c1:	e8 fa f3 ff ff       	call   801049c0 <argptr>
801055c6:	83 c4 10             	add    $0x10,%esp
801055c9:	85 c0                	test   %eax,%eax
801055cb:	78 4a                	js     80105617 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801055cd:	83 ec 08             	sub    $0x8,%esp
801055d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055d3:	50                   	push   %eax
801055d4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801055d7:	50                   	push   %eax
801055d8:	e8 43 dd ff ff       	call   80103320 <pipealloc>
801055dd:	83 c4 10             	add    $0x10,%esp
801055e0:	85 c0                	test   %eax,%eax
801055e2:	78 33                	js     80105617 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055e4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801055e7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801055e9:	e8 92 e2 ff ff       	call   80103880 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055ee:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801055f0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801055f4:	85 f6                	test   %esi,%esi
801055f6:	74 28                	je     80105620 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
801055f8:	83 c3 01             	add    $0x1,%ebx
801055fb:	83 fb 10             	cmp    $0x10,%ebx
801055fe:	75 f0                	jne    801055f0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105600:	83 ec 0c             	sub    $0xc,%esp
80105603:	ff 75 e0             	pushl  -0x20(%ebp)
80105606:	e8 b5 b8 ff ff       	call   80100ec0 <fileclose>
    fileclose(wf);
8010560b:	58                   	pop    %eax
8010560c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010560f:	e8 ac b8 ff ff       	call   80100ec0 <fileclose>
    return -1;
80105614:	83 c4 10             	add    $0x10,%esp
80105617:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010561c:	eb 53                	jmp    80105671 <sys_pipe+0xc1>
8010561e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105620:	8d 73 08             	lea    0x8(%ebx),%esi
80105623:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105627:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010562a:	e8 51 e2 ff ff       	call   80103880 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010562f:	31 d2                	xor    %edx,%edx
80105631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105638:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010563c:	85 c9                	test   %ecx,%ecx
8010563e:	74 20                	je     80105660 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80105640:	83 c2 01             	add    $0x1,%edx
80105643:	83 fa 10             	cmp    $0x10,%edx
80105646:	75 f0                	jne    80105638 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80105648:	e8 33 e2 ff ff       	call   80103880 <myproc>
8010564d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105654:	00 
80105655:	eb a9                	jmp    80105600 <sys_pipe+0x50>
80105657:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010565e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105660:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105664:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105667:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105669:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010566c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010566f:	31 c0                	xor    %eax,%eax
}
80105671:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105674:	5b                   	pop    %ebx
80105675:	5e                   	pop    %esi
80105676:	5f                   	pop    %edi
80105677:	5d                   	pop    %ebp
80105678:	c3                   	ret    
80105679:	66 90                	xchg   %ax,%ax
8010567b:	66 90                	xchg   %ax,%ax
8010567d:	66 90                	xchg   %ax,%ax
8010567f:	90                   	nop

80105680 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105680:	e9 9b e3 ff ff       	jmp    80103a20 <fork>
80105685:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010568c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105690 <sys_exit>:
}

int
sys_exit(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	83 ec 08             	sub    $0x8,%esp
  exit();
80105696:	e8 25 e6 ff ff       	call   80103cc0 <exit>
  return 0;  // not reached
}
8010569b:	31 c0                	xor    %eax,%eax
8010569d:	c9                   	leave  
8010569e:	c3                   	ret    
8010569f:	90                   	nop

801056a0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
801056a0:	e9 5b e8 ff ff       	jmp    80103f00 <wait>
801056a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056b0 <sys_kill>:
}

int
sys_kill(void)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801056b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056b9:	50                   	push   %eax
801056ba:	6a 00                	push   $0x0
801056bc:	e8 af f2 ff ff       	call   80104970 <argint>
801056c1:	83 c4 10             	add    $0x10,%esp
801056c4:	85 c0                	test   %eax,%eax
801056c6:	78 18                	js     801056e0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801056c8:	83 ec 0c             	sub    $0xc,%esp
801056cb:	ff 75 f4             	pushl  -0xc(%ebp)
801056ce:	e8 7d e9 ff ff       	call   80104050 <kill>
801056d3:	83 c4 10             	add    $0x10,%esp
}
801056d6:	c9                   	leave  
801056d7:	c3                   	ret    
801056d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056df:	90                   	nop
801056e0:	c9                   	leave  
    return -1;
801056e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056e6:	c3                   	ret    
801056e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ee:	66 90                	xchg   %ax,%ax

801056f0 <sys_getpid>:

int
sys_getpid(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801056f6:	e8 85 e1 ff ff       	call   80103880 <myproc>
801056fb:	8b 40 10             	mov    0x10(%eax),%eax
}
801056fe:	c9                   	leave  
801056ff:	c3                   	ret    

80105700 <sys_sbrk>:

int
sys_sbrk(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105704:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105707:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010570a:	50                   	push   %eax
8010570b:	6a 00                	push   $0x0
8010570d:	e8 5e f2 ff ff       	call   80104970 <argint>
80105712:	83 c4 10             	add    $0x10,%esp
80105715:	85 c0                	test   %eax,%eax
80105717:	78 27                	js     80105740 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105719:	e8 62 e1 ff ff       	call   80103880 <myproc>
  if(growproc(n) < 0)
8010571e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105721:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105723:	ff 75 f4             	pushl  -0xc(%ebp)
80105726:	e8 75 e2 ff ff       	call   801039a0 <growproc>
8010572b:	83 c4 10             	add    $0x10,%esp
8010572e:	85 c0                	test   %eax,%eax
80105730:	78 0e                	js     80105740 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105732:	89 d8                	mov    %ebx,%eax
80105734:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105737:	c9                   	leave  
80105738:	c3                   	ret    
80105739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105740:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105745:	eb eb                	jmp    80105732 <sys_sbrk+0x32>
80105747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010574e:	66 90                	xchg   %ax,%ax

80105750 <sys_sleep>:

int
sys_sleep(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105754:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105757:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010575a:	50                   	push   %eax
8010575b:	6a 00                	push   $0x0
8010575d:	e8 0e f2 ff ff       	call   80104970 <argint>
80105762:	83 c4 10             	add    $0x10,%esp
80105765:	85 c0                	test   %eax,%eax
80105767:	0f 88 8a 00 00 00    	js     801057f7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010576d:	83 ec 0c             	sub    $0xc,%esp
80105770:	68 60 4d 11 80       	push   $0x80114d60
80105775:	e8 c6 ed ff ff       	call   80104540 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010577a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010577d:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
  while(ticks - ticks0 < n){
80105783:	83 c4 10             	add    $0x10,%esp
80105786:	85 d2                	test   %edx,%edx
80105788:	75 27                	jne    801057b1 <sys_sleep+0x61>
8010578a:	eb 54                	jmp    801057e0 <sys_sleep+0x90>
8010578c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105790:	83 ec 08             	sub    $0x8,%esp
80105793:	68 60 4d 11 80       	push   $0x80114d60
80105798:	68 a0 55 11 80       	push   $0x801155a0
8010579d:	e8 9e e6 ff ff       	call   80103e40 <sleep>
  while(ticks - ticks0 < n){
801057a2:	a1 a0 55 11 80       	mov    0x801155a0,%eax
801057a7:	83 c4 10             	add    $0x10,%esp
801057aa:	29 d8                	sub    %ebx,%eax
801057ac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801057af:	73 2f                	jae    801057e0 <sys_sleep+0x90>
    if(myproc()->killed){
801057b1:	e8 ca e0 ff ff       	call   80103880 <myproc>
801057b6:	8b 40 24             	mov    0x24(%eax),%eax
801057b9:	85 c0                	test   %eax,%eax
801057bb:	74 d3                	je     80105790 <sys_sleep+0x40>
      release(&tickslock);
801057bd:	83 ec 0c             	sub    $0xc,%esp
801057c0:	68 60 4d 11 80       	push   $0x80114d60
801057c5:	e8 96 ee ff ff       	call   80104660 <release>
  }
  release(&tickslock);
  return 0;
}
801057ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
801057cd:	83 c4 10             	add    $0x10,%esp
801057d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057d5:	c9                   	leave  
801057d6:	c3                   	ret    
801057d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057de:	66 90                	xchg   %ax,%ax
  release(&tickslock);
801057e0:	83 ec 0c             	sub    $0xc,%esp
801057e3:	68 60 4d 11 80       	push   $0x80114d60
801057e8:	e8 73 ee ff ff       	call   80104660 <release>
  return 0;
801057ed:	83 c4 10             	add    $0x10,%esp
801057f0:	31 c0                	xor    %eax,%eax
}
801057f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057f5:	c9                   	leave  
801057f6:	c3                   	ret    
    return -1;
801057f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057fc:	eb f4                	jmp    801057f2 <sys_sleep+0xa2>
801057fe:	66 90                	xchg   %ax,%ax

80105800 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	53                   	push   %ebx
80105804:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105807:	68 60 4d 11 80       	push   $0x80114d60
8010580c:	e8 2f ed ff ff       	call   80104540 <acquire>
  xticks = ticks;
80105811:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
  release(&tickslock);
80105817:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
8010581e:	e8 3d ee ff ff       	call   80104660 <release>
  return xticks;
}
80105823:	89 d8                	mov    %ebx,%eax
80105825:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105828:	c9                   	leave  
80105829:	c3                   	ret    
8010582a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105830 <sys_cps>:

int
sys_cps(void)
{
  return cps();
80105830:	e9 5b e9 ff ff       	jmp    80104190 <cps>
80105835:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010583c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105840 <sys_nps>:
}

int
sys_nps(void)
{
  return nps();
80105840:	e9 1b ea ff ff       	jmp    80104260 <nps>
80105845:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010584c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105850 <sys_chpr>:
}

int
sys_chpr (void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	83 ec 20             	sub    $0x20,%esp
  int pid, pr;
  if(argint(0, &pid) < 0)
80105856:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105859:	50                   	push   %eax
8010585a:	6a 00                	push   $0x0
8010585c:	e8 0f f1 ff ff       	call   80104970 <argint>
80105861:	83 c4 10             	add    $0x10,%esp
80105864:	85 c0                	test   %eax,%eax
80105866:	78 28                	js     80105890 <sys_chpr+0x40>
    return -1;
  if(argint(1, &pr) < 0)
80105868:	83 ec 08             	sub    $0x8,%esp
8010586b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010586e:	50                   	push   %eax
8010586f:	6a 01                	push   $0x1
80105871:	e8 fa f0 ff ff       	call   80104970 <argint>
80105876:	83 c4 10             	add    $0x10,%esp
80105879:	85 c0                	test   %eax,%eax
8010587b:	78 13                	js     80105890 <sys_chpr+0x40>
    return -1;

  return chpr ( pid, pr );
8010587d:	83 ec 08             	sub    $0x8,%esp
80105880:	ff 75 f4             	pushl  -0xc(%ebp)
80105883:	ff 75 f0             	pushl  -0x10(%ebp)
80105886:	e8 55 ea ff ff       	call   801042e0 <chpr>
8010588b:	83 c4 10             	add    $0x10,%esp
}
8010588e:	c9                   	leave  
8010588f:	c3                   	ret    
80105890:	c9                   	leave  
    return -1;
80105891:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105896:	c3                   	ret    
80105897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010589e:	66 90                	xchg   %ax,%ax

801058a0 <sys_date>:

//starting edits---Ken Lin
int sys_date(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 1c             	sub    $0x1c,%esp
  struct rtcdate *d;
  if(argptr(0, (void*)&d, sizeof(struct rtcdate)) < 0)
801058a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058a9:	6a 18                	push   $0x18
801058ab:	50                   	push   %eax
801058ac:	6a 00                	push   $0x0
801058ae:	e8 0d f1 ff ff       	call   801049c0 <argptr>
801058b3:	83 c4 10             	add    $0x10,%esp
801058b6:	85 c0                	test   %eax,%eax
801058b8:	78 16                	js     801058d0 <sys_date+0x30>
    return -1;
  cmostime(d);
801058ba:	83 ec 0c             	sub    $0xc,%esp
801058bd:	ff 75 f4             	pushl  -0xc(%ebp)
801058c0:	e8 2b d0 ff ff       	call   801028f0 <cmostime>
  return 0;
801058c5:	83 c4 10             	add    $0x10,%esp
801058c8:	31 c0                	xor    %eax,%eax
}
801058ca:	c9                   	leave  
801058cb:	c3                   	ret    
801058cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058d0:	c9                   	leave  
    return -1;
801058d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058d6:	c3                   	ret    

801058d7 <alltraps>:
801058d7:	1e                   	push   %ds
801058d8:	06                   	push   %es
801058d9:	0f a0                	push   %fs
801058db:	0f a8                	push   %gs
801058dd:	60                   	pusha  
801058de:	66 b8 10 00          	mov    $0x10,%ax
801058e2:	8e d8                	mov    %eax,%ds
801058e4:	8e c0                	mov    %eax,%es
801058e6:	54                   	push   %esp
801058e7:	e8 c4 00 00 00       	call   801059b0 <trap>
801058ec:	83 c4 04             	add    $0x4,%esp

801058ef <trapret>:
801058ef:	61                   	popa   
801058f0:	0f a9                	pop    %gs
801058f2:	0f a1                	pop    %fs
801058f4:	07                   	pop    %es
801058f5:	1f                   	pop    %ds
801058f6:	83 c4 08             	add    $0x8,%esp
801058f9:	cf                   	iret   
801058fa:	66 90                	xchg   %ax,%ax
801058fc:	66 90                	xchg   %ax,%ax
801058fe:	66 90                	xchg   %ax,%ax

80105900 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105900:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105901:	31 c0                	xor    %eax,%eax
{
80105903:	89 e5                	mov    %esp,%ebp
80105905:	83 ec 08             	sub    $0x8,%esp
80105908:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010590f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105910:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105917:	c7 04 c5 a2 4d 11 80 	movl   $0x8e000008,-0x7feeb25e(,%eax,8)
8010591e:	08 00 00 8e 
80105922:	66 89 14 c5 a0 4d 11 	mov    %dx,-0x7feeb260(,%eax,8)
80105929:	80 
8010592a:	c1 ea 10             	shr    $0x10,%edx
8010592d:	66 89 14 c5 a6 4d 11 	mov    %dx,-0x7feeb25a(,%eax,8)
80105934:	80 
  for(i = 0; i < 256; i++)
80105935:	83 c0 01             	add    $0x1,%eax
80105938:	3d 00 01 00 00       	cmp    $0x100,%eax
8010593d:	75 d1                	jne    80105910 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010593f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105942:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105947:	c7 05 a2 4f 11 80 08 	movl   $0xef000008,0x80114fa2
8010594e:	00 00 ef 
  initlock(&tickslock, "time");
80105951:	68 69 79 10 80       	push   $0x80107969
80105956:	68 60 4d 11 80       	push   $0x80114d60
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010595b:	66 a3 a0 4f 11 80    	mov    %ax,0x80114fa0
80105961:	c1 e8 10             	shr    $0x10,%eax
80105964:	66 a3 a6 4f 11 80    	mov    %ax,0x80114fa6
  initlock(&tickslock, "time");
8010596a:	e8 d1 ea ff ff       	call   80104440 <initlock>
}
8010596f:	83 c4 10             	add    $0x10,%esp
80105972:	c9                   	leave  
80105973:	c3                   	ret    
80105974:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010597f:	90                   	nop

80105980 <idtinit>:

void
idtinit(void)
{
80105980:	55                   	push   %ebp
  pd[0] = size-1;
80105981:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105986:	89 e5                	mov    %esp,%ebp
80105988:	83 ec 10             	sub    $0x10,%esp
8010598b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010598f:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
80105994:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105998:	c1 e8 10             	shr    $0x10,%eax
8010599b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010599f:	8d 45 fa             	lea    -0x6(%ebp),%eax
801059a2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801059a5:	c9                   	leave  
801059a6:	c3                   	ret    
801059a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ae:	66 90                	xchg   %ax,%ax

801059b0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	57                   	push   %edi
801059b4:	56                   	push   %esi
801059b5:	53                   	push   %ebx
801059b6:	83 ec 1c             	sub    $0x1c,%esp
801059b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801059bc:	8b 43 30             	mov    0x30(%ebx),%eax
801059bf:	83 f8 40             	cmp    $0x40,%eax
801059c2:	0f 84 c0 01 00 00    	je     80105b88 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801059c8:	83 e8 20             	sub    $0x20,%eax
801059cb:	83 f8 1f             	cmp    $0x1f,%eax
801059ce:	77 07                	ja     801059d7 <trap+0x27>
801059d0:	ff 24 85 10 7a 10 80 	jmp    *-0x7fef85f0(,%eax,4)
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801059d7:	e8 a4 de ff ff       	call   80103880 <myproc>
801059dc:	8b 7b 38             	mov    0x38(%ebx),%edi
801059df:	85 c0                	test   %eax,%eax
801059e1:	0f 84 f0 01 00 00    	je     80105bd7 <trap+0x227>
801059e7:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801059eb:	0f 84 e6 01 00 00    	je     80105bd7 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801059f1:	0f 20 d1             	mov    %cr2,%ecx
801059f4:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801059f7:	e8 64 de ff ff       	call   80103860 <cpuid>
801059fc:	8b 73 30             	mov    0x30(%ebx),%esi
801059ff:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105a02:	8b 43 34             	mov    0x34(%ebx),%eax
80105a05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a08:	e8 73 de ff ff       	call   80103880 <myproc>
80105a0d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105a10:	e8 6b de ff ff       	call   80103880 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a15:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105a18:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a1b:	51                   	push   %ecx
80105a1c:	57                   	push   %edi
80105a1d:	52                   	push   %edx
80105a1e:	ff 75 e4             	pushl  -0x1c(%ebp)
80105a21:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105a22:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105a25:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a28:	56                   	push   %esi
80105a29:	ff 70 10             	pushl  0x10(%eax)
80105a2c:	68 cc 79 10 80       	push   $0x801079cc
80105a31:	e8 6a ac ff ff       	call   801006a0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105a36:	83 c4 20             	add    $0x20,%esp
80105a39:	e8 42 de ff ff       	call   80103880 <myproc>
80105a3e:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a45:	e8 36 de ff ff       	call   80103880 <myproc>
80105a4a:	85 c0                	test   %eax,%eax
80105a4c:	74 1d                	je     80105a6b <trap+0xbb>
80105a4e:	e8 2d de ff ff       	call   80103880 <myproc>
80105a53:	8b 50 24             	mov    0x24(%eax),%edx
80105a56:	85 d2                	test   %edx,%edx
80105a58:	74 11                	je     80105a6b <trap+0xbb>
80105a5a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a5e:	83 e0 03             	and    $0x3,%eax
80105a61:	66 83 f8 03          	cmp    $0x3,%ax
80105a65:	0f 84 55 01 00 00    	je     80105bc0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105a6b:	e8 10 de ff ff       	call   80103880 <myproc>
80105a70:	85 c0                	test   %eax,%eax
80105a72:	74 0f                	je     80105a83 <trap+0xd3>
80105a74:	e8 07 de ff ff       	call   80103880 <myproc>
80105a79:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a7d:	0f 84 ed 00 00 00    	je     80105b70 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a83:	e8 f8 dd ff ff       	call   80103880 <myproc>
80105a88:	85 c0                	test   %eax,%eax
80105a8a:	74 1d                	je     80105aa9 <trap+0xf9>
80105a8c:	e8 ef dd ff ff       	call   80103880 <myproc>
80105a91:	8b 40 24             	mov    0x24(%eax),%eax
80105a94:	85 c0                	test   %eax,%eax
80105a96:	74 11                	je     80105aa9 <trap+0xf9>
80105a98:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a9c:	83 e0 03             	and    $0x3,%eax
80105a9f:	66 83 f8 03          	cmp    $0x3,%ax
80105aa3:	0f 84 08 01 00 00    	je     80105bb1 <trap+0x201>
    exit();
}
80105aa9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105aac:	5b                   	pop    %ebx
80105aad:	5e                   	pop    %esi
80105aae:	5f                   	pop    %edi
80105aaf:	5d                   	pop    %ebp
80105ab0:	c3                   	ret    
    ideintr();
80105ab1:	e8 aa c6 ff ff       	call   80102160 <ideintr>
    lapiceoi();
80105ab6:	e8 75 cd ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105abb:	e8 c0 dd ff ff       	call   80103880 <myproc>
80105ac0:	85 c0                	test   %eax,%eax
80105ac2:	75 8a                	jne    80105a4e <trap+0x9e>
80105ac4:	eb a5                	jmp    80105a6b <trap+0xbb>
    if(cpuid() == 0){
80105ac6:	e8 95 dd ff ff       	call   80103860 <cpuid>
80105acb:	85 c0                	test   %eax,%eax
80105acd:	75 e7                	jne    80105ab6 <trap+0x106>
      acquire(&tickslock);
80105acf:	83 ec 0c             	sub    $0xc,%esp
80105ad2:	68 60 4d 11 80       	push   $0x80114d60
80105ad7:	e8 64 ea ff ff       	call   80104540 <acquire>
      wakeup(&ticks);
80105adc:	c7 04 24 a0 55 11 80 	movl   $0x801155a0,(%esp)
      ticks++;
80105ae3:	83 05 a0 55 11 80 01 	addl   $0x1,0x801155a0
      wakeup(&ticks);
80105aea:	e8 01 e5 ff ff       	call   80103ff0 <wakeup>
      release(&tickslock);
80105aef:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
80105af6:	e8 65 eb ff ff       	call   80104660 <release>
80105afb:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105afe:	eb b6                	jmp    80105ab6 <trap+0x106>
    kbdintr();
80105b00:	e8 eb cb ff ff       	call   801026f0 <kbdintr>
    lapiceoi();
80105b05:	e8 26 cd ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b0a:	e8 71 dd ff ff       	call   80103880 <myproc>
80105b0f:	85 c0                	test   %eax,%eax
80105b11:	0f 85 37 ff ff ff    	jne    80105a4e <trap+0x9e>
80105b17:	e9 4f ff ff ff       	jmp    80105a6b <trap+0xbb>
    uartintr();
80105b1c:	e8 4f 02 00 00       	call   80105d70 <uartintr>
    lapiceoi();
80105b21:	e8 0a cd ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b26:	e8 55 dd ff ff       	call   80103880 <myproc>
80105b2b:	85 c0                	test   %eax,%eax
80105b2d:	0f 85 1b ff ff ff    	jne    80105a4e <trap+0x9e>
80105b33:	e9 33 ff ff ff       	jmp    80105a6b <trap+0xbb>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b38:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b3b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b3f:	e8 1c dd ff ff       	call   80103860 <cpuid>
80105b44:	57                   	push   %edi
80105b45:	56                   	push   %esi
80105b46:	50                   	push   %eax
80105b47:	68 74 79 10 80       	push   $0x80107974
80105b4c:	e8 4f ab ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80105b51:	e8 da cc ff ff       	call   80102830 <lapiceoi>
    break;
80105b56:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b59:	e8 22 dd ff ff       	call   80103880 <myproc>
80105b5e:	85 c0                	test   %eax,%eax
80105b60:	0f 85 e8 fe ff ff    	jne    80105a4e <trap+0x9e>
80105b66:	e9 00 ff ff ff       	jmp    80105a6b <trap+0xbb>
80105b6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b6f:	90                   	nop
  if(myproc() && myproc()->state == RUNNING &&
80105b70:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105b74:	0f 85 09 ff ff ff    	jne    80105a83 <trap+0xd3>
    yield();
80105b7a:	e8 71 e2 ff ff       	call   80103df0 <yield>
80105b7f:	e9 ff fe ff ff       	jmp    80105a83 <trap+0xd3>
80105b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105b88:	e8 f3 dc ff ff       	call   80103880 <myproc>
80105b8d:	8b 70 24             	mov    0x24(%eax),%esi
80105b90:	85 f6                	test   %esi,%esi
80105b92:	75 3c                	jne    80105bd0 <trap+0x220>
    myproc()->tf = tf;
80105b94:	e8 e7 dc ff ff       	call   80103880 <myproc>
80105b99:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105b9c:	e8 bf ee ff ff       	call   80104a60 <syscall>
    if(myproc()->killed)
80105ba1:	e8 da dc ff ff       	call   80103880 <myproc>
80105ba6:	8b 48 24             	mov    0x24(%eax),%ecx
80105ba9:	85 c9                	test   %ecx,%ecx
80105bab:	0f 84 f8 fe ff ff    	je     80105aa9 <trap+0xf9>
}
80105bb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bb4:	5b                   	pop    %ebx
80105bb5:	5e                   	pop    %esi
80105bb6:	5f                   	pop    %edi
80105bb7:	5d                   	pop    %ebp
      exit();
80105bb8:	e9 03 e1 ff ff       	jmp    80103cc0 <exit>
80105bbd:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80105bc0:	e8 fb e0 ff ff       	call   80103cc0 <exit>
80105bc5:	e9 a1 fe ff ff       	jmp    80105a6b <trap+0xbb>
80105bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105bd0:	e8 eb e0 ff ff       	call   80103cc0 <exit>
80105bd5:	eb bd                	jmp    80105b94 <trap+0x1e4>
80105bd7:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105bda:	e8 81 dc ff ff       	call   80103860 <cpuid>
80105bdf:	83 ec 0c             	sub    $0xc,%esp
80105be2:	56                   	push   %esi
80105be3:	57                   	push   %edi
80105be4:	50                   	push   %eax
80105be5:	ff 73 30             	pushl  0x30(%ebx)
80105be8:	68 98 79 10 80       	push   $0x80107998
80105bed:	e8 ae aa ff ff       	call   801006a0 <cprintf>
      panic("trap");
80105bf2:	83 c4 14             	add    $0x14,%esp
80105bf5:	68 6e 79 10 80       	push   $0x8010796e
80105bfa:	e8 81 a7 ff ff       	call   80100380 <panic>
80105bff:	90                   	nop

80105c00 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c00:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105c05:	85 c0                	test   %eax,%eax
80105c07:	74 17                	je     80105c20 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c09:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c0e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c0f:	a8 01                	test   $0x1,%al
80105c11:	74 0d                	je     80105c20 <uartgetc+0x20>
80105c13:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c18:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c19:	0f b6 c0             	movzbl %al,%eax
80105c1c:	c3                   	ret    
80105c1d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c25:	c3                   	ret    
80105c26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c2d:	8d 76 00             	lea    0x0(%esi),%esi

80105c30 <uartputc.part.0>:
uartputc(int c)
80105c30:	55                   	push   %ebp
80105c31:	89 e5                	mov    %esp,%ebp
80105c33:	57                   	push   %edi
80105c34:	89 c7                	mov    %eax,%edi
80105c36:	56                   	push   %esi
80105c37:	be fd 03 00 00       	mov    $0x3fd,%esi
80105c3c:	53                   	push   %ebx
80105c3d:	bb 80 00 00 00       	mov    $0x80,%ebx
80105c42:	83 ec 0c             	sub    $0xc,%esp
80105c45:	eb 1b                	jmp    80105c62 <uartputc.part.0+0x32>
80105c47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c4e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80105c50:	83 ec 0c             	sub    $0xc,%esp
80105c53:	6a 0a                	push   $0xa
80105c55:	e8 f6 cb ff ff       	call   80102850 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105c5a:	83 c4 10             	add    $0x10,%esp
80105c5d:	83 eb 01             	sub    $0x1,%ebx
80105c60:	74 07                	je     80105c69 <uartputc.part.0+0x39>
80105c62:	89 f2                	mov    %esi,%edx
80105c64:	ec                   	in     (%dx),%al
80105c65:	a8 20                	test   $0x20,%al
80105c67:	74 e7                	je     80105c50 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105c69:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c6e:	89 f8                	mov    %edi,%eax
80105c70:	ee                   	out    %al,(%dx)
}
80105c71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c74:	5b                   	pop    %ebx
80105c75:	5e                   	pop    %esi
80105c76:	5f                   	pop    %edi
80105c77:	5d                   	pop    %ebp
80105c78:	c3                   	ret    
80105c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105c80 <uartinit>:
{
80105c80:	55                   	push   %ebp
80105c81:	31 c9                	xor    %ecx,%ecx
80105c83:	89 c8                	mov    %ecx,%eax
80105c85:	89 e5                	mov    %esp,%ebp
80105c87:	57                   	push   %edi
80105c88:	56                   	push   %esi
80105c89:	53                   	push   %ebx
80105c8a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105c8f:	89 da                	mov    %ebx,%edx
80105c91:	83 ec 0c             	sub    $0xc,%esp
80105c94:	ee                   	out    %al,(%dx)
80105c95:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105c9a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105c9f:	89 fa                	mov    %edi,%edx
80105ca1:	ee                   	out    %al,(%dx)
80105ca2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ca7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cac:	ee                   	out    %al,(%dx)
80105cad:	be f9 03 00 00       	mov    $0x3f9,%esi
80105cb2:	89 c8                	mov    %ecx,%eax
80105cb4:	89 f2                	mov    %esi,%edx
80105cb6:	ee                   	out    %al,(%dx)
80105cb7:	b8 03 00 00 00       	mov    $0x3,%eax
80105cbc:	89 fa                	mov    %edi,%edx
80105cbe:	ee                   	out    %al,(%dx)
80105cbf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105cc4:	89 c8                	mov    %ecx,%eax
80105cc6:	ee                   	out    %al,(%dx)
80105cc7:	b8 01 00 00 00       	mov    $0x1,%eax
80105ccc:	89 f2                	mov    %esi,%edx
80105cce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105ccf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cd4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105cd5:	3c ff                	cmp    $0xff,%al
80105cd7:	74 56                	je     80105d2f <uartinit+0xaf>
  uart = 1;
80105cd9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105ce0:	00 00 00 
80105ce3:	89 da                	mov    %ebx,%edx
80105ce5:	ec                   	in     (%dx),%al
80105ce6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ceb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105cec:	83 ec 08             	sub    $0x8,%esp
80105cef:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80105cf4:	bb 90 7a 10 80       	mov    $0x80107a90,%ebx
  ioapicenable(IRQ_COM1, 0);
80105cf9:	6a 00                	push   $0x0
80105cfb:	6a 04                	push   $0x4
80105cfd:	e8 9e c6 ff ff       	call   801023a0 <ioapicenable>
80105d02:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105d05:	b8 78 00 00 00       	mov    $0x78,%eax
80105d0a:	eb 08                	jmp    80105d14 <uartinit+0x94>
80105d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d10:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80105d14:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105d1a:	85 d2                	test   %edx,%edx
80105d1c:	74 08                	je     80105d26 <uartinit+0xa6>
    uartputc(*p);
80105d1e:	0f be c0             	movsbl %al,%eax
80105d21:	e8 0a ff ff ff       	call   80105c30 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80105d26:	89 f0                	mov    %esi,%eax
80105d28:	83 c3 01             	add    $0x1,%ebx
80105d2b:	84 c0                	test   %al,%al
80105d2d:	75 e1                	jne    80105d10 <uartinit+0x90>
}
80105d2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d32:	5b                   	pop    %ebx
80105d33:	5e                   	pop    %esi
80105d34:	5f                   	pop    %edi
80105d35:	5d                   	pop    %ebp
80105d36:	c3                   	ret    
80105d37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d3e:	66 90                	xchg   %ax,%ax

80105d40 <uartputc>:
{
80105d40:	55                   	push   %ebp
  if(!uart)
80105d41:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105d47:	89 e5                	mov    %esp,%ebp
80105d49:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105d4c:	85 d2                	test   %edx,%edx
80105d4e:	74 10                	je     80105d60 <uartputc+0x20>
}
80105d50:	5d                   	pop    %ebp
80105d51:	e9 da fe ff ff       	jmp    80105c30 <uartputc.part.0>
80105d56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d5d:	8d 76 00             	lea    0x0(%esi),%esi
80105d60:	5d                   	pop    %ebp
80105d61:	c3                   	ret    
80105d62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d70 <uartintr>:

void
uartintr(void)
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
80105d73:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105d76:	68 00 5c 10 80       	push   $0x80105c00
80105d7b:	e8 d0 aa ff ff       	call   80100850 <consoleintr>
}
80105d80:	83 c4 10             	add    $0x10,%esp
80105d83:	c9                   	leave  
80105d84:	c3                   	ret    

80105d85 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105d85:	6a 00                	push   $0x0
  pushl $0
80105d87:	6a 00                	push   $0x0
  jmp alltraps
80105d89:	e9 49 fb ff ff       	jmp    801058d7 <alltraps>

80105d8e <vector1>:
.globl vector1
vector1:
  pushl $0
80105d8e:	6a 00                	push   $0x0
  pushl $1
80105d90:	6a 01                	push   $0x1
  jmp alltraps
80105d92:	e9 40 fb ff ff       	jmp    801058d7 <alltraps>

80105d97 <vector2>:
.globl vector2
vector2:
  pushl $0
80105d97:	6a 00                	push   $0x0
  pushl $2
80105d99:	6a 02                	push   $0x2
  jmp alltraps
80105d9b:	e9 37 fb ff ff       	jmp    801058d7 <alltraps>

80105da0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105da0:	6a 00                	push   $0x0
  pushl $3
80105da2:	6a 03                	push   $0x3
  jmp alltraps
80105da4:	e9 2e fb ff ff       	jmp    801058d7 <alltraps>

80105da9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105da9:	6a 00                	push   $0x0
  pushl $4
80105dab:	6a 04                	push   $0x4
  jmp alltraps
80105dad:	e9 25 fb ff ff       	jmp    801058d7 <alltraps>

80105db2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105db2:	6a 00                	push   $0x0
  pushl $5
80105db4:	6a 05                	push   $0x5
  jmp alltraps
80105db6:	e9 1c fb ff ff       	jmp    801058d7 <alltraps>

80105dbb <vector6>:
.globl vector6
vector6:
  pushl $0
80105dbb:	6a 00                	push   $0x0
  pushl $6
80105dbd:	6a 06                	push   $0x6
  jmp alltraps
80105dbf:	e9 13 fb ff ff       	jmp    801058d7 <alltraps>

80105dc4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105dc4:	6a 00                	push   $0x0
  pushl $7
80105dc6:	6a 07                	push   $0x7
  jmp alltraps
80105dc8:	e9 0a fb ff ff       	jmp    801058d7 <alltraps>

80105dcd <vector8>:
.globl vector8
vector8:
  pushl $8
80105dcd:	6a 08                	push   $0x8
  jmp alltraps
80105dcf:	e9 03 fb ff ff       	jmp    801058d7 <alltraps>

80105dd4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105dd4:	6a 00                	push   $0x0
  pushl $9
80105dd6:	6a 09                	push   $0x9
  jmp alltraps
80105dd8:	e9 fa fa ff ff       	jmp    801058d7 <alltraps>

80105ddd <vector10>:
.globl vector10
vector10:
  pushl $10
80105ddd:	6a 0a                	push   $0xa
  jmp alltraps
80105ddf:	e9 f3 fa ff ff       	jmp    801058d7 <alltraps>

80105de4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105de4:	6a 0b                	push   $0xb
  jmp alltraps
80105de6:	e9 ec fa ff ff       	jmp    801058d7 <alltraps>

80105deb <vector12>:
.globl vector12
vector12:
  pushl $12
80105deb:	6a 0c                	push   $0xc
  jmp alltraps
80105ded:	e9 e5 fa ff ff       	jmp    801058d7 <alltraps>

80105df2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105df2:	6a 0d                	push   $0xd
  jmp alltraps
80105df4:	e9 de fa ff ff       	jmp    801058d7 <alltraps>

80105df9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105df9:	6a 0e                	push   $0xe
  jmp alltraps
80105dfb:	e9 d7 fa ff ff       	jmp    801058d7 <alltraps>

80105e00 <vector15>:
.globl vector15
vector15:
  pushl $0
80105e00:	6a 00                	push   $0x0
  pushl $15
80105e02:	6a 0f                	push   $0xf
  jmp alltraps
80105e04:	e9 ce fa ff ff       	jmp    801058d7 <alltraps>

80105e09 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e09:	6a 00                	push   $0x0
  pushl $16
80105e0b:	6a 10                	push   $0x10
  jmp alltraps
80105e0d:	e9 c5 fa ff ff       	jmp    801058d7 <alltraps>

80105e12 <vector17>:
.globl vector17
vector17:
  pushl $17
80105e12:	6a 11                	push   $0x11
  jmp alltraps
80105e14:	e9 be fa ff ff       	jmp    801058d7 <alltraps>

80105e19 <vector18>:
.globl vector18
vector18:
  pushl $0
80105e19:	6a 00                	push   $0x0
  pushl $18
80105e1b:	6a 12                	push   $0x12
  jmp alltraps
80105e1d:	e9 b5 fa ff ff       	jmp    801058d7 <alltraps>

80105e22 <vector19>:
.globl vector19
vector19:
  pushl $0
80105e22:	6a 00                	push   $0x0
  pushl $19
80105e24:	6a 13                	push   $0x13
  jmp alltraps
80105e26:	e9 ac fa ff ff       	jmp    801058d7 <alltraps>

80105e2b <vector20>:
.globl vector20
vector20:
  pushl $0
80105e2b:	6a 00                	push   $0x0
  pushl $20
80105e2d:	6a 14                	push   $0x14
  jmp alltraps
80105e2f:	e9 a3 fa ff ff       	jmp    801058d7 <alltraps>

80105e34 <vector21>:
.globl vector21
vector21:
  pushl $0
80105e34:	6a 00                	push   $0x0
  pushl $21
80105e36:	6a 15                	push   $0x15
  jmp alltraps
80105e38:	e9 9a fa ff ff       	jmp    801058d7 <alltraps>

80105e3d <vector22>:
.globl vector22
vector22:
  pushl $0
80105e3d:	6a 00                	push   $0x0
  pushl $22
80105e3f:	6a 16                	push   $0x16
  jmp alltraps
80105e41:	e9 91 fa ff ff       	jmp    801058d7 <alltraps>

80105e46 <vector23>:
.globl vector23
vector23:
  pushl $0
80105e46:	6a 00                	push   $0x0
  pushl $23
80105e48:	6a 17                	push   $0x17
  jmp alltraps
80105e4a:	e9 88 fa ff ff       	jmp    801058d7 <alltraps>

80105e4f <vector24>:
.globl vector24
vector24:
  pushl $0
80105e4f:	6a 00                	push   $0x0
  pushl $24
80105e51:	6a 18                	push   $0x18
  jmp alltraps
80105e53:	e9 7f fa ff ff       	jmp    801058d7 <alltraps>

80105e58 <vector25>:
.globl vector25
vector25:
  pushl $0
80105e58:	6a 00                	push   $0x0
  pushl $25
80105e5a:	6a 19                	push   $0x19
  jmp alltraps
80105e5c:	e9 76 fa ff ff       	jmp    801058d7 <alltraps>

80105e61 <vector26>:
.globl vector26
vector26:
  pushl $0
80105e61:	6a 00                	push   $0x0
  pushl $26
80105e63:	6a 1a                	push   $0x1a
  jmp alltraps
80105e65:	e9 6d fa ff ff       	jmp    801058d7 <alltraps>

80105e6a <vector27>:
.globl vector27
vector27:
  pushl $0
80105e6a:	6a 00                	push   $0x0
  pushl $27
80105e6c:	6a 1b                	push   $0x1b
  jmp alltraps
80105e6e:	e9 64 fa ff ff       	jmp    801058d7 <alltraps>

80105e73 <vector28>:
.globl vector28
vector28:
  pushl $0
80105e73:	6a 00                	push   $0x0
  pushl $28
80105e75:	6a 1c                	push   $0x1c
  jmp alltraps
80105e77:	e9 5b fa ff ff       	jmp    801058d7 <alltraps>

80105e7c <vector29>:
.globl vector29
vector29:
  pushl $0
80105e7c:	6a 00                	push   $0x0
  pushl $29
80105e7e:	6a 1d                	push   $0x1d
  jmp alltraps
80105e80:	e9 52 fa ff ff       	jmp    801058d7 <alltraps>

80105e85 <vector30>:
.globl vector30
vector30:
  pushl $0
80105e85:	6a 00                	push   $0x0
  pushl $30
80105e87:	6a 1e                	push   $0x1e
  jmp alltraps
80105e89:	e9 49 fa ff ff       	jmp    801058d7 <alltraps>

80105e8e <vector31>:
.globl vector31
vector31:
  pushl $0
80105e8e:	6a 00                	push   $0x0
  pushl $31
80105e90:	6a 1f                	push   $0x1f
  jmp alltraps
80105e92:	e9 40 fa ff ff       	jmp    801058d7 <alltraps>

80105e97 <vector32>:
.globl vector32
vector32:
  pushl $0
80105e97:	6a 00                	push   $0x0
  pushl $32
80105e99:	6a 20                	push   $0x20
  jmp alltraps
80105e9b:	e9 37 fa ff ff       	jmp    801058d7 <alltraps>

80105ea0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105ea0:	6a 00                	push   $0x0
  pushl $33
80105ea2:	6a 21                	push   $0x21
  jmp alltraps
80105ea4:	e9 2e fa ff ff       	jmp    801058d7 <alltraps>

80105ea9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105ea9:	6a 00                	push   $0x0
  pushl $34
80105eab:	6a 22                	push   $0x22
  jmp alltraps
80105ead:	e9 25 fa ff ff       	jmp    801058d7 <alltraps>

80105eb2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105eb2:	6a 00                	push   $0x0
  pushl $35
80105eb4:	6a 23                	push   $0x23
  jmp alltraps
80105eb6:	e9 1c fa ff ff       	jmp    801058d7 <alltraps>

80105ebb <vector36>:
.globl vector36
vector36:
  pushl $0
80105ebb:	6a 00                	push   $0x0
  pushl $36
80105ebd:	6a 24                	push   $0x24
  jmp alltraps
80105ebf:	e9 13 fa ff ff       	jmp    801058d7 <alltraps>

80105ec4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105ec4:	6a 00                	push   $0x0
  pushl $37
80105ec6:	6a 25                	push   $0x25
  jmp alltraps
80105ec8:	e9 0a fa ff ff       	jmp    801058d7 <alltraps>

80105ecd <vector38>:
.globl vector38
vector38:
  pushl $0
80105ecd:	6a 00                	push   $0x0
  pushl $38
80105ecf:	6a 26                	push   $0x26
  jmp alltraps
80105ed1:	e9 01 fa ff ff       	jmp    801058d7 <alltraps>

80105ed6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105ed6:	6a 00                	push   $0x0
  pushl $39
80105ed8:	6a 27                	push   $0x27
  jmp alltraps
80105eda:	e9 f8 f9 ff ff       	jmp    801058d7 <alltraps>

80105edf <vector40>:
.globl vector40
vector40:
  pushl $0
80105edf:	6a 00                	push   $0x0
  pushl $40
80105ee1:	6a 28                	push   $0x28
  jmp alltraps
80105ee3:	e9 ef f9 ff ff       	jmp    801058d7 <alltraps>

80105ee8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105ee8:	6a 00                	push   $0x0
  pushl $41
80105eea:	6a 29                	push   $0x29
  jmp alltraps
80105eec:	e9 e6 f9 ff ff       	jmp    801058d7 <alltraps>

80105ef1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105ef1:	6a 00                	push   $0x0
  pushl $42
80105ef3:	6a 2a                	push   $0x2a
  jmp alltraps
80105ef5:	e9 dd f9 ff ff       	jmp    801058d7 <alltraps>

80105efa <vector43>:
.globl vector43
vector43:
  pushl $0
80105efa:	6a 00                	push   $0x0
  pushl $43
80105efc:	6a 2b                	push   $0x2b
  jmp alltraps
80105efe:	e9 d4 f9 ff ff       	jmp    801058d7 <alltraps>

80105f03 <vector44>:
.globl vector44
vector44:
  pushl $0
80105f03:	6a 00                	push   $0x0
  pushl $44
80105f05:	6a 2c                	push   $0x2c
  jmp alltraps
80105f07:	e9 cb f9 ff ff       	jmp    801058d7 <alltraps>

80105f0c <vector45>:
.globl vector45
vector45:
  pushl $0
80105f0c:	6a 00                	push   $0x0
  pushl $45
80105f0e:	6a 2d                	push   $0x2d
  jmp alltraps
80105f10:	e9 c2 f9 ff ff       	jmp    801058d7 <alltraps>

80105f15 <vector46>:
.globl vector46
vector46:
  pushl $0
80105f15:	6a 00                	push   $0x0
  pushl $46
80105f17:	6a 2e                	push   $0x2e
  jmp alltraps
80105f19:	e9 b9 f9 ff ff       	jmp    801058d7 <alltraps>

80105f1e <vector47>:
.globl vector47
vector47:
  pushl $0
80105f1e:	6a 00                	push   $0x0
  pushl $47
80105f20:	6a 2f                	push   $0x2f
  jmp alltraps
80105f22:	e9 b0 f9 ff ff       	jmp    801058d7 <alltraps>

80105f27 <vector48>:
.globl vector48
vector48:
  pushl $0
80105f27:	6a 00                	push   $0x0
  pushl $48
80105f29:	6a 30                	push   $0x30
  jmp alltraps
80105f2b:	e9 a7 f9 ff ff       	jmp    801058d7 <alltraps>

80105f30 <vector49>:
.globl vector49
vector49:
  pushl $0
80105f30:	6a 00                	push   $0x0
  pushl $49
80105f32:	6a 31                	push   $0x31
  jmp alltraps
80105f34:	e9 9e f9 ff ff       	jmp    801058d7 <alltraps>

80105f39 <vector50>:
.globl vector50
vector50:
  pushl $0
80105f39:	6a 00                	push   $0x0
  pushl $50
80105f3b:	6a 32                	push   $0x32
  jmp alltraps
80105f3d:	e9 95 f9 ff ff       	jmp    801058d7 <alltraps>

80105f42 <vector51>:
.globl vector51
vector51:
  pushl $0
80105f42:	6a 00                	push   $0x0
  pushl $51
80105f44:	6a 33                	push   $0x33
  jmp alltraps
80105f46:	e9 8c f9 ff ff       	jmp    801058d7 <alltraps>

80105f4b <vector52>:
.globl vector52
vector52:
  pushl $0
80105f4b:	6a 00                	push   $0x0
  pushl $52
80105f4d:	6a 34                	push   $0x34
  jmp alltraps
80105f4f:	e9 83 f9 ff ff       	jmp    801058d7 <alltraps>

80105f54 <vector53>:
.globl vector53
vector53:
  pushl $0
80105f54:	6a 00                	push   $0x0
  pushl $53
80105f56:	6a 35                	push   $0x35
  jmp alltraps
80105f58:	e9 7a f9 ff ff       	jmp    801058d7 <alltraps>

80105f5d <vector54>:
.globl vector54
vector54:
  pushl $0
80105f5d:	6a 00                	push   $0x0
  pushl $54
80105f5f:	6a 36                	push   $0x36
  jmp alltraps
80105f61:	e9 71 f9 ff ff       	jmp    801058d7 <alltraps>

80105f66 <vector55>:
.globl vector55
vector55:
  pushl $0
80105f66:	6a 00                	push   $0x0
  pushl $55
80105f68:	6a 37                	push   $0x37
  jmp alltraps
80105f6a:	e9 68 f9 ff ff       	jmp    801058d7 <alltraps>

80105f6f <vector56>:
.globl vector56
vector56:
  pushl $0
80105f6f:	6a 00                	push   $0x0
  pushl $56
80105f71:	6a 38                	push   $0x38
  jmp alltraps
80105f73:	e9 5f f9 ff ff       	jmp    801058d7 <alltraps>

80105f78 <vector57>:
.globl vector57
vector57:
  pushl $0
80105f78:	6a 00                	push   $0x0
  pushl $57
80105f7a:	6a 39                	push   $0x39
  jmp alltraps
80105f7c:	e9 56 f9 ff ff       	jmp    801058d7 <alltraps>

80105f81 <vector58>:
.globl vector58
vector58:
  pushl $0
80105f81:	6a 00                	push   $0x0
  pushl $58
80105f83:	6a 3a                	push   $0x3a
  jmp alltraps
80105f85:	e9 4d f9 ff ff       	jmp    801058d7 <alltraps>

80105f8a <vector59>:
.globl vector59
vector59:
  pushl $0
80105f8a:	6a 00                	push   $0x0
  pushl $59
80105f8c:	6a 3b                	push   $0x3b
  jmp alltraps
80105f8e:	e9 44 f9 ff ff       	jmp    801058d7 <alltraps>

80105f93 <vector60>:
.globl vector60
vector60:
  pushl $0
80105f93:	6a 00                	push   $0x0
  pushl $60
80105f95:	6a 3c                	push   $0x3c
  jmp alltraps
80105f97:	e9 3b f9 ff ff       	jmp    801058d7 <alltraps>

80105f9c <vector61>:
.globl vector61
vector61:
  pushl $0
80105f9c:	6a 00                	push   $0x0
  pushl $61
80105f9e:	6a 3d                	push   $0x3d
  jmp alltraps
80105fa0:	e9 32 f9 ff ff       	jmp    801058d7 <alltraps>

80105fa5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105fa5:	6a 00                	push   $0x0
  pushl $62
80105fa7:	6a 3e                	push   $0x3e
  jmp alltraps
80105fa9:	e9 29 f9 ff ff       	jmp    801058d7 <alltraps>

80105fae <vector63>:
.globl vector63
vector63:
  pushl $0
80105fae:	6a 00                	push   $0x0
  pushl $63
80105fb0:	6a 3f                	push   $0x3f
  jmp alltraps
80105fb2:	e9 20 f9 ff ff       	jmp    801058d7 <alltraps>

80105fb7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105fb7:	6a 00                	push   $0x0
  pushl $64
80105fb9:	6a 40                	push   $0x40
  jmp alltraps
80105fbb:	e9 17 f9 ff ff       	jmp    801058d7 <alltraps>

80105fc0 <vector65>:
.globl vector65
vector65:
  pushl $0
80105fc0:	6a 00                	push   $0x0
  pushl $65
80105fc2:	6a 41                	push   $0x41
  jmp alltraps
80105fc4:	e9 0e f9 ff ff       	jmp    801058d7 <alltraps>

80105fc9 <vector66>:
.globl vector66
vector66:
  pushl $0
80105fc9:	6a 00                	push   $0x0
  pushl $66
80105fcb:	6a 42                	push   $0x42
  jmp alltraps
80105fcd:	e9 05 f9 ff ff       	jmp    801058d7 <alltraps>

80105fd2 <vector67>:
.globl vector67
vector67:
  pushl $0
80105fd2:	6a 00                	push   $0x0
  pushl $67
80105fd4:	6a 43                	push   $0x43
  jmp alltraps
80105fd6:	e9 fc f8 ff ff       	jmp    801058d7 <alltraps>

80105fdb <vector68>:
.globl vector68
vector68:
  pushl $0
80105fdb:	6a 00                	push   $0x0
  pushl $68
80105fdd:	6a 44                	push   $0x44
  jmp alltraps
80105fdf:	e9 f3 f8 ff ff       	jmp    801058d7 <alltraps>

80105fe4 <vector69>:
.globl vector69
vector69:
  pushl $0
80105fe4:	6a 00                	push   $0x0
  pushl $69
80105fe6:	6a 45                	push   $0x45
  jmp alltraps
80105fe8:	e9 ea f8 ff ff       	jmp    801058d7 <alltraps>

80105fed <vector70>:
.globl vector70
vector70:
  pushl $0
80105fed:	6a 00                	push   $0x0
  pushl $70
80105fef:	6a 46                	push   $0x46
  jmp alltraps
80105ff1:	e9 e1 f8 ff ff       	jmp    801058d7 <alltraps>

80105ff6 <vector71>:
.globl vector71
vector71:
  pushl $0
80105ff6:	6a 00                	push   $0x0
  pushl $71
80105ff8:	6a 47                	push   $0x47
  jmp alltraps
80105ffa:	e9 d8 f8 ff ff       	jmp    801058d7 <alltraps>

80105fff <vector72>:
.globl vector72
vector72:
  pushl $0
80105fff:	6a 00                	push   $0x0
  pushl $72
80106001:	6a 48                	push   $0x48
  jmp alltraps
80106003:	e9 cf f8 ff ff       	jmp    801058d7 <alltraps>

80106008 <vector73>:
.globl vector73
vector73:
  pushl $0
80106008:	6a 00                	push   $0x0
  pushl $73
8010600a:	6a 49                	push   $0x49
  jmp alltraps
8010600c:	e9 c6 f8 ff ff       	jmp    801058d7 <alltraps>

80106011 <vector74>:
.globl vector74
vector74:
  pushl $0
80106011:	6a 00                	push   $0x0
  pushl $74
80106013:	6a 4a                	push   $0x4a
  jmp alltraps
80106015:	e9 bd f8 ff ff       	jmp    801058d7 <alltraps>

8010601a <vector75>:
.globl vector75
vector75:
  pushl $0
8010601a:	6a 00                	push   $0x0
  pushl $75
8010601c:	6a 4b                	push   $0x4b
  jmp alltraps
8010601e:	e9 b4 f8 ff ff       	jmp    801058d7 <alltraps>

80106023 <vector76>:
.globl vector76
vector76:
  pushl $0
80106023:	6a 00                	push   $0x0
  pushl $76
80106025:	6a 4c                	push   $0x4c
  jmp alltraps
80106027:	e9 ab f8 ff ff       	jmp    801058d7 <alltraps>

8010602c <vector77>:
.globl vector77
vector77:
  pushl $0
8010602c:	6a 00                	push   $0x0
  pushl $77
8010602e:	6a 4d                	push   $0x4d
  jmp alltraps
80106030:	e9 a2 f8 ff ff       	jmp    801058d7 <alltraps>

80106035 <vector78>:
.globl vector78
vector78:
  pushl $0
80106035:	6a 00                	push   $0x0
  pushl $78
80106037:	6a 4e                	push   $0x4e
  jmp alltraps
80106039:	e9 99 f8 ff ff       	jmp    801058d7 <alltraps>

8010603e <vector79>:
.globl vector79
vector79:
  pushl $0
8010603e:	6a 00                	push   $0x0
  pushl $79
80106040:	6a 4f                	push   $0x4f
  jmp alltraps
80106042:	e9 90 f8 ff ff       	jmp    801058d7 <alltraps>

80106047 <vector80>:
.globl vector80
vector80:
  pushl $0
80106047:	6a 00                	push   $0x0
  pushl $80
80106049:	6a 50                	push   $0x50
  jmp alltraps
8010604b:	e9 87 f8 ff ff       	jmp    801058d7 <alltraps>

80106050 <vector81>:
.globl vector81
vector81:
  pushl $0
80106050:	6a 00                	push   $0x0
  pushl $81
80106052:	6a 51                	push   $0x51
  jmp alltraps
80106054:	e9 7e f8 ff ff       	jmp    801058d7 <alltraps>

80106059 <vector82>:
.globl vector82
vector82:
  pushl $0
80106059:	6a 00                	push   $0x0
  pushl $82
8010605b:	6a 52                	push   $0x52
  jmp alltraps
8010605d:	e9 75 f8 ff ff       	jmp    801058d7 <alltraps>

80106062 <vector83>:
.globl vector83
vector83:
  pushl $0
80106062:	6a 00                	push   $0x0
  pushl $83
80106064:	6a 53                	push   $0x53
  jmp alltraps
80106066:	e9 6c f8 ff ff       	jmp    801058d7 <alltraps>

8010606b <vector84>:
.globl vector84
vector84:
  pushl $0
8010606b:	6a 00                	push   $0x0
  pushl $84
8010606d:	6a 54                	push   $0x54
  jmp alltraps
8010606f:	e9 63 f8 ff ff       	jmp    801058d7 <alltraps>

80106074 <vector85>:
.globl vector85
vector85:
  pushl $0
80106074:	6a 00                	push   $0x0
  pushl $85
80106076:	6a 55                	push   $0x55
  jmp alltraps
80106078:	e9 5a f8 ff ff       	jmp    801058d7 <alltraps>

8010607d <vector86>:
.globl vector86
vector86:
  pushl $0
8010607d:	6a 00                	push   $0x0
  pushl $86
8010607f:	6a 56                	push   $0x56
  jmp alltraps
80106081:	e9 51 f8 ff ff       	jmp    801058d7 <alltraps>

80106086 <vector87>:
.globl vector87
vector87:
  pushl $0
80106086:	6a 00                	push   $0x0
  pushl $87
80106088:	6a 57                	push   $0x57
  jmp alltraps
8010608a:	e9 48 f8 ff ff       	jmp    801058d7 <alltraps>

8010608f <vector88>:
.globl vector88
vector88:
  pushl $0
8010608f:	6a 00                	push   $0x0
  pushl $88
80106091:	6a 58                	push   $0x58
  jmp alltraps
80106093:	e9 3f f8 ff ff       	jmp    801058d7 <alltraps>

80106098 <vector89>:
.globl vector89
vector89:
  pushl $0
80106098:	6a 00                	push   $0x0
  pushl $89
8010609a:	6a 59                	push   $0x59
  jmp alltraps
8010609c:	e9 36 f8 ff ff       	jmp    801058d7 <alltraps>

801060a1 <vector90>:
.globl vector90
vector90:
  pushl $0
801060a1:	6a 00                	push   $0x0
  pushl $90
801060a3:	6a 5a                	push   $0x5a
  jmp alltraps
801060a5:	e9 2d f8 ff ff       	jmp    801058d7 <alltraps>

801060aa <vector91>:
.globl vector91
vector91:
  pushl $0
801060aa:	6a 00                	push   $0x0
  pushl $91
801060ac:	6a 5b                	push   $0x5b
  jmp alltraps
801060ae:	e9 24 f8 ff ff       	jmp    801058d7 <alltraps>

801060b3 <vector92>:
.globl vector92
vector92:
  pushl $0
801060b3:	6a 00                	push   $0x0
  pushl $92
801060b5:	6a 5c                	push   $0x5c
  jmp alltraps
801060b7:	e9 1b f8 ff ff       	jmp    801058d7 <alltraps>

801060bc <vector93>:
.globl vector93
vector93:
  pushl $0
801060bc:	6a 00                	push   $0x0
  pushl $93
801060be:	6a 5d                	push   $0x5d
  jmp alltraps
801060c0:	e9 12 f8 ff ff       	jmp    801058d7 <alltraps>

801060c5 <vector94>:
.globl vector94
vector94:
  pushl $0
801060c5:	6a 00                	push   $0x0
  pushl $94
801060c7:	6a 5e                	push   $0x5e
  jmp alltraps
801060c9:	e9 09 f8 ff ff       	jmp    801058d7 <alltraps>

801060ce <vector95>:
.globl vector95
vector95:
  pushl $0
801060ce:	6a 00                	push   $0x0
  pushl $95
801060d0:	6a 5f                	push   $0x5f
  jmp alltraps
801060d2:	e9 00 f8 ff ff       	jmp    801058d7 <alltraps>

801060d7 <vector96>:
.globl vector96
vector96:
  pushl $0
801060d7:	6a 00                	push   $0x0
  pushl $96
801060d9:	6a 60                	push   $0x60
  jmp alltraps
801060db:	e9 f7 f7 ff ff       	jmp    801058d7 <alltraps>

801060e0 <vector97>:
.globl vector97
vector97:
  pushl $0
801060e0:	6a 00                	push   $0x0
  pushl $97
801060e2:	6a 61                	push   $0x61
  jmp alltraps
801060e4:	e9 ee f7 ff ff       	jmp    801058d7 <alltraps>

801060e9 <vector98>:
.globl vector98
vector98:
  pushl $0
801060e9:	6a 00                	push   $0x0
  pushl $98
801060eb:	6a 62                	push   $0x62
  jmp alltraps
801060ed:	e9 e5 f7 ff ff       	jmp    801058d7 <alltraps>

801060f2 <vector99>:
.globl vector99
vector99:
  pushl $0
801060f2:	6a 00                	push   $0x0
  pushl $99
801060f4:	6a 63                	push   $0x63
  jmp alltraps
801060f6:	e9 dc f7 ff ff       	jmp    801058d7 <alltraps>

801060fb <vector100>:
.globl vector100
vector100:
  pushl $0
801060fb:	6a 00                	push   $0x0
  pushl $100
801060fd:	6a 64                	push   $0x64
  jmp alltraps
801060ff:	e9 d3 f7 ff ff       	jmp    801058d7 <alltraps>

80106104 <vector101>:
.globl vector101
vector101:
  pushl $0
80106104:	6a 00                	push   $0x0
  pushl $101
80106106:	6a 65                	push   $0x65
  jmp alltraps
80106108:	e9 ca f7 ff ff       	jmp    801058d7 <alltraps>

8010610d <vector102>:
.globl vector102
vector102:
  pushl $0
8010610d:	6a 00                	push   $0x0
  pushl $102
8010610f:	6a 66                	push   $0x66
  jmp alltraps
80106111:	e9 c1 f7 ff ff       	jmp    801058d7 <alltraps>

80106116 <vector103>:
.globl vector103
vector103:
  pushl $0
80106116:	6a 00                	push   $0x0
  pushl $103
80106118:	6a 67                	push   $0x67
  jmp alltraps
8010611a:	e9 b8 f7 ff ff       	jmp    801058d7 <alltraps>

8010611f <vector104>:
.globl vector104
vector104:
  pushl $0
8010611f:	6a 00                	push   $0x0
  pushl $104
80106121:	6a 68                	push   $0x68
  jmp alltraps
80106123:	e9 af f7 ff ff       	jmp    801058d7 <alltraps>

80106128 <vector105>:
.globl vector105
vector105:
  pushl $0
80106128:	6a 00                	push   $0x0
  pushl $105
8010612a:	6a 69                	push   $0x69
  jmp alltraps
8010612c:	e9 a6 f7 ff ff       	jmp    801058d7 <alltraps>

80106131 <vector106>:
.globl vector106
vector106:
  pushl $0
80106131:	6a 00                	push   $0x0
  pushl $106
80106133:	6a 6a                	push   $0x6a
  jmp alltraps
80106135:	e9 9d f7 ff ff       	jmp    801058d7 <alltraps>

8010613a <vector107>:
.globl vector107
vector107:
  pushl $0
8010613a:	6a 00                	push   $0x0
  pushl $107
8010613c:	6a 6b                	push   $0x6b
  jmp alltraps
8010613e:	e9 94 f7 ff ff       	jmp    801058d7 <alltraps>

80106143 <vector108>:
.globl vector108
vector108:
  pushl $0
80106143:	6a 00                	push   $0x0
  pushl $108
80106145:	6a 6c                	push   $0x6c
  jmp alltraps
80106147:	e9 8b f7 ff ff       	jmp    801058d7 <alltraps>

8010614c <vector109>:
.globl vector109
vector109:
  pushl $0
8010614c:	6a 00                	push   $0x0
  pushl $109
8010614e:	6a 6d                	push   $0x6d
  jmp alltraps
80106150:	e9 82 f7 ff ff       	jmp    801058d7 <alltraps>

80106155 <vector110>:
.globl vector110
vector110:
  pushl $0
80106155:	6a 00                	push   $0x0
  pushl $110
80106157:	6a 6e                	push   $0x6e
  jmp alltraps
80106159:	e9 79 f7 ff ff       	jmp    801058d7 <alltraps>

8010615e <vector111>:
.globl vector111
vector111:
  pushl $0
8010615e:	6a 00                	push   $0x0
  pushl $111
80106160:	6a 6f                	push   $0x6f
  jmp alltraps
80106162:	e9 70 f7 ff ff       	jmp    801058d7 <alltraps>

80106167 <vector112>:
.globl vector112
vector112:
  pushl $0
80106167:	6a 00                	push   $0x0
  pushl $112
80106169:	6a 70                	push   $0x70
  jmp alltraps
8010616b:	e9 67 f7 ff ff       	jmp    801058d7 <alltraps>

80106170 <vector113>:
.globl vector113
vector113:
  pushl $0
80106170:	6a 00                	push   $0x0
  pushl $113
80106172:	6a 71                	push   $0x71
  jmp alltraps
80106174:	e9 5e f7 ff ff       	jmp    801058d7 <alltraps>

80106179 <vector114>:
.globl vector114
vector114:
  pushl $0
80106179:	6a 00                	push   $0x0
  pushl $114
8010617b:	6a 72                	push   $0x72
  jmp alltraps
8010617d:	e9 55 f7 ff ff       	jmp    801058d7 <alltraps>

80106182 <vector115>:
.globl vector115
vector115:
  pushl $0
80106182:	6a 00                	push   $0x0
  pushl $115
80106184:	6a 73                	push   $0x73
  jmp alltraps
80106186:	e9 4c f7 ff ff       	jmp    801058d7 <alltraps>

8010618b <vector116>:
.globl vector116
vector116:
  pushl $0
8010618b:	6a 00                	push   $0x0
  pushl $116
8010618d:	6a 74                	push   $0x74
  jmp alltraps
8010618f:	e9 43 f7 ff ff       	jmp    801058d7 <alltraps>

80106194 <vector117>:
.globl vector117
vector117:
  pushl $0
80106194:	6a 00                	push   $0x0
  pushl $117
80106196:	6a 75                	push   $0x75
  jmp alltraps
80106198:	e9 3a f7 ff ff       	jmp    801058d7 <alltraps>

8010619d <vector118>:
.globl vector118
vector118:
  pushl $0
8010619d:	6a 00                	push   $0x0
  pushl $118
8010619f:	6a 76                	push   $0x76
  jmp alltraps
801061a1:	e9 31 f7 ff ff       	jmp    801058d7 <alltraps>

801061a6 <vector119>:
.globl vector119
vector119:
  pushl $0
801061a6:	6a 00                	push   $0x0
  pushl $119
801061a8:	6a 77                	push   $0x77
  jmp alltraps
801061aa:	e9 28 f7 ff ff       	jmp    801058d7 <alltraps>

801061af <vector120>:
.globl vector120
vector120:
  pushl $0
801061af:	6a 00                	push   $0x0
  pushl $120
801061b1:	6a 78                	push   $0x78
  jmp alltraps
801061b3:	e9 1f f7 ff ff       	jmp    801058d7 <alltraps>

801061b8 <vector121>:
.globl vector121
vector121:
  pushl $0
801061b8:	6a 00                	push   $0x0
  pushl $121
801061ba:	6a 79                	push   $0x79
  jmp alltraps
801061bc:	e9 16 f7 ff ff       	jmp    801058d7 <alltraps>

801061c1 <vector122>:
.globl vector122
vector122:
  pushl $0
801061c1:	6a 00                	push   $0x0
  pushl $122
801061c3:	6a 7a                	push   $0x7a
  jmp alltraps
801061c5:	e9 0d f7 ff ff       	jmp    801058d7 <alltraps>

801061ca <vector123>:
.globl vector123
vector123:
  pushl $0
801061ca:	6a 00                	push   $0x0
  pushl $123
801061cc:	6a 7b                	push   $0x7b
  jmp alltraps
801061ce:	e9 04 f7 ff ff       	jmp    801058d7 <alltraps>

801061d3 <vector124>:
.globl vector124
vector124:
  pushl $0
801061d3:	6a 00                	push   $0x0
  pushl $124
801061d5:	6a 7c                	push   $0x7c
  jmp alltraps
801061d7:	e9 fb f6 ff ff       	jmp    801058d7 <alltraps>

801061dc <vector125>:
.globl vector125
vector125:
  pushl $0
801061dc:	6a 00                	push   $0x0
  pushl $125
801061de:	6a 7d                	push   $0x7d
  jmp alltraps
801061e0:	e9 f2 f6 ff ff       	jmp    801058d7 <alltraps>

801061e5 <vector126>:
.globl vector126
vector126:
  pushl $0
801061e5:	6a 00                	push   $0x0
  pushl $126
801061e7:	6a 7e                	push   $0x7e
  jmp alltraps
801061e9:	e9 e9 f6 ff ff       	jmp    801058d7 <alltraps>

801061ee <vector127>:
.globl vector127
vector127:
  pushl $0
801061ee:	6a 00                	push   $0x0
  pushl $127
801061f0:	6a 7f                	push   $0x7f
  jmp alltraps
801061f2:	e9 e0 f6 ff ff       	jmp    801058d7 <alltraps>

801061f7 <vector128>:
.globl vector128
vector128:
  pushl $0
801061f7:	6a 00                	push   $0x0
  pushl $128
801061f9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801061fe:	e9 d4 f6 ff ff       	jmp    801058d7 <alltraps>

80106203 <vector129>:
.globl vector129
vector129:
  pushl $0
80106203:	6a 00                	push   $0x0
  pushl $129
80106205:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010620a:	e9 c8 f6 ff ff       	jmp    801058d7 <alltraps>

8010620f <vector130>:
.globl vector130
vector130:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $130
80106211:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106216:	e9 bc f6 ff ff       	jmp    801058d7 <alltraps>

8010621b <vector131>:
.globl vector131
vector131:
  pushl $0
8010621b:	6a 00                	push   $0x0
  pushl $131
8010621d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106222:	e9 b0 f6 ff ff       	jmp    801058d7 <alltraps>

80106227 <vector132>:
.globl vector132
vector132:
  pushl $0
80106227:	6a 00                	push   $0x0
  pushl $132
80106229:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010622e:	e9 a4 f6 ff ff       	jmp    801058d7 <alltraps>

80106233 <vector133>:
.globl vector133
vector133:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $133
80106235:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010623a:	e9 98 f6 ff ff       	jmp    801058d7 <alltraps>

8010623f <vector134>:
.globl vector134
vector134:
  pushl $0
8010623f:	6a 00                	push   $0x0
  pushl $134
80106241:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106246:	e9 8c f6 ff ff       	jmp    801058d7 <alltraps>

8010624b <vector135>:
.globl vector135
vector135:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $135
8010624d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106252:	e9 80 f6 ff ff       	jmp    801058d7 <alltraps>

80106257 <vector136>:
.globl vector136
vector136:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $136
80106259:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010625e:	e9 74 f6 ff ff       	jmp    801058d7 <alltraps>

80106263 <vector137>:
.globl vector137
vector137:
  pushl $0
80106263:	6a 00                	push   $0x0
  pushl $137
80106265:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010626a:	e9 68 f6 ff ff       	jmp    801058d7 <alltraps>

8010626f <vector138>:
.globl vector138
vector138:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $138
80106271:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106276:	e9 5c f6 ff ff       	jmp    801058d7 <alltraps>

8010627b <vector139>:
.globl vector139
vector139:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $139
8010627d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106282:	e9 50 f6 ff ff       	jmp    801058d7 <alltraps>

80106287 <vector140>:
.globl vector140
vector140:
  pushl $0
80106287:	6a 00                	push   $0x0
  pushl $140
80106289:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010628e:	e9 44 f6 ff ff       	jmp    801058d7 <alltraps>

80106293 <vector141>:
.globl vector141
vector141:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $141
80106295:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010629a:	e9 38 f6 ff ff       	jmp    801058d7 <alltraps>

8010629f <vector142>:
.globl vector142
vector142:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $142
801062a1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801062a6:	e9 2c f6 ff ff       	jmp    801058d7 <alltraps>

801062ab <vector143>:
.globl vector143
vector143:
  pushl $0
801062ab:	6a 00                	push   $0x0
  pushl $143
801062ad:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801062b2:	e9 20 f6 ff ff       	jmp    801058d7 <alltraps>

801062b7 <vector144>:
.globl vector144
vector144:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $144
801062b9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801062be:	e9 14 f6 ff ff       	jmp    801058d7 <alltraps>

801062c3 <vector145>:
.globl vector145
vector145:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $145
801062c5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801062ca:	e9 08 f6 ff ff       	jmp    801058d7 <alltraps>

801062cf <vector146>:
.globl vector146
vector146:
  pushl $0
801062cf:	6a 00                	push   $0x0
  pushl $146
801062d1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801062d6:	e9 fc f5 ff ff       	jmp    801058d7 <alltraps>

801062db <vector147>:
.globl vector147
vector147:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $147
801062dd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801062e2:	e9 f0 f5 ff ff       	jmp    801058d7 <alltraps>

801062e7 <vector148>:
.globl vector148
vector148:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $148
801062e9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801062ee:	e9 e4 f5 ff ff       	jmp    801058d7 <alltraps>

801062f3 <vector149>:
.globl vector149
vector149:
  pushl $0
801062f3:	6a 00                	push   $0x0
  pushl $149
801062f5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801062fa:	e9 d8 f5 ff ff       	jmp    801058d7 <alltraps>

801062ff <vector150>:
.globl vector150
vector150:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $150
80106301:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106306:	e9 cc f5 ff ff       	jmp    801058d7 <alltraps>

8010630b <vector151>:
.globl vector151
vector151:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $151
8010630d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106312:	e9 c0 f5 ff ff       	jmp    801058d7 <alltraps>

80106317 <vector152>:
.globl vector152
vector152:
  pushl $0
80106317:	6a 00                	push   $0x0
  pushl $152
80106319:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010631e:	e9 b4 f5 ff ff       	jmp    801058d7 <alltraps>

80106323 <vector153>:
.globl vector153
vector153:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $153
80106325:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010632a:	e9 a8 f5 ff ff       	jmp    801058d7 <alltraps>

8010632f <vector154>:
.globl vector154
vector154:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $154
80106331:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106336:	e9 9c f5 ff ff       	jmp    801058d7 <alltraps>

8010633b <vector155>:
.globl vector155
vector155:
  pushl $0
8010633b:	6a 00                	push   $0x0
  pushl $155
8010633d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106342:	e9 90 f5 ff ff       	jmp    801058d7 <alltraps>

80106347 <vector156>:
.globl vector156
vector156:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $156
80106349:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010634e:	e9 84 f5 ff ff       	jmp    801058d7 <alltraps>

80106353 <vector157>:
.globl vector157
vector157:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $157
80106355:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010635a:	e9 78 f5 ff ff       	jmp    801058d7 <alltraps>

8010635f <vector158>:
.globl vector158
vector158:
  pushl $0
8010635f:	6a 00                	push   $0x0
  pushl $158
80106361:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106366:	e9 6c f5 ff ff       	jmp    801058d7 <alltraps>

8010636b <vector159>:
.globl vector159
vector159:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $159
8010636d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106372:	e9 60 f5 ff ff       	jmp    801058d7 <alltraps>

80106377 <vector160>:
.globl vector160
vector160:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $160
80106379:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010637e:	e9 54 f5 ff ff       	jmp    801058d7 <alltraps>

80106383 <vector161>:
.globl vector161
vector161:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $161
80106385:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010638a:	e9 48 f5 ff ff       	jmp    801058d7 <alltraps>

8010638f <vector162>:
.globl vector162
vector162:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $162
80106391:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106396:	e9 3c f5 ff ff       	jmp    801058d7 <alltraps>

8010639b <vector163>:
.globl vector163
vector163:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $163
8010639d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801063a2:	e9 30 f5 ff ff       	jmp    801058d7 <alltraps>

801063a7 <vector164>:
.globl vector164
vector164:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $164
801063a9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801063ae:	e9 24 f5 ff ff       	jmp    801058d7 <alltraps>

801063b3 <vector165>:
.globl vector165
vector165:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $165
801063b5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801063ba:	e9 18 f5 ff ff       	jmp    801058d7 <alltraps>

801063bf <vector166>:
.globl vector166
vector166:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $166
801063c1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801063c6:	e9 0c f5 ff ff       	jmp    801058d7 <alltraps>

801063cb <vector167>:
.globl vector167
vector167:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $167
801063cd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801063d2:	e9 00 f5 ff ff       	jmp    801058d7 <alltraps>

801063d7 <vector168>:
.globl vector168
vector168:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $168
801063d9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801063de:	e9 f4 f4 ff ff       	jmp    801058d7 <alltraps>

801063e3 <vector169>:
.globl vector169
vector169:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $169
801063e5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801063ea:	e9 e8 f4 ff ff       	jmp    801058d7 <alltraps>

801063ef <vector170>:
.globl vector170
vector170:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $170
801063f1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801063f6:	e9 dc f4 ff ff       	jmp    801058d7 <alltraps>

801063fb <vector171>:
.globl vector171
vector171:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $171
801063fd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106402:	e9 d0 f4 ff ff       	jmp    801058d7 <alltraps>

80106407 <vector172>:
.globl vector172
vector172:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $172
80106409:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010640e:	e9 c4 f4 ff ff       	jmp    801058d7 <alltraps>

80106413 <vector173>:
.globl vector173
vector173:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $173
80106415:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010641a:	e9 b8 f4 ff ff       	jmp    801058d7 <alltraps>

8010641f <vector174>:
.globl vector174
vector174:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $174
80106421:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106426:	e9 ac f4 ff ff       	jmp    801058d7 <alltraps>

8010642b <vector175>:
.globl vector175
vector175:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $175
8010642d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106432:	e9 a0 f4 ff ff       	jmp    801058d7 <alltraps>

80106437 <vector176>:
.globl vector176
vector176:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $176
80106439:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010643e:	e9 94 f4 ff ff       	jmp    801058d7 <alltraps>

80106443 <vector177>:
.globl vector177
vector177:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $177
80106445:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010644a:	e9 88 f4 ff ff       	jmp    801058d7 <alltraps>

8010644f <vector178>:
.globl vector178
vector178:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $178
80106451:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106456:	e9 7c f4 ff ff       	jmp    801058d7 <alltraps>

8010645b <vector179>:
.globl vector179
vector179:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $179
8010645d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106462:	e9 70 f4 ff ff       	jmp    801058d7 <alltraps>

80106467 <vector180>:
.globl vector180
vector180:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $180
80106469:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010646e:	e9 64 f4 ff ff       	jmp    801058d7 <alltraps>

80106473 <vector181>:
.globl vector181
vector181:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $181
80106475:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010647a:	e9 58 f4 ff ff       	jmp    801058d7 <alltraps>

8010647f <vector182>:
.globl vector182
vector182:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $182
80106481:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106486:	e9 4c f4 ff ff       	jmp    801058d7 <alltraps>

8010648b <vector183>:
.globl vector183
vector183:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $183
8010648d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106492:	e9 40 f4 ff ff       	jmp    801058d7 <alltraps>

80106497 <vector184>:
.globl vector184
vector184:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $184
80106499:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010649e:	e9 34 f4 ff ff       	jmp    801058d7 <alltraps>

801064a3 <vector185>:
.globl vector185
vector185:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $185
801064a5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801064aa:	e9 28 f4 ff ff       	jmp    801058d7 <alltraps>

801064af <vector186>:
.globl vector186
vector186:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $186
801064b1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801064b6:	e9 1c f4 ff ff       	jmp    801058d7 <alltraps>

801064bb <vector187>:
.globl vector187
vector187:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $187
801064bd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801064c2:	e9 10 f4 ff ff       	jmp    801058d7 <alltraps>

801064c7 <vector188>:
.globl vector188
vector188:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $188
801064c9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801064ce:	e9 04 f4 ff ff       	jmp    801058d7 <alltraps>

801064d3 <vector189>:
.globl vector189
vector189:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $189
801064d5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801064da:	e9 f8 f3 ff ff       	jmp    801058d7 <alltraps>

801064df <vector190>:
.globl vector190
vector190:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $190
801064e1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801064e6:	e9 ec f3 ff ff       	jmp    801058d7 <alltraps>

801064eb <vector191>:
.globl vector191
vector191:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $191
801064ed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801064f2:	e9 e0 f3 ff ff       	jmp    801058d7 <alltraps>

801064f7 <vector192>:
.globl vector192
vector192:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $192
801064f9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801064fe:	e9 d4 f3 ff ff       	jmp    801058d7 <alltraps>

80106503 <vector193>:
.globl vector193
vector193:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $193
80106505:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010650a:	e9 c8 f3 ff ff       	jmp    801058d7 <alltraps>

8010650f <vector194>:
.globl vector194
vector194:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $194
80106511:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106516:	e9 bc f3 ff ff       	jmp    801058d7 <alltraps>

8010651b <vector195>:
.globl vector195
vector195:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $195
8010651d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106522:	e9 b0 f3 ff ff       	jmp    801058d7 <alltraps>

80106527 <vector196>:
.globl vector196
vector196:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $196
80106529:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010652e:	e9 a4 f3 ff ff       	jmp    801058d7 <alltraps>

80106533 <vector197>:
.globl vector197
vector197:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $197
80106535:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010653a:	e9 98 f3 ff ff       	jmp    801058d7 <alltraps>

8010653f <vector198>:
.globl vector198
vector198:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $198
80106541:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106546:	e9 8c f3 ff ff       	jmp    801058d7 <alltraps>

8010654b <vector199>:
.globl vector199
vector199:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $199
8010654d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106552:	e9 80 f3 ff ff       	jmp    801058d7 <alltraps>

80106557 <vector200>:
.globl vector200
vector200:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $200
80106559:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010655e:	e9 74 f3 ff ff       	jmp    801058d7 <alltraps>

80106563 <vector201>:
.globl vector201
vector201:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $201
80106565:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010656a:	e9 68 f3 ff ff       	jmp    801058d7 <alltraps>

8010656f <vector202>:
.globl vector202
vector202:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $202
80106571:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106576:	e9 5c f3 ff ff       	jmp    801058d7 <alltraps>

8010657b <vector203>:
.globl vector203
vector203:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $203
8010657d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106582:	e9 50 f3 ff ff       	jmp    801058d7 <alltraps>

80106587 <vector204>:
.globl vector204
vector204:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $204
80106589:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010658e:	e9 44 f3 ff ff       	jmp    801058d7 <alltraps>

80106593 <vector205>:
.globl vector205
vector205:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $205
80106595:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010659a:	e9 38 f3 ff ff       	jmp    801058d7 <alltraps>

8010659f <vector206>:
.globl vector206
vector206:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $206
801065a1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801065a6:	e9 2c f3 ff ff       	jmp    801058d7 <alltraps>

801065ab <vector207>:
.globl vector207
vector207:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $207
801065ad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801065b2:	e9 20 f3 ff ff       	jmp    801058d7 <alltraps>

801065b7 <vector208>:
.globl vector208
vector208:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $208
801065b9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801065be:	e9 14 f3 ff ff       	jmp    801058d7 <alltraps>

801065c3 <vector209>:
.globl vector209
vector209:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $209
801065c5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801065ca:	e9 08 f3 ff ff       	jmp    801058d7 <alltraps>

801065cf <vector210>:
.globl vector210
vector210:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $210
801065d1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801065d6:	e9 fc f2 ff ff       	jmp    801058d7 <alltraps>

801065db <vector211>:
.globl vector211
vector211:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $211
801065dd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801065e2:	e9 f0 f2 ff ff       	jmp    801058d7 <alltraps>

801065e7 <vector212>:
.globl vector212
vector212:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $212
801065e9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801065ee:	e9 e4 f2 ff ff       	jmp    801058d7 <alltraps>

801065f3 <vector213>:
.globl vector213
vector213:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $213
801065f5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801065fa:	e9 d8 f2 ff ff       	jmp    801058d7 <alltraps>

801065ff <vector214>:
.globl vector214
vector214:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $214
80106601:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106606:	e9 cc f2 ff ff       	jmp    801058d7 <alltraps>

8010660b <vector215>:
.globl vector215
vector215:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $215
8010660d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106612:	e9 c0 f2 ff ff       	jmp    801058d7 <alltraps>

80106617 <vector216>:
.globl vector216
vector216:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $216
80106619:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010661e:	e9 b4 f2 ff ff       	jmp    801058d7 <alltraps>

80106623 <vector217>:
.globl vector217
vector217:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $217
80106625:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010662a:	e9 a8 f2 ff ff       	jmp    801058d7 <alltraps>

8010662f <vector218>:
.globl vector218
vector218:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $218
80106631:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106636:	e9 9c f2 ff ff       	jmp    801058d7 <alltraps>

8010663b <vector219>:
.globl vector219
vector219:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $219
8010663d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106642:	e9 90 f2 ff ff       	jmp    801058d7 <alltraps>

80106647 <vector220>:
.globl vector220
vector220:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $220
80106649:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010664e:	e9 84 f2 ff ff       	jmp    801058d7 <alltraps>

80106653 <vector221>:
.globl vector221
vector221:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $221
80106655:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010665a:	e9 78 f2 ff ff       	jmp    801058d7 <alltraps>

8010665f <vector222>:
.globl vector222
vector222:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $222
80106661:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106666:	e9 6c f2 ff ff       	jmp    801058d7 <alltraps>

8010666b <vector223>:
.globl vector223
vector223:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $223
8010666d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106672:	e9 60 f2 ff ff       	jmp    801058d7 <alltraps>

80106677 <vector224>:
.globl vector224
vector224:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $224
80106679:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010667e:	e9 54 f2 ff ff       	jmp    801058d7 <alltraps>

80106683 <vector225>:
.globl vector225
vector225:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $225
80106685:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010668a:	e9 48 f2 ff ff       	jmp    801058d7 <alltraps>

8010668f <vector226>:
.globl vector226
vector226:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $226
80106691:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106696:	e9 3c f2 ff ff       	jmp    801058d7 <alltraps>

8010669b <vector227>:
.globl vector227
vector227:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $227
8010669d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801066a2:	e9 30 f2 ff ff       	jmp    801058d7 <alltraps>

801066a7 <vector228>:
.globl vector228
vector228:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $228
801066a9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801066ae:	e9 24 f2 ff ff       	jmp    801058d7 <alltraps>

801066b3 <vector229>:
.globl vector229
vector229:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $229
801066b5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801066ba:	e9 18 f2 ff ff       	jmp    801058d7 <alltraps>

801066bf <vector230>:
.globl vector230
vector230:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $230
801066c1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801066c6:	e9 0c f2 ff ff       	jmp    801058d7 <alltraps>

801066cb <vector231>:
.globl vector231
vector231:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $231
801066cd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801066d2:	e9 00 f2 ff ff       	jmp    801058d7 <alltraps>

801066d7 <vector232>:
.globl vector232
vector232:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $232
801066d9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801066de:	e9 f4 f1 ff ff       	jmp    801058d7 <alltraps>

801066e3 <vector233>:
.globl vector233
vector233:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $233
801066e5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801066ea:	e9 e8 f1 ff ff       	jmp    801058d7 <alltraps>

801066ef <vector234>:
.globl vector234
vector234:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $234
801066f1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801066f6:	e9 dc f1 ff ff       	jmp    801058d7 <alltraps>

801066fb <vector235>:
.globl vector235
vector235:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $235
801066fd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106702:	e9 d0 f1 ff ff       	jmp    801058d7 <alltraps>

80106707 <vector236>:
.globl vector236
vector236:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $236
80106709:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010670e:	e9 c4 f1 ff ff       	jmp    801058d7 <alltraps>

80106713 <vector237>:
.globl vector237
vector237:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $237
80106715:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010671a:	e9 b8 f1 ff ff       	jmp    801058d7 <alltraps>

8010671f <vector238>:
.globl vector238
vector238:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $238
80106721:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106726:	e9 ac f1 ff ff       	jmp    801058d7 <alltraps>

8010672b <vector239>:
.globl vector239
vector239:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $239
8010672d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106732:	e9 a0 f1 ff ff       	jmp    801058d7 <alltraps>

80106737 <vector240>:
.globl vector240
vector240:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $240
80106739:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010673e:	e9 94 f1 ff ff       	jmp    801058d7 <alltraps>

80106743 <vector241>:
.globl vector241
vector241:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $241
80106745:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010674a:	e9 88 f1 ff ff       	jmp    801058d7 <alltraps>

8010674f <vector242>:
.globl vector242
vector242:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $242
80106751:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106756:	e9 7c f1 ff ff       	jmp    801058d7 <alltraps>

8010675b <vector243>:
.globl vector243
vector243:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $243
8010675d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106762:	e9 70 f1 ff ff       	jmp    801058d7 <alltraps>

80106767 <vector244>:
.globl vector244
vector244:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $244
80106769:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010676e:	e9 64 f1 ff ff       	jmp    801058d7 <alltraps>

80106773 <vector245>:
.globl vector245
vector245:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $245
80106775:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010677a:	e9 58 f1 ff ff       	jmp    801058d7 <alltraps>

8010677f <vector246>:
.globl vector246
vector246:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $246
80106781:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106786:	e9 4c f1 ff ff       	jmp    801058d7 <alltraps>

8010678b <vector247>:
.globl vector247
vector247:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $247
8010678d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106792:	e9 40 f1 ff ff       	jmp    801058d7 <alltraps>

80106797 <vector248>:
.globl vector248
vector248:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $248
80106799:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010679e:	e9 34 f1 ff ff       	jmp    801058d7 <alltraps>

801067a3 <vector249>:
.globl vector249
vector249:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $249
801067a5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801067aa:	e9 28 f1 ff ff       	jmp    801058d7 <alltraps>

801067af <vector250>:
.globl vector250
vector250:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $250
801067b1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801067b6:	e9 1c f1 ff ff       	jmp    801058d7 <alltraps>

801067bb <vector251>:
.globl vector251
vector251:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $251
801067bd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801067c2:	e9 10 f1 ff ff       	jmp    801058d7 <alltraps>

801067c7 <vector252>:
.globl vector252
vector252:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $252
801067c9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801067ce:	e9 04 f1 ff ff       	jmp    801058d7 <alltraps>

801067d3 <vector253>:
.globl vector253
vector253:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $253
801067d5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801067da:	e9 f8 f0 ff ff       	jmp    801058d7 <alltraps>

801067df <vector254>:
.globl vector254
vector254:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $254
801067e1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801067e6:	e9 ec f0 ff ff       	jmp    801058d7 <alltraps>

801067eb <vector255>:
.globl vector255
vector255:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $255
801067ed:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801067f2:	e9 e0 f0 ff ff       	jmp    801058d7 <alltraps>
801067f7:	66 90                	xchg   %ax,%ax
801067f9:	66 90                	xchg   %ax,%ax
801067fb:	66 90                	xchg   %ax,%ax
801067fd:	66 90                	xchg   %ax,%ax
801067ff:	90                   	nop

80106800 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106800:	55                   	push   %ebp
80106801:	89 e5                	mov    %esp,%ebp
80106803:	57                   	push   %edi
80106804:	56                   	push   %esi
80106805:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106807:	c1 ea 16             	shr    $0x16,%edx
{
8010680a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010680b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010680e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106811:	8b 1f                	mov    (%edi),%ebx
80106813:	f6 c3 01             	test   $0x1,%bl
80106816:	74 28                	je     80106840 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106818:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010681e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106824:	89 f0                	mov    %esi,%eax
}
80106826:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106829:	c1 e8 0a             	shr    $0xa,%eax
8010682c:	25 fc 0f 00 00       	and    $0xffc,%eax
80106831:	01 d8                	add    %ebx,%eax
}
80106833:	5b                   	pop    %ebx
80106834:	5e                   	pop    %esi
80106835:	5f                   	pop    %edi
80106836:	5d                   	pop    %ebp
80106837:	c3                   	ret    
80106838:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010683f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106840:	85 c9                	test   %ecx,%ecx
80106842:	74 2c                	je     80106870 <walkpgdir+0x70>
80106844:	e8 57 bd ff ff       	call   801025a0 <kalloc>
80106849:	89 c3                	mov    %eax,%ebx
8010684b:	85 c0                	test   %eax,%eax
8010684d:	74 21                	je     80106870 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010684f:	83 ec 04             	sub    $0x4,%esp
80106852:	68 00 10 00 00       	push   $0x1000
80106857:	6a 00                	push   $0x0
80106859:	50                   	push   %eax
8010685a:	e8 51 de ff ff       	call   801046b0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010685f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106865:	83 c4 10             	add    $0x10,%esp
80106868:	83 c8 07             	or     $0x7,%eax
8010686b:	89 07                	mov    %eax,(%edi)
8010686d:	eb b5                	jmp    80106824 <walkpgdir+0x24>
8010686f:	90                   	nop
}
80106870:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106873:	31 c0                	xor    %eax,%eax
}
80106875:	5b                   	pop    %ebx
80106876:	5e                   	pop    %esi
80106877:	5f                   	pop    %edi
80106878:	5d                   	pop    %ebp
80106879:	c3                   	ret    
8010687a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106880 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	57                   	push   %edi
80106884:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106886:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010688a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010688b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80106890:	89 d6                	mov    %edx,%esi
{
80106892:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106893:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80106899:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010689c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010689f:	8b 45 08             	mov    0x8(%ebp),%eax
801068a2:	29 f0                	sub    %esi,%eax
801068a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801068a7:	eb 1f                	jmp    801068c8 <mappages+0x48>
801068a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801068b0:	f6 00 01             	testb  $0x1,(%eax)
801068b3:	75 45                	jne    801068fa <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801068b5:	0b 5d 0c             	or     0xc(%ebp),%ebx
801068b8:	83 cb 01             	or     $0x1,%ebx
801068bb:	89 18                	mov    %ebx,(%eax)
    if(a == last)
801068bd:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801068c0:	74 2e                	je     801068f0 <mappages+0x70>
      break;
    a += PGSIZE;
801068c2:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
801068c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801068cb:	b9 01 00 00 00       	mov    $0x1,%ecx
801068d0:	89 f2                	mov    %esi,%edx
801068d2:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
801068d5:	89 f8                	mov    %edi,%eax
801068d7:	e8 24 ff ff ff       	call   80106800 <walkpgdir>
801068dc:	85 c0                	test   %eax,%eax
801068de:	75 d0                	jne    801068b0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801068e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801068e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068e8:	5b                   	pop    %ebx
801068e9:	5e                   	pop    %esi
801068ea:	5f                   	pop    %edi
801068eb:	5d                   	pop    %ebp
801068ec:	c3                   	ret    
801068ed:	8d 76 00             	lea    0x0(%esi),%esi
801068f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801068f3:	31 c0                	xor    %eax,%eax
}
801068f5:	5b                   	pop    %ebx
801068f6:	5e                   	pop    %esi
801068f7:	5f                   	pop    %edi
801068f8:	5d                   	pop    %ebp
801068f9:	c3                   	ret    
      panic("remap");
801068fa:	83 ec 0c             	sub    $0xc,%esp
801068fd:	68 98 7a 10 80       	push   $0x80107a98
80106902:	e8 79 9a ff ff       	call   80100380 <panic>
80106907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010690e:	66 90                	xchg   %ax,%ax

80106910 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	57                   	push   %edi
80106914:	56                   	push   %esi
80106915:	89 c6                	mov    %eax,%esi
80106917:	53                   	push   %ebx
80106918:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010691a:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
80106920:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106926:	83 ec 1c             	sub    $0x1c,%esp
80106929:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010692c:	39 da                	cmp    %ebx,%edx
8010692e:	73 5b                	jae    8010698b <deallocuvm.part.0+0x7b>
80106930:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80106933:	89 d7                	mov    %edx,%edi
80106935:	eb 14                	jmp    8010694b <deallocuvm.part.0+0x3b>
80106937:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010693e:	66 90                	xchg   %ax,%ax
80106940:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106946:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106949:	76 40                	jbe    8010698b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010694b:	31 c9                	xor    %ecx,%ecx
8010694d:	89 fa                	mov    %edi,%edx
8010694f:	89 f0                	mov    %esi,%eax
80106951:	e8 aa fe ff ff       	call   80106800 <walkpgdir>
80106956:	89 c3                	mov    %eax,%ebx
    if(!pte)
80106958:	85 c0                	test   %eax,%eax
8010695a:	74 44                	je     801069a0 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
8010695c:	8b 00                	mov    (%eax),%eax
8010695e:	a8 01                	test   $0x1,%al
80106960:	74 de                	je     80106940 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106962:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106967:	74 47                	je     801069b0 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106969:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010696c:	05 00 00 00 80       	add    $0x80000000,%eax
80106971:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80106977:	50                   	push   %eax
80106978:	e8 63 ba ff ff       	call   801023e0 <kfree>
      *pte = 0;
8010697d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80106983:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80106986:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106989:	77 c0                	ja     8010694b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010698b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010698e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106991:	5b                   	pop    %ebx
80106992:	5e                   	pop    %esi
80106993:	5f                   	pop    %edi
80106994:	5d                   	pop    %ebp
80106995:	c3                   	ret    
80106996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010699d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801069a0:	89 fa                	mov    %edi,%edx
801069a2:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
801069a8:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
801069ae:	eb 96                	jmp    80106946 <deallocuvm.part.0+0x36>
        panic("kfree");
801069b0:	83 ec 0c             	sub    $0xc,%esp
801069b3:	68 86 73 10 80       	push   $0x80107386
801069b8:	e8 c3 99 ff ff       	call   80100380 <panic>
801069bd:	8d 76 00             	lea    0x0(%esi),%esi

801069c0 <seginit>:
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801069c6:	e8 95 ce ff ff       	call   80103860 <cpuid>
  pd[0] = size-1;
801069cb:	ba 2f 00 00 00       	mov    $0x2f,%edx
801069d0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801069d6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801069da:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
801069e1:	ff 00 00 
801069e4:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
801069eb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069ee:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
801069f5:	ff 00 00 
801069f8:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
801069ff:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a02:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106a09:	ff 00 00 
80106a0c:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106a13:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a16:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
80106a1d:	ff 00 00 
80106a20:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106a27:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106a2a:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
80106a2f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106a33:	c1 e8 10             	shr    $0x10,%eax
80106a36:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106a3a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106a3d:	0f 01 10             	lgdtl  (%eax)
}
80106a40:	c9                   	leave  
80106a41:	c3                   	ret    
80106a42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a50 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106a50:	a1 a4 55 11 80       	mov    0x801155a4,%eax
80106a55:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a5a:	0f 22 d8             	mov    %eax,%cr3
}
80106a5d:	c3                   	ret    
80106a5e:	66 90                	xchg   %ax,%ax

80106a60 <switchuvm>:
{
80106a60:	55                   	push   %ebp
80106a61:	89 e5                	mov    %esp,%ebp
80106a63:	57                   	push   %edi
80106a64:	56                   	push   %esi
80106a65:	53                   	push   %ebx
80106a66:	83 ec 1c             	sub    $0x1c,%esp
80106a69:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106a6c:	85 f6                	test   %esi,%esi
80106a6e:	0f 84 cb 00 00 00    	je     80106b3f <switchuvm+0xdf>
  if(p->kstack == 0)
80106a74:	8b 46 08             	mov    0x8(%esi),%eax
80106a77:	85 c0                	test   %eax,%eax
80106a79:	0f 84 da 00 00 00    	je     80106b59 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106a7f:	8b 46 04             	mov    0x4(%esi),%eax
80106a82:	85 c0                	test   %eax,%eax
80106a84:	0f 84 c2 00 00 00    	je     80106b4c <switchuvm+0xec>
  pushcli();
80106a8a:	e8 61 da ff ff       	call   801044f0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a8f:	e8 5c cd ff ff       	call   801037f0 <mycpu>
80106a94:	89 c3                	mov    %eax,%ebx
80106a96:	e8 55 cd ff ff       	call   801037f0 <mycpu>
80106a9b:	89 c7                	mov    %eax,%edi
80106a9d:	e8 4e cd ff ff       	call   801037f0 <mycpu>
80106aa2:	83 c7 08             	add    $0x8,%edi
80106aa5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106aa8:	e8 43 cd ff ff       	call   801037f0 <mycpu>
80106aad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106ab0:	ba 67 00 00 00       	mov    $0x67,%edx
80106ab5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106abc:	83 c0 08             	add    $0x8,%eax
80106abf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106ac6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106acb:	83 c1 08             	add    $0x8,%ecx
80106ace:	c1 e8 18             	shr    $0x18,%eax
80106ad1:	c1 e9 10             	shr    $0x10,%ecx
80106ad4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106ada:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106ae0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106ae5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106aec:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106af1:	e8 fa cc ff ff       	call   801037f0 <mycpu>
80106af6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106afd:	e8 ee cc ff ff       	call   801037f0 <mycpu>
80106b02:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106b06:	8b 5e 08             	mov    0x8(%esi),%ebx
80106b09:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b0f:	e8 dc cc ff ff       	call   801037f0 <mycpu>
80106b14:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b17:	e8 d4 cc ff ff       	call   801037f0 <mycpu>
80106b1c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106b20:	b8 28 00 00 00       	mov    $0x28,%eax
80106b25:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106b28:	8b 46 04             	mov    0x4(%esi),%eax
80106b2b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b30:	0f 22 d8             	mov    %eax,%cr3
}
80106b33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b36:	5b                   	pop    %ebx
80106b37:	5e                   	pop    %esi
80106b38:	5f                   	pop    %edi
80106b39:	5d                   	pop    %ebp
  popcli();
80106b3a:	e9 c1 da ff ff       	jmp    80104600 <popcli>
    panic("switchuvm: no process");
80106b3f:	83 ec 0c             	sub    $0xc,%esp
80106b42:	68 9e 7a 10 80       	push   $0x80107a9e
80106b47:	e8 34 98 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106b4c:	83 ec 0c             	sub    $0xc,%esp
80106b4f:	68 c9 7a 10 80       	push   $0x80107ac9
80106b54:	e8 27 98 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106b59:	83 ec 0c             	sub    $0xc,%esp
80106b5c:	68 b4 7a 10 80       	push   $0x80107ab4
80106b61:	e8 1a 98 ff ff       	call   80100380 <panic>
80106b66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b6d:	8d 76 00             	lea    0x0(%esi),%esi

80106b70 <inituvm>:
{
80106b70:	55                   	push   %ebp
80106b71:	89 e5                	mov    %esp,%ebp
80106b73:	57                   	push   %edi
80106b74:	56                   	push   %esi
80106b75:	53                   	push   %ebx
80106b76:	83 ec 1c             	sub    $0x1c,%esp
80106b79:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b7c:	8b 75 10             	mov    0x10(%ebp),%esi
80106b7f:	8b 7d 08             	mov    0x8(%ebp),%edi
80106b82:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106b85:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106b8b:	77 4b                	ja     80106bd8 <inituvm+0x68>
  mem = kalloc();
80106b8d:	e8 0e ba ff ff       	call   801025a0 <kalloc>
  memset(mem, 0, PGSIZE);
80106b92:	83 ec 04             	sub    $0x4,%esp
80106b95:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106b9a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106b9c:	6a 00                	push   $0x0
80106b9e:	50                   	push   %eax
80106b9f:	e8 0c db ff ff       	call   801046b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106ba4:	58                   	pop    %eax
80106ba5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106bab:	5a                   	pop    %edx
80106bac:	6a 06                	push   $0x6
80106bae:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106bb3:	31 d2                	xor    %edx,%edx
80106bb5:	50                   	push   %eax
80106bb6:	89 f8                	mov    %edi,%eax
80106bb8:	e8 c3 fc ff ff       	call   80106880 <mappages>
  memmove(mem, init, sz);
80106bbd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bc0:	89 75 10             	mov    %esi,0x10(%ebp)
80106bc3:	83 c4 10             	add    $0x10,%esp
80106bc6:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106bc9:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80106bcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bcf:	5b                   	pop    %ebx
80106bd0:	5e                   	pop    %esi
80106bd1:	5f                   	pop    %edi
80106bd2:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106bd3:	e9 78 db ff ff       	jmp    80104750 <memmove>
    panic("inituvm: more than a page");
80106bd8:	83 ec 0c             	sub    $0xc,%esp
80106bdb:	68 dd 7a 10 80       	push   $0x80107add
80106be0:	e8 9b 97 ff ff       	call   80100380 <panic>
80106be5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bf0 <loaduvm>:
{
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	57                   	push   %edi
80106bf4:	56                   	push   %esi
80106bf5:	53                   	push   %ebx
80106bf6:	83 ec 1c             	sub    $0x1c,%esp
80106bf9:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bfc:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106bff:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106c04:	0f 85 8d 00 00 00    	jne    80106c97 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106c0a:	01 f0                	add    %esi,%eax
80106c0c:	89 f3                	mov    %esi,%ebx
80106c0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c11:	8b 45 14             	mov    0x14(%ebp),%eax
80106c14:	01 f0                	add    %esi,%eax
80106c16:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106c19:	85 f6                	test   %esi,%esi
80106c1b:	75 11                	jne    80106c2e <loaduvm+0x3e>
80106c1d:	eb 61                	jmp    80106c80 <loaduvm+0x90>
80106c1f:	90                   	nop
80106c20:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106c26:	89 f0                	mov    %esi,%eax
80106c28:	29 d8                	sub    %ebx,%eax
80106c2a:	39 c6                	cmp    %eax,%esi
80106c2c:	76 52                	jbe    80106c80 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106c2e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106c31:	8b 45 08             	mov    0x8(%ebp),%eax
80106c34:	31 c9                	xor    %ecx,%ecx
80106c36:	29 da                	sub    %ebx,%edx
80106c38:	e8 c3 fb ff ff       	call   80106800 <walkpgdir>
80106c3d:	85 c0                	test   %eax,%eax
80106c3f:	74 49                	je     80106c8a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106c41:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c43:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80106c46:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106c4b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106c50:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106c56:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c59:	29 d9                	sub    %ebx,%ecx
80106c5b:	05 00 00 00 80       	add    $0x80000000,%eax
80106c60:	57                   	push   %edi
80106c61:	51                   	push   %ecx
80106c62:	50                   	push   %eax
80106c63:	ff 75 10             	pushl  0x10(%ebp)
80106c66:	e8 95 ad ff ff       	call   80101a00 <readi>
80106c6b:	83 c4 10             	add    $0x10,%esp
80106c6e:	39 f8                	cmp    %edi,%eax
80106c70:	74 ae                	je     80106c20 <loaduvm+0x30>
}
80106c72:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106c75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c7a:	5b                   	pop    %ebx
80106c7b:	5e                   	pop    %esi
80106c7c:	5f                   	pop    %edi
80106c7d:	5d                   	pop    %ebp
80106c7e:	c3                   	ret    
80106c7f:	90                   	nop
80106c80:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106c83:	31 c0                	xor    %eax,%eax
}
80106c85:	5b                   	pop    %ebx
80106c86:	5e                   	pop    %esi
80106c87:	5f                   	pop    %edi
80106c88:	5d                   	pop    %ebp
80106c89:	c3                   	ret    
      panic("loaduvm: address should exist");
80106c8a:	83 ec 0c             	sub    $0xc,%esp
80106c8d:	68 f7 7a 10 80       	push   $0x80107af7
80106c92:	e8 e9 96 ff ff       	call   80100380 <panic>
    panic("loaduvm: addr must be page aligned");
80106c97:	83 ec 0c             	sub    $0xc,%esp
80106c9a:	68 98 7b 10 80       	push   $0x80107b98
80106c9f:	e8 dc 96 ff ff       	call   80100380 <panic>
80106ca4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106caf:	90                   	nop

80106cb0 <allocuvm>:
{
80106cb0:	55                   	push   %ebp
80106cb1:	89 e5                	mov    %esp,%ebp
80106cb3:	57                   	push   %edi
80106cb4:	56                   	push   %esi
80106cb5:	53                   	push   %ebx
80106cb6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106cb9:	8b 45 10             	mov    0x10(%ebp),%eax
{
80106cbc:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80106cbf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106cc2:	85 c0                	test   %eax,%eax
80106cc4:	0f 88 b6 00 00 00    	js     80106d80 <allocuvm+0xd0>
  if(newsz < oldsz)
80106cca:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80106ccd:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106cd0:	0f 82 9a 00 00 00    	jb     80106d70 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106cd6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106cdc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106ce2:	39 75 10             	cmp    %esi,0x10(%ebp)
80106ce5:	77 44                	ja     80106d2b <allocuvm+0x7b>
80106ce7:	e9 87 00 00 00       	jmp    80106d73 <allocuvm+0xc3>
80106cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106cf0:	83 ec 04             	sub    $0x4,%esp
80106cf3:	68 00 10 00 00       	push   $0x1000
80106cf8:	6a 00                	push   $0x0
80106cfa:	50                   	push   %eax
80106cfb:	e8 b0 d9 ff ff       	call   801046b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106d00:	58                   	pop    %eax
80106d01:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d07:	5a                   	pop    %edx
80106d08:	6a 06                	push   $0x6
80106d0a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d0f:	89 f2                	mov    %esi,%edx
80106d11:	50                   	push   %eax
80106d12:	89 f8                	mov    %edi,%eax
80106d14:	e8 67 fb ff ff       	call   80106880 <mappages>
80106d19:	83 c4 10             	add    $0x10,%esp
80106d1c:	85 c0                	test   %eax,%eax
80106d1e:	78 78                	js     80106d98 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80106d20:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106d26:	39 75 10             	cmp    %esi,0x10(%ebp)
80106d29:	76 48                	jbe    80106d73 <allocuvm+0xc3>
    mem = kalloc();
80106d2b:	e8 70 b8 ff ff       	call   801025a0 <kalloc>
80106d30:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106d32:	85 c0                	test   %eax,%eax
80106d34:	75 ba                	jne    80106cf0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106d36:	83 ec 0c             	sub    $0xc,%esp
80106d39:	68 15 7b 10 80       	push   $0x80107b15
80106d3e:	e8 5d 99 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80106d43:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d46:	83 c4 10             	add    $0x10,%esp
80106d49:	39 45 10             	cmp    %eax,0x10(%ebp)
80106d4c:	74 32                	je     80106d80 <allocuvm+0xd0>
80106d4e:	8b 55 10             	mov    0x10(%ebp),%edx
80106d51:	89 c1                	mov    %eax,%ecx
80106d53:	89 f8                	mov    %edi,%eax
80106d55:	e8 b6 fb ff ff       	call   80106910 <deallocuvm.part.0>
      return 0;
80106d5a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80106d61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d67:	5b                   	pop    %ebx
80106d68:	5e                   	pop    %esi
80106d69:	5f                   	pop    %edi
80106d6a:	5d                   	pop    %ebp
80106d6b:	c3                   	ret    
80106d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80106d70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80106d73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d79:	5b                   	pop    %ebx
80106d7a:	5e                   	pop    %esi
80106d7b:	5f                   	pop    %edi
80106d7c:	5d                   	pop    %ebp
80106d7d:	c3                   	ret    
80106d7e:	66 90                	xchg   %ax,%ax
    return 0;
80106d80:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80106d87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d8d:	5b                   	pop    %ebx
80106d8e:	5e                   	pop    %esi
80106d8f:	5f                   	pop    %edi
80106d90:	5d                   	pop    %ebp
80106d91:	c3                   	ret    
80106d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106d98:	83 ec 0c             	sub    $0xc,%esp
80106d9b:	68 2d 7b 10 80       	push   $0x80107b2d
80106da0:	e8 fb 98 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80106da5:	8b 45 0c             	mov    0xc(%ebp),%eax
80106da8:	83 c4 10             	add    $0x10,%esp
80106dab:	39 45 10             	cmp    %eax,0x10(%ebp)
80106dae:	74 0c                	je     80106dbc <allocuvm+0x10c>
80106db0:	8b 55 10             	mov    0x10(%ebp),%edx
80106db3:	89 c1                	mov    %eax,%ecx
80106db5:	89 f8                	mov    %edi,%eax
80106db7:	e8 54 fb ff ff       	call   80106910 <deallocuvm.part.0>
      kfree(mem);
80106dbc:	83 ec 0c             	sub    $0xc,%esp
80106dbf:	53                   	push   %ebx
80106dc0:	e8 1b b6 ff ff       	call   801023e0 <kfree>
      return 0;
80106dc5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80106dcc:	83 c4 10             	add    $0x10,%esp
}
80106dcf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106dd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dd5:	5b                   	pop    %ebx
80106dd6:	5e                   	pop    %esi
80106dd7:	5f                   	pop    %edi
80106dd8:	5d                   	pop    %ebp
80106dd9:	c3                   	ret    
80106dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106de0 <deallocuvm>:
{
80106de0:	55                   	push   %ebp
80106de1:	89 e5                	mov    %esp,%ebp
80106de3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106de6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106de9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106dec:	39 d1                	cmp    %edx,%ecx
80106dee:	73 10                	jae    80106e00 <deallocuvm+0x20>
}
80106df0:	5d                   	pop    %ebp
80106df1:	e9 1a fb ff ff       	jmp    80106910 <deallocuvm.part.0>
80106df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dfd:	8d 76 00             	lea    0x0(%esi),%esi
80106e00:	89 d0                	mov    %edx,%eax
80106e02:	5d                   	pop    %ebp
80106e03:	c3                   	ret    
80106e04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106e0f:	90                   	nop

80106e10 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	57                   	push   %edi
80106e14:	56                   	push   %esi
80106e15:	53                   	push   %ebx
80106e16:	83 ec 0c             	sub    $0xc,%esp
80106e19:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106e1c:	85 f6                	test   %esi,%esi
80106e1e:	74 59                	je     80106e79 <freevm+0x69>
  if(newsz >= oldsz)
80106e20:	31 c9                	xor    %ecx,%ecx
80106e22:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106e27:	89 f0                	mov    %esi,%eax
80106e29:	89 f3                	mov    %esi,%ebx
80106e2b:	e8 e0 fa ff ff       	call   80106910 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106e30:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106e36:	eb 0f                	jmp    80106e47 <freevm+0x37>
80106e38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e3f:	90                   	nop
80106e40:	83 c3 04             	add    $0x4,%ebx
80106e43:	39 df                	cmp    %ebx,%edi
80106e45:	74 23                	je     80106e6a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106e47:	8b 03                	mov    (%ebx),%eax
80106e49:	a8 01                	test   $0x1,%al
80106e4b:	74 f3                	je     80106e40 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106e4d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106e52:	83 ec 0c             	sub    $0xc,%esp
80106e55:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106e58:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106e5d:	50                   	push   %eax
80106e5e:	e8 7d b5 ff ff       	call   801023e0 <kfree>
80106e63:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106e66:	39 df                	cmp    %ebx,%edi
80106e68:	75 dd                	jne    80106e47 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106e6a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106e6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e70:	5b                   	pop    %ebx
80106e71:	5e                   	pop    %esi
80106e72:	5f                   	pop    %edi
80106e73:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106e74:	e9 67 b5 ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80106e79:	83 ec 0c             	sub    $0xc,%esp
80106e7c:	68 49 7b 10 80       	push   $0x80107b49
80106e81:	e8 fa 94 ff ff       	call   80100380 <panic>
80106e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e8d:	8d 76 00             	lea    0x0(%esi),%esi

80106e90 <setupkvm>:
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	56                   	push   %esi
80106e94:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106e95:	e8 06 b7 ff ff       	call   801025a0 <kalloc>
80106e9a:	89 c6                	mov    %eax,%esi
80106e9c:	85 c0                	test   %eax,%eax
80106e9e:	74 42                	je     80106ee2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106ea0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ea3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106ea8:	68 00 10 00 00       	push   $0x1000
80106ead:	6a 00                	push   $0x0
80106eaf:	50                   	push   %eax
80106eb0:	e8 fb d7 ff ff       	call   801046b0 <memset>
80106eb5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106eb8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ebb:	83 ec 08             	sub    $0x8,%esp
80106ebe:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ec1:	ff 73 0c             	pushl  0xc(%ebx)
80106ec4:	8b 13                	mov    (%ebx),%edx
80106ec6:	50                   	push   %eax
80106ec7:	29 c1                	sub    %eax,%ecx
80106ec9:	89 f0                	mov    %esi,%eax
80106ecb:	e8 b0 f9 ff ff       	call   80106880 <mappages>
80106ed0:	83 c4 10             	add    $0x10,%esp
80106ed3:	85 c0                	test   %eax,%eax
80106ed5:	78 19                	js     80106ef0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ed7:	83 c3 10             	add    $0x10,%ebx
80106eda:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106ee0:	75 d6                	jne    80106eb8 <setupkvm+0x28>
}
80106ee2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106ee5:	89 f0                	mov    %esi,%eax
80106ee7:	5b                   	pop    %ebx
80106ee8:	5e                   	pop    %esi
80106ee9:	5d                   	pop    %ebp
80106eea:	c3                   	ret    
80106eeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106eef:	90                   	nop
      freevm(pgdir);
80106ef0:	83 ec 0c             	sub    $0xc,%esp
80106ef3:	56                   	push   %esi
      return 0;
80106ef4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106ef6:	e8 15 ff ff ff       	call   80106e10 <freevm>
      return 0;
80106efb:	83 c4 10             	add    $0x10,%esp
}
80106efe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f01:	89 f0                	mov    %esi,%eax
80106f03:	5b                   	pop    %ebx
80106f04:	5e                   	pop    %esi
80106f05:	5d                   	pop    %ebp
80106f06:	c3                   	ret    
80106f07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f0e:	66 90                	xchg   %ax,%ax

80106f10 <kvmalloc>:
{
80106f10:	55                   	push   %ebp
80106f11:	89 e5                	mov    %esp,%ebp
80106f13:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f16:	e8 75 ff ff ff       	call   80106e90 <setupkvm>
80106f1b:	a3 a4 55 11 80       	mov    %eax,0x801155a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f20:	05 00 00 00 80       	add    $0x80000000,%eax
80106f25:	0f 22 d8             	mov    %eax,%cr3
}
80106f28:	c9                   	leave  
80106f29:	c3                   	ret    
80106f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f30 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f30:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f31:	31 c9                	xor    %ecx,%ecx
{
80106f33:	89 e5                	mov    %esp,%ebp
80106f35:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106f38:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f3b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f3e:	e8 bd f8 ff ff       	call   80106800 <walkpgdir>
  if(pte == 0)
80106f43:	85 c0                	test   %eax,%eax
80106f45:	74 05                	je     80106f4c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106f47:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106f4a:	c9                   	leave  
80106f4b:	c3                   	ret    
    panic("clearpteu");
80106f4c:	83 ec 0c             	sub    $0xc,%esp
80106f4f:	68 5a 7b 10 80       	push   $0x80107b5a
80106f54:	e8 27 94 ff ff       	call   80100380 <panic>
80106f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f60 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106f60:	55                   	push   %ebp
80106f61:	89 e5                	mov    %esp,%ebp
80106f63:	57                   	push   %edi
80106f64:	56                   	push   %esi
80106f65:	53                   	push   %ebx
80106f66:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106f69:	e8 22 ff ff ff       	call   80106e90 <setupkvm>
80106f6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f71:	85 c0                	test   %eax,%eax
80106f73:	0f 84 a0 00 00 00    	je     80107019 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106f79:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f7c:	85 c9                	test   %ecx,%ecx
80106f7e:	0f 84 95 00 00 00    	je     80107019 <copyuvm+0xb9>
80106f84:	31 f6                	xor    %esi,%esi
80106f86:	eb 4e                	jmp    80106fd6 <copyuvm+0x76>
80106f88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f8f:	90                   	nop
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106f90:	83 ec 04             	sub    $0x4,%esp
80106f93:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106f99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f9c:	68 00 10 00 00       	push   $0x1000
80106fa1:	57                   	push   %edi
80106fa2:	50                   	push   %eax
80106fa3:	e8 a8 d7 ff ff       	call   80104750 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106fa8:	58                   	pop    %eax
80106fa9:	5a                   	pop    %edx
80106faa:	53                   	push   %ebx
80106fab:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106fae:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106fb1:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106fb6:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106fbc:	52                   	push   %edx
80106fbd:	89 f2                	mov    %esi,%edx
80106fbf:	e8 bc f8 ff ff       	call   80106880 <mappages>
80106fc4:	83 c4 10             	add    $0x10,%esp
80106fc7:	85 c0                	test   %eax,%eax
80106fc9:	78 39                	js     80107004 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
80106fcb:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106fd1:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106fd4:	76 43                	jbe    80107019 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106fd6:	8b 45 08             	mov    0x8(%ebp),%eax
80106fd9:	31 c9                	xor    %ecx,%ecx
80106fdb:	89 f2                	mov    %esi,%edx
80106fdd:	e8 1e f8 ff ff       	call   80106800 <walkpgdir>
80106fe2:	85 c0                	test   %eax,%eax
80106fe4:	74 3e                	je     80107024 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
80106fe6:	8b 18                	mov    (%eax),%ebx
80106fe8:	f6 c3 01             	test   $0x1,%bl
80106feb:	74 44                	je     80107031 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
80106fed:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
80106fef:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80106ff5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80106ffb:	e8 a0 b5 ff ff       	call   801025a0 <kalloc>
80107000:	85 c0                	test   %eax,%eax
80107002:	75 8c                	jne    80106f90 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107004:	83 ec 0c             	sub    $0xc,%esp
80107007:	ff 75 e0             	pushl  -0x20(%ebp)
8010700a:	e8 01 fe ff ff       	call   80106e10 <freevm>
  return 0;
8010700f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107016:	83 c4 10             	add    $0x10,%esp
}
80107019:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010701c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010701f:	5b                   	pop    %ebx
80107020:	5e                   	pop    %esi
80107021:	5f                   	pop    %edi
80107022:	5d                   	pop    %ebp
80107023:	c3                   	ret    
      panic("copyuvm: pte should exist");
80107024:	83 ec 0c             	sub    $0xc,%esp
80107027:	68 64 7b 10 80       	push   $0x80107b64
8010702c:	e8 4f 93 ff ff       	call   80100380 <panic>
      panic("copyuvm: page not present");
80107031:	83 ec 0c             	sub    $0xc,%esp
80107034:	68 7e 7b 10 80       	push   $0x80107b7e
80107039:	e8 42 93 ff ff       	call   80100380 <panic>
8010703e:	66 90                	xchg   %ax,%ax

80107040 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107040:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107041:	31 c9                	xor    %ecx,%ecx
{
80107043:	89 e5                	mov    %esp,%ebp
80107045:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107048:	8b 55 0c             	mov    0xc(%ebp),%edx
8010704b:	8b 45 08             	mov    0x8(%ebp),%eax
8010704e:	e8 ad f7 ff ff       	call   80106800 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107053:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107055:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107056:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107058:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010705d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107060:	05 00 00 00 80       	add    $0x80000000,%eax
80107065:	83 fa 05             	cmp    $0x5,%edx
80107068:	ba 00 00 00 00       	mov    $0x0,%edx
8010706d:	0f 45 c2             	cmovne %edx,%eax
}
80107070:	c3                   	ret    
80107071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107078:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010707f:	90                   	nop

80107080 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	57                   	push   %edi
80107084:	56                   	push   %esi
80107085:	53                   	push   %ebx
80107086:	83 ec 0c             	sub    $0xc,%esp
80107089:	8b 75 14             	mov    0x14(%ebp),%esi
8010708c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010708f:	85 f6                	test   %esi,%esi
80107091:	75 38                	jne    801070cb <copyout+0x4b>
80107093:	eb 6b                	jmp    80107100 <copyout+0x80>
80107095:	8d 76 00             	lea    0x0(%esi),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107098:	8b 55 0c             	mov    0xc(%ebp),%edx
8010709b:	89 fb                	mov    %edi,%ebx
8010709d:	29 d3                	sub    %edx,%ebx
8010709f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801070a5:	39 f3                	cmp    %esi,%ebx
801070a7:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801070aa:	29 fa                	sub    %edi,%edx
801070ac:	83 ec 04             	sub    $0x4,%esp
801070af:	01 c2                	add    %eax,%edx
801070b1:	53                   	push   %ebx
801070b2:	ff 75 10             	pushl  0x10(%ebp)
801070b5:	52                   	push   %edx
801070b6:	e8 95 d6 ff ff       	call   80104750 <memmove>
    len -= n;
    buf += n;
801070bb:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
801070be:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
801070c4:	83 c4 10             	add    $0x10,%esp
801070c7:	29 de                	sub    %ebx,%esi
801070c9:	74 35                	je     80107100 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
801070cb:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801070cd:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801070d0:	89 55 0c             	mov    %edx,0xc(%ebp)
801070d3:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801070d9:	57                   	push   %edi
801070da:	ff 75 08             	pushl  0x8(%ebp)
801070dd:	e8 5e ff ff ff       	call   80107040 <uva2ka>
    if(pa0 == 0)
801070e2:	83 c4 10             	add    $0x10,%esp
801070e5:	85 c0                	test   %eax,%eax
801070e7:	75 af                	jne    80107098 <copyout+0x18>
  }
  return 0;
}
801070e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801070ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070f1:	5b                   	pop    %ebx
801070f2:	5e                   	pop    %esi
801070f3:	5f                   	pop    %edi
801070f4:	5d                   	pop    %ebp
801070f5:	c3                   	ret    
801070f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070fd:	8d 76 00             	lea    0x0(%esi),%esi
80107100:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107103:	31 c0                	xor    %eax,%eax
}
80107105:	5b                   	pop    %ebx
80107106:	5e                   	pop    %esi
80107107:	5f                   	pop    %edi
80107108:	5d                   	pop    %ebp
80107109:	c3                   	ret    
