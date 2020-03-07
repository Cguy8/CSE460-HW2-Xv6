
_vid:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
	unsigned int uid, gid, ppid;

	uid = getuid();
  11:	e8 cb 03 00 00       	call   3e1 <getuid>
	printf(2, "Current UID is: %d\n", uid);
  16:	83 ec 04             	sub    $0x4,%esp
  19:	50                   	push   %eax
  1a:	68 38 08 00 00       	push   $0x838
  1f:	6a 02                	push   $0x2
  21:	e8 aa 04 00 00       	call   4d0 <printf>
	printf(2, "Setting UID to 100\n");
  26:	58                   	pop    %eax
  27:	5a                   	pop    %edx
  28:	68 4c 08 00 00       	push   $0x84c
  2d:	6a 02                	push   $0x2
  2f:	e8 9c 04 00 00       	call   4d0 <printf>
	setuid(100);
  34:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  3b:	e8 b9 03 00 00       	call   3f9 <setuid>
	uid = getuid();
  40:	e8 9c 03 00 00       	call   3e1 <getuid>
	printf(2, "Current UID is: %d\n", uid);
  45:	83 c4 0c             	add    $0xc,%esp
  48:	50                   	push   %eax
  49:	68 38 08 00 00       	push   $0x838
  4e:	6a 02                	push   $0x2
  50:	e8 7b 04 00 00       	call   4d0 <printf>

	gid = getgid();
  55:	e8 8f 03 00 00       	call   3e9 <getgid>
	printf(2, "Current GID is: %d\n", gid);
  5a:	83 c4 0c             	add    $0xc,%esp
  5d:	50                   	push   %eax
  5e:	68 60 08 00 00       	push   $0x860
  63:	6a 02                	push   $0x2
  65:	e8 66 04 00 00       	call   4d0 <printf>
	printf(2, "Setting GID to 100\n");
  6a:	59                   	pop    %ecx
  6b:	58                   	pop    %eax
  6c:	68 74 08 00 00       	push   $0x874
  71:	6a 02                	push   $0x2
  73:	e8 58 04 00 00       	call   4d0 <printf>
	setgid(100);
  78:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  7f:	e8 7d 03 00 00       	call   401 <setgid>
	gid = getgid();
  84:	e8 60 03 00 00       	call   3e9 <getgid>
	printf(2, "Current GID is: %d\n", gid);
  89:	83 c4 0c             	add    $0xc,%esp
  8c:	50                   	push   %eax
  8d:	68 60 08 00 00       	push   $0x860
  92:	6a 02                	push   $0x2
  94:	e8 37 04 00 00       	call   4d0 <printf>

	ppid = getppid();
  99:	e8 53 03 00 00       	call   3f1 <getppid>
	printf(2, "My parent process is: %d\n", ppid);
  9e:	83 c4 0c             	add    $0xc,%esp
  a1:	50                   	push   %eax
  a2:	68 88 08 00 00       	push   $0x888
  a7:	6a 02                	push   $0x2
  a9:	e8 22 04 00 00       	call   4d0 <printf>
	printf(2, "Done!\n");
  ae:	58                   	pop    %eax
  af:	5a                   	pop    %edx
  b0:	68 a2 08 00 00       	push   $0x8a2
  b5:	6a 02                	push   $0x2
  b7:	e8 14 04 00 00       	call   4d0 <printf>

	exit();
  bc:	e8 60 02 00 00       	call   321 <exit>
  c1:	66 90                	xchg   %ax,%ax
  c3:	66 90                	xchg   %ax,%ax
  c5:	66 90                	xchg   %ax,%ax
  c7:	66 90                	xchg   %ax,%ax
  c9:	66 90                	xchg   %ax,%ax
  cb:	66 90                	xchg   %ax,%ax
  cd:	66 90                	xchg   %ax,%ax
  cf:	90                   	nop

000000d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  d0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  d1:	31 d2                	xor    %edx,%edx
{
  d3:	89 e5                	mov    %esp,%ebp
  d5:	53                   	push   %ebx
  d6:	8b 45 08             	mov    0x8(%ebp),%eax
  d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  e0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  e4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  e7:	83 c2 01             	add    $0x1,%edx
  ea:	84 c9                	test   %cl,%cl
  ec:	75 f2                	jne    e0 <strcpy+0x10>
    ;
  return os;
}
  ee:	5b                   	pop    %ebx
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret    
  f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff:	90                   	nop

