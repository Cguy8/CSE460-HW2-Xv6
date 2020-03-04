
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
  cps();
   6:	e8 08 03 00 00       	call   313 <cps>
  nps();
   b:	e8 0b 03 00 00       	call   31b <nps>

  exit();
  10:	e8 5e 02 00 00       	call   273 <exit>
  15:	66 90                	xchg   %ax,%ax
  17:	66 90                	xchg   %ax,%ax
  19:	66 90                	xchg   %ax,%ax
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	90                   	nop

00000020 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  20:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  21:	31 c0                	xor    %eax,%eax
{
  23:	89 e5                	mov    %esp,%ebp
  25:	53                   	push   %ebx
  26:	8b 4d 08             	mov    0x8(%ebp),%ecx
  29:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  30:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  34:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  37:	83 c0 01             	add    $0x1,%eax
  3a:	84 d2                	test   %dl,%dl
  3c:	75 f2                	jne    30 <strcpy+0x10>
    ;
  return os;
}
  3e:	89 c8                	mov    %ecx,%eax
  40:	5b                   	pop    %ebx
  41:	5d                   	pop    %ebp
  42:	c3                   	ret    
  43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000050 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	53                   	push   %ebx
  54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  57:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  5a:	0f b6 01             	movzbl (%ecx),%eax
  5d:	0f b6 1a             	movzbl (%edx),%ebx
  60:	84 c0                	test   %al,%al
  62:	75 1d                	jne    81 <strcmp+0x31>
  64:	eb 2a                	jmp    90 <strcmp+0x40>
  66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  6d:	8d 76 00             	lea    0x0(%esi),%esi
  70:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  74:	83 c1 01             	add    $0x1,%ecx
  77:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  7a:	0f b6 1a             	movzbl (%edx),%ebx
  7d:	84 c0                	test   %al,%al
  7f:	74 0f                	je     90 <strcmp+0x40>
  81:	38 d8                	cmp    %bl,%al
  83:	74 eb                	je     70 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  85:	29 d8                	sub    %ebx,%eax
}
  87:	5b                   	pop    %ebx
  88:	5d                   	pop    %ebp
  89:	c3                   	ret    
  8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  90:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  92:	29 d8                	sub    %ebx,%eax
}
  94:	5b                   	pop    %ebx
  95:	5d                   	pop    %ebp
  96:	c3                   	ret    
  97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  9e:	66 90                	xchg   %ax,%ax

000000a0 <strlen>:

uint
strlen(char *s)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  a6:	80 3a 00             	cmpb   $0x0,(%edx)
  a9:	74 15                	je     c0 <strlen+0x20>
  ab:	31 c0                	xor    %eax,%eax
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  b0:	83 c0 01             	add    $0x1,%eax
  b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  b7:	89 c1                	mov    %eax,%ecx
  b9:	75 f5                	jne    b0 <strlen+0x10>
    ;
  return n;
}
  bb:	89 c8                	mov    %ecx,%eax
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret    
  bf:	90                   	nop
  for(n = 0; s[n]; n++)
  c0:	31 c9                	xor    %ecx,%ecx
}
  c2:	5d                   	pop    %ebp
  c3:	89 c8                	mov    %ecx,%eax
  c5:	c3                   	ret    
  c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cd:	8d 76 00             	lea    0x0(%esi),%esi

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	57                   	push   %edi
  d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  da:	8b 45 0c             	mov    0xc(%ebp),%eax
  dd:	89 d7                	mov    %edx,%edi
  df:	fc                   	cld    
  e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e2:	89 d0                	mov    %edx,%eax
  e4:	5f                   	pop    %edi
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ee:	66 90                	xchg   %ax,%ax