00000100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	56                   	push   %esi
 104:	53                   	push   %ebx
 105:	8b 5d 08             	mov    0x8(%ebp),%ebx
 108:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(*p && *p == *q)
 10b:	0f b6 13             	movzbl (%ebx),%edx
 10e:	0f b6 0e             	movzbl (%esi),%ecx
 111:	84 d2                	test   %dl,%dl
 113:	74 1e                	je     133 <strcmp+0x33>
 115:	b8 01 00 00 00       	mov    $0x1,%eax
 11a:	38 ca                	cmp    %cl,%dl
 11c:	74 09                	je     127 <strcmp+0x27>
 11e:	eb 20                	jmp    140 <strcmp+0x40>
 120:	83 c0 01             	add    $0x1,%eax
 123:	38 ca                	cmp    %cl,%dl
 125:	75 19                	jne    140 <strcmp+0x40>
 127:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 12b:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 12f:	84 d2                	test   %dl,%dl
 131:	75 ed                	jne    120 <strcmp+0x20>
 133:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 135:	5b                   	pop    %ebx
 136:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 137:	29 c8                	sub    %ecx,%eax
}
 139:	5d                   	pop    %ebp
 13a:	c3                   	ret    
 13b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 13f:	90                   	nop
 140:	0f b6 c2             	movzbl %dl,%eax
 143:	5b                   	pop    %ebx
 144:	5e                   	pop    %esi
  return (uchar)*p - (uchar)*q;
 145:	29 c8                	sub    %ecx,%eax
}
 147:	5d                   	pop    %ebp
 148:	c3                   	ret    
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000150 <strlen>:

uint
strlen(char *s)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 156:	80 39 00             	cmpb   $0x0,(%ecx)
 159:	74 15                	je     170 <strlen+0x20>
 15b:	31 d2                	xor    %edx,%edx
 15d:	8d 76 00             	lea    0x0(%esi),%esi
 160:	83 c2 01             	add    $0x1,%edx
 163:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 167:	89 d0                	mov    %edx,%eax
 169:	75 f5                	jne    160 <strlen+0x10>
    ;
  return n;
}
 16b:	5d                   	pop    %ebp
 16c:	c3                   	ret    
 16d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 170:	31 c0                	xor    %eax,%eax
}
 172:	5d                   	pop    %ebp
 173:	c3                   	ret    
 174:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 17f:	90                   	nop

00000180 <memset>:

void*
memset(void *dst, int c, uint n)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 187:	8b 4d 10             	mov    0x10(%ebp),%ecx
 18a:	8b 45 0c             	mov    0xc(%ebp),%eax
 18d:	89 d7                	mov    %edx,%edi
 18f:	fc                   	cld    
 190:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 192:	89 d0                	mov    %edx,%eax
 194:	5f                   	pop    %edi
 195:	5d                   	pop    %ebp
 196:	c3                   	ret    
 197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19e:	66 90                	xchg   %ax,%ax

000001a0 <strchr>:

char*
strchr(const char *s, char c)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	53                   	push   %ebx
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1aa:	0f b6 18             	movzbl (%eax),%ebx
 1ad:	84 db                	test   %bl,%bl
 1af:	74 1d                	je     1ce <strchr+0x2e>
 1b1:	89 d1                	mov    %edx,%ecx
    if(*s == c)
 1b3:	38 d3                	cmp    %dl,%bl
 1b5:	75 0d                	jne    1c4 <strchr+0x24>
 1b7:	eb 17                	jmp    1d0 <strchr+0x30>
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1c0:	38 ca                	cmp    %cl,%dl
 1c2:	74 0c                	je     1d0 <strchr+0x30>
  for(; *s; s++)
 1c4:	83 c0 01             	add    $0x1,%eax
 1c7:	0f b6 10             	movzbl (%eax),%edx
 1ca:	84 d2                	test   %dl,%dl
 1cc:	75 f2                	jne    1c0 <strchr+0x20>
      return (char*)s;
  return 0;
 1ce:	31 c0                	xor    %eax,%eax
}
 1d0:	5b                   	pop    %ebx
 1d1:	5d                   	pop    %ebp
 1d2:	c3                   	ret    
 1d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001e0 <gets>:

char*
gets(char *buf, int max)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e5:	31 f6                	xor    %esi,%esi
{
 1e7:	53                   	push   %ebx
 1e8:	89 f3                	mov    %esi,%ebx
 1ea:	83 ec 1c             	sub    $0x1c,%esp
 1ed:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1f0:	eb 2f                	jmp    221 <gets+0x41>
 1f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1f8:	83 ec 04             	sub    $0x4,%esp
 1fb:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1fe:	6a 01                	push   $0x1
 200:	50                   	push   %eax
 201:	6a 00                	push   $0x0
 203:	e8 31 01 00 00       	call   339 <read>
    if(cc < 1)
 208:	83 c4 10             	add    $0x10,%esp
 20b:	85 c0                	test   %eax,%eax
 20d:	7e 1c                	jle    22b <gets+0x4b>
      break;
    buf[i++] = c;
 20f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 213:	83 c7 01             	add    $0x1,%edi
 216:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 219:	3c 0a                	cmp    $0xa,%al
 21b:	74 23                	je     240 <gets+0x60>
 21d:	3c 0d                	cmp    $0xd,%al
 21f:	74 1f                	je     240 <gets+0x60>
  for(i=0; i+1 < max; ){
 221:	83 c3 01             	add    $0x1,%ebx
 224:	89 fe                	mov    %edi,%esi
 226:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 229:	7c cd                	jl     1f8 <gets+0x18>
 22b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 22d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 230:	c6 03 00             	movb   $0x0,(%ebx)
}
 233:	8d 65 f4             	lea    -0xc(%ebp),%esp
 236:	5b                   	pop    %ebx
 237:	5e                   	pop    %esi
 238:	5f                   	pop    %edi
 239:	5d                   	pop    %ebp
 23a:	c3                   	ret    
 23b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 23f:	90                   	nop
 240:	8b 75 08             	mov    0x8(%ebp),%esi
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	01 de                	add    %ebx,%esi
 248:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 24a:	c6 03 00             	movb   $0x0,(%ebx)
}
 24d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 250:	5b                   	pop    %ebx
 251:	5e                   	pop    %esi
 252:	5f                   	pop    %edi
 253:	5d                   	pop    %ebp
 254:	c3                   	ret    
 255:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000260 <stat>:

int
stat(char *n, struct stat *st)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 265:	83 ec 08             	sub    $0x8,%esp
 268:	6a 00                	push   $0x0
 26a:	ff 75 08             	pushl  0x8(%ebp)
 26d:	e8 ef 00 00 00       	call   361 <open>
  if(fd < 0)
 272:	83 c4 10             	add    $0x10,%esp
 275:	85 c0                	test   %eax,%eax
 277:	78 27                	js     2a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 279:	83 ec 08             	sub    $0x8,%esp
 27c:	ff 75 0c             	pushl  0xc(%ebp)
 27f:	89 c3                	mov    %eax,%ebx
 281:	50                   	push   %eax
 282:	e8 f2 00 00 00       	call   379 <fstat>
  close(fd);
 287:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 28a:	89 c6                	mov    %eax,%esi
  close(fd);
 28c:	e8 b8 00 00 00       	call   349 <close>
  return r;
 291:	83 c4 10             	add    $0x10,%esp
}
 294:	8d 65 f8             	lea    -0x8(%ebp),%esp
 297:	89 f0                	mov    %esi,%eax
 299:	5b                   	pop    %ebx
 29a:	5e                   	pop    %esi
 29b:	5d                   	pop    %ebp
 29c:	c3                   	ret    
 29d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2a5:	eb ed                	jmp    294 <stat+0x34>
 2a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ae:	66 90                	xchg   %ax,%ax

000002b0 <atoi>:

int
atoi(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b7:	0f be 11             	movsbl (%ecx),%edx
 2ba:	8d 42 d0             	lea    -0x30(%edx),%eax
 2bd:	3c 09                	cmp    $0x9,%al
  n = 0;
 2bf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2c4:	77 1f                	ja     2e5 <atoi+0x35>
 2c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    n = n*10 + *s++ - '0';
 2d0:	83 c1 01             	add    $0x1,%ecx
 2d3:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2da:	0f be 11             	movsbl (%ecx),%edx
 2dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2e0:	80 fb 09             	cmp    $0x9,%bl
 2e3:	76 eb                	jbe    2d0 <atoi+0x20>
  return n;
}
 2e5:	5b                   	pop    %ebx
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    
 2e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ef:	90                   	nop

000002f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	8b 55 10             	mov    0x10(%ebp),%edx
 2f7:	8b 45 08             	mov    0x8(%ebp),%eax
 2fa:	56                   	push   %esi
 2fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2fe:	85 d2                	test   %edx,%edx
 300:	7e 13                	jle    315 <memmove+0x25>
 302:	01 c2                	add    %eax,%edx
  dst = vdst;
 304:	89 c7                	mov    %eax,%edi
 306:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 310:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 311:	39 fa                	cmp    %edi,%edx
 313:	75 fb                	jne    310 <memmove+0x20>
  return vdst;
}
 315:	5e                   	pop    %esi
 316:	5f                   	pop    %edi
 317:	5d                   	pop    %ebp
 318:	c3                   	ret    

00000319 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 319:	b8 01 00 00 00       	mov    $0x1,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <exit>:
SYSCALL(exit)
 321:	b8 02 00 00 00       	mov    $0x2,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <wait>:
SYSCALL(wait)
 329:	b8 03 00 00 00       	mov    $0x3,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <pipe>:
SYSCALL(pipe)
 331:	b8 04 00 00 00       	mov    $0x4,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <read>:
SYSCALL(read)
 339:	b8 05 00 00 00       	mov    $0x5,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <write>:
SYSCALL(write)
 341:	b8 10 00 00 00       	mov    $0x10,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <close>:
SYSCALL(close)
 349:	b8 15 00 00 00       	mov    $0x15,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <kill>:
SYSCALL(kill)
 351:	b8 06 00 00 00       	mov    $0x6,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <exec>:
SYSCALL(exec)
 359:	b8 07 00 00 00       	mov    $0x7,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <open>:
SYSCALL(open)
 361:	b8 0f 00 00 00       	mov    $0xf,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <mknod>:
SYSCALL(mknod)
 369:	b8 11 00 00 00       	mov    $0x11,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <unlink>:
SYSCALL(unlink)
 371:	b8 12 00 00 00       	mov    $0x12,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <fstat>:
SYSCALL(fstat)
 379:	b8 08 00 00 00       	mov    $0x8,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <link>:
SYSCALL(link)
 381:	b8 13 00 00 00       	mov    $0x13,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <mkdir>:
SYSCALL(mkdir)
 389:	b8 14 00 00 00       	mov    $0x14,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <chdir>:
SYSCALL(chdir)
 391:	b8 09 00 00 00       	mov    $0x9,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <dup>:
SYSCALL(dup)
 399:	b8 0a 00 00 00       	mov    $0xa,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <getpid>:
SYSCALL(getpid)
 3a1:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <sbrk>:
SYSCALL(sbrk)
 3a9:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <sleep>:
SYSCALL(sleep)
 3b1:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <uptime>:
SYSCALL(uptime)
 3b9:	b8 0e 00 00 00       	mov    $0xe,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <cps>:
SYSCALL(cps)
 3c1:	b8 16 00 00 00       	mov    $0x16,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <nps>:
SYSCALL(nps)
 3c9:	b8 17 00 00 00       	mov    $0x17,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <chpr>:
SYSCALL(chpr)
 3d1:	b8 18 00 00 00       	mov    $0x18,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <date>:
SYSCALL(date)
 3d9:	b8 19 00 00 00       	mov    $0x19,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <getuid>:
SYSCALL(getuid)
 3e1:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <getgid>:
SYSCALL(getgid)
 3e9:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <getppid>:
SYSCALL(getppid)
 3f1:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <setuid>:
SYSCALL(setuid)
 3f9:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <setgid>:
SYSCALL(setgid)
 401:	b8 1e 00 00 00       	mov    $0x1e,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    
 409:	66 90                	xchg   %ax,%ax
 40b:	66 90                	xchg   %ax,%ax
 40d:	66 90                	xchg   %ax,%ax
 40f:	90                   	nop

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 416:	89 d3                	mov    %edx,%ebx
{
 418:	83 ec 3c             	sub    $0x3c,%esp
 41b:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 41e:	85 d2                	test   %edx,%edx
 420:	0f 89 92 00 00 00    	jns    4b8 <printint+0xa8>
 426:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 42a:	0f 84 88 00 00 00    	je     4b8 <printint+0xa8>
    neg = 1;
 430:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 437:	f7 db                	neg    %ebx
  } else {
    x = xx;
  }

  i = 0;
 439:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 440:	8d 75 d7             	lea    -0x29(%ebp),%esi
 443:	eb 08                	jmp    44d <printint+0x3d>
 445:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 448:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  }while((x /= base) != 0);
 44b:	89 c3                	mov    %eax,%ebx
    buf[i++] = digits[x % base];
 44d:	89 d8                	mov    %ebx,%eax
 44f:	31 d2                	xor    %edx,%edx
 451:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 454:	f7 f1                	div    %ecx
 456:	83 c7 01             	add    $0x1,%edi
 459:	0f b6 92 b0 08 00 00 	movzbl 0x8b0(%edx),%edx
 460:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 463:	39 d9                	cmp    %ebx,%ecx
 465:	76 e1                	jbe    448 <printint+0x38>
  if(neg)
 467:	8b 45 c0             	mov    -0x40(%ebp),%eax
 46a:	85 c0                	test   %eax,%eax
 46c:	74 0d                	je     47b <printint+0x6b>
    buf[i++] = '-';
 46e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 473:	ba 2d 00 00 00       	mov    $0x2d,%edx
    buf[i++] = digits[x % base];
 478:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 47b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 47e:	8b 7d bc             	mov    -0x44(%ebp),%edi
 481:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 485:	eb 0f                	jmp    496 <printint+0x86>
 487:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48e:	66 90                	xchg   %ax,%ax
 490:	0f b6 13             	movzbl (%ebx),%edx
 493:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 496:	83 ec 04             	sub    $0x4,%esp
 499:	88 55 d7             	mov    %dl,-0x29(%ebp)
 49c:	6a 01                	push   $0x1
 49e:	56                   	push   %esi
 49f:	57                   	push   %edi
 4a0:	e8 9c fe ff ff       	call   341 <write>

  while(--i >= 0)
 4a5:	83 c4 10             	add    $0x10,%esp
 4a8:	39 de                	cmp    %ebx,%esi
 4aa:	75 e4                	jne    490 <printint+0x80>
    putc(fd, buf[i]);
}
 4ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4af:	5b                   	pop    %ebx
 4b0:	5e                   	pop    %esi
 4b1:	5f                   	pop    %edi
 4b2:	5d                   	pop    %ebp
 4b3:	c3                   	ret    
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4b8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 4bf:	e9 75 ff ff ff       	jmp    439 <printint+0x29>
 4c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4cf:	90                   	nop