000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  fa:	0f b6 10             	movzbl (%eax),%edx
  fd:	84 d2                	test   %dl,%dl
  ff:	75 12                	jne    113 <strchr+0x23>
 101:	eb 1d                	jmp    120 <strchr+0x30>
 103:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 107:	90                   	nop
 108:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 10c:	83 c0 01             	add    $0x1,%eax
 10f:	84 d2                	test   %dl,%dl
 111:	74 0d                	je     120 <strchr+0x30>
    if(*s == c)
 113:	38 d1                	cmp    %dl,%cl
 115:	75 f1                	jne    108 <strchr+0x18>
      return (char*)s;
  return 0;
}
 117:	5d                   	pop    %ebp
 118:	c3                   	ret    
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 12f:	90                   	nop

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 135:	31 f6                	xor    %esi,%esi
{
 137:	53                   	push   %ebx
 138:	89 f3                	mov    %esi,%ebx
 13a:	83 ec 1c             	sub    $0x1c,%esp
 13d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 140:	eb 2f                	jmp    171 <gets+0x41>
 142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 148:	83 ec 04             	sub    $0x4,%esp
 14b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 14e:	6a 01                	push   $0x1
 150:	50                   	push   %eax
 151:	6a 00                	push   $0x0
 153:	e8 33 01 00 00       	call   28b <read>
    if(cc < 1)
 158:	83 c4 10             	add    $0x10,%esp
 15b:	85 c0                	test   %eax,%eax
 15d:	7e 1c                	jle    17b <gets+0x4b>
      break;
    buf[i++] = c;
 15f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 163:	83 c7 01             	add    $0x1,%edi
 166:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 169:	3c 0a                	cmp    $0xa,%al
 16b:	74 23                	je     190 <gets+0x60>
 16d:	3c 0d                	cmp    $0xd,%al
 16f:	74 1f                	je     190 <gets+0x60>
  for(i=0; i+1 < max; ){
 171:	83 c3 01             	add    $0x1,%ebx
 174:	89 fe                	mov    %edi,%esi
 176:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 179:	7c cd                	jl     148 <gets+0x18>
 17b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 180:	c6 03 00             	movb   $0x0,(%ebx)
}
 183:	8d 65 f4             	lea    -0xc(%ebp),%esp
 186:	5b                   	pop    %ebx
 187:	5e                   	pop    %esi
 188:	5f                   	pop    %edi
 189:	5d                   	pop    %ebp
 18a:	c3                   	ret    
 18b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 18f:	90                   	nop
 190:	8b 75 08             	mov    0x8(%ebp),%esi
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	01 de                	add    %ebx,%esi
 198:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 19a:	c6 03 00             	movb   $0x0,(%ebx)
}
 19d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1a0:	5b                   	pop    %ebx
 1a1:	5e                   	pop    %esi
 1a2:	5f                   	pop    %edi
 1a3:	5d                   	pop    %ebp
 1a4:	c3                   	ret    
 1a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <stat>:

int
stat(char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	6a 00                	push   $0x0
 1ba:	ff 75 08             	pushl  0x8(%ebp)
 1bd:	e8 f1 00 00 00       	call   2b3 <open>
  if(fd < 0)
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	85 c0                	test   %eax,%eax
 1c7:	78 27                	js     1f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1c9:	83 ec 08             	sub    $0x8,%esp
 1cc:	ff 75 0c             	pushl  0xc(%ebp)
 1cf:	89 c3                	mov    %eax,%ebx
 1d1:	50                   	push   %eax
 1d2:	e8 f4 00 00 00       	call   2cb <fstat>
  close(fd);
 1d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1da:	89 c6                	mov    %eax,%esi
  close(fd);
 1dc:	e8 ba 00 00 00       	call   29b <close>
  return r;
 1e1:	83 c4 10             	add    $0x10,%esp
}
 1e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e7:	89 f0                	mov    %esi,%eax
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret    
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb ed                	jmp    1e4 <stat+0x34>
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	0f be 02             	movsbl (%edx),%eax
 20a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 20d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 210:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 215:	77 1e                	ja     235 <atoi+0x35>
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 220:	83 c2 01             	add    $0x1,%edx
 223:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 226:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 22a:	0f be 02             	movsbl (%edx),%eax
 22d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
  return n;
}
 235:	89 c8                	mov    %ecx,%eax
 237:	5b                   	pop    %ebx
 238:	5d                   	pop    %ebp
 239:	c3                   	ret    
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000240 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 45 10             	mov    0x10(%ebp),%eax
 247:	8b 55 08             	mov    0x8(%ebp),%edx
 24a:	56                   	push   %esi
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 c0                	test   %eax,%eax
 250:	7e 13                	jle    265 <memmove+0x25>
 252:	01 d0                	add    %edx,%eax
  dst = vdst;
 254:	89 d7                	mov    %edx,%edi
 256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 260:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 261:	39 f8                	cmp    %edi,%eax
 263:	75 fb                	jne    260 <memmove+0x20>
  return vdst;
}
 265:	5e                   	pop    %esi
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    

0000026b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <exit>:
SYSCALL(exit)
 273:	b8 02 00 00 00       	mov    $0x2,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <wait>:
SYSCALL(wait)
 27b:	b8 03 00 00 00       	mov    $0x3,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <pipe>:
SYSCALL(pipe)
 283:	b8 04 00 00 00       	mov    $0x4,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <read>:
SYSCALL(read)
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <write>:
SYSCALL(write)
 293:	b8 10 00 00 00       	mov    $0x10,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <close>:
SYSCALL(close)
 29b:	b8 15 00 00 00       	mov    $0x15,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <kill>:
SYSCALL(kill)
 2a3:	b8 06 00 00 00       	mov    $0x6,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <exec>:
SYSCALL(exec)
 2ab:	b8 07 00 00 00       	mov    $0x7,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <open>:
SYSCALL(open)
 2b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <mknod>:
SYSCALL(mknod)
 2bb:	b8 11 00 00 00       	mov    $0x11,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <unlink>:
SYSCALL(unlink)
 2c3:	b8 12 00 00 00       	mov    $0x12,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <fstat>:
SYSCALL(fstat)
 2cb:	b8 08 00 00 00       	mov    $0x8,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <link>:
SYSCALL(link)
 2d3:	b8 13 00 00 00       	mov    $0x13,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <mkdir>:
SYSCALL(mkdir)
 2db:	b8 14 00 00 00       	mov    $0x14,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <chdir>:
SYSCALL(chdir)
 2e3:	b8 09 00 00 00       	mov    $0x9,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <dup>:
SYSCALL(dup)
 2eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <getpid>:
SYSCALL(getpid)
 2f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <sbrk>:
SYSCALL(sbrk)
 2fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <sleep>:
SYSCALL(sleep)
 303:	b8 0d 00 00 00       	mov    $0xd,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <uptime>:
SYSCALL(uptime)
 30b:	b8 0e 00 00 00       	mov    $0xe,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <cps>:
SYSCALL(cps)
 313:	b8 16 00 00 00       	mov    $0x16,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <nps>:
SYSCALL(nps)
 31b:	b8 17 00 00 00       	mov    $0x17,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <chpr>:
SYSCALL(chpr)
 323:	b8 18 00 00 00       	mov    $0x18,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <date>:
SYSCALL(date)
 32b:	b8 19 00 00 00       	mov    $0x19,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    
 333:	66 90                	xchg   %ax,%ax
 335:	66 90                	xchg   %ax,%ax
 337:	66 90                	xchg   %ax,%ax
 339:	66 90                	xchg   %ax,%ax
 33b:	66 90                	xchg   %ax,%ax
 33d:	66 90                	xchg   %ax,%ax
 33f:	90                   	nop