000004d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4dc:	0f b6 1e             	movzbl (%esi),%ebx
 4df:	84 db                	test   %bl,%bl
 4e1:	0f 84 b9 00 00 00    	je     5a0 <printf+0xd0>
  ap = (uint*)(void*)&fmt + 1;
 4e7:	8d 45 10             	lea    0x10(%ebp),%eax
 4ea:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4ed:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4f0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4f5:	eb 38                	jmp    52f <printf+0x5f>
 4f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fe:	66 90                	xchg   %ax,%ax
 500:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 503:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 508:	83 f8 25             	cmp    $0x25,%eax
 50b:	74 17                	je     524 <printf+0x54>
  write(fd, &c, 1);
 50d:	83 ec 04             	sub    $0x4,%esp
 510:	88 5d e7             	mov    %bl,-0x19(%ebp)
 513:	6a 01                	push   $0x1
 515:	57                   	push   %edi
 516:	ff 75 08             	pushl  0x8(%ebp)
 519:	e8 23 fe ff ff       	call   341 <write>
 51e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 521:	83 c4 10             	add    $0x10,%esp
 524:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 527:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 52b:	84 db                	test   %bl,%bl
 52d:	74 71                	je     5a0 <printf+0xd0>
    c = fmt[i] & 0xff;
 52f:	0f be cb             	movsbl %bl,%ecx
 532:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 535:	85 d2                	test   %edx,%edx
 537:	74 c7                	je     500 <printf+0x30>
      }
    } else if(state == '%'){
 539:	83 fa 25             	cmp    $0x25,%edx
 53c:	75 e6                	jne    524 <printf+0x54>
      if(c == 'd'){
 53e:	83 f8 64             	cmp    $0x64,%eax
 541:	0f 84 99 00 00 00    	je     5e0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 547:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 54d:	83 f9 70             	cmp    $0x70,%ecx
 550:	74 5e                	je     5b0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 552:	83 f8 73             	cmp    $0x73,%eax
 555:	0f 84 d5 00 00 00    	je     630 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 55b:	83 f8 63             	cmp    $0x63,%eax
 55e:	0f 84 8c 00 00 00    	je     5f0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 564:	83 f8 25             	cmp    $0x25,%eax
 567:	0f 84 b3 00 00 00    	je     620 <printf+0x150>
  write(fd, &c, 1);
 56d:	83 ec 04             	sub    $0x4,%esp
 570:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 574:	6a 01                	push   $0x1
 576:	57                   	push   %edi
 577:	ff 75 08             	pushl  0x8(%ebp)
 57a:	e8 c2 fd ff ff       	call   341 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 57f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 582:	83 c4 0c             	add    $0xc,%esp
 585:	6a 01                	push   $0x1
 587:	83 c6 01             	add    $0x1,%esi
 58a:	57                   	push   %edi
 58b:	ff 75 08             	pushl  0x8(%ebp)
 58e:	e8 ae fd ff ff       	call   341 <write>
  for(i = 0; fmt[i]; i++){
 593:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 597:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 59a:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 59c:	84 db                	test   %bl,%bl
 59e:	75 8f                	jne    52f <printf+0x5f>
    }
  }
}
 5a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5a3:	5b                   	pop    %ebx
 5a4:	5e                   	pop    %esi
 5a5:	5f                   	pop    %edi
 5a6:	5d                   	pop    %ebp
 5a7:	c3                   	ret    
 5a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop
        printint(fd, *ap, 16, 0);
 5b0:	83 ec 0c             	sub    $0xc,%esp
 5b3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5b8:	6a 00                	push   $0x0
 5ba:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5bd:	8b 45 08             	mov    0x8(%ebp),%eax
 5c0:	8b 13                	mov    (%ebx),%edx
 5c2:	e8 49 fe ff ff       	call   410 <printint>
        ap++;
 5c7:	89 d8                	mov    %ebx,%eax
 5c9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5cc:	31 d2                	xor    %edx,%edx
        ap++;
 5ce:	83 c0 04             	add    $0x4,%eax
 5d1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5d4:	e9 4b ff ff ff       	jmp    524 <printf+0x54>
 5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5e0:	83 ec 0c             	sub    $0xc,%esp
 5e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5e8:	6a 01                	push   $0x1
 5ea:	eb ce                	jmp    5ba <printf+0xea>
 5ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5f6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5f8:	6a 01                	push   $0x1
        ap++;
 5fa:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5fd:	57                   	push   %edi
 5fe:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 601:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 604:	e8 38 fd ff ff       	call   341 <write>
        ap++;
 609:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 60c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 60f:	31 d2                	xor    %edx,%edx
 611:	e9 0e ff ff ff       	jmp    524 <printf+0x54>
 616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 620:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 623:	83 ec 04             	sub    $0x4,%esp
 626:	e9 5a ff ff ff       	jmp    585 <printf+0xb5>
 62b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 62f:	90                   	nop
        s = (char*)*ap;
 630:	8b 45 d0             	mov    -0x30(%ebp),%eax
 633:	8b 18                	mov    (%eax),%ebx
        ap++;
 635:	83 c0 04             	add    $0x4,%eax
 638:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 63b:	85 db                	test   %ebx,%ebx
 63d:	74 17                	je     656 <printf+0x186>
        while(*s != 0){
 63f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 642:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 644:	84 c0                	test   %al,%al
 646:	0f 84 d8 fe ff ff    	je     524 <printf+0x54>
 64c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 64f:	89 de                	mov    %ebx,%esi
 651:	8b 5d 08             	mov    0x8(%ebp),%ebx
 654:	eb 1a                	jmp    670 <printf+0x1a0>
          s = "(null)";
 656:	bb a9 08 00 00       	mov    $0x8a9,%ebx
        while(*s != 0){
 65b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 65e:	b8 28 00 00 00       	mov    $0x28,%eax
 663:	89 de                	mov    %ebx,%esi
 665:	8b 5d 08             	mov    0x8(%ebp),%ebx
 668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 66f:	90                   	nop
  write(fd, &c, 1);
 670:	83 ec 04             	sub    $0x4,%esp
          s++;
 673:	83 c6 01             	add    $0x1,%esi
 676:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 679:	6a 01                	push   $0x1
 67b:	57                   	push   %edi
 67c:	53                   	push   %ebx
 67d:	e8 bf fc ff ff       	call   341 <write>
        while(*s != 0){
 682:	0f b6 06             	movzbl (%esi),%eax
 685:	83 c4 10             	add    $0x10,%esp
 688:	84 c0                	test   %al,%al
 68a:	75 e4                	jne    670 <printf+0x1a0>
 68c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 68f:	31 d2                	xor    %edx,%edx
 691:	e9 8e fe ff ff       	jmp    524 <printf+0x54>
 696:	66 90                	xchg   %ax,%ax
 698:	66 90                	xchg   %ax,%ax
 69a:	66 90                	xchg   %ax,%ax
 69c:	66 90                	xchg   %ax,%ax
 69e:	66 90                	xchg   %ax,%ax

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	a1 58 0b 00 00       	mov    0xb58,%eax
{
 6a6:	89 e5                	mov    %esp,%ebp
 6a8:	57                   	push   %edi
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ae:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6b0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b3:	39 c8                	cmp    %ecx,%eax
 6b5:	73 19                	jae    6d0 <free+0x30>
 6b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6be:	66 90                	xchg   %ax,%ax
 6c0:	39 d1                	cmp    %edx,%ecx
 6c2:	72 14                	jb     6d8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c4:	39 d0                	cmp    %edx,%eax
 6c6:	73 10                	jae    6d8 <free+0x38>
{
 6c8:	89 d0                	mov    %edx,%eax
 6ca:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6cc:	39 c8                	cmp    %ecx,%eax
 6ce:	72 f0                	jb     6c0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d0:	39 d0                	cmp    %edx,%eax
 6d2:	72 f4                	jb     6c8 <free+0x28>
 6d4:	39 d1                	cmp    %edx,%ecx
 6d6:	73 f0                	jae    6c8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6de:	39 fa                	cmp    %edi,%edx
 6e0:	74 1e                	je     700 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6e2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6e5:	8b 50 04             	mov    0x4(%eax),%edx
 6e8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6eb:	39 f1                	cmp    %esi,%ecx
 6ed:	74 28                	je     717 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6ef:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6f1:	5b                   	pop    %ebx
  freep = p;
 6f2:	a3 58 0b 00 00       	mov    %eax,0xb58
}
 6f7:	5e                   	pop    %esi
 6f8:	5f                   	pop    %edi
 6f9:	5d                   	pop    %ebp
 6fa:	c3                   	ret    
 6fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 700:	03 72 04             	add    0x4(%edx),%esi
 703:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 706:	8b 10                	mov    (%eax),%edx
 708:	8b 12                	mov    (%edx),%edx
 70a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 70d:	8b 50 04             	mov    0x4(%eax),%edx
 710:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 713:	39 f1                	cmp    %esi,%ecx
 715:	75 d8                	jne    6ef <free+0x4f>
    p->s.size += bp->s.size;
 717:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 71a:	a3 58 0b 00 00       	mov    %eax,0xb58
    p->s.size += bp->s.size;
 71f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 722:	8b 53 f8             	mov    -0x8(%ebx),%edx
 725:	89 10                	mov    %edx,(%eax)
}
 727:	5b                   	pop    %ebx
 728:	5e                   	pop    %esi
 729:	5f                   	pop    %edi
 72a:	5d                   	pop    %ebp
 72b:	c3                   	ret    
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000730 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 739:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 73c:	8b 3d 58 0b 00 00    	mov    0xb58,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 742:	8d 70 07             	lea    0x7(%eax),%esi
 745:	c1 ee 03             	shr    $0x3,%esi
 748:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 74b:	85 ff                	test   %edi,%edi
 74d:	0f 84 ad 00 00 00    	je     800 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 753:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 755:	8b 4a 04             	mov    0x4(%edx),%ecx
 758:	39 f1                	cmp    %esi,%ecx
 75a:	73 72                	jae    7ce <malloc+0x9e>
 75c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 762:	bb 00 10 00 00       	mov    $0x1000,%ebx
 767:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 76a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 771:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 774:	eb 1b                	jmp    791 <malloc+0x61>
 776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 780:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 782:	8b 48 04             	mov    0x4(%eax),%ecx
 785:	39 f1                	cmp    %esi,%ecx
 787:	73 4f                	jae    7d8 <malloc+0xa8>
 789:	8b 3d 58 0b 00 00    	mov    0xb58,%edi
 78f:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 791:	39 d7                	cmp    %edx,%edi
 793:	75 eb                	jne    780 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 795:	83 ec 0c             	sub    $0xc,%esp
 798:	ff 75 e4             	pushl  -0x1c(%ebp)
 79b:	e8 09 fc ff ff       	call   3a9 <sbrk>
  if(p == (char*)-1)
 7a0:	83 c4 10             	add    $0x10,%esp
 7a3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7a6:	74 1c                	je     7c4 <malloc+0x94>
  hp->s.size = nu;
 7a8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7ab:	83 ec 0c             	sub    $0xc,%esp
 7ae:	83 c0 08             	add    $0x8,%eax
 7b1:	50                   	push   %eax
 7b2:	e8 e9 fe ff ff       	call   6a0 <free>
  return freep;
 7b7:	8b 15 58 0b 00 00    	mov    0xb58,%edx
      if((p = morecore(nunits)) == 0)
 7bd:	83 c4 10             	add    $0x10,%esp
 7c0:	85 d2                	test   %edx,%edx
 7c2:	75 bc                	jne    780 <malloc+0x50>
        return 0;
  }
}
 7c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7c7:	31 c0                	xor    %eax,%eax
}
 7c9:	5b                   	pop    %ebx
 7ca:	5e                   	pop    %esi
 7cb:	5f                   	pop    %edi
 7cc:	5d                   	pop    %ebp
 7cd:	c3                   	ret    
    if(p->s.size >= nunits){
 7ce:	89 d0                	mov    %edx,%eax
 7d0:	89 fa                	mov    %edi,%edx
 7d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7d8:	39 ce                	cmp    %ecx,%esi
 7da:	74 54                	je     830 <malloc+0x100>
        p->s.size -= nunits;
 7dc:	29 f1                	sub    %esi,%ecx
 7de:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7e1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7e4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 7e7:	89 15 58 0b 00 00    	mov    %edx,0xb58
}
 7ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7f0:	83 c0 08             	add    $0x8,%eax
}
 7f3:	5b                   	pop    %ebx
 7f4:	5e                   	pop    %esi
 7f5:	5f                   	pop    %edi
 7f6:	5d                   	pop    %ebp
 7f7:	c3                   	ret    
 7f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ff:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 800:	c7 05 58 0b 00 00 5c 	movl   $0xb5c,0xb58
 807:	0b 00 00 
    base.s.size = 0;
 80a:	bf 5c 0b 00 00       	mov    $0xb5c,%edi
    base.s.ptr = freep = prevp = &base;
 80f:	c7 05 5c 0b 00 00 5c 	movl   $0xb5c,0xb5c
 816:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 819:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 81b:	c7 05 60 0b 00 00 00 	movl   $0x0,0xb60
 822:	00 00 00 
    if(p->s.size >= nunits){
 825:	e9 32 ff ff ff       	jmp    75c <malloc+0x2c>
 82a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 830:	8b 08                	mov    (%eax),%ecx
 832:	89 0a                	mov    %ecx,(%edx)
 834:	eb b1                	jmp    7e7 <malloc+0xb7>