00000340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
 346:	83 ec 3c             	sub    $0x3c,%esp
 349:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 34c:	89 d1                	mov    %edx,%ecx
{
 34e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 351:	85 d2                	test   %edx,%edx
 353:	0f 89 7f 00 00 00    	jns    3d8 <printint+0x98>
 359:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 35d:	74 79                	je     3d8 <printint+0x98>
    neg = 1;
 35f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 366:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 368:	31 db                	xor    %ebx,%ebx
 36a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 36d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 370:	89 c8                	mov    %ecx,%eax
 372:	31 d2                	xor    %edx,%edx
 374:	89 cf                	mov    %ecx,%edi
 376:	f7 75 c4             	divl   -0x3c(%ebp)
 379:	0f b6 92 60 07 00 00 	movzbl 0x760(%edx),%edx
 380:	89 45 c0             	mov    %eax,-0x40(%ebp)
 383:	89 d8                	mov    %ebx,%eax
 385:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 388:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 38b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 38e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 391:	76 dd                	jbe    370 <printint+0x30>
  if(neg)
 393:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 396:	85 c9                	test   %ecx,%ecx
 398:	74 0c                	je     3a6 <printint+0x66>
    buf[i++] = '-';
 39a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 39f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 3a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 3a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 3a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 3ad:	eb 07                	jmp    3b6 <printint+0x76>
 3af:	90                   	nop
 3b0:	0f b6 13             	movzbl (%ebx),%edx
 3b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 3b6:	83 ec 04             	sub    $0x4,%esp
 3b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 3bc:	6a 01                	push   $0x1
 3be:	56                   	push   %esi
 3bf:	57                   	push   %edi
 3c0:	e8 ce fe ff ff       	call   293 <write>
  while(--i >= 0)
 3c5:	83 c4 10             	add    $0x10,%esp
 3c8:	39 de                	cmp    %ebx,%esi
 3ca:	75 e4                	jne    3b0 <printint+0x70>
    putc(fd, buf[i]);
}
 3cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3cf:	5b                   	pop    %ebx
 3d0:	5e                   	pop    %esi
 3d1:	5f                   	pop    %edi
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 3df:	eb 87                	jmp    368 <printint+0x28>
 3e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ef:	90                   	nop

000003f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 3fc:	0f b6 1e             	movzbl (%esi),%ebx
 3ff:	84 db                	test   %bl,%bl
 401:	0f 84 b8 00 00 00    	je     4bf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 407:	8d 45 10             	lea    0x10(%ebp),%eax
 40a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 40d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 410:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 412:	89 45 d0             	mov    %eax,-0x30(%ebp)
 415:	eb 37                	jmp    44e <printf+0x5e>
 417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41e:	66 90                	xchg   %ax,%ax
 420:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 423:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 428:	83 f8 25             	cmp    $0x25,%eax
 42b:	74 17                	je     444 <printf+0x54>
  write(fd, &c, 1);
 42d:	83 ec 04             	sub    $0x4,%esp
 430:	88 5d e7             	mov    %bl,-0x19(%ebp)
 433:	6a 01                	push   $0x1
 435:	57                   	push   %edi
 436:	ff 75 08             	pushl  0x8(%ebp)
 439:	e8 55 fe ff ff       	call   293 <write>
 43e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 441:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 444:	0f b6 1e             	movzbl (%esi),%ebx
 447:	83 c6 01             	add    $0x1,%esi
 44a:	84 db                	test   %bl,%bl
 44c:	74 71                	je     4bf <printf+0xcf>
    c = fmt[i] & 0xff;
 44e:	0f be cb             	movsbl %bl,%ecx
 451:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 454:	85 d2                	test   %edx,%edx
 456:	74 c8                	je     420 <printf+0x30>
      }
    } else if(state == '%'){
 458:	83 fa 25             	cmp    $0x25,%edx
 45b:	75 e7                	jne    444 <printf+0x54>
      if(c == 'd'){
 45d:	83 f8 64             	cmp    $0x64,%eax
 460:	0f 84 9a 00 00 00    	je     500 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 466:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 46c:	83 f9 70             	cmp    $0x70,%ecx
 46f:	74 5f                	je     4d0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 471:	83 f8 73             	cmp    $0x73,%eax
 474:	0f 84 d6 00 00 00    	je     550 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 47a:	83 f8 63             	cmp    $0x63,%eax
 47d:	0f 84 8d 00 00 00    	je     510 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 483:	83 f8 25             	cmp    $0x25,%eax
 486:	0f 84 b4 00 00 00    	je     540 <printf+0x150>
  write(fd, &c, 1);
 48c:	83 ec 04             	sub    $0x4,%esp
 48f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 493:	6a 01                	push   $0x1
 495:	57                   	push   %edi
 496:	ff 75 08             	pushl  0x8(%ebp)
 499:	e8 f5 fd ff ff       	call   293 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 49e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 4a1:	83 c4 0c             	add    $0xc,%esp
 4a4:	6a 01                	push   $0x1
 4a6:	83 c6 01             	add    $0x1,%esi
 4a9:	57                   	push   %edi
 4aa:	ff 75 08             	pushl  0x8(%ebp)
 4ad:	e8 e1 fd ff ff       	call   293 <write>
  for(i = 0; fmt[i]; i++){
 4b2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 4b6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 4b9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4bb:	84 db                	test   %bl,%bl
 4bd:	75 8f                	jne    44e <printf+0x5e>
    }
  }
}
 4bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c2:	5b                   	pop    %ebx
 4c3:	5e                   	pop    %esi
 4c4:	5f                   	pop    %edi
 4c5:	5d                   	pop    %ebp
 4c6:	c3                   	ret    
 4c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4d0:	83 ec 0c             	sub    $0xc,%esp
 4d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4d8:	6a 00                	push   $0x0
 4da:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4dd:	8b 45 08             	mov    0x8(%ebp),%eax
 4e0:	8b 13                	mov    (%ebx),%edx
 4e2:	e8 59 fe ff ff       	call   340 <printint>
        ap++;
 4e7:	89 d8                	mov    %ebx,%eax
 4e9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4ec:	31 d2                	xor    %edx,%edx
        ap++;
 4ee:	83 c0 04             	add    $0x4,%eax
 4f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4f4:	e9 4b ff ff ff       	jmp    444 <printf+0x54>
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 500:	83 ec 0c             	sub    $0xc,%esp
 503:	b9 0a 00 00 00       	mov    $0xa,%ecx
 508:	6a 01                	push   $0x1
 50a:	eb ce                	jmp    4da <printf+0xea>
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 510:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 513:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 516:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 518:	6a 01                	push   $0x1
        ap++;
 51a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 51d:	57                   	push   %edi
 51e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 521:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 524:	e8 6a fd ff ff       	call   293 <write>
        ap++;
 529:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 52c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 52f:	31 d2                	xor    %edx,%edx
 531:	e9 0e ff ff ff       	jmp    444 <printf+0x54>
 536:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 540:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 543:	83 ec 04             	sub    $0x4,%esp
 546:	e9 59 ff ff ff       	jmp    4a4 <printf+0xb4>
 54b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 54f:	90                   	nop
        s = (char*)*ap;
 550:	8b 45 d0             	mov    -0x30(%ebp),%eax
 553:	8b 18                	mov    (%eax),%ebx
        ap++;
 555:	83 c0 04             	add    $0x4,%eax
 558:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 55b:	85 db                	test   %ebx,%ebx
 55d:	74 17                	je     576 <printf+0x186>
        while(*s != 0){
 55f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 562:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 564:	84 c0                	test   %al,%al
 566:	0f 84 d8 fe ff ff    	je     444 <printf+0x54>
 56c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 56f:	89 de                	mov    %ebx,%esi
 571:	8b 5d 08             	mov    0x8(%ebp),%ebx
 574:	eb 1a                	jmp    590 <printf+0x1a0>
          s = "(null)";
 576:	bb 58 07 00 00       	mov    $0x758,%ebx
        while(*s != 0){
 57b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 57e:	b8 28 00 00 00       	mov    $0x28,%eax
 583:	89 de                	mov    %ebx,%esi
 585:	8b 5d 08             	mov    0x8(%ebp),%ebx
 588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58f:	90                   	nop
  write(fd, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
          s++;
 593:	83 c6 01             	add    $0x1,%esi
 596:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 599:	6a 01                	push   $0x1
 59b:	57                   	push   %edi
 59c:	53                   	push   %ebx
 59d:	e8 f1 fc ff ff       	call   293 <write>
        while(*s != 0){
 5a2:	0f b6 06             	movzbl (%esi),%eax
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	84 c0                	test   %al,%al
 5aa:	75 e4                	jne    590 <printf+0x1a0>
 5ac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 5af:	31 d2                	xor    %edx,%edx
 5b1:	e9 8e fe ff ff       	jmp    444 <printf+0x54>
 5b6:	66 90                	xchg   %ax,%ax
 5b8:	66 90                	xchg   %ax,%ax
 5ba:	66 90                	xchg   %ax,%ax
 5bc:	66 90                	xchg   %ax,%ax
 5be:	66 90                	xchg   %ax,%ax

000005c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c1:	a1 00 0a 00 00       	mov    0xa00,%eax
{
 5c6:	89 e5                	mov    %esp,%ebp
 5c8:	57                   	push   %edi
 5c9:	56                   	push   %esi
 5ca:	53                   	push   %ebx
 5cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ce:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 5d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d3:	39 c8                	cmp    %ecx,%eax
 5d5:	73 19                	jae    5f0 <free+0x30>
 5d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5de:	66 90                	xchg   %ax,%ax
 5e0:	39 d1                	cmp    %edx,%ecx
 5e2:	72 14                	jb     5f8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e4:	39 d0                	cmp    %edx,%eax
 5e6:	73 10                	jae    5f8 <free+0x38>
{
 5e8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ea:	8b 10                	mov    (%eax),%edx
 5ec:	39 c8                	cmp    %ecx,%eax
 5ee:	72 f0                	jb     5e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f0:	39 d0                	cmp    %edx,%eax
 5f2:	72 f4                	jb     5e8 <free+0x28>
 5f4:	39 d1                	cmp    %edx,%ecx
 5f6:	73 f0                	jae    5e8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5fe:	39 fa                	cmp    %edi,%edx
 600:	74 1e                	je     620 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 602:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 605:	8b 50 04             	mov    0x4(%eax),%edx
 608:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 60b:	39 f1                	cmp    %esi,%ecx
 60d:	74 28                	je     637 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 60f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 611:	5b                   	pop    %ebx
  freep = p;
 612:	a3 00 0a 00 00       	mov    %eax,0xa00
}
 617:	5e                   	pop    %esi
 618:	5f                   	pop    %edi
 619:	5d                   	pop    %ebp
 61a:	c3                   	ret    
 61b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 620:	03 72 04             	add    0x4(%edx),%esi
 623:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 626:	8b 10                	mov    (%eax),%edx
 628:	8b 12                	mov    (%edx),%edx
 62a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 62d:	8b 50 04             	mov    0x4(%eax),%edx
 630:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 633:	39 f1                	cmp    %esi,%ecx
 635:	75 d8                	jne    60f <free+0x4f>
    p->s.size += bp->s.size;
 637:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 63a:	a3 00 0a 00 00       	mov    %eax,0xa00
    p->s.size += bp->s.size;
 63f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 642:	8b 53 f8             	mov    -0x8(%ebx),%edx
 645:	89 10                	mov    %edx,(%eax)
}
 647:	5b                   	pop    %ebx
 648:	5e                   	pop    %esi
 649:	5f                   	pop    %edi
 64a:	5d                   	pop    %ebp
 64b:	c3                   	ret    
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000650 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
 655:	53                   	push   %ebx
 656:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 659:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 65c:	8b 3d 00 0a 00 00    	mov    0xa00,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 662:	8d 70 07             	lea    0x7(%eax),%esi
 665:	c1 ee 03             	shr    $0x3,%esi
 668:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 66b:	85 ff                	test   %edi,%edi
 66d:	0f 84 ad 00 00 00    	je     720 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 673:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 675:	8b 48 04             	mov    0x4(%eax),%ecx
 678:	39 f1                	cmp    %esi,%ecx
 67a:	73 71                	jae    6ed <malloc+0x9d>
 67c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 682:	bb 00 10 00 00       	mov    $0x1000,%ebx
 687:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 68a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 691:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 694:	eb 1b                	jmp    6b1 <malloc+0x61>
 696:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6a0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 6a2:	8b 4a 04             	mov    0x4(%edx),%ecx
 6a5:	39 f1                	cmp    %esi,%ecx
 6a7:	73 4f                	jae    6f8 <malloc+0xa8>
 6a9:	8b 3d 00 0a 00 00    	mov    0xa00,%edi
 6af:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6b1:	39 c7                	cmp    %eax,%edi
 6b3:	75 eb                	jne    6a0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 6b5:	83 ec 0c             	sub    $0xc,%esp
 6b8:	ff 75 e4             	pushl  -0x1c(%ebp)
 6bb:	e8 3b fc ff ff       	call   2fb <sbrk>
  if(p == (char*)-1)
 6c0:	83 c4 10             	add    $0x10,%esp
 6c3:	83 f8 ff             	cmp    $0xffffffff,%eax
 6c6:	74 1b                	je     6e3 <malloc+0x93>
  hp->s.size = nu;
 6c8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6cb:	83 ec 0c             	sub    $0xc,%esp
 6ce:	83 c0 08             	add    $0x8,%eax
 6d1:	50                   	push   %eax
 6d2:	e8 e9 fe ff ff       	call   5c0 <free>
  return freep;
 6d7:	a1 00 0a 00 00       	mov    0xa00,%eax
      if((p = morecore(nunits)) == 0)
 6dc:	83 c4 10             	add    $0x10,%esp
 6df:	85 c0                	test   %eax,%eax
 6e1:	75 bd                	jne    6a0 <malloc+0x50>
        return 0;
  }
}
 6e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 6e6:	31 c0                	xor    %eax,%eax
}
 6e8:	5b                   	pop    %ebx
 6e9:	5e                   	pop    %esi
 6ea:	5f                   	pop    %edi
 6eb:	5d                   	pop    %ebp
 6ec:	c3                   	ret    
    if(p->s.size >= nunits){
 6ed:	89 c2                	mov    %eax,%edx
 6ef:	89 f8                	mov    %edi,%eax
 6f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 6f8:	39 ce                	cmp    %ecx,%esi
 6fa:	74 54                	je     750 <malloc+0x100>
        p->s.size -= nunits;
 6fc:	29 f1                	sub    %esi,%ecx
 6fe:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 701:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 704:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 707:	a3 00 0a 00 00       	mov    %eax,0xa00
}
 70c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 70f:	8d 42 08             	lea    0x8(%edx),%eax
}
 712:	5b                   	pop    %ebx
 713:	5e                   	pop    %esi
 714:	5f                   	pop    %edi
 715:	5d                   	pop    %ebp
 716:	c3                   	ret    
 717:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 720:	c7 05 00 0a 00 00 04 	movl   $0xa04,0xa00
 727:	0a 00 00 
    base.s.size = 0;
 72a:	bf 04 0a 00 00       	mov    $0xa04,%edi
    base.s.ptr = freep = prevp = &base;
 72f:	c7 05 04 0a 00 00 04 	movl   $0xa04,0xa04
 736:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 739:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 73b:	c7 05 08 0a 00 00 00 	movl   $0x0,0xa08
 742:	00 00 00 
    if(p->s.size >= nunits){
 745:	e9 32 ff ff ff       	jmp    67c <malloc+0x2c>
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 750:	8b 0a                	mov    (%edx),%ecx
 752:	89 08                	mov    %ecx,(%eax)
 754:	eb b1                	jmp    707 <malloc+0xb7>
