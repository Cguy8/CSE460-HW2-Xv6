
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 a6 4d 00 00       	push   $0x4da6
      16:	6a 01                	push   $0x1
      18:	e8 33 3a 00 00       	call   3a50 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 ba 4d 00 00       	push   $0x4dba
      26:	e8 e8 38 00 00       	call   3913 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 24 55 00 00       	push   $0x5524
      39:	6a 01                	push   $0x1
      3b:	e8 10 3a 00 00       	call   3a50 <printf>
    exit();
      40:	e8 8e 38 00 00       	call   38d3 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 ba 4d 00 00       	push   $0x4dba
      51:	e8 bd 38 00 00       	call   3913 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 9d 38 00 00       	call   38fb <close>

  argptest();
      5e:	e8 8d 35 00 00       	call   35f0 <argptest>
  createdelete();
      63:	e8 b8 11 00 00       	call   1220 <createdelete>
  linkunlink();
      68:	e8 83 1a 00 00       	call   1af0 <linkunlink>
  concreate();
      6d:	e8 7e 17 00 00       	call   17f0 <concreate>
  fourfiles();
      72:	e8 a9 0f 00 00       	call   1020 <fourfiles>
  sharedfd();
      77:	e8 e4 0d 00 00       	call   e60 <sharedfd>

  bigargtest();
      7c:	e8 1f 32 00 00       	call   32a0 <bigargtest>
  bigwrite();
      81:	e8 8a 23 00 00       	call   2410 <bigwrite>
  bigargtest();
      86:	e8 15 32 00 00       	call   32a0 <bigargtest>
  bsstest();
      8b:	e8 a0 31 00 00       	call   3230 <bsstest>
  sbrktest();
      90:	e8 bb 2c 00 00       	call   2d50 <sbrktest>
  validatetest();
      95:	e8 e6 30 00 00       	call   3180 <validatetest>

  opentest();
      9a:	e8 61 03 00 00       	call   400 <opentest>
  writetest();
      9f:	e8 ec 03 00 00       	call   490 <writetest>
  writetest1();
      a4:	e8 c7 05 00 00       	call   670 <writetest1>
  createtest();
      a9:	e8 92 07 00 00       	call   840 <createtest>

  openiputtest();
      ae:	e8 4d 02 00 00       	call   300 <openiputtest>
  exitiputtest();
      b3:	e8 48 01 00 00       	call   200 <exitiputtest>
  iputtest();
      b8:	e8 63 00 00 00       	call   120 <iputtest>

  mem();
      bd:	e8 ce 0c 00 00       	call   d90 <mem>
  pipe1();
      c2:	e8 59 09 00 00       	call   a20 <pipe1>
  preempt();
      c7:	e8 e4 0a 00 00       	call   bb0 <preempt>
  exitwait();
      cc:	e8 3f 0c 00 00       	call   d10 <exitwait>

  rmdot();
      d1:	e8 2a 27 00 00       	call   2800 <rmdot>
  fourteen();
      d6:	e8 e5 25 00 00       	call   26c0 <fourteen>
  bigfile();
      db:	e8 10 24 00 00       	call   24f0 <bigfile>
  subdir();
      e0:	e8 4b 1c 00 00       	call   1d30 <subdir>
  linktest();
      e5:	e8 f6 14 00 00       	call   15e0 <linktest>
  unlinkread();
      ea:	e8 61 13 00 00       	call   1450 <unlinkread>
  dirfile();
      ef:	e8 8c 28 00 00       	call   2980 <dirfile>
  iref();
      f4:	e8 87 2a 00 00       	call   2b80 <iref>
  forktest();
      f9:	e8 a2 2b 00 00       	call   2ca0 <forktest>
  bigdir(); // slow
      fe:	e8 fd 1a 00 00       	call   1c00 <bigdir>

  uio();
     103:	e8 78 34 00 00       	call   3580 <uio>

  exectest();
     108:	e8 c3 08 00 00       	call   9d0 <exectest>

  exit();
     10d:	e8 c1 37 00 00       	call   38d3 <exit>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     126:	68 4c 3e 00 00       	push   $0x3e4c
     12b:	ff 35 50 5e 00 00    	pushl  0x5e50
     131:	e8 1a 39 00 00       	call   3a50 <printf>
  if(mkdir("iputdir") < 0){
     136:	c7 04 24 df 3d 00 00 	movl   $0x3ddf,(%esp)
     13d:	e8 f9 37 00 00       	call   393b <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 df 3d 00 00       	push   $0x3ddf
     151:	e8 ed 37 00 00       	call   3943 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     161:	83 ec 0c             	sub    $0xc,%esp
     164:	68 dc 3d 00 00       	push   $0x3ddc
     169:	e8 b5 37 00 00       	call   3923 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
  if(chdir("/") < 0){
     175:	83 ec 0c             	sub    $0xc,%esp
     178:	68 01 3e 00 00       	push   $0x3e01
     17d:	e8 c1 37 00 00       	call   3943 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 84 3e 00 00       	push   $0x3e84
     191:	ff 35 50 5e 00 00    	pushl  0x5e50
     197:	e8 b4 38 00 00       	call   3a50 <printf>
}
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave  
     1a0:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
     1a3:	68 b8 3d 00 00       	push   $0x3db8
     1a8:	ff 35 50 5e 00 00    	pushl  0x5e50
     1ae:	e8 9d 38 00 00       	call   3a50 <printf>
    exit();
     1b3:	e8 1b 37 00 00       	call   38d3 <exit>
    printf(stdout, "chdir / failed\n");
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
     1ba:	68 03 3e 00 00       	push   $0x3e03
     1bf:	ff 35 50 5e 00 00    	pushl  0x5e50
     1c5:	e8 86 38 00 00       	call   3a50 <printf>
    exit();
     1ca:	e8 04 37 00 00       	call   38d3 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
     1d1:	68 e7 3d 00 00       	push   $0x3de7
     1d6:	ff 35 50 5e 00 00    	pushl  0x5e50
     1dc:	e8 6f 38 00 00       	call   3a50 <printf>
    exit();
     1e1:	e8 ed 36 00 00       	call   38d3 <exit>
    printf(stdout, "chdir iputdir failed\n");
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
     1e8:	68 c6 3d 00 00       	push   $0x3dc6
     1ed:	ff 35 50 5e 00 00    	pushl  0x5e50
     1f3:	e8 58 38 00 00       	call   3a50 <printf>
    exit();
     1f8:	e8 d6 36 00 00       	call   38d3 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     206:	68 13 3e 00 00       	push   $0x3e13
     20b:	ff 35 50 5e 00 00    	pushl  0x5e50
     211:	e8 3a 38 00 00       	call   3a50 <printf>
  pid = fork();
     216:	e8 b0 36 00 00       	call   38cb <fork>
  if(pid < 0){
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	85 c0                	test   %eax,%eax
     220:	0f 88 8a 00 00 00    	js     2b0 <exitiputtest+0xb0>
  if(pid == 0){
     226:	75 50                	jne    278 <exitiputtest+0x78>
    if(mkdir("iputdir") < 0){
     228:	83 ec 0c             	sub    $0xc,%esp
     22b:	68 df 3d 00 00       	push   $0x3ddf
     230:	e8 06 37 00 00       	call   393b <mkdir>
     235:	83 c4 10             	add    $0x10,%esp
     238:	85 c0                	test   %eax,%eax
     23a:	0f 88 87 00 00 00    	js     2c7 <exitiputtest+0xc7>
    if(chdir("iputdir") < 0){
     240:	83 ec 0c             	sub    $0xc,%esp
     243:	68 df 3d 00 00       	push   $0x3ddf
     248:	e8 f6 36 00 00       	call   3943 <chdir>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	85 c0                	test   %eax,%eax
     252:	0f 88 86 00 00 00    	js     2de <exitiputtest+0xde>
    if(unlink("../iputdir") < 0){
     258:	83 ec 0c             	sub    $0xc,%esp
     25b:	68 dc 3d 00 00       	push   $0x3ddc
     260:	e8 be 36 00 00       	call   3923 <unlink>
     265:	83 c4 10             	add    $0x10,%esp
     268:	85 c0                	test   %eax,%eax
     26a:	78 2c                	js     298 <exitiputtest+0x98>
    exit();
     26c:	e8 62 36 00 00       	call   38d3 <exit>
     271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  wait();
     278:	e8 5e 36 00 00       	call   38db <wait>
  printf(stdout, "exitiput test ok\n");
     27d:	83 ec 08             	sub    $0x8,%esp
     280:	68 36 3e 00 00       	push   $0x3e36
     285:	ff 35 50 5e 00 00    	pushl  0x5e50
     28b:	e8 c0 37 00 00       	call   3a50 <printf>
}
     290:	83 c4 10             	add    $0x10,%esp
     293:	c9                   	leave  
     294:	c3                   	ret    
     295:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     298:	83 ec 08             	sub    $0x8,%esp
     29b:	68 e7 3d 00 00       	push   $0x3de7
     2a0:	ff 35 50 5e 00 00    	pushl  0x5e50
     2a6:	e8 a5 37 00 00       	call   3a50 <printf>
      exit();
     2ab:	e8 23 36 00 00       	call   38d3 <exit>
    printf(stdout, "fork failed\n");
     2b0:	51                   	push   %ecx
     2b1:	51                   	push   %ecx
     2b2:	68 f9 4c 00 00       	push   $0x4cf9
     2b7:	ff 35 50 5e 00 00    	pushl  0x5e50
     2bd:	e8 8e 37 00 00       	call   3a50 <printf>
    exit();
     2c2:	e8 0c 36 00 00       	call   38d3 <exit>
      printf(stdout, "mkdir failed\n");
     2c7:	52                   	push   %edx
     2c8:	52                   	push   %edx
     2c9:	68 b8 3d 00 00       	push   $0x3db8
     2ce:	ff 35 50 5e 00 00    	pushl  0x5e50
     2d4:	e8 77 37 00 00       	call   3a50 <printf>
      exit();
     2d9:	e8 f5 35 00 00       	call   38d3 <exit>
      printf(stdout, "child chdir failed\n");
     2de:	50                   	push   %eax
     2df:	50                   	push   %eax
     2e0:	68 22 3e 00 00       	push   $0x3e22
     2e5:	ff 35 50 5e 00 00    	pushl  0x5e50
     2eb:	e8 60 37 00 00       	call   3a50 <printf>
      exit();
     2f0:	e8 de 35 00 00       	call   38d3 <exit>
     2f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <openiputtest>:
{
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     306:	68 48 3e 00 00       	push   $0x3e48
     30b:	ff 35 50 5e 00 00    	pushl  0x5e50
     311:	e8 3a 37 00 00       	call   3a50 <printf>
  if(mkdir("oidir") < 0){
     316:	c7 04 24 57 3e 00 00 	movl   $0x3e57,(%esp)
     31d:	e8 19 36 00 00       	call   393b <mkdir>
     322:	83 c4 10             	add    $0x10,%esp
     325:	85 c0                	test   %eax,%eax
     327:	0f 88 9f 00 00 00    	js     3cc <openiputtest+0xcc>
  pid = fork();
     32d:	e8 99 35 00 00       	call   38cb <fork>
  if(pid < 0){
     332:	85 c0                	test   %eax,%eax
     334:	78 7f                	js     3b5 <openiputtest+0xb5>
  if(pid == 0){
     336:	75 38                	jne    370 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     338:	83 ec 08             	sub    $0x8,%esp
     33b:	6a 02                	push   $0x2
     33d:	68 57 3e 00 00       	push   $0x3e57
     342:	e8 cc 35 00 00       	call   3913 <open>
    if(fd >= 0){
     347:	83 c4 10             	add    $0x10,%esp
     34a:	85 c0                	test   %eax,%eax
     34c:	78 62                	js     3b0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     34e:	83 ec 08             	sub    $0x8,%esp
     351:	68 dc 4d 00 00       	push   $0x4ddc
     356:	ff 35 50 5e 00 00    	pushl  0x5e50
     35c:	e8 ef 36 00 00       	call   3a50 <printf>
      exit();
     361:	e8 6d 35 00 00       	call   38d3 <exit>
     366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     36d:	8d 76 00             	lea    0x0(%esi),%esi
  sleep(1);
     370:	83 ec 0c             	sub    $0xc,%esp
     373:	6a 01                	push   $0x1
     375:	e8 e9 35 00 00       	call   3963 <sleep>
  if(unlink("oidir") != 0){
     37a:	c7 04 24 57 3e 00 00 	movl   $0x3e57,(%esp)
     381:	e8 9d 35 00 00       	call   3923 <unlink>
     386:	83 c4 10             	add    $0x10,%esp
     389:	85 c0                	test   %eax,%eax
     38b:	75 56                	jne    3e3 <openiputtest+0xe3>
  wait();
     38d:	e8 49 35 00 00       	call   38db <wait>
  printf(stdout, "openiput test ok\n");
     392:	83 ec 08             	sub    $0x8,%esp
     395:	68 80 3e 00 00       	push   $0x3e80
     39a:	ff 35 50 5e 00 00    	pushl  0x5e50
     3a0:	e8 ab 36 00 00       	call   3a50 <printf>
     3a5:	83 c4 10             	add    $0x10,%esp
}
     3a8:	c9                   	leave  
     3a9:	c3                   	ret    
     3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     3b0:	e8 1e 35 00 00       	call   38d3 <exit>
    printf(stdout, "fork failed\n");
     3b5:	52                   	push   %edx
     3b6:	52                   	push   %edx
     3b7:	68 f9 4c 00 00       	push   $0x4cf9
     3bc:	ff 35 50 5e 00 00    	pushl  0x5e50
     3c2:	e8 89 36 00 00       	call   3a50 <printf>
    exit();
     3c7:	e8 07 35 00 00       	call   38d3 <exit>
    printf(stdout, "mkdir oidir failed\n");
     3cc:	51                   	push   %ecx
     3cd:	51                   	push   %ecx
     3ce:	68 5d 3e 00 00       	push   $0x3e5d
     3d3:	ff 35 50 5e 00 00    	pushl  0x5e50
     3d9:	e8 72 36 00 00       	call   3a50 <printf>
    exit();
     3de:	e8 f0 34 00 00       	call   38d3 <exit>
    printf(stdout, "unlink failed\n");
     3e3:	50                   	push   %eax
     3e4:	50                   	push   %eax
     3e5:	68 71 3e 00 00       	push   $0x3e71
     3ea:	ff 35 50 5e 00 00    	pushl  0x5e50
     3f0:	e8 5b 36 00 00       	call   3a50 <printf>
    exit();
     3f5:	e8 d9 34 00 00       	call   38d3 <exit>
     3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <opentest>:
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     406:	68 92 3e 00 00       	push   $0x3e92
     40b:	ff 35 50 5e 00 00    	pushl  0x5e50
     411:	e8 3a 36 00 00       	call   3a50 <printf>
  fd = open("echo", 0);
     416:	58                   	pop    %eax
     417:	5a                   	pop    %edx
     418:	6a 00                	push   $0x0
     41a:	68 9d 3e 00 00       	push   $0x3e9d
     41f:	e8 ef 34 00 00       	call   3913 <open>
  if(fd < 0){
     424:	83 c4 10             	add    $0x10,%esp
     427:	85 c0                	test   %eax,%eax
     429:	78 36                	js     461 <opentest+0x61>
  close(fd);
     42b:	83 ec 0c             	sub    $0xc,%esp
     42e:	50                   	push   %eax
     42f:	e8 c7 34 00 00       	call   38fb <close>
  fd = open("doesnotexist", 0);
     434:	5a                   	pop    %edx
     435:	59                   	pop    %ecx
     436:	6a 00                	push   $0x0
     438:	68 b5 3e 00 00       	push   $0x3eb5
     43d:	e8 d1 34 00 00       	call   3913 <open>
  if(fd >= 0){
     442:	83 c4 10             	add    $0x10,%esp
     445:	85 c0                	test   %eax,%eax
     447:	79 2f                	jns    478 <opentest+0x78>
  printf(stdout, "open test ok\n");
     449:	83 ec 08             	sub    $0x8,%esp
     44c:	68 e0 3e 00 00       	push   $0x3ee0
     451:	ff 35 50 5e 00 00    	pushl  0x5e50
     457:	e8 f4 35 00 00       	call   3a50 <printf>
}
     45c:	83 c4 10             	add    $0x10,%esp
     45f:	c9                   	leave  
     460:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     461:	50                   	push   %eax
     462:	50                   	push   %eax
     463:	68 a2 3e 00 00       	push   $0x3ea2
     468:	ff 35 50 5e 00 00    	pushl  0x5e50
     46e:	e8 dd 35 00 00       	call   3a50 <printf>
    exit();
     473:	e8 5b 34 00 00       	call   38d3 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     478:	50                   	push   %eax
     479:	50                   	push   %eax
     47a:	68 c2 3e 00 00       	push   $0x3ec2
     47f:	ff 35 50 5e 00 00    	pushl  0x5e50
     485:	e8 c6 35 00 00       	call   3a50 <printf>
    exit();
     48a:	e8 44 34 00 00       	call   38d3 <exit>
     48f:	90                   	nop

00000490 <writetest>:
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     495:	83 ec 08             	sub    $0x8,%esp
     498:	68 ee 3e 00 00       	push   $0x3eee
     49d:	ff 35 50 5e 00 00    	pushl  0x5e50
     4a3:	e8 a8 35 00 00       	call   3a50 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     4a8:	58                   	pop    %eax
     4a9:	5a                   	pop    %edx
     4aa:	68 02 02 00 00       	push   $0x202
     4af:	68 ff 3e 00 00       	push   $0x3eff
     4b4:	e8 5a 34 00 00       	call   3913 <open>
  if(fd >= 0){
     4b9:	83 c4 10             	add    $0x10,%esp
     4bc:	85 c0                	test   %eax,%eax
     4be:	0f 88 88 01 00 00    	js     64c <writetest+0x1bc>
    printf(stdout, "creat small succeeded; ok\n");
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     4c9:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     4cb:	68 05 3f 00 00       	push   $0x3f05
     4d0:	ff 35 50 5e 00 00    	pushl  0x5e50
     4d6:	e8 75 35 00 00       	call   3a50 <printf>
     4db:	83 c4 10             	add    $0x10,%esp
     4de:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4e0:	83 ec 04             	sub    $0x4,%esp
     4e3:	6a 0a                	push   $0xa
     4e5:	68 3c 3f 00 00       	push   $0x3f3c
     4ea:	56                   	push   %esi
     4eb:	e8 03 34 00 00       	call   38f3 <write>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	83 f8 0a             	cmp    $0xa,%eax
     4f6:	0f 85 d9 00 00 00    	jne    5d5 <writetest+0x145>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4fc:	83 ec 04             	sub    $0x4,%esp
     4ff:	6a 0a                	push   $0xa
     501:	68 47 3f 00 00       	push   $0x3f47
     506:	56                   	push   %esi
     507:	e8 e7 33 00 00       	call   38f3 <write>
     50c:	83 c4 10             	add    $0x10,%esp
     50f:	83 f8 0a             	cmp    $0xa,%eax
     512:	0f 85 d6 00 00 00    	jne    5ee <writetest+0x15e>
  for(i = 0; i < 100; i++){
     518:	83 c3 01             	add    $0x1,%ebx
     51b:	83 fb 64             	cmp    $0x64,%ebx
     51e:	75 c0                	jne    4e0 <writetest+0x50>
  printf(stdout, "writes ok\n");
     520:	83 ec 08             	sub    $0x8,%esp
     523:	68 52 3f 00 00       	push   $0x3f52
     528:	ff 35 50 5e 00 00    	pushl  0x5e50
     52e:	e8 1d 35 00 00       	call   3a50 <printf>
  close(fd);
     533:	89 34 24             	mov    %esi,(%esp)
     536:	e8 c0 33 00 00       	call   38fb <close>
  fd = open("small", O_RDONLY);
     53b:	5b                   	pop    %ebx
     53c:	5e                   	pop    %esi
     53d:	6a 00                	push   $0x0
     53f:	68 ff 3e 00 00       	push   $0x3eff
     544:	e8 ca 33 00 00       	call   3913 <open>
  if(fd >= 0){
     549:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     54c:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     54e:	85 c0                	test   %eax,%eax
     550:	0f 88 b1 00 00 00    	js     607 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     556:	83 ec 08             	sub    $0x8,%esp
     559:	68 5d 3f 00 00       	push   $0x3f5d
     55e:	ff 35 50 5e 00 00    	pushl  0x5e50
     564:	e8 e7 34 00 00       	call   3a50 <printf>
  i = read(fd, buf, 2000);
     569:	83 c4 0c             	add    $0xc,%esp
     56c:	68 d0 07 00 00       	push   $0x7d0
     571:	68 40 86 00 00       	push   $0x8640
     576:	53                   	push   %ebx
     577:	e8 6f 33 00 00       	call   38eb <read>
  if(i == 2000){
     57c:	83 c4 10             	add    $0x10,%esp
     57f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     584:	0f 85 94 00 00 00    	jne    61e <writetest+0x18e>
    printf(stdout, "read succeeded ok\n");
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 91 3f 00 00       	push   $0x3f91
     592:	ff 35 50 5e 00 00    	pushl  0x5e50
     598:	e8 b3 34 00 00       	call   3a50 <printf>
  close(fd);
     59d:	89 1c 24             	mov    %ebx,(%esp)
     5a0:	e8 56 33 00 00       	call   38fb <close>
  if(unlink("small") < 0){
     5a5:	c7 04 24 ff 3e 00 00 	movl   $0x3eff,(%esp)
     5ac:	e8 72 33 00 00       	call   3923 <unlink>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	85 c0                	test   %eax,%eax
     5b6:	78 7d                	js     635 <writetest+0x1a5>
  printf(stdout, "small file test ok\n");
     5b8:	83 ec 08             	sub    $0x8,%esp
     5bb:	68 b9 3f 00 00       	push   $0x3fb9
     5c0:	ff 35 50 5e 00 00    	pushl  0x5e50
     5c6:	e8 85 34 00 00       	call   3a50 <printf>
}
     5cb:	83 c4 10             	add    $0x10,%esp
     5ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5d1:	5b                   	pop    %ebx
     5d2:	5e                   	pop    %esi
     5d3:	5d                   	pop    %ebp
     5d4:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5d5:	83 ec 04             	sub    $0x4,%esp
     5d8:	53                   	push   %ebx
     5d9:	68 00 4e 00 00       	push   $0x4e00
     5de:	ff 35 50 5e 00 00    	pushl  0x5e50
     5e4:	e8 67 34 00 00       	call   3a50 <printf>
      exit();
     5e9:	e8 e5 32 00 00       	call   38d3 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5ee:	83 ec 04             	sub    $0x4,%esp
     5f1:	53                   	push   %ebx
     5f2:	68 24 4e 00 00       	push   $0x4e24
     5f7:	ff 35 50 5e 00 00    	pushl  0x5e50
     5fd:	e8 4e 34 00 00       	call   3a50 <printf>
      exit();
     602:	e8 cc 32 00 00       	call   38d3 <exit>
    printf(stdout, "error: open small failed!\n");
     607:	51                   	push   %ecx
     608:	51                   	push   %ecx
     609:	68 76 3f 00 00       	push   $0x3f76
     60e:	ff 35 50 5e 00 00    	pushl  0x5e50
     614:	e8 37 34 00 00       	call   3a50 <printf>
    exit();
     619:	e8 b5 32 00 00       	call   38d3 <exit>
    printf(stdout, "read failed\n");
     61e:	52                   	push   %edx
     61f:	52                   	push   %edx
     620:	68 bd 42 00 00       	push   $0x42bd
     625:	ff 35 50 5e 00 00    	pushl  0x5e50
     62b:	e8 20 34 00 00       	call   3a50 <printf>
    exit();
     630:	e8 9e 32 00 00       	call   38d3 <exit>
    printf(stdout, "unlink small failed\n");
     635:	50                   	push   %eax
     636:	50                   	push   %eax
     637:	68 a4 3f 00 00       	push   $0x3fa4
     63c:	ff 35 50 5e 00 00    	pushl  0x5e50
     642:	e8 09 34 00 00       	call   3a50 <printf>
    exit();
     647:	e8 87 32 00 00       	call   38d3 <exit>
    printf(stdout, "error: creat small failed!\n");
     64c:	50                   	push   %eax
     64d:	50                   	push   %eax
     64e:	68 20 3f 00 00       	push   $0x3f20
     653:	ff 35 50 5e 00 00    	pushl  0x5e50
     659:	e8 f2 33 00 00       	call   3a50 <printf>
    exit();
     65e:	e8 70 32 00 00       	call   38d3 <exit>
     663:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000670 <writetest1>:
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	56                   	push   %esi
     674:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     675:	83 ec 08             	sub    $0x8,%esp
     678:	68 cd 3f 00 00       	push   $0x3fcd
     67d:	ff 35 50 5e 00 00    	pushl  0x5e50
     683:	e8 c8 33 00 00       	call   3a50 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     688:	58                   	pop    %eax
     689:	5a                   	pop    %edx
     68a:	68 02 02 00 00       	push   $0x202
     68f:	68 47 40 00 00       	push   $0x4047
     694:	e8 7a 32 00 00       	call   3913 <open>
  if(fd < 0){
     699:	83 c4 10             	add    $0x10,%esp
     69c:	85 c0                	test   %eax,%eax
     69e:	0f 88 61 01 00 00    	js     805 <writetest1+0x195>
     6a4:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     6a6:	31 db                	xor    %ebx,%ebx
     6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6af:	90                   	nop
    if(write(fd, buf, 512) != 512){
     6b0:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
     6b3:	89 1d 40 86 00 00    	mov    %ebx,0x8640
    if(write(fd, buf, 512) != 512){
     6b9:	68 00 02 00 00       	push   $0x200
     6be:	68 40 86 00 00       	push   $0x8640
     6c3:	56                   	push   %esi
     6c4:	e8 2a 32 00 00       	call   38f3 <write>
     6c9:	83 c4 10             	add    $0x10,%esp
     6cc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6d1:	0f 85 b3 00 00 00    	jne    78a <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     6d7:	83 c3 01             	add    $0x1,%ebx
     6da:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6e0:	75 ce                	jne    6b0 <writetest1+0x40>
  close(fd);
     6e2:	83 ec 0c             	sub    $0xc,%esp
     6e5:	56                   	push   %esi
     6e6:	e8 10 32 00 00       	call   38fb <close>
  fd = open("big", O_RDONLY);
     6eb:	5b                   	pop    %ebx
     6ec:	5e                   	pop    %esi
     6ed:	6a 00                	push   $0x0
     6ef:	68 47 40 00 00       	push   $0x4047
     6f4:	e8 1a 32 00 00       	call   3913 <open>
  if(fd < 0){
     6f9:	83 c4 10             	add    $0x10,%esp
  fd = open("big", O_RDONLY);
     6fc:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
     6fe:	85 c0                	test   %eax,%eax
     700:	0f 88 e8 00 00 00    	js     7ee <writetest1+0x17e>
  n = 0;
     706:	31 f6                	xor    %esi,%esi
     708:	eb 1d                	jmp    727 <writetest1+0xb7>
     70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     710:	3d 00 02 00 00       	cmp    $0x200,%eax
     715:	0f 85 9f 00 00 00    	jne    7ba <writetest1+0x14a>
    if(((int*)buf)[0] != n){
     71b:	a1 40 86 00 00       	mov    0x8640,%eax
     720:	39 f0                	cmp    %esi,%eax
     722:	75 7f                	jne    7a3 <writetest1+0x133>
    n++;
     724:	83 c6 01             	add    $0x1,%esi
    i = read(fd, buf, 512);
     727:	83 ec 04             	sub    $0x4,%esp
     72a:	68 00 02 00 00       	push   $0x200
     72f:	68 40 86 00 00       	push   $0x8640
     734:	53                   	push   %ebx
     735:	e8 b1 31 00 00       	call   38eb <read>
    if(i == 0){
     73a:	83 c4 10             	add    $0x10,%esp
     73d:	85 c0                	test   %eax,%eax
     73f:	75 cf                	jne    710 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     741:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
     747:	0f 84 86 00 00 00    	je     7d3 <writetest1+0x163>
  close(fd);
     74d:	83 ec 0c             	sub    $0xc,%esp
     750:	53                   	push   %ebx
     751:	e8 a5 31 00 00       	call   38fb <close>
  if(unlink("big") < 0){
     756:	c7 04 24 47 40 00 00 	movl   $0x4047,(%esp)
     75d:	e8 c1 31 00 00       	call   3923 <unlink>
     762:	83 c4 10             	add    $0x10,%esp
     765:	85 c0                	test   %eax,%eax
     767:	0f 88 af 00 00 00    	js     81c <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     76d:	83 ec 08             	sub    $0x8,%esp
     770:	68 6e 40 00 00       	push   $0x406e
     775:	ff 35 50 5e 00 00    	pushl  0x5e50
     77b:	e8 d0 32 00 00       	call   3a50 <printf>
}
     780:	83 c4 10             	add    $0x10,%esp
     783:	8d 65 f8             	lea    -0x8(%ebp),%esp
     786:	5b                   	pop    %ebx
     787:	5e                   	pop    %esi
     788:	5d                   	pop    %ebp
     789:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     78a:	83 ec 04             	sub    $0x4,%esp
     78d:	53                   	push   %ebx
     78e:	68 f7 3f 00 00       	push   $0x3ff7
     793:	ff 35 50 5e 00 00    	pushl  0x5e50
     799:	e8 b2 32 00 00       	call   3a50 <printf>
      exit();
     79e:	e8 30 31 00 00       	call   38d3 <exit>
      printf(stdout, "read content of block %d is %d\n",
     7a3:	50                   	push   %eax
     7a4:	56                   	push   %esi
     7a5:	68 48 4e 00 00       	push   $0x4e48
     7aa:	ff 35 50 5e 00 00    	pushl  0x5e50
     7b0:	e8 9b 32 00 00       	call   3a50 <printf>
      exit();
     7b5:	e8 19 31 00 00       	call   38d3 <exit>
      printf(stdout, "read failed %d\n", i);
     7ba:	83 ec 04             	sub    $0x4,%esp
     7bd:	50                   	push   %eax
     7be:	68 4b 40 00 00       	push   $0x404b
     7c3:	ff 35 50 5e 00 00    	pushl  0x5e50
     7c9:	e8 82 32 00 00       	call   3a50 <printf>
      exit();
     7ce:	e8 00 31 00 00       	call   38d3 <exit>
        printf(stdout, "read only %d blocks from big", n);
     7d3:	52                   	push   %edx
     7d4:	68 8b 00 00 00       	push   $0x8b
     7d9:	68 2e 40 00 00       	push   $0x402e
     7de:	ff 35 50 5e 00 00    	pushl  0x5e50
     7e4:	e8 67 32 00 00       	call   3a50 <printf>
        exit();
     7e9:	e8 e5 30 00 00       	call   38d3 <exit>
    printf(stdout, "error: open big failed!\n");
     7ee:	51                   	push   %ecx
     7ef:	51                   	push   %ecx
     7f0:	68 15 40 00 00       	push   $0x4015
     7f5:	ff 35 50 5e 00 00    	pushl  0x5e50
     7fb:	e8 50 32 00 00       	call   3a50 <printf>
    exit();
     800:	e8 ce 30 00 00       	call   38d3 <exit>
    printf(stdout, "error: creat big failed!\n");
     805:	50                   	push   %eax
     806:	50                   	push   %eax
     807:	68 dd 3f 00 00       	push   $0x3fdd
     80c:	ff 35 50 5e 00 00    	pushl  0x5e50
     812:	e8 39 32 00 00       	call   3a50 <printf>
    exit();
     817:	e8 b7 30 00 00       	call   38d3 <exit>
    printf(stdout, "unlink big failed\n");
     81c:	50                   	push   %eax
     81d:	50                   	push   %eax
     81e:	68 5b 40 00 00       	push   $0x405b
     823:	ff 35 50 5e 00 00    	pushl  0x5e50
     829:	e8 22 32 00 00       	call   3a50 <printf>
    exit();
     82e:	e8 a0 30 00 00       	call   38d3 <exit>
     833:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000840 <createtest>:
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	53                   	push   %ebx
  name[2] = '\0';
     844:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     849:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     84c:	68 68 4e 00 00       	push   $0x4e68
     851:	ff 35 50 5e 00 00    	pushl  0x5e50
     857:	e8 f4 31 00 00       	call   3a50 <printf>
  name[0] = 'a';
     85c:	c6 05 40 a6 00 00 61 	movb   $0x61,0xa640
  name[2] = '\0';
     863:	83 c4 10             	add    $0x10,%esp
     866:	c6 05 42 a6 00 00 00 	movb   $0x0,0xa642
  for(i = 0; i < 52; i++){
     86d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     870:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     873:	88 1d 41 a6 00 00    	mov    %bl,0xa641
    fd = open(name, O_CREATE|O_RDWR);
     879:	83 c3 01             	add    $0x1,%ebx
     87c:	68 02 02 00 00       	push   $0x202
     881:	68 40 a6 00 00       	push   $0xa640
     886:	e8 88 30 00 00       	call   3913 <open>
    close(fd);
     88b:	89 04 24             	mov    %eax,(%esp)
     88e:	e8 68 30 00 00       	call   38fb <close>
  for(i = 0; i < 52; i++){
     893:	83 c4 10             	add    $0x10,%esp
     896:	80 fb 64             	cmp    $0x64,%bl
     899:	75 d5                	jne    870 <createtest+0x30>
  name[0] = 'a';
     89b:	c6 05 40 a6 00 00 61 	movb   $0x61,0xa640
  name[2] = '\0';
     8a2:	bb 30 00 00 00       	mov    $0x30,%ebx
     8a7:	c6 05 42 a6 00 00 00 	movb   $0x0,0xa642
  for(i = 0; i < 52; i++){
     8ae:	66 90                	xchg   %ax,%ax
    unlink(name);
     8b0:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
     8b3:	88 1d 41 a6 00 00    	mov    %bl,0xa641
    unlink(name);
     8b9:	83 c3 01             	add    $0x1,%ebx
     8bc:	68 40 a6 00 00       	push   $0xa640
     8c1:	e8 5d 30 00 00       	call   3923 <unlink>
  for(i = 0; i < 52; i++){
     8c6:	83 c4 10             	add    $0x10,%esp
     8c9:	80 fb 64             	cmp    $0x64,%bl
     8cc:	75 e2                	jne    8b0 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8ce:	83 ec 08             	sub    $0x8,%esp
     8d1:	68 90 4e 00 00       	push   $0x4e90
     8d6:	ff 35 50 5e 00 00    	pushl  0x5e50
     8dc:	e8 6f 31 00 00       	call   3a50 <printf>
}
     8e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8e4:	83 c4 10             	add    $0x10,%esp
     8e7:	c9                   	leave  
     8e8:	c3                   	ret    
     8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008f0 <dirtest>:
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     8f6:	68 7c 40 00 00       	push   $0x407c
     8fb:	ff 35 50 5e 00 00    	pushl  0x5e50
     901:	e8 4a 31 00 00       	call   3a50 <printf>
  if(mkdir("dir0") < 0){
     906:	c7 04 24 88 40 00 00 	movl   $0x4088,(%esp)
     90d:	e8 29 30 00 00       	call   393b <mkdir>
     912:	83 c4 10             	add    $0x10,%esp
     915:	85 c0                	test   %eax,%eax
     917:	78 58                	js     971 <dirtest+0x81>
  if(chdir("dir0") < 0){
     919:	83 ec 0c             	sub    $0xc,%esp
     91c:	68 88 40 00 00       	push   $0x4088
     921:	e8 1d 30 00 00       	call   3943 <chdir>
     926:	83 c4 10             	add    $0x10,%esp
     929:	85 c0                	test   %eax,%eax
     92b:	0f 88 85 00 00 00    	js     9b6 <dirtest+0xc6>
  if(chdir("..") < 0){
     931:	83 ec 0c             	sub    $0xc,%esp
     934:	68 2d 46 00 00       	push   $0x462d
     939:	e8 05 30 00 00       	call   3943 <chdir>
     93e:	83 c4 10             	add    $0x10,%esp
     941:	85 c0                	test   %eax,%eax
     943:	78 5a                	js     99f <dirtest+0xaf>
  if(unlink("dir0") < 0){
     945:	83 ec 0c             	sub    $0xc,%esp
     948:	68 88 40 00 00       	push   $0x4088
     94d:	e8 d1 2f 00 00       	call   3923 <unlink>
     952:	83 c4 10             	add    $0x10,%esp
     955:	85 c0                	test   %eax,%eax
     957:	78 2f                	js     988 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     959:	83 ec 08             	sub    $0x8,%esp
     95c:	68 c5 40 00 00       	push   $0x40c5
     961:	ff 35 50 5e 00 00    	pushl  0x5e50
     967:	e8 e4 30 00 00       	call   3a50 <printf>
}
     96c:	83 c4 10             	add    $0x10,%esp
     96f:	c9                   	leave  
     970:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     971:	50                   	push   %eax
     972:	50                   	push   %eax
     973:	68 b8 3d 00 00       	push   $0x3db8
     978:	ff 35 50 5e 00 00    	pushl  0x5e50
     97e:	e8 cd 30 00 00       	call   3a50 <printf>
    exit();
     983:	e8 4b 2f 00 00       	call   38d3 <exit>
    printf(stdout, "unlink dir0 failed\n");
     988:	50                   	push   %eax
     989:	50                   	push   %eax
     98a:	68 b1 40 00 00       	push   $0x40b1
     98f:	ff 35 50 5e 00 00    	pushl  0x5e50
     995:	e8 b6 30 00 00       	call   3a50 <printf>
    exit();
     99a:	e8 34 2f 00 00       	call   38d3 <exit>
    printf(stdout, "chdir .. failed\n");
     99f:	52                   	push   %edx
     9a0:	52                   	push   %edx
     9a1:	68 a0 40 00 00       	push   $0x40a0
     9a6:	ff 35 50 5e 00 00    	pushl  0x5e50
     9ac:	e8 9f 30 00 00       	call   3a50 <printf>
    exit();
     9b1:	e8 1d 2f 00 00       	call   38d3 <exit>
    printf(stdout, "chdir dir0 failed\n");
     9b6:	51                   	push   %ecx
     9b7:	51                   	push   %ecx
     9b8:	68 8d 40 00 00       	push   $0x408d
     9bd:	ff 35 50 5e 00 00    	pushl  0x5e50
     9c3:	e8 88 30 00 00       	call   3a50 <printf>
    exit();
     9c8:	e8 06 2f 00 00       	call   38d3 <exit>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi

000009d0 <exectest>:
{
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     9d6:	68 d4 40 00 00       	push   $0x40d4
     9db:	ff 35 50 5e 00 00    	pushl  0x5e50
     9e1:	e8 6a 30 00 00       	call   3a50 <printf>
  if(exec("echo", echoargv) < 0){
     9e6:	5a                   	pop    %edx
     9e7:	59                   	pop    %ecx
     9e8:	68 54 5e 00 00       	push   $0x5e54
     9ed:	68 9d 3e 00 00       	push   $0x3e9d
     9f2:	e8 14 2f 00 00       	call   390b <exec>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	85 c0                	test   %eax,%eax
     9fc:	78 02                	js     a00 <exectest+0x30>
}
     9fe:	c9                   	leave  
     9ff:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     a00:	50                   	push   %eax
     a01:	50                   	push   %eax
     a02:	68 df 40 00 00       	push   $0x40df
     a07:	ff 35 50 5e 00 00    	pushl  0x5e50
     a0d:	e8 3e 30 00 00       	call   3a50 <printf>
    exit();
     a12:	e8 bc 2e 00 00       	call   38d3 <exit>
     a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a1e:	66 90                	xchg   %ax,%ax

00000a20 <pipe1>:
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
  if(pipe(fds) != 0){
     a25:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
     a28:	53                   	push   %ebx
     a29:	83 ec 38             	sub    $0x38,%esp
  if(pipe(fds) != 0){
     a2c:	50                   	push   %eax
     a2d:	e8 b1 2e 00 00       	call   38e3 <pipe>
     a32:	83 c4 10             	add    $0x10,%esp
     a35:	85 c0                	test   %eax,%eax
     a37:	0f 85 34 01 00 00    	jne    b71 <pipe1+0x151>
  pid = fork();
     a3d:	e8 89 2e 00 00       	call   38cb <fork>
  if(pid == 0){
     a42:	85 c0                	test   %eax,%eax
     a44:	0f 84 89 00 00 00    	je     ad3 <pipe1+0xb3>
  } else if(pid > 0){
     a4a:	0f 8e 34 01 00 00    	jle    b84 <pipe1+0x164>
    close(fds[1]);
     a50:	83 ec 0c             	sub    $0xc,%esp
     a53:	ff 75 e4             	pushl  -0x1c(%ebp)
  seq = 0;
     a56:	31 db                	xor    %ebx,%ebx
    cc = 1;
     a58:	be 01 00 00 00       	mov    $0x1,%esi
    close(fds[1]);
     a5d:	e8 99 2e 00 00       	call   38fb <close>
    total = 0;
     a62:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a69:	83 c4 10             	add    $0x10,%esp
     a6c:	83 ec 04             	sub    $0x4,%esp
     a6f:	56                   	push   %esi
     a70:	68 40 86 00 00       	push   $0x8640
     a75:	ff 75 e0             	pushl  -0x20(%ebp)
     a78:	e8 6e 2e 00 00       	call   38eb <read>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	89 c7                	mov    %eax,%edi
     a82:	85 c0                	test   %eax,%eax
     a84:	0f 8e a3 00 00 00    	jle    b2d <pipe1+0x10d>
     a8a:	8d 0c 3b             	lea    (%ebx,%edi,1),%ecx
      for(i = 0; i < n; i++){
     a8d:	31 c0                	xor    %eax,%eax
     a8f:	90                   	nop
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a90:	89 da                	mov    %ebx,%edx
     a92:	83 c3 01             	add    $0x1,%ebx
     a95:	38 90 40 86 00 00    	cmp    %dl,0x8640(%eax)
     a9b:	75 1c                	jne    ab9 <pipe1+0x99>
      for(i = 0; i < n; i++){
     a9d:	83 c0 01             	add    $0x1,%eax
     aa0:	39 d9                	cmp    %ebx,%ecx
     aa2:	75 ec                	jne    a90 <pipe1+0x70>
      cc = cc * 2;
     aa4:	01 f6                	add    %esi,%esi
      total += n;
     aa6:	01 7d d4             	add    %edi,-0x2c(%ebp)
     aa9:	b8 00 20 00 00       	mov    $0x2000,%eax
     aae:	81 fe 00 20 00 00    	cmp    $0x2000,%esi
     ab4:	0f 4f f0             	cmovg  %eax,%esi
     ab7:	eb b3                	jmp    a6c <pipe1+0x4c>
          printf(1, "pipe1 oops 2\n");
     ab9:	83 ec 08             	sub    $0x8,%esp
     abc:	68 0e 41 00 00       	push   $0x410e
     ac1:	6a 01                	push   $0x1
     ac3:	e8 88 2f 00 00       	call   3a50 <printf>
          return;
     ac8:	83 c4 10             	add    $0x10,%esp
}
     acb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ace:	5b                   	pop    %ebx
     acf:	5e                   	pop    %esi
     ad0:	5f                   	pop    %edi
     ad1:	5d                   	pop    %ebp
     ad2:	c3                   	ret    
    close(fds[0]);
     ad3:	83 ec 0c             	sub    $0xc,%esp
     ad6:	ff 75 e0             	pushl  -0x20(%ebp)
  seq = 0;
     ad9:	31 db                	xor    %ebx,%ebx
    close(fds[0]);
     adb:	e8 1b 2e 00 00       	call   38fb <close>
     ae0:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 1033; i++)
     ae3:	31 c0                	xor    %eax,%eax
     ae5:	8d 76 00             	lea    0x0(%esi),%esi
        buf[i] = seq++;
     ae8:	8d 14 18             	lea    (%eax,%ebx,1),%edx
      for(i = 0; i < 1033; i++)
     aeb:	83 c0 01             	add    $0x1,%eax
        buf[i] = seq++;
     aee:	88 90 3f 86 00 00    	mov    %dl,0x863f(%eax)
      for(i = 0; i < 1033; i++)
     af4:	3d 09 04 00 00       	cmp    $0x409,%eax
     af9:	75 ed                	jne    ae8 <pipe1+0xc8>
      if(write(fds[1], buf, 1033) != 1033){
     afb:	83 ec 04             	sub    $0x4,%esp
     afe:	81 c3 09 04 00 00    	add    $0x409,%ebx
     b04:	68 09 04 00 00       	push   $0x409
     b09:	68 40 86 00 00       	push   $0x8640
     b0e:	ff 75 e4             	pushl  -0x1c(%ebp)
     b11:	e8 dd 2d 00 00       	call   38f3 <write>
     b16:	83 c4 10             	add    $0x10,%esp
     b19:	3d 09 04 00 00       	cmp    $0x409,%eax
     b1e:	75 77                	jne    b97 <pipe1+0x177>
    for(n = 0; n < 5; n++){
     b20:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b26:	75 bb                	jne    ae3 <pipe1+0xc3>
    exit();
     b28:	e8 a6 2d 00 00       	call   38d3 <exit>
    if(total != 5 * 1033){
     b2d:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b34:	75 26                	jne    b5c <pipe1+0x13c>
    close(fds[0]);
     b36:	83 ec 0c             	sub    $0xc,%esp
     b39:	ff 75 e0             	pushl  -0x20(%ebp)
     b3c:	e8 ba 2d 00 00       	call   38fb <close>
    wait();
     b41:	e8 95 2d 00 00       	call   38db <wait>
  printf(1, "pipe1 ok\n");
     b46:	5a                   	pop    %edx
     b47:	59                   	pop    %ecx
     b48:	68 33 41 00 00       	push   $0x4133
     b4d:	6a 01                	push   $0x1
     b4f:	e8 fc 2e 00 00       	call   3a50 <printf>
     b54:	83 c4 10             	add    $0x10,%esp
     b57:	e9 6f ff ff ff       	jmp    acb <pipe1+0xab>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b5c:	53                   	push   %ebx
     b5d:	ff 75 d4             	pushl  -0x2c(%ebp)
     b60:	68 1c 41 00 00       	push   $0x411c
     b65:	6a 01                	push   $0x1
     b67:	e8 e4 2e 00 00       	call   3a50 <printf>
      exit();
     b6c:	e8 62 2d 00 00       	call   38d3 <exit>
    printf(1, "pipe() failed\n");
     b71:	57                   	push   %edi
     b72:	57                   	push   %edi
     b73:	68 f1 40 00 00       	push   $0x40f1
     b78:	6a 01                	push   $0x1
     b7a:	e8 d1 2e 00 00       	call   3a50 <printf>
    exit();
     b7f:	e8 4f 2d 00 00       	call   38d3 <exit>
    printf(1, "fork() failed\n");
     b84:	50                   	push   %eax
     b85:	50                   	push   %eax
     b86:	68 3d 41 00 00       	push   $0x413d
     b8b:	6a 01                	push   $0x1
     b8d:	e8 be 2e 00 00       	call   3a50 <printf>
    exit();
     b92:	e8 3c 2d 00 00       	call   38d3 <exit>
        printf(1, "pipe1 oops 1\n");
     b97:	56                   	push   %esi
     b98:	56                   	push   %esi
     b99:	68 00 41 00 00       	push   $0x4100
     b9e:	6a 01                	push   $0x1
     ba0:	e8 ab 2e 00 00       	call   3a50 <printf>
        exit();
     ba5:	e8 29 2d 00 00       	call   38d3 <exit>
     baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000bb0 <preempt>:
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     bb9:	68 4c 41 00 00       	push   $0x414c
     bbe:	6a 01                	push   $0x1
     bc0:	e8 8b 2e 00 00       	call   3a50 <printf>
  pid1 = fork();
     bc5:	e8 01 2d 00 00       	call   38cb <fork>
  if(pid1 == 0)
     bca:	83 c4 10             	add    $0x10,%esp
     bcd:	85 c0                	test   %eax,%eax
     bcf:	75 07                	jne    bd8 <preempt+0x28>
    for(;;)
     bd1:	eb fe                	jmp    bd1 <preempt+0x21>
     bd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bd7:	90                   	nop
     bd8:	89 c7                	mov    %eax,%edi
  pid2 = fork();
     bda:	e8 ec 2c 00 00       	call   38cb <fork>
     bdf:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     be1:	85 c0                	test   %eax,%eax
     be3:	75 0b                	jne    bf0 <preempt+0x40>
    for(;;)
     be5:	eb fe                	jmp    be5 <preempt+0x35>
     be7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bee:	66 90                	xchg   %ax,%ax
  pipe(pfds);
     bf0:	83 ec 0c             	sub    $0xc,%esp
     bf3:	8d 45 e0             	lea    -0x20(%ebp),%eax
     bf6:	50                   	push   %eax
     bf7:	e8 e7 2c 00 00       	call   38e3 <pipe>
  pid3 = fork();
     bfc:	e8 ca 2c 00 00       	call   38cb <fork>
  if(pid3 == 0){
     c01:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     c04:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     c06:	85 c0                	test   %eax,%eax
     c08:	75 3e                	jne    c48 <preempt+0x98>
    close(pfds[0]);
     c0a:	83 ec 0c             	sub    $0xc,%esp
     c0d:	ff 75 e0             	pushl  -0x20(%ebp)
     c10:	e8 e6 2c 00 00       	call   38fb <close>
    if(write(pfds[1], "x", 1) != 1)
     c15:	83 c4 0c             	add    $0xc,%esp
     c18:	6a 01                	push   $0x1
     c1a:	68 11 47 00 00       	push   $0x4711
     c1f:	ff 75 e4             	pushl  -0x1c(%ebp)
     c22:	e8 cc 2c 00 00       	call   38f3 <write>
     c27:	83 c4 10             	add    $0x10,%esp
     c2a:	83 f8 01             	cmp    $0x1,%eax
     c2d:	0f 85 a4 00 00 00    	jne    cd7 <preempt+0x127>
    close(pfds[1]);
     c33:	83 ec 0c             	sub    $0xc,%esp
     c36:	ff 75 e4             	pushl  -0x1c(%ebp)
     c39:	e8 bd 2c 00 00       	call   38fb <close>
     c3e:	83 c4 10             	add    $0x10,%esp
    for(;;)
     c41:	eb fe                	jmp    c41 <preempt+0x91>
     c43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c47:	90                   	nop
  close(pfds[1]);
     c48:	83 ec 0c             	sub    $0xc,%esp
     c4b:	ff 75 e4             	pushl  -0x1c(%ebp)
     c4e:	e8 a8 2c 00 00       	call   38fb <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c53:	83 c4 0c             	add    $0xc,%esp
     c56:	68 00 20 00 00       	push   $0x2000
     c5b:	68 40 86 00 00       	push   $0x8640
     c60:	ff 75 e0             	pushl  -0x20(%ebp)
     c63:	e8 83 2c 00 00       	call   38eb <read>
     c68:	83 c4 10             	add    $0x10,%esp
     c6b:	83 f8 01             	cmp    $0x1,%eax
     c6e:	75 7e                	jne    cee <preempt+0x13e>
  close(pfds[0]);
     c70:	83 ec 0c             	sub    $0xc,%esp
     c73:	ff 75 e0             	pushl  -0x20(%ebp)
     c76:	e8 80 2c 00 00       	call   38fb <close>
  printf(1, "kill... ");
     c7b:	58                   	pop    %eax
     c7c:	5a                   	pop    %edx
     c7d:	68 7d 41 00 00       	push   $0x417d
     c82:	6a 01                	push   $0x1
     c84:	e8 c7 2d 00 00       	call   3a50 <printf>
  kill(pid1);
     c89:	89 3c 24             	mov    %edi,(%esp)
     c8c:	e8 72 2c 00 00       	call   3903 <kill>
  kill(pid2);
     c91:	89 34 24             	mov    %esi,(%esp)
     c94:	e8 6a 2c 00 00       	call   3903 <kill>
  kill(pid3);
     c99:	89 1c 24             	mov    %ebx,(%esp)
     c9c:	e8 62 2c 00 00       	call   3903 <kill>
  printf(1, "wait... ");
     ca1:	59                   	pop    %ecx
     ca2:	5b                   	pop    %ebx
     ca3:	68 86 41 00 00       	push   $0x4186
     ca8:	6a 01                	push   $0x1
     caa:	e8 a1 2d 00 00       	call   3a50 <printf>
  wait();
     caf:	e8 27 2c 00 00       	call   38db <wait>
  wait();
     cb4:	e8 22 2c 00 00       	call   38db <wait>
  wait();
     cb9:	e8 1d 2c 00 00       	call   38db <wait>
  printf(1, "preempt ok\n");
     cbe:	5e                   	pop    %esi
     cbf:	5f                   	pop    %edi
     cc0:	68 8f 41 00 00       	push   $0x418f
     cc5:	6a 01                	push   $0x1
     cc7:	e8 84 2d 00 00       	call   3a50 <printf>
     ccc:	83 c4 10             	add    $0x10,%esp
}
     ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd2:	5b                   	pop    %ebx
     cd3:	5e                   	pop    %esi
     cd4:	5f                   	pop    %edi
     cd5:	5d                   	pop    %ebp
     cd6:	c3                   	ret    
      printf(1, "preempt write error");
     cd7:	83 ec 08             	sub    $0x8,%esp
     cda:	68 56 41 00 00       	push   $0x4156
     cdf:	6a 01                	push   $0x1
     ce1:	e8 6a 2d 00 00       	call   3a50 <printf>
     ce6:	83 c4 10             	add    $0x10,%esp
     ce9:	e9 45 ff ff ff       	jmp    c33 <preempt+0x83>
    printf(1, "preempt read error");
     cee:	83 ec 08             	sub    $0x8,%esp
     cf1:	68 6a 41 00 00       	push   $0x416a
     cf6:	6a 01                	push   $0x1
     cf8:	e8 53 2d 00 00       	call   3a50 <printf>
    return;
     cfd:	83 c4 10             	add    $0x10,%esp
     d00:	eb cd                	jmp    ccf <preempt+0x11f>
     d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d10 <exitwait>:
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	be 64 00 00 00       	mov    $0x64,%esi
     d19:	53                   	push   %ebx
     d1a:	eb 14                	jmp    d30 <exitwait+0x20>
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
     d20:	74 68                	je     d8a <exitwait+0x7a>
      if(wait() != pid){
     d22:	e8 b4 2b 00 00       	call   38db <wait>
     d27:	39 d8                	cmp    %ebx,%eax
     d29:	75 2d                	jne    d58 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     d2b:	83 ee 01             	sub    $0x1,%esi
     d2e:	74 41                	je     d71 <exitwait+0x61>
    pid = fork();
     d30:	e8 96 2b 00 00       	call   38cb <fork>
     d35:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d37:	85 c0                	test   %eax,%eax
     d39:	79 e5                	jns    d20 <exitwait+0x10>
      printf(1, "fork failed\n");
     d3b:	83 ec 08             	sub    $0x8,%esp
     d3e:	68 f9 4c 00 00       	push   $0x4cf9
     d43:	6a 01                	push   $0x1
     d45:	e8 06 2d 00 00       	call   3a50 <printf>
      return;
     d4a:	83 c4 10             	add    $0x10,%esp
}
     d4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d50:	5b                   	pop    %ebx
     d51:	5e                   	pop    %esi
     d52:	5d                   	pop    %ebp
     d53:	c3                   	ret    
     d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 9b 41 00 00       	push   $0x419b
     d60:	6a 01                	push   $0x1
     d62:	e8 e9 2c 00 00       	call   3a50 <printf>
        return;
     d67:	83 c4 10             	add    $0x10,%esp
}
     d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d6d:	5b                   	pop    %ebx
     d6e:	5e                   	pop    %esi
     d6f:	5d                   	pop    %ebp
     d70:	c3                   	ret    
  printf(1, "exitwait ok\n");
     d71:	83 ec 08             	sub    $0x8,%esp
     d74:	68 ab 41 00 00       	push   $0x41ab
     d79:	6a 01                	push   $0x1
     d7b:	e8 d0 2c 00 00       	call   3a50 <printf>
     d80:	83 c4 10             	add    $0x10,%esp
}
     d83:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d86:	5b                   	pop    %ebx
     d87:	5e                   	pop    %esi
     d88:	5d                   	pop    %ebp
     d89:	c3                   	ret    
      exit();
     d8a:	e8 44 2b 00 00       	call   38d3 <exit>
     d8f:	90                   	nop

00000d90 <mem>:
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	56                   	push   %esi
     d94:	31 f6                	xor    %esi,%esi
     d96:	53                   	push   %ebx
  printf(1, "mem test\n");
     d97:	83 ec 08             	sub    $0x8,%esp
     d9a:	68 b8 41 00 00       	push   $0x41b8
     d9f:	6a 01                	push   $0x1
     da1:	e8 aa 2c 00 00       	call   3a50 <printf>
  ppid = getpid();
     da6:	e8 a8 2b 00 00       	call   3953 <getpid>
     dab:	89 c3                	mov    %eax,%ebx
  if((pid = fork()) == 0){
     dad:	e8 19 2b 00 00       	call   38cb <fork>
     db2:	83 c4 10             	add    $0x10,%esp
     db5:	85 c0                	test   %eax,%eax
     db7:	74 0b                	je     dc4 <mem+0x34>
     db9:	e9 8a 00 00 00       	jmp    e48 <mem+0xb8>
     dbe:	66 90                	xchg   %ax,%ax
      *(char**)m2 = m1;
     dc0:	89 30                	mov    %esi,(%eax)
     dc2:	89 c6                	mov    %eax,%esi
    while((m2 = malloc(10001)) != 0){
     dc4:	83 ec 0c             	sub    $0xc,%esp
     dc7:	68 11 27 00 00       	push   $0x2711
     dcc:	e8 df 2e 00 00       	call   3cb0 <malloc>
     dd1:	83 c4 10             	add    $0x10,%esp
     dd4:	85 c0                	test   %eax,%eax
     dd6:	75 e8                	jne    dc0 <mem+0x30>
    while(m1){
     dd8:	85 f6                	test   %esi,%esi
     dda:	74 18                	je     df4 <mem+0x64>
     ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     de0:	89 f0                	mov    %esi,%eax
      free(m1);
     de2:	83 ec 0c             	sub    $0xc,%esp
      m2 = *(char**)m1;
     de5:	8b 36                	mov    (%esi),%esi
      free(m1);
     de7:	50                   	push   %eax
     de8:	e8 33 2e 00 00       	call   3c20 <free>
    while(m1){
     ded:	83 c4 10             	add    $0x10,%esp
     df0:	85 f6                	test   %esi,%esi
     df2:	75 ec                	jne    de0 <mem+0x50>
    m1 = malloc(1024*20);
     df4:	83 ec 0c             	sub    $0xc,%esp
     df7:	68 00 50 00 00       	push   $0x5000
     dfc:	e8 af 2e 00 00       	call   3cb0 <malloc>
    if(m1 == 0){
     e01:	83 c4 10             	add    $0x10,%esp
     e04:	85 c0                	test   %eax,%eax
     e06:	74 20                	je     e28 <mem+0x98>
    free(m1);
     e08:	83 ec 0c             	sub    $0xc,%esp
     e0b:	50                   	push   %eax
     e0c:	e8 0f 2e 00 00       	call   3c20 <free>
    printf(1, "mem ok\n");
     e11:	58                   	pop    %eax
     e12:	5a                   	pop    %edx
     e13:	68 dc 41 00 00       	push   $0x41dc
     e18:	6a 01                	push   $0x1
     e1a:	e8 31 2c 00 00       	call   3a50 <printf>
    exit();
     e1f:	e8 af 2a 00 00       	call   38d3 <exit>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	68 c2 41 00 00       	push   $0x41c2
     e30:	6a 01                	push   $0x1
     e32:	e8 19 2c 00 00       	call   3a50 <printf>
      kill(ppid);
     e37:	89 1c 24             	mov    %ebx,(%esp)
     e3a:	e8 c4 2a 00 00       	call   3903 <kill>
      exit();
     e3f:	e8 8f 2a 00 00       	call   38d3 <exit>
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     e48:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e4b:	5b                   	pop    %ebx
     e4c:	5e                   	pop    %esi
     e4d:	5d                   	pop    %ebp
    wait();
     e4e:	e9 88 2a 00 00       	jmp    38db <wait>
     e53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e60 <sharedfd>:
{
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	57                   	push   %edi
     e64:	56                   	push   %esi
     e65:	53                   	push   %ebx
     e66:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     e69:	68 e4 41 00 00       	push   $0x41e4
     e6e:	6a 01                	push   $0x1
     e70:	e8 db 2b 00 00       	call   3a50 <printf>
  unlink("sharedfd");
     e75:	c7 04 24 f3 41 00 00 	movl   $0x41f3,(%esp)
     e7c:	e8 a2 2a 00 00       	call   3923 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e81:	5b                   	pop    %ebx
     e82:	5e                   	pop    %esi
     e83:	68 02 02 00 00       	push   $0x202
     e88:	68 f3 41 00 00       	push   $0x41f3
     e8d:	e8 81 2a 00 00       	call   3913 <open>
  if(fd < 0){
     e92:	83 c4 10             	add    $0x10,%esp
     e95:	85 c0                	test   %eax,%eax
     e97:	0f 88 2a 01 00 00    	js     fc7 <sharedfd+0x167>
     e9d:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e9f:	8d 75 de             	lea    -0x22(%ebp),%esi
     ea2:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     ea7:	e8 1f 2a 00 00       	call   38cb <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eac:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     eaf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eb2:	19 c0                	sbb    %eax,%eax
     eb4:	83 ec 04             	sub    $0x4,%esp
     eb7:	83 e0 f3             	and    $0xfffffff3,%eax
     eba:	6a 0a                	push   $0xa
     ebc:	83 c0 70             	add    $0x70,%eax
     ebf:	50                   	push   %eax
     ec0:	56                   	push   %esi
     ec1:	e8 6a 28 00 00       	call   3730 <memset>
     ec6:	83 c4 10             	add    $0x10,%esp
     ec9:	eb 0a                	jmp    ed5 <sharedfd+0x75>
     ecb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ecf:	90                   	nop
  for(i = 0; i < 1000; i++){
     ed0:	83 eb 01             	sub    $0x1,%ebx
     ed3:	74 26                	je     efb <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ed5:	83 ec 04             	sub    $0x4,%esp
     ed8:	6a 0a                	push   $0xa
     eda:	56                   	push   %esi
     edb:	57                   	push   %edi
     edc:	e8 12 2a 00 00       	call   38f3 <write>
     ee1:	83 c4 10             	add    $0x10,%esp
     ee4:	83 f8 0a             	cmp    $0xa,%eax
     ee7:	74 e7                	je     ed0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     ee9:	83 ec 08             	sub    $0x8,%esp
     eec:	68 e4 4e 00 00       	push   $0x4ee4
     ef1:	6a 01                	push   $0x1
     ef3:	e8 58 2b 00 00       	call   3a50 <printf>
      break;
     ef8:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     efb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     efe:	85 c9                	test   %ecx,%ecx
     f00:	0f 84 f5 00 00 00    	je     ffb <sharedfd+0x19b>
    wait();
     f06:	e8 d0 29 00 00       	call   38db <wait>
  close(fd);
     f0b:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
     f0e:	31 db                	xor    %ebx,%ebx
  close(fd);
     f10:	57                   	push   %edi
     f11:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f14:	e8 e2 29 00 00       	call   38fb <close>
  fd = open("sharedfd", 0);
     f19:	58                   	pop    %eax
     f1a:	5a                   	pop    %edx
     f1b:	6a 00                	push   $0x0
     f1d:	68 f3 41 00 00       	push   $0x41f3
     f22:	e8 ec 29 00 00       	call   3913 <open>
  if(fd < 0){
     f27:	83 c4 10             	add    $0x10,%esp
  nc = np = 0;
     f2a:	31 d2                	xor    %edx,%edx
  fd = open("sharedfd", 0);
     f2c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     f2f:	85 c0                	test   %eax,%eax
     f31:	0f 88 aa 00 00 00    	js     fe1 <sharedfd+0x181>
     f37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f3e:	66 90                	xchg   %ax,%ax
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f40:	83 ec 04             	sub    $0x4,%esp
     f43:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f46:	6a 0a                	push   $0xa
     f48:	56                   	push   %esi
     f49:	ff 75 d0             	pushl  -0x30(%ebp)
     f4c:	e8 9a 29 00 00       	call   38eb <read>
     f51:	83 c4 10             	add    $0x10,%esp
     f54:	85 c0                	test   %eax,%eax
     f56:	7e 28                	jle    f80 <sharedfd+0x120>
    for(i = 0; i < sizeof(buf); i++){
     f58:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f5b:	89 f0                	mov    %esi,%eax
     f5d:	eb 13                	jmp    f72 <sharedfd+0x112>
     f5f:	90                   	nop
        np++;
     f60:	80 f9 70             	cmp    $0x70,%cl
     f63:	0f 94 c1             	sete   %cl
     f66:	0f b6 c9             	movzbl %cl,%ecx
     f69:	01 cb                	add    %ecx,%ebx
    for(i = 0; i < sizeof(buf); i++){
     f6b:	83 c0 01             	add    $0x1,%eax
     f6e:	39 c7                	cmp    %eax,%edi
     f70:	74 ce                	je     f40 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f72:	0f b6 08             	movzbl (%eax),%ecx
     f75:	80 f9 63             	cmp    $0x63,%cl
     f78:	75 e6                	jne    f60 <sharedfd+0x100>
        nc++;
     f7a:	83 c2 01             	add    $0x1,%edx
      if(buf[i] == 'p')
     f7d:	eb ec                	jmp    f6b <sharedfd+0x10b>
     f7f:	90                   	nop
  close(fd);
     f80:	83 ec 0c             	sub    $0xc,%esp
     f83:	ff 75 d0             	pushl  -0x30(%ebp)
     f86:	e8 70 29 00 00       	call   38fb <close>
  unlink("sharedfd");
     f8b:	c7 04 24 f3 41 00 00 	movl   $0x41f3,(%esp)
     f92:	e8 8c 29 00 00       	call   3923 <unlink>
  if(nc == 10000 && np == 10000){
     f97:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f9a:	83 c4 10             	add    $0x10,%esp
     f9d:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     fa3:	75 5b                	jne    1000 <sharedfd+0x1a0>
     fa5:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     fab:	75 53                	jne    1000 <sharedfd+0x1a0>
    printf(1, "sharedfd ok\n");
     fad:	83 ec 08             	sub    $0x8,%esp
     fb0:	68 fc 41 00 00       	push   $0x41fc
     fb5:	6a 01                	push   $0x1
     fb7:	e8 94 2a 00 00       	call   3a50 <printf>
     fbc:	83 c4 10             	add    $0x10,%esp
}
     fbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fc2:	5b                   	pop    %ebx
     fc3:	5e                   	pop    %esi
     fc4:	5f                   	pop    %edi
     fc5:	5d                   	pop    %ebp
     fc6:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for writing");
     fc7:	83 ec 08             	sub    $0x8,%esp
     fca:	68 b8 4e 00 00       	push   $0x4eb8
     fcf:	6a 01                	push   $0x1
     fd1:	e8 7a 2a 00 00       	call   3a50 <printf>
    return;
     fd6:	83 c4 10             	add    $0x10,%esp
}
     fd9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fdc:	5b                   	pop    %ebx
     fdd:	5e                   	pop    %esi
     fde:	5f                   	pop    %edi
     fdf:	5d                   	pop    %ebp
     fe0:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
     fe1:	83 ec 08             	sub    $0x8,%esp
     fe4:	68 04 4f 00 00       	push   $0x4f04
     fe9:	6a 01                	push   $0x1
     feb:	e8 60 2a 00 00       	call   3a50 <printf>
    return;
     ff0:	83 c4 10             	add    $0x10,%esp
}
     ff3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ff6:	5b                   	pop    %ebx
     ff7:	5e                   	pop    %esi
     ff8:	5f                   	pop    %edi
     ff9:	5d                   	pop    %ebp
     ffa:	c3                   	ret    
    exit();
     ffb:	e8 d3 28 00 00       	call   38d3 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1000:	53                   	push   %ebx
    1001:	52                   	push   %edx
    1002:	68 09 42 00 00       	push   $0x4209
    1007:	6a 01                	push   $0x1
    1009:	e8 42 2a 00 00       	call   3a50 <printf>
    exit();
    100e:	e8 c0 28 00 00       	call   38d3 <exit>
    1013:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001020 <fourfiles>:
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
  printf(1, "fourfiles test\n");
    1025:	be 1e 42 00 00       	mov    $0x421e,%esi
{
    102a:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    102b:	31 db                	xor    %ebx,%ebx
{
    102d:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
    1030:	c7 45 d8 1e 42 00 00 	movl   $0x421e,-0x28(%ebp)
  printf(1, "fourfiles test\n");
    1037:	68 24 42 00 00       	push   $0x4224
    103c:	6a 01                	push   $0x1
  char *names[] = { "f0", "f1", "f2", "f3" };
    103e:	c7 45 dc 67 43 00 00 	movl   $0x4367,-0x24(%ebp)
    1045:	c7 45 e0 6b 43 00 00 	movl   $0x436b,-0x20(%ebp)
    104c:	c7 45 e4 21 42 00 00 	movl   $0x4221,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    1053:	e8 f8 29 00 00       	call   3a50 <printf>
    1058:	83 c4 10             	add    $0x10,%esp
    unlink(fname);
    105b:	83 ec 0c             	sub    $0xc,%esp
    105e:	56                   	push   %esi
    105f:	e8 bf 28 00 00       	call   3923 <unlink>
    pid = fork();
    1064:	e8 62 28 00 00       	call   38cb <fork>
    if(pid < 0){
    1069:	83 c4 10             	add    $0x10,%esp
    106c:	85 c0                	test   %eax,%eax
    106e:	0f 88 64 01 00 00    	js     11d8 <fourfiles+0x1b8>
    if(pid == 0){
    1074:	0f 84 e9 00 00 00    	je     1163 <fourfiles+0x143>
  for(pi = 0; pi < 4; pi++){
    107a:	83 c3 01             	add    $0x1,%ebx
    107d:	83 fb 04             	cmp    $0x4,%ebx
    1080:	74 06                	je     1088 <fourfiles+0x68>
    1082:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1086:	eb d3                	jmp    105b <fourfiles+0x3b>
    wait();
    1088:	e8 4e 28 00 00       	call   38db <wait>
  for(i = 0; i < 2; i++){
    108d:	31 f6                	xor    %esi,%esi
    wait();
    108f:	e8 47 28 00 00       	call   38db <wait>
    1094:	e8 42 28 00 00       	call   38db <wait>
    1099:	e8 3d 28 00 00       	call   38db <wait>
    fname = names[i];
    109e:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    fd = open(fname, 0);
    10a2:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    10a5:	31 db                	xor    %ebx,%ebx
    fd = open(fname, 0);
    10a7:	6a 00                	push   $0x0
    10a9:	50                   	push   %eax
    fname = names[i];
    10aa:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
    10ad:	e8 61 28 00 00       	call   3913 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10b2:	83 c4 10             	add    $0x10,%esp
    fd = open(fname, 0);
    10b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10bf:	90                   	nop
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	68 00 20 00 00       	push   $0x2000
    10c8:	68 40 86 00 00       	push   $0x8640
    10cd:	ff 75 d4             	pushl  -0x2c(%ebp)
    10d0:	e8 16 28 00 00       	call   38eb <read>
    10d5:	83 c4 10             	add    $0x10,%esp
    10d8:	85 c0                	test   %eax,%eax
    10da:	7e 22                	jle    10fe <fourfiles+0xde>
      for(j = 0; j < n; j++){
    10dc:	31 d2                	xor    %edx,%edx
    10de:	66 90                	xchg   %ax,%ax
        if(buf[j] != '0'+i){
    10e0:	83 fe 01             	cmp    $0x1,%esi
    10e3:	0f be ba 40 86 00 00 	movsbl 0x8640(%edx),%edi
    10ea:	19 c9                	sbb    %ecx,%ecx
    10ec:	83 c1 31             	add    $0x31,%ecx
    10ef:	39 cf                	cmp    %ecx,%edi
    10f1:	75 5c                	jne    114f <fourfiles+0x12f>
      for(j = 0; j < n; j++){
    10f3:	83 c2 01             	add    $0x1,%edx
    10f6:	39 d0                	cmp    %edx,%eax
    10f8:	75 e6                	jne    10e0 <fourfiles+0xc0>
      total += n;
    10fa:	01 c3                	add    %eax,%ebx
    10fc:	eb c2                	jmp    10c0 <fourfiles+0xa0>
    close(fd);
    10fe:	83 ec 0c             	sub    $0xc,%esp
    1101:	ff 75 d4             	pushl  -0x2c(%ebp)
    1104:	e8 f2 27 00 00       	call   38fb <close>
    if(total != 12*500){
    1109:	83 c4 10             	add    $0x10,%esp
    110c:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1112:	0f 85 d4 00 00 00    	jne    11ec <fourfiles+0x1cc>
    unlink(fname);
    1118:	83 ec 0c             	sub    $0xc,%esp
    111b:	ff 75 d0             	pushl  -0x30(%ebp)
    111e:	e8 00 28 00 00       	call   3923 <unlink>
  for(i = 0; i < 2; i++){
    1123:	83 c4 10             	add    $0x10,%esp
    1126:	83 fe 01             	cmp    $0x1,%esi
    1129:	75 1a                	jne    1145 <fourfiles+0x125>
  printf(1, "fourfiles ok\n");
    112b:	83 ec 08             	sub    $0x8,%esp
    112e:	68 62 42 00 00       	push   $0x4262
    1133:	6a 01                	push   $0x1
    1135:	e8 16 29 00 00       	call   3a50 <printf>
}
    113a:	83 c4 10             	add    $0x10,%esp
    113d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1140:	5b                   	pop    %ebx
    1141:	5e                   	pop    %esi
    1142:	5f                   	pop    %edi
    1143:	5d                   	pop    %ebp
    1144:	c3                   	ret    
    1145:	be 01 00 00 00       	mov    $0x1,%esi
    114a:	e9 4f ff ff ff       	jmp    109e <fourfiles+0x7e>
          printf(1, "wrong char\n");
    114f:	83 ec 08             	sub    $0x8,%esp
    1152:	68 45 42 00 00       	push   $0x4245
    1157:	6a 01                	push   $0x1
    1159:	e8 f2 28 00 00       	call   3a50 <printf>
          exit();
    115e:	e8 70 27 00 00       	call   38d3 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    1163:	83 ec 08             	sub    $0x8,%esp
    1166:	68 02 02 00 00       	push   $0x202
    116b:	56                   	push   %esi
    116c:	e8 a2 27 00 00       	call   3913 <open>
      if(fd < 0){
    1171:	83 c4 10             	add    $0x10,%esp
      fd = open(fname, O_CREATE | O_RDWR);
    1174:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1176:	85 c0                	test   %eax,%eax
    1178:	78 45                	js     11bf <fourfiles+0x19f>
      memset(buf, '0'+pi, 512);
    117a:	83 ec 04             	sub    $0x4,%esp
    117d:	83 c3 30             	add    $0x30,%ebx
    1180:	68 00 02 00 00       	push   $0x200
    1185:	53                   	push   %ebx
    1186:	bb 0c 00 00 00       	mov    $0xc,%ebx
    118b:	68 40 86 00 00       	push   $0x8640
    1190:	e8 9b 25 00 00       	call   3730 <memset>
    1195:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    1198:	83 ec 04             	sub    $0x4,%esp
    119b:	68 f4 01 00 00       	push   $0x1f4
    11a0:	68 40 86 00 00       	push   $0x8640
    11a5:	56                   	push   %esi
    11a6:	e8 48 27 00 00       	call   38f3 <write>
    11ab:	83 c4 10             	add    $0x10,%esp
    11ae:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11b3:	75 4a                	jne    11ff <fourfiles+0x1df>
      for(i = 0; i < 12; i++){
    11b5:	83 eb 01             	sub    $0x1,%ebx
    11b8:	75 de                	jne    1198 <fourfiles+0x178>
      exit();
    11ba:	e8 14 27 00 00       	call   38d3 <exit>
        printf(1, "create failed\n");
    11bf:	51                   	push   %ecx
    11c0:	51                   	push   %ecx
    11c1:	68 bf 44 00 00       	push   $0x44bf
    11c6:	6a 01                	push   $0x1
    11c8:	e8 83 28 00 00       	call   3a50 <printf>
        exit();
    11cd:	e8 01 27 00 00       	call   38d3 <exit>
    11d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
    11d8:	83 ec 08             	sub    $0x8,%esp
    11db:	68 f9 4c 00 00       	push   $0x4cf9
    11e0:	6a 01                	push   $0x1
    11e2:	e8 69 28 00 00       	call   3a50 <printf>
      exit();
    11e7:	e8 e7 26 00 00       	call   38d3 <exit>
      printf(1, "wrong length %d\n", total);
    11ec:	50                   	push   %eax
    11ed:	53                   	push   %ebx
    11ee:	68 51 42 00 00       	push   $0x4251
    11f3:	6a 01                	push   $0x1
    11f5:	e8 56 28 00 00       	call   3a50 <printf>
      exit();
    11fa:	e8 d4 26 00 00       	call   38d3 <exit>
          printf(1, "write failed %d\n", n);
    11ff:	52                   	push   %edx
    1200:	50                   	push   %eax
    1201:	68 34 42 00 00       	push   $0x4234
    1206:	6a 01                	push   $0x1
    1208:	e8 43 28 00 00       	call   3a50 <printf>
          exit();
    120d:	e8 c1 26 00 00       	call   38d3 <exit>
    1212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001220 <createdelete>:
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1226:	31 db                	xor    %ebx,%ebx
{
    1228:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    122b:	68 70 42 00 00       	push   $0x4270
    1230:	6a 01                	push   $0x1
    1232:	e8 19 28 00 00       	call   3a50 <printf>
    1237:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    123a:	e8 8c 26 00 00       	call   38cb <fork>
    if(pid < 0){
    123f:	85 c0                	test   %eax,%eax
    1241:	0f 88 d2 01 00 00    	js     1419 <createdelete+0x1f9>
    if(pid == 0){
    1247:	0f 84 1b 01 00 00    	je     1368 <createdelete+0x148>
  for(pi = 0; pi < 4; pi++){
    124d:	83 c3 01             	add    $0x1,%ebx
    1250:	83 fb 04             	cmp    $0x4,%ebx
    1253:	75 e5                	jne    123a <createdelete+0x1a>
    wait();
    1255:	e8 81 26 00 00       	call   38db <wait>
    125a:	8d 7d c8             	lea    -0x38(%ebp),%edi
  name[0] = name[1] = name[2] = 0;
    125d:	be ff ff ff ff       	mov    $0xffffffff,%esi
    wait();
    1262:	e8 74 26 00 00       	call   38db <wait>
    1267:	e8 6f 26 00 00       	call   38db <wait>
    126c:	e8 6a 26 00 00       	call   38db <wait>
  name[0] = name[1] = name[2] = 0;
    1271:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    1275:	89 7d c0             	mov    %edi,-0x40(%ebp)
    1278:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    127f:	90                   	nop
    for(pi = 0; pi < 4; pi++){
    1280:	8d 46 31             	lea    0x31(%esi),%eax
    1283:	89 f7                	mov    %esi,%edi
    1285:	83 c6 01             	add    $0x1,%esi
    1288:	83 fe 09             	cmp    $0x9,%esi
    128b:	88 45 c7             	mov    %al,-0x39(%ebp)
    128e:	0f 9f c3             	setg   %bl
    1291:	85 f6                	test   %esi,%esi
    1293:	0f 94 c0             	sete   %al
    1296:	09 c3                	or     %eax,%ebx
    1298:	88 5d c6             	mov    %bl,-0x3a(%ebp)
      name[2] = '\0';
    129b:	bb 70 00 00 00       	mov    $0x70,%ebx
      fd = open(name, 0);
    12a0:	83 ec 08             	sub    $0x8,%esp
      name[1] = '0' + i;
    12a3:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      name[0] = 'p' + pi;
    12a7:	88 5d c8             	mov    %bl,-0x38(%ebp)
      fd = open(name, 0);
    12aa:	6a 00                	push   $0x0
    12ac:	ff 75 c0             	pushl  -0x40(%ebp)
      name[1] = '0' + i;
    12af:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    12b2:	e8 5c 26 00 00       	call   3913 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    12b7:	83 c4 10             	add    $0x10,%esp
    12ba:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    12be:	0f 84 8c 00 00 00    	je     1350 <createdelete+0x130>
    12c4:	85 c0                	test   %eax,%eax
    12c6:	0f 88 21 01 00 00    	js     13ed <createdelete+0x1cd>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12cc:	83 ff 08             	cmp    $0x8,%edi
    12cf:	0f 86 60 01 00 00    	jbe    1435 <createdelete+0x215>
        close(fd);
    12d5:	83 ec 0c             	sub    $0xc,%esp
    12d8:	50                   	push   %eax
    12d9:	e8 1d 26 00 00       	call   38fb <close>
    12de:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    12e1:	83 c3 01             	add    $0x1,%ebx
    12e4:	80 fb 74             	cmp    $0x74,%bl
    12e7:	75 b7                	jne    12a0 <createdelete+0x80>
  for(i = 0; i < N; i++){
    12e9:	83 fe 13             	cmp    $0x13,%esi
    12ec:	75 92                	jne    1280 <createdelete+0x60>
    12ee:	8b 7d c0             	mov    -0x40(%ebp),%edi
    12f1:	be 70 00 00 00       	mov    $0x70,%esi
    12f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12fd:	8d 76 00             	lea    0x0(%esi),%esi
    for(pi = 0; pi < 4; pi++){
    1300:	8d 46 c0             	lea    -0x40(%esi),%eax
  name[0] = name[1] = name[2] = 0;
    1303:	bb 04 00 00 00       	mov    $0x4,%ebx
    1308:	88 45 c7             	mov    %al,-0x39(%ebp)
      unlink(name);
    130b:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    130e:	89 f0                	mov    %esi,%eax
      unlink(name);
    1310:	57                   	push   %edi
      name[0] = 'p' + i;
    1311:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1314:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1318:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    131b:	e8 03 26 00 00       	call   3923 <unlink>
    for(pi = 0; pi < 4; pi++){
    1320:	83 c4 10             	add    $0x10,%esp
    1323:	83 eb 01             	sub    $0x1,%ebx
    1326:	75 e3                	jne    130b <createdelete+0xeb>
  for(i = 0; i < N; i++){
    1328:	83 c6 01             	add    $0x1,%esi
    132b:	89 f0                	mov    %esi,%eax
    132d:	3c 84                	cmp    $0x84,%al
    132f:	75 cf                	jne    1300 <createdelete+0xe0>
  printf(1, "createdelete ok\n");
    1331:	83 ec 08             	sub    $0x8,%esp
    1334:	68 83 42 00 00       	push   $0x4283
    1339:	6a 01                	push   $0x1
    133b:	e8 10 27 00 00       	call   3a50 <printf>
}
    1340:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1343:	5b                   	pop    %ebx
    1344:	5e                   	pop    %esi
    1345:	5f                   	pop    %edi
    1346:	5d                   	pop    %ebp
    1347:	c3                   	ret    
    1348:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    134f:	90                   	nop
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1350:	83 ff 08             	cmp    $0x8,%edi
    1353:	0f 86 d4 00 00 00    	jbe    142d <createdelete+0x20d>
      if(fd >= 0)
    1359:	85 c0                	test   %eax,%eax
    135b:	78 84                	js     12e1 <createdelete+0xc1>
    135d:	e9 73 ff ff ff       	jmp    12d5 <createdelete+0xb5>
    1362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      name[0] = 'p' + pi;
    1368:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    136b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    136f:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[0] = 'p' + pi;
    1372:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    1375:	31 db                	xor    %ebx,%ebx
    1377:	eb 0f                	jmp    1388 <createdelete+0x168>
    1379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    1380:	83 fb 13             	cmp    $0x13,%ebx
    1383:	74 63                	je     13e8 <createdelete+0x1c8>
    1385:	83 c3 01             	add    $0x1,%ebx
        fd = open(name, O_CREATE | O_RDWR);
    1388:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    138b:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    138e:	68 02 02 00 00       	push   $0x202
    1393:	57                   	push   %edi
        name[1] = '0' + i;
    1394:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1397:	e8 77 25 00 00       	call   3913 <open>
        if(fd < 0){
    139c:	83 c4 10             	add    $0x10,%esp
    139f:	85 c0                	test   %eax,%eax
    13a1:	78 62                	js     1405 <createdelete+0x1e5>
        close(fd);
    13a3:	83 ec 0c             	sub    $0xc,%esp
    13a6:	50                   	push   %eax
    13a7:	e8 4f 25 00 00       	call   38fb <close>
        if(i > 0 && (i % 2 ) == 0){
    13ac:	83 c4 10             	add    $0x10,%esp
    13af:	85 db                	test   %ebx,%ebx
    13b1:	74 d2                	je     1385 <createdelete+0x165>
    13b3:	f6 c3 01             	test   $0x1,%bl
    13b6:	75 c8                	jne    1380 <createdelete+0x160>
          if(unlink(name) < 0){
    13b8:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    13bb:	89 d8                	mov    %ebx,%eax
          if(unlink(name) < 0){
    13bd:	57                   	push   %edi
          name[1] = '0' + (i / 2);
    13be:	d1 f8                	sar    %eax
    13c0:	83 c0 30             	add    $0x30,%eax
    13c3:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    13c6:	e8 58 25 00 00       	call   3923 <unlink>
    13cb:	83 c4 10             	add    $0x10,%esp
    13ce:	85 c0                	test   %eax,%eax
    13d0:	79 ae                	jns    1380 <createdelete+0x160>
            printf(1, "unlink failed\n");
    13d2:	52                   	push   %edx
    13d3:	52                   	push   %edx
    13d4:	68 71 3e 00 00       	push   $0x3e71
    13d9:	6a 01                	push   $0x1
    13db:	e8 70 26 00 00       	call   3a50 <printf>
            exit();
    13e0:	e8 ee 24 00 00       	call   38d3 <exit>
    13e5:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    13e8:	e8 e6 24 00 00       	call   38d3 <exit>
    13ed:	8b 7d c0             	mov    -0x40(%ebp),%edi
        printf(1, "oops createdelete %s didn't exist\n", name);
    13f0:	83 ec 04             	sub    $0x4,%esp
    13f3:	57                   	push   %edi
    13f4:	68 30 4f 00 00       	push   $0x4f30
    13f9:	6a 01                	push   $0x1
    13fb:	e8 50 26 00 00       	call   3a50 <printf>
        exit();
    1400:	e8 ce 24 00 00       	call   38d3 <exit>
          printf(1, "create failed\n");
    1405:	83 ec 08             	sub    $0x8,%esp
    1408:	68 bf 44 00 00       	push   $0x44bf
    140d:	6a 01                	push   $0x1
    140f:	e8 3c 26 00 00       	call   3a50 <printf>
          exit();
    1414:	e8 ba 24 00 00       	call   38d3 <exit>
      printf(1, "fork failed\n");
    1419:	83 ec 08             	sub    $0x8,%esp
    141c:	68 f9 4c 00 00       	push   $0x4cf9
    1421:	6a 01                	push   $0x1
    1423:	e8 28 26 00 00       	call   3a50 <printf>
      exit();
    1428:	e8 a6 24 00 00       	call   38d3 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    142d:	85 c0                	test   %eax,%eax
    142f:	0f 88 ac fe ff ff    	js     12e1 <createdelete+0xc1>
    1435:	8b 7d c0             	mov    -0x40(%ebp),%edi
        printf(1, "oops createdelete %s did exist\n", name);
    1438:	50                   	push   %eax
    1439:	57                   	push   %edi
    143a:	68 54 4f 00 00       	push   $0x4f54
    143f:	6a 01                	push   $0x1
    1441:	e8 0a 26 00 00       	call   3a50 <printf>
        exit();
    1446:	e8 88 24 00 00       	call   38d3 <exit>
    144b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    144f:	90                   	nop

00001450 <unlinkread>:
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	56                   	push   %esi
    1454:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    1455:	83 ec 08             	sub    $0x8,%esp
    1458:	68 94 42 00 00       	push   $0x4294
    145d:	6a 01                	push   $0x1
    145f:	e8 ec 25 00 00       	call   3a50 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1464:	5b                   	pop    %ebx
    1465:	5e                   	pop    %esi
    1466:	68 02 02 00 00       	push   $0x202
    146b:	68 a5 42 00 00       	push   $0x42a5
    1470:	e8 9e 24 00 00       	call   3913 <open>
  if(fd < 0){
    1475:	83 c4 10             	add    $0x10,%esp
    1478:	85 c0                	test   %eax,%eax
    147a:	0f 88 e6 00 00 00    	js     1566 <unlinkread+0x116>
  write(fd, "hello", 5);
    1480:	83 ec 04             	sub    $0x4,%esp
    1483:	89 c3                	mov    %eax,%ebx
    1485:	6a 05                	push   $0x5
    1487:	68 ca 42 00 00       	push   $0x42ca
    148c:	50                   	push   %eax
    148d:	e8 61 24 00 00       	call   38f3 <write>
  close(fd);
    1492:	89 1c 24             	mov    %ebx,(%esp)
    1495:	e8 61 24 00 00       	call   38fb <close>
  fd = open("unlinkread", O_RDWR);
    149a:	58                   	pop    %eax
    149b:	5a                   	pop    %edx
    149c:	6a 02                	push   $0x2
    149e:	68 a5 42 00 00       	push   $0x42a5
    14a3:	e8 6b 24 00 00       	call   3913 <open>
  if(fd < 0){
    14a8:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_RDWR);
    14ab:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    14ad:	85 c0                	test   %eax,%eax
    14af:	0f 88 10 01 00 00    	js     15c5 <unlinkread+0x175>
  if(unlink("unlinkread") != 0){
    14b5:	83 ec 0c             	sub    $0xc,%esp
    14b8:	68 a5 42 00 00       	push   $0x42a5
    14bd:	e8 61 24 00 00       	call   3923 <unlink>
    14c2:	83 c4 10             	add    $0x10,%esp
    14c5:	85 c0                	test   %eax,%eax
    14c7:	0f 85 e5 00 00 00    	jne    15b2 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14cd:	83 ec 08             	sub    $0x8,%esp
    14d0:	68 02 02 00 00       	push   $0x202
    14d5:	68 a5 42 00 00       	push   $0x42a5
    14da:	e8 34 24 00 00       	call   3913 <open>
  write(fd1, "yyy", 3);
    14df:	83 c4 0c             	add    $0xc,%esp
    14e2:	6a 03                	push   $0x3
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14e4:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    14e6:	68 02 43 00 00       	push   $0x4302
    14eb:	50                   	push   %eax
    14ec:	e8 02 24 00 00       	call   38f3 <write>
  close(fd1);
    14f1:	89 34 24             	mov    %esi,(%esp)
    14f4:	e8 02 24 00 00       	call   38fb <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    14f9:	83 c4 0c             	add    $0xc,%esp
    14fc:	68 00 20 00 00       	push   $0x2000
    1501:	68 40 86 00 00       	push   $0x8640
    1506:	53                   	push   %ebx
    1507:	e8 df 23 00 00       	call   38eb <read>
    150c:	83 c4 10             	add    $0x10,%esp
    150f:	83 f8 05             	cmp    $0x5,%eax
    1512:	0f 85 87 00 00 00    	jne    159f <unlinkread+0x14f>
  if(buf[0] != 'h'){
    1518:	80 3d 40 86 00 00 68 	cmpb   $0x68,0x8640
    151f:	75 6b                	jne    158c <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    1521:	83 ec 04             	sub    $0x4,%esp
    1524:	6a 0a                	push   $0xa
    1526:	68 40 86 00 00       	push   $0x8640
    152b:	53                   	push   %ebx
    152c:	e8 c2 23 00 00       	call   38f3 <write>
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	83 f8 0a             	cmp    $0xa,%eax
    1537:	75 40                	jne    1579 <unlinkread+0x129>
  close(fd);
    1539:	83 ec 0c             	sub    $0xc,%esp
    153c:	53                   	push   %ebx
    153d:	e8 b9 23 00 00       	call   38fb <close>
  unlink("unlinkread");
    1542:	c7 04 24 a5 42 00 00 	movl   $0x42a5,(%esp)
    1549:	e8 d5 23 00 00       	call   3923 <unlink>
  printf(1, "unlinkread ok\n");
    154e:	58                   	pop    %eax
    154f:	5a                   	pop    %edx
    1550:	68 4d 43 00 00       	push   $0x434d
    1555:	6a 01                	push   $0x1
    1557:	e8 f4 24 00 00       	call   3a50 <printf>
}
    155c:	83 c4 10             	add    $0x10,%esp
    155f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1562:	5b                   	pop    %ebx
    1563:	5e                   	pop    %esi
    1564:	5d                   	pop    %ebp
    1565:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1566:	51                   	push   %ecx
    1567:	51                   	push   %ecx
    1568:	68 b0 42 00 00       	push   $0x42b0
    156d:	6a 01                	push   $0x1
    156f:	e8 dc 24 00 00       	call   3a50 <printf>
    exit();
    1574:	e8 5a 23 00 00       	call   38d3 <exit>
    printf(1, "unlinkread write failed\n");
    1579:	51                   	push   %ecx
    157a:	51                   	push   %ecx
    157b:	68 34 43 00 00       	push   $0x4334
    1580:	6a 01                	push   $0x1
    1582:	e8 c9 24 00 00       	call   3a50 <printf>
    exit();
    1587:	e8 47 23 00 00       	call   38d3 <exit>
    printf(1, "unlinkread wrong data\n");
    158c:	53                   	push   %ebx
    158d:	53                   	push   %ebx
    158e:	68 1d 43 00 00       	push   $0x431d
    1593:	6a 01                	push   $0x1
    1595:	e8 b6 24 00 00       	call   3a50 <printf>
    exit();
    159a:	e8 34 23 00 00       	call   38d3 <exit>
    printf(1, "unlinkread read failed");
    159f:	56                   	push   %esi
    15a0:	56                   	push   %esi
    15a1:	68 06 43 00 00       	push   $0x4306
    15a6:	6a 01                	push   $0x1
    15a8:	e8 a3 24 00 00       	call   3a50 <printf>
    exit();
    15ad:	e8 21 23 00 00       	call   38d3 <exit>
    printf(1, "unlink unlinkread failed\n");
    15b2:	50                   	push   %eax
    15b3:	50                   	push   %eax
    15b4:	68 e8 42 00 00       	push   $0x42e8
    15b9:	6a 01                	push   $0x1
    15bb:	e8 90 24 00 00       	call   3a50 <printf>
    exit();
    15c0:	e8 0e 23 00 00       	call   38d3 <exit>
    printf(1, "open unlinkread failed\n");
    15c5:	50                   	push   %eax
    15c6:	50                   	push   %eax
    15c7:	68 d0 42 00 00       	push   $0x42d0
    15cc:	6a 01                	push   $0x1
    15ce:	e8 7d 24 00 00       	call   3a50 <printf>
    exit();
    15d3:	e8 fb 22 00 00       	call   38d3 <exit>
    15d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15df:	90                   	nop

000015e0 <linktest>:
{
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	53                   	push   %ebx
    15e4:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    15e7:	68 5c 43 00 00       	push   $0x435c
    15ec:	6a 01                	push   $0x1
    15ee:	e8 5d 24 00 00       	call   3a50 <printf>
  unlink("lf1");
    15f3:	c7 04 24 66 43 00 00 	movl   $0x4366,(%esp)
    15fa:	e8 24 23 00 00       	call   3923 <unlink>
  unlink("lf2");
    15ff:	c7 04 24 6a 43 00 00 	movl   $0x436a,(%esp)
    1606:	e8 18 23 00 00       	call   3923 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    160b:	58                   	pop    %eax
    160c:	5a                   	pop    %edx
    160d:	68 02 02 00 00       	push   $0x202
    1612:	68 66 43 00 00       	push   $0x4366
    1617:	e8 f7 22 00 00       	call   3913 <open>
  if(fd < 0){
    161c:	83 c4 10             	add    $0x10,%esp
    161f:	85 c0                	test   %eax,%eax
    1621:	0f 88 1e 01 00 00    	js     1745 <linktest+0x165>
  if(write(fd, "hello", 5) != 5){
    1627:	83 ec 04             	sub    $0x4,%esp
    162a:	89 c3                	mov    %eax,%ebx
    162c:	6a 05                	push   $0x5
    162e:	68 ca 42 00 00       	push   $0x42ca
    1633:	50                   	push   %eax
    1634:	e8 ba 22 00 00       	call   38f3 <write>
    1639:	83 c4 10             	add    $0x10,%esp
    163c:	83 f8 05             	cmp    $0x5,%eax
    163f:	0f 85 98 01 00 00    	jne    17dd <linktest+0x1fd>
  close(fd);
    1645:	83 ec 0c             	sub    $0xc,%esp
    1648:	53                   	push   %ebx
    1649:	e8 ad 22 00 00       	call   38fb <close>
  if(link("lf1", "lf2") < 0){
    164e:	5b                   	pop    %ebx
    164f:	58                   	pop    %eax
    1650:	68 6a 43 00 00       	push   $0x436a
    1655:	68 66 43 00 00       	push   $0x4366
    165a:	e8 d4 22 00 00       	call   3933 <link>
    165f:	83 c4 10             	add    $0x10,%esp
    1662:	85 c0                	test   %eax,%eax
    1664:	0f 88 60 01 00 00    	js     17ca <linktest+0x1ea>
  unlink("lf1");
    166a:	83 ec 0c             	sub    $0xc,%esp
    166d:	68 66 43 00 00       	push   $0x4366
    1672:	e8 ac 22 00 00       	call   3923 <unlink>
  if(open("lf1", 0) >= 0){
    1677:	58                   	pop    %eax
    1678:	5a                   	pop    %edx
    1679:	6a 00                	push   $0x0
    167b:	68 66 43 00 00       	push   $0x4366
    1680:	e8 8e 22 00 00       	call   3913 <open>
    1685:	83 c4 10             	add    $0x10,%esp
    1688:	85 c0                	test   %eax,%eax
    168a:	0f 89 27 01 00 00    	jns    17b7 <linktest+0x1d7>
  fd = open("lf2", 0);
    1690:	83 ec 08             	sub    $0x8,%esp
    1693:	6a 00                	push   $0x0
    1695:	68 6a 43 00 00       	push   $0x436a
    169a:	e8 74 22 00 00       	call   3913 <open>
  if(fd < 0){
    169f:	83 c4 10             	add    $0x10,%esp
  fd = open("lf2", 0);
    16a2:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    16a4:	85 c0                	test   %eax,%eax
    16a6:	0f 88 f8 00 00 00    	js     17a4 <linktest+0x1c4>
  if(read(fd, buf, sizeof(buf)) != 5){
    16ac:	83 ec 04             	sub    $0x4,%esp
    16af:	68 00 20 00 00       	push   $0x2000
    16b4:	68 40 86 00 00       	push   $0x8640
    16b9:	50                   	push   %eax
    16ba:	e8 2c 22 00 00       	call   38eb <read>
    16bf:	83 c4 10             	add    $0x10,%esp
    16c2:	83 f8 05             	cmp    $0x5,%eax
    16c5:	0f 85 c6 00 00 00    	jne    1791 <linktest+0x1b1>
  close(fd);
    16cb:	83 ec 0c             	sub    $0xc,%esp
    16ce:	53                   	push   %ebx
    16cf:	e8 27 22 00 00       	call   38fb <close>
  if(link("lf2", "lf2") >= 0){
    16d4:	58                   	pop    %eax
    16d5:	5a                   	pop    %edx
    16d6:	68 6a 43 00 00       	push   $0x436a
    16db:	68 6a 43 00 00       	push   $0x436a
    16e0:	e8 4e 22 00 00       	call   3933 <link>
    16e5:	83 c4 10             	add    $0x10,%esp
    16e8:	85 c0                	test   %eax,%eax
    16ea:	0f 89 8e 00 00 00    	jns    177e <linktest+0x19e>
  unlink("lf2");
    16f0:	83 ec 0c             	sub    $0xc,%esp
    16f3:	68 6a 43 00 00       	push   $0x436a
    16f8:	e8 26 22 00 00       	call   3923 <unlink>
  if(link("lf2", "lf1") >= 0){
    16fd:	59                   	pop    %ecx
    16fe:	5b                   	pop    %ebx
    16ff:	68 66 43 00 00       	push   $0x4366
    1704:	68 6a 43 00 00       	push   $0x436a
    1709:	e8 25 22 00 00       	call   3933 <link>
    170e:	83 c4 10             	add    $0x10,%esp
    1711:	85 c0                	test   %eax,%eax
    1713:	79 56                	jns    176b <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    1715:	83 ec 08             	sub    $0x8,%esp
    1718:	68 66 43 00 00       	push   $0x4366
    171d:	68 2e 46 00 00       	push   $0x462e
    1722:	e8 0c 22 00 00       	call   3933 <link>
    1727:	83 c4 10             	add    $0x10,%esp
    172a:	85 c0                	test   %eax,%eax
    172c:	79 2a                	jns    1758 <linktest+0x178>
  printf(1, "linktest ok\n");
    172e:	83 ec 08             	sub    $0x8,%esp
    1731:	68 04 44 00 00       	push   $0x4404
    1736:	6a 01                	push   $0x1
    1738:	e8 13 23 00 00       	call   3a50 <printf>
}
    173d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1740:	83 c4 10             	add    $0x10,%esp
    1743:	c9                   	leave  
    1744:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    1745:	50                   	push   %eax
    1746:	50                   	push   %eax
    1747:	68 6e 43 00 00       	push   $0x436e
    174c:	6a 01                	push   $0x1
    174e:	e8 fd 22 00 00       	call   3a50 <printf>
    exit();
    1753:	e8 7b 21 00 00       	call   38d3 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1758:	50                   	push   %eax
    1759:	50                   	push   %eax
    175a:	68 e8 43 00 00       	push   $0x43e8
    175f:	6a 01                	push   $0x1
    1761:	e8 ea 22 00 00       	call   3a50 <printf>
    exit();
    1766:	e8 68 21 00 00       	call   38d3 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    176b:	52                   	push   %edx
    176c:	52                   	push   %edx
    176d:	68 9c 4f 00 00       	push   $0x4f9c
    1772:	6a 01                	push   $0x1
    1774:	e8 d7 22 00 00       	call   3a50 <printf>
    exit();
    1779:	e8 55 21 00 00       	call   38d3 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    177e:	50                   	push   %eax
    177f:	50                   	push   %eax
    1780:	68 ca 43 00 00       	push   $0x43ca
    1785:	6a 01                	push   $0x1
    1787:	e8 c4 22 00 00       	call   3a50 <printf>
    exit();
    178c:	e8 42 21 00 00       	call   38d3 <exit>
    printf(1, "read lf2 failed\n");
    1791:	51                   	push   %ecx
    1792:	51                   	push   %ecx
    1793:	68 b9 43 00 00       	push   $0x43b9
    1798:	6a 01                	push   $0x1
    179a:	e8 b1 22 00 00       	call   3a50 <printf>
    exit();
    179f:	e8 2f 21 00 00       	call   38d3 <exit>
    printf(1, "open lf2 failed\n");
    17a4:	53                   	push   %ebx
    17a5:	53                   	push   %ebx
    17a6:	68 a8 43 00 00       	push   $0x43a8
    17ab:	6a 01                	push   $0x1
    17ad:	e8 9e 22 00 00       	call   3a50 <printf>
    exit();
    17b2:	e8 1c 21 00 00       	call   38d3 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    17b7:	50                   	push   %eax
    17b8:	50                   	push   %eax
    17b9:	68 74 4f 00 00       	push   $0x4f74
    17be:	6a 01                	push   $0x1
    17c0:	e8 8b 22 00 00       	call   3a50 <printf>
    exit();
    17c5:	e8 09 21 00 00       	call   38d3 <exit>
    printf(1, "link lf1 lf2 failed\n");
    17ca:	51                   	push   %ecx
    17cb:	51                   	push   %ecx
    17cc:	68 93 43 00 00       	push   $0x4393
    17d1:	6a 01                	push   $0x1
    17d3:	e8 78 22 00 00       	call   3a50 <printf>
    exit();
    17d8:	e8 f6 20 00 00       	call   38d3 <exit>
    printf(1, "write lf1 failed\n");
    17dd:	50                   	push   %eax
    17de:	50                   	push   %eax
    17df:	68 81 43 00 00       	push   $0x4381
    17e4:	6a 01                	push   $0x1
    17e6:	e8 65 22 00 00       	call   3a50 <printf>
    exit();
    17eb:	e8 e3 20 00 00       	call   38d3 <exit>

000017f0 <concreate>:
{
    17f0:	55                   	push   %ebp
    17f1:	89 e5                	mov    %esp,%ebp
    17f3:	57                   	push   %edi
    17f4:	56                   	push   %esi
  for(i = 0; i < 40; i++){
    17f5:	31 f6                	xor    %esi,%esi
{
    17f7:	53                   	push   %ebx
    17f8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17fb:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    17fe:	68 11 44 00 00       	push   $0x4411
    1803:	6a 01                	push   $0x1
    1805:	e8 46 22 00 00       	call   3a50 <printf>
  file[0] = 'C';
    180a:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    180e:	83 c4 10             	add    $0x10,%esp
    1811:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
  for(i = 0; i < 40; i++){
    1815:	eb 4c                	jmp    1863 <concreate+0x73>
    1817:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    181e:	66 90                	xchg   %ax,%ax
    1820:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
    if(pid && (i % 3) == 1){
    1826:	3d ab aa aa aa       	cmp    $0xaaaaaaab,%eax
    182b:	0f 83 af 00 00 00    	jae    18e0 <concreate+0xf0>
      fd = open(file, O_CREATE | O_RDWR);
    1831:	83 ec 08             	sub    $0x8,%esp
    1834:	68 02 02 00 00       	push   $0x202
    1839:	53                   	push   %ebx
    183a:	e8 d4 20 00 00       	call   3913 <open>
      if(fd < 0){
    183f:	83 c4 10             	add    $0x10,%esp
    1842:	85 c0                	test   %eax,%eax
    1844:	78 5f                	js     18a5 <concreate+0xb5>
      close(fd);
    1846:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    1849:	83 c6 01             	add    $0x1,%esi
      close(fd);
    184c:	50                   	push   %eax
    184d:	e8 a9 20 00 00       	call   38fb <close>
    1852:	83 c4 10             	add    $0x10,%esp
      wait();
    1855:	e8 81 20 00 00       	call   38db <wait>
  for(i = 0; i < 40; i++){
    185a:	83 fe 28             	cmp    $0x28,%esi
    185d:	0f 84 9f 00 00 00    	je     1902 <concreate+0x112>
    unlink(file);
    1863:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    1866:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    1869:	53                   	push   %ebx
    file[1] = '0' + i;
    186a:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    186d:	e8 b1 20 00 00       	call   3923 <unlink>
    pid = fork();
    1872:	e8 54 20 00 00       	call   38cb <fork>
    if(pid && (i % 3) == 1){
    1877:	83 c4 10             	add    $0x10,%esp
    187a:	85 c0                	test   %eax,%eax
    187c:	75 a2                	jne    1820 <concreate+0x30>
      link("C0", file);
    187e:	69 f6 cd cc cc cc    	imul   $0xcccccccd,%esi,%esi
    } else if(pid == 0 && (i % 5) == 1){
    1884:	81 fe cd cc cc cc    	cmp    $0xcccccccd,%esi
    188a:	73 34                	jae    18c0 <concreate+0xd0>
      fd = open(file, O_CREATE | O_RDWR);
    188c:	83 ec 08             	sub    $0x8,%esp
    188f:	68 02 02 00 00       	push   $0x202
    1894:	53                   	push   %ebx
    1895:	e8 79 20 00 00       	call   3913 <open>
      if(fd < 0){
    189a:	83 c4 10             	add    $0x10,%esp
    189d:	85 c0                	test   %eax,%eax
    189f:	0f 89 39 02 00 00    	jns    1ade <concreate+0x2ee>
        printf(1, "concreate create %s failed\n", file);
    18a5:	83 ec 04             	sub    $0x4,%esp
    18a8:	53                   	push   %ebx
    18a9:	68 24 44 00 00       	push   $0x4424
    18ae:	6a 01                	push   $0x1
    18b0:	e8 9b 21 00 00       	call   3a50 <printf>
        exit();
    18b5:	e8 19 20 00 00       	call   38d3 <exit>
    18ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      link("C0", file);
    18c0:	83 ec 08             	sub    $0x8,%esp
    18c3:	53                   	push   %ebx
    18c4:	68 21 44 00 00       	push   $0x4421
    18c9:	e8 65 20 00 00       	call   3933 <link>
    18ce:	83 c4 10             	add    $0x10,%esp
      exit();
    18d1:	e8 fd 1f 00 00       	call   38d3 <exit>
    18d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18dd:	8d 76 00             	lea    0x0(%esi),%esi
      link("C0", file);
    18e0:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    18e3:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
    18e6:	53                   	push   %ebx
    18e7:	68 21 44 00 00       	push   $0x4421
    18ec:	e8 42 20 00 00       	call   3933 <link>
    18f1:	83 c4 10             	add    $0x10,%esp
      wait();
    18f4:	e8 e2 1f 00 00       	call   38db <wait>
  for(i = 0; i < 40; i++){
    18f9:	83 fe 28             	cmp    $0x28,%esi
    18fc:	0f 85 61 ff ff ff    	jne    1863 <concreate+0x73>
  memset(fa, 0, sizeof(fa));
    1902:	83 ec 04             	sub    $0x4,%esp
    1905:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1908:	6a 28                	push   $0x28
    190a:	6a 00                	push   $0x0
    190c:	50                   	push   %eax
    190d:	e8 1e 1e 00 00       	call   3730 <memset>
  fd = open(".", 0);
    1912:	5e                   	pop    %esi
    1913:	5f                   	pop    %edi
    1914:	6a 00                	push   $0x0
    1916:	68 2e 46 00 00       	push   $0x462e
    191b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    191e:	e8 f0 1f 00 00       	call   3913 <open>
  n = 0;
    1923:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    192a:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    192d:	89 c6                	mov    %eax,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    192f:	90                   	nop
    1930:	83 ec 04             	sub    $0x4,%esp
    1933:	6a 10                	push   $0x10
    1935:	57                   	push   %edi
    1936:	56                   	push   %esi
    1937:	e8 af 1f 00 00       	call   38eb <read>
    193c:	83 c4 10             	add    $0x10,%esp
    193f:	85 c0                	test   %eax,%eax
    1941:	7e 3d                	jle    1980 <concreate+0x190>
    if(de.inum == 0)
    1943:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1948:	74 e6                	je     1930 <concreate+0x140>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    194a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    194e:	75 e0                	jne    1930 <concreate+0x140>
    1950:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1954:	75 da                	jne    1930 <concreate+0x140>
      i = de.name[1] - '0';
    1956:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    195a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    195d:	83 f8 27             	cmp    $0x27,%eax
    1960:	0f 87 60 01 00 00    	ja     1ac6 <concreate+0x2d6>
      if(fa[i]){
    1966:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    196b:	0f 85 3d 01 00 00    	jne    1aae <concreate+0x2be>
      n++;
    1971:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
      fa[i] = 1;
    1975:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    197a:	eb b4                	jmp    1930 <concreate+0x140>
    197c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1980:	83 ec 0c             	sub    $0xc,%esp
    1983:	56                   	push   %esi
    1984:	e8 72 1f 00 00       	call   38fb <close>
  if(n != 40){
    1989:	83 c4 10             	add    $0x10,%esp
    198c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1990:	0f 85 05 01 00 00    	jne    1a9b <concreate+0x2ab>
  for(i = 0; i < 40; i++){
    1996:	31 f6                	xor    %esi,%esi
    1998:	eb 4c                	jmp    19e6 <concreate+0x1f6>
    199a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    19a0:	85 ff                	test   %edi,%edi
    19a2:	74 05                	je     19a9 <concreate+0x1b9>
    19a4:	83 f8 01             	cmp    $0x1,%eax
    19a7:	74 6c                	je     1a15 <concreate+0x225>
      unlink(file);
    19a9:	83 ec 0c             	sub    $0xc,%esp
    19ac:	53                   	push   %ebx
    19ad:	e8 71 1f 00 00       	call   3923 <unlink>
      unlink(file);
    19b2:	89 1c 24             	mov    %ebx,(%esp)
    19b5:	e8 69 1f 00 00       	call   3923 <unlink>
      unlink(file);
    19ba:	89 1c 24             	mov    %ebx,(%esp)
    19bd:	e8 61 1f 00 00       	call   3923 <unlink>
      unlink(file);
    19c2:	89 1c 24             	mov    %ebx,(%esp)
    19c5:	e8 59 1f 00 00       	call   3923 <unlink>
    19ca:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    19cd:	85 ff                	test   %edi,%edi
    19cf:	0f 84 fc fe ff ff    	je     18d1 <concreate+0xe1>
      wait();
    19d5:	e8 01 1f 00 00       	call   38db <wait>
  for(i = 0; i < 40; i++){
    19da:	83 c6 01             	add    $0x1,%esi
    19dd:	83 fe 28             	cmp    $0x28,%esi
    19e0:	0f 84 8a 00 00 00    	je     1a70 <concreate+0x280>
    file[1] = '0' + i;
    19e6:	8d 46 30             	lea    0x30(%esi),%eax
    19e9:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    19ec:	e8 da 1e 00 00       	call   38cb <fork>
    19f1:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    19f3:	85 c0                	test   %eax,%eax
    19f5:	0f 88 8c 00 00 00    	js     1a87 <concreate+0x297>
    if(((i % 3) == 0 && pid == 0) ||
    19fb:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1a00:	f7 e6                	mul    %esi
    1a02:	89 d0                	mov    %edx,%eax
    1a04:	83 e2 fe             	and    $0xfffffffe,%edx
    1a07:	d1 e8                	shr    %eax
    1a09:	01 c2                	add    %eax,%edx
    1a0b:	89 f0                	mov    %esi,%eax
    1a0d:	29 d0                	sub    %edx,%eax
    1a0f:	89 c1                	mov    %eax,%ecx
    1a11:	09 f9                	or     %edi,%ecx
    1a13:	75 8b                	jne    19a0 <concreate+0x1b0>
      close(open(file, 0));
    1a15:	83 ec 08             	sub    $0x8,%esp
    1a18:	6a 00                	push   $0x0
    1a1a:	53                   	push   %ebx
    1a1b:	e8 f3 1e 00 00       	call   3913 <open>
    1a20:	89 04 24             	mov    %eax,(%esp)
    1a23:	e8 d3 1e 00 00       	call   38fb <close>
      close(open(file, 0));
    1a28:	58                   	pop    %eax
    1a29:	5a                   	pop    %edx
    1a2a:	6a 00                	push   $0x0
    1a2c:	53                   	push   %ebx
    1a2d:	e8 e1 1e 00 00       	call   3913 <open>
    1a32:	89 04 24             	mov    %eax,(%esp)
    1a35:	e8 c1 1e 00 00       	call   38fb <close>
      close(open(file, 0));
    1a3a:	59                   	pop    %ecx
    1a3b:	58                   	pop    %eax
    1a3c:	6a 00                	push   $0x0
    1a3e:	53                   	push   %ebx
    1a3f:	e8 cf 1e 00 00       	call   3913 <open>
    1a44:	89 04 24             	mov    %eax,(%esp)
    1a47:	e8 af 1e 00 00       	call   38fb <close>
      close(open(file, 0));
    1a4c:	58                   	pop    %eax
    1a4d:	5a                   	pop    %edx
    1a4e:	6a 00                	push   $0x0
    1a50:	53                   	push   %ebx
    1a51:	e8 bd 1e 00 00       	call   3913 <open>
    1a56:	89 04 24             	mov    %eax,(%esp)
    1a59:	e8 9d 1e 00 00       	call   38fb <close>
    1a5e:	83 c4 10             	add    $0x10,%esp
    1a61:	e9 67 ff ff ff       	jmp    19cd <concreate+0x1dd>
    1a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1a6d:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "concreate ok\n");
    1a70:	83 ec 08             	sub    $0x8,%esp
    1a73:	68 76 44 00 00       	push   $0x4476
    1a78:	6a 01                	push   $0x1
    1a7a:	e8 d1 1f 00 00       	call   3a50 <printf>
}
    1a7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a82:	5b                   	pop    %ebx
    1a83:	5e                   	pop    %esi
    1a84:	5f                   	pop    %edi
    1a85:	5d                   	pop    %ebp
    1a86:	c3                   	ret    
      printf(1, "fork failed\n");
    1a87:	83 ec 08             	sub    $0x8,%esp
    1a8a:	68 f9 4c 00 00       	push   $0x4cf9
    1a8f:	6a 01                	push   $0x1
    1a91:	e8 ba 1f 00 00       	call   3a50 <printf>
      exit();
    1a96:	e8 38 1e 00 00       	call   38d3 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1a9b:	51                   	push   %ecx
    1a9c:	51                   	push   %ecx
    1a9d:	68 c0 4f 00 00       	push   $0x4fc0
    1aa2:	6a 01                	push   $0x1
    1aa4:	e8 a7 1f 00 00       	call   3a50 <printf>
    exit();
    1aa9:	e8 25 1e 00 00       	call   38d3 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1aae:	83 ec 04             	sub    $0x4,%esp
    1ab1:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1ab4:	50                   	push   %eax
    1ab5:	68 59 44 00 00       	push   $0x4459
    1aba:	6a 01                	push   $0x1
    1abc:	e8 8f 1f 00 00       	call   3a50 <printf>
        exit();
    1ac1:	e8 0d 1e 00 00       	call   38d3 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1ac6:	83 ec 04             	sub    $0x4,%esp
    1ac9:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1acc:	50                   	push   %eax
    1acd:	68 40 44 00 00       	push   $0x4440
    1ad2:	6a 01                	push   $0x1
    1ad4:	e8 77 1f 00 00       	call   3a50 <printf>
        exit();
    1ad9:	e8 f5 1d 00 00       	call   38d3 <exit>
      close(fd);
    1ade:	83 ec 0c             	sub    $0xc,%esp
    1ae1:	50                   	push   %eax
    1ae2:	e8 14 1e 00 00       	call   38fb <close>
    1ae7:	83 c4 10             	add    $0x10,%esp
    1aea:	e9 e2 fd ff ff       	jmp    18d1 <concreate+0xe1>
    1aef:	90                   	nop

00001af0 <linkunlink>:
{
    1af0:	55                   	push   %ebp
    1af1:	89 e5                	mov    %esp,%ebp
    1af3:	57                   	push   %edi
    1af4:	56                   	push   %esi
    1af5:	53                   	push   %ebx
    1af6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    1af9:	68 84 44 00 00       	push   $0x4484
    1afe:	6a 01                	push   $0x1
    1b00:	e8 4b 1f 00 00       	call   3a50 <printf>
  unlink("x");
    1b05:	c7 04 24 11 47 00 00 	movl   $0x4711,(%esp)
    1b0c:	e8 12 1e 00 00       	call   3923 <unlink>
  pid = fork();
    1b11:	e8 b5 1d 00 00       	call   38cb <fork>
  if(pid < 0){
    1b16:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1b19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1b1c:	85 c0                	test   %eax,%eax
    1b1e:	0f 88 b6 00 00 00    	js     1bda <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1b24:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b28:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1b2d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1b32:	19 ff                	sbb    %edi,%edi
    1b34:	83 e7 60             	and    $0x60,%edi
    1b37:	83 c7 01             	add    $0x1,%edi
    1b3a:	eb 1e                	jmp    1b5a <linkunlink+0x6a>
    1b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if((x % 3) == 1){
    1b40:	83 f8 01             	cmp    $0x1,%eax
    1b43:	74 7b                	je     1bc0 <linkunlink+0xd0>
      unlink("x");
    1b45:	83 ec 0c             	sub    $0xc,%esp
    1b48:	68 11 47 00 00       	push   $0x4711
    1b4d:	e8 d1 1d 00 00       	call   3923 <unlink>
    1b52:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b55:	83 eb 01             	sub    $0x1,%ebx
    1b58:	74 41                	je     1b9b <linkunlink+0xab>
    x = x * 1103515245 + 12345;
    1b5a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b60:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b66:	89 f8                	mov    %edi,%eax
    1b68:	f7 e6                	mul    %esi
    1b6a:	89 d0                	mov    %edx,%eax
    1b6c:	83 e2 fe             	and    $0xfffffffe,%edx
    1b6f:	d1 e8                	shr    %eax
    1b71:	01 c2                	add    %eax,%edx
    1b73:	89 f8                	mov    %edi,%eax
    1b75:	29 d0                	sub    %edx,%eax
    1b77:	75 c7                	jne    1b40 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1b79:	83 ec 08             	sub    $0x8,%esp
    1b7c:	68 02 02 00 00       	push   $0x202
    1b81:	68 11 47 00 00       	push   $0x4711
    1b86:	e8 88 1d 00 00       	call   3913 <open>
    1b8b:	89 04 24             	mov    %eax,(%esp)
    1b8e:	e8 68 1d 00 00       	call   38fb <close>
    1b93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b96:	83 eb 01             	sub    $0x1,%ebx
    1b99:	75 bf                	jne    1b5a <linkunlink+0x6a>
  if(pid)
    1b9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b9e:	85 c0                	test   %eax,%eax
    1ba0:	74 4b                	je     1bed <linkunlink+0xfd>
    wait();
    1ba2:	e8 34 1d 00 00       	call   38db <wait>
  printf(1, "linkunlink ok\n");
    1ba7:	83 ec 08             	sub    $0x8,%esp
    1baa:	68 99 44 00 00       	push   $0x4499
    1baf:	6a 01                	push   $0x1
    1bb1:	e8 9a 1e 00 00       	call   3a50 <printf>
}
    1bb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1bb9:	5b                   	pop    %ebx
    1bba:	5e                   	pop    %esi
    1bbb:	5f                   	pop    %edi
    1bbc:	5d                   	pop    %ebp
    1bbd:	c3                   	ret    
    1bbe:	66 90                	xchg   %ax,%ax
      link("cat", "x");
    1bc0:	83 ec 08             	sub    $0x8,%esp
    1bc3:	68 11 47 00 00       	push   $0x4711
    1bc8:	68 95 44 00 00       	push   $0x4495
    1bcd:	e8 61 1d 00 00       	call   3933 <link>
    1bd2:	83 c4 10             	add    $0x10,%esp
    1bd5:	e9 7b ff ff ff       	jmp    1b55 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1bda:	52                   	push   %edx
    1bdb:	52                   	push   %edx
    1bdc:	68 f9 4c 00 00       	push   $0x4cf9
    1be1:	6a 01                	push   $0x1
    1be3:	e8 68 1e 00 00       	call   3a50 <printf>
    exit();
    1be8:	e8 e6 1c 00 00       	call   38d3 <exit>
    exit();
    1bed:	e8 e1 1c 00 00       	call   38d3 <exit>
    1bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001c00 <bigdir>:
{
    1c00:	55                   	push   %ebp
    1c01:	89 e5                	mov    %esp,%ebp
    1c03:	57                   	push   %edi
    1c04:	56                   	push   %esi
    1c05:	53                   	push   %ebx
    1c06:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1c09:	68 a8 44 00 00       	push   $0x44a8
    1c0e:	6a 01                	push   $0x1
    1c10:	e8 3b 1e 00 00       	call   3a50 <printf>
  unlink("bd");
    1c15:	c7 04 24 b5 44 00 00 	movl   $0x44b5,(%esp)
    1c1c:	e8 02 1d 00 00       	call   3923 <unlink>
  fd = open("bd", O_CREATE);
    1c21:	5a                   	pop    %edx
    1c22:	59                   	pop    %ecx
    1c23:	68 00 02 00 00       	push   $0x200
    1c28:	68 b5 44 00 00       	push   $0x44b5
    1c2d:	e8 e1 1c 00 00       	call   3913 <open>
  if(fd < 0){
    1c32:	83 c4 10             	add    $0x10,%esp
    1c35:	85 c0                	test   %eax,%eax
    1c37:	0f 88 de 00 00 00    	js     1d1b <bigdir+0x11b>
  close(fd);
    1c3d:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    1c40:	31 f6                	xor    %esi,%esi
    1c42:	8d 7d de             	lea    -0x22(%ebp),%edi
  close(fd);
    1c45:	50                   	push   %eax
    1c46:	e8 b0 1c 00 00       	call   38fb <close>
    1c4b:	83 c4 10             	add    $0x10,%esp
    1c4e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + (i / 64);
    1c50:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    1c52:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    1c55:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c59:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    1c5c:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1c5d:	83 c0 30             	add    $0x30,%eax
    if(link("bd", name) != 0){
    1c60:	68 b5 44 00 00       	push   $0x44b5
    name[1] = '0' + (i / 64);
    1c65:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c68:	89 f0                	mov    %esi,%eax
    1c6a:	83 e0 3f             	and    $0x3f,%eax
    name[3] = '\0';
    1c6d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[2] = '0' + (i % 64);
    1c71:	83 c0 30             	add    $0x30,%eax
    1c74:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    1c77:	e8 b7 1c 00 00       	call   3933 <link>
    1c7c:	83 c4 10             	add    $0x10,%esp
    1c7f:	89 c3                	mov    %eax,%ebx
    1c81:	85 c0                	test   %eax,%eax
    1c83:	75 6e                	jne    1cf3 <bigdir+0xf3>
  for(i = 0; i < 500; i++){
    1c85:	83 c6 01             	add    $0x1,%esi
    1c88:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c8e:	75 c0                	jne    1c50 <bigdir+0x50>
  unlink("bd");
    1c90:	83 ec 0c             	sub    $0xc,%esp
    1c93:	68 b5 44 00 00       	push   $0x44b5
    1c98:	e8 86 1c 00 00       	call   3923 <unlink>
    1c9d:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + (i / 64);
    1ca0:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    1ca2:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    1ca5:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1ca9:	c1 f8 06             	sar    $0x6,%eax
    if(unlink(name) != 0){
    1cac:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1cad:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    1cb0:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1cb4:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1cb7:	89 d8                	mov    %ebx,%eax
    1cb9:	83 e0 3f             	and    $0x3f,%eax
    1cbc:	83 c0 30             	add    $0x30,%eax
    1cbf:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    1cc2:	e8 5c 1c 00 00       	call   3923 <unlink>
    1cc7:	83 c4 10             	add    $0x10,%esp
    1cca:	85 c0                	test   %eax,%eax
    1ccc:	75 39                	jne    1d07 <bigdir+0x107>
  for(i = 0; i < 500; i++){
    1cce:	83 c3 01             	add    $0x1,%ebx
    1cd1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cd7:	75 c7                	jne    1ca0 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    1cd9:	83 ec 08             	sub    $0x8,%esp
    1cdc:	68 f7 44 00 00       	push   $0x44f7
    1ce1:	6a 01                	push   $0x1
    1ce3:	e8 68 1d 00 00       	call   3a50 <printf>
    1ce8:	83 c4 10             	add    $0x10,%esp
}
    1ceb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cee:	5b                   	pop    %ebx
    1cef:	5e                   	pop    %esi
    1cf0:	5f                   	pop    %edi
    1cf1:	5d                   	pop    %ebp
    1cf2:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    1cf3:	83 ec 08             	sub    $0x8,%esp
    1cf6:	68 ce 44 00 00       	push   $0x44ce
    1cfb:	6a 01                	push   $0x1
    1cfd:	e8 4e 1d 00 00       	call   3a50 <printf>
      exit();
    1d02:	e8 cc 1b 00 00       	call   38d3 <exit>
      printf(1, "bigdir unlink failed");
    1d07:	83 ec 08             	sub    $0x8,%esp
    1d0a:	68 e2 44 00 00       	push   $0x44e2
    1d0f:	6a 01                	push   $0x1
    1d11:	e8 3a 1d 00 00       	call   3a50 <printf>
      exit();
    1d16:	e8 b8 1b 00 00       	call   38d3 <exit>
    printf(1, "bigdir create failed\n");
    1d1b:	50                   	push   %eax
    1d1c:	50                   	push   %eax
    1d1d:	68 b8 44 00 00       	push   $0x44b8
    1d22:	6a 01                	push   $0x1
    1d24:	e8 27 1d 00 00       	call   3a50 <printf>
    exit();
    1d29:	e8 a5 1b 00 00       	call   38d3 <exit>
    1d2e:	66 90                	xchg   %ax,%ax

00001d30 <subdir>:
{
    1d30:	55                   	push   %ebp
    1d31:	89 e5                	mov    %esp,%ebp
    1d33:	53                   	push   %ebx
    1d34:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1d37:	68 02 45 00 00       	push   $0x4502
    1d3c:	6a 01                	push   $0x1
    1d3e:	e8 0d 1d 00 00       	call   3a50 <printf>
  unlink("ff");
    1d43:	c7 04 24 8b 45 00 00 	movl   $0x458b,(%esp)
    1d4a:	e8 d4 1b 00 00       	call   3923 <unlink>
  if(mkdir("dd") != 0){
    1d4f:	c7 04 24 28 46 00 00 	movl   $0x4628,(%esp)
    1d56:	e8 e0 1b 00 00       	call   393b <mkdir>
    1d5b:	83 c4 10             	add    $0x10,%esp
    1d5e:	85 c0                	test   %eax,%eax
    1d60:	0f 85 b3 05 00 00    	jne    2319 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d66:	83 ec 08             	sub    $0x8,%esp
    1d69:	68 02 02 00 00       	push   $0x202
    1d6e:	68 61 45 00 00       	push   $0x4561
    1d73:	e8 9b 1b 00 00       	call   3913 <open>
  if(fd < 0){
    1d78:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d7b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d7d:	85 c0                	test   %eax,%eax
    1d7f:	0f 88 81 05 00 00    	js     2306 <subdir+0x5d6>
  write(fd, "ff", 2);
    1d85:	83 ec 04             	sub    $0x4,%esp
    1d88:	6a 02                	push   $0x2
    1d8a:	68 8b 45 00 00       	push   $0x458b
    1d8f:	50                   	push   %eax
    1d90:	e8 5e 1b 00 00       	call   38f3 <write>
  close(fd);
    1d95:	89 1c 24             	mov    %ebx,(%esp)
    1d98:	e8 5e 1b 00 00       	call   38fb <close>
  if(unlink("dd") >= 0){
    1d9d:	c7 04 24 28 46 00 00 	movl   $0x4628,(%esp)
    1da4:	e8 7a 1b 00 00       	call   3923 <unlink>
    1da9:	83 c4 10             	add    $0x10,%esp
    1dac:	85 c0                	test   %eax,%eax
    1dae:	0f 89 3f 05 00 00    	jns    22f3 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    1db4:	83 ec 0c             	sub    $0xc,%esp
    1db7:	68 3c 45 00 00       	push   $0x453c
    1dbc:	e8 7a 1b 00 00       	call   393b <mkdir>
    1dc1:	83 c4 10             	add    $0x10,%esp
    1dc4:	85 c0                	test   %eax,%eax
    1dc6:	0f 85 14 05 00 00    	jne    22e0 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dcc:	83 ec 08             	sub    $0x8,%esp
    1dcf:	68 02 02 00 00       	push   $0x202
    1dd4:	68 5e 45 00 00       	push   $0x455e
    1dd9:	e8 35 1b 00 00       	call   3913 <open>
  if(fd < 0){
    1dde:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1de1:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1de3:	85 c0                	test   %eax,%eax
    1de5:	0f 88 24 04 00 00    	js     220f <subdir+0x4df>
  write(fd, "FF", 2);
    1deb:	83 ec 04             	sub    $0x4,%esp
    1dee:	6a 02                	push   $0x2
    1df0:	68 7f 45 00 00       	push   $0x457f
    1df5:	50                   	push   %eax
    1df6:	e8 f8 1a 00 00       	call   38f3 <write>
  close(fd);
    1dfb:	89 1c 24             	mov    %ebx,(%esp)
    1dfe:	e8 f8 1a 00 00       	call   38fb <close>
  fd = open("dd/dd/../ff", 0);
    1e03:	58                   	pop    %eax
    1e04:	5a                   	pop    %edx
    1e05:	6a 00                	push   $0x0
    1e07:	68 82 45 00 00       	push   $0x4582
    1e0c:	e8 02 1b 00 00       	call   3913 <open>
  if(fd < 0){
    1e11:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/../ff", 0);
    1e14:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e16:	85 c0                	test   %eax,%eax
    1e18:	0f 88 de 03 00 00    	js     21fc <subdir+0x4cc>
  cc = read(fd, buf, sizeof(buf));
    1e1e:	83 ec 04             	sub    $0x4,%esp
    1e21:	68 00 20 00 00       	push   $0x2000
    1e26:	68 40 86 00 00       	push   $0x8640
    1e2b:	50                   	push   %eax
    1e2c:	e8 ba 1a 00 00       	call   38eb <read>
  if(cc != 2 || buf[0] != 'f'){
    1e31:	83 c4 10             	add    $0x10,%esp
    1e34:	83 f8 02             	cmp    $0x2,%eax
    1e37:	0f 85 3a 03 00 00    	jne    2177 <subdir+0x447>
    1e3d:	80 3d 40 86 00 00 66 	cmpb   $0x66,0x8640
    1e44:	0f 85 2d 03 00 00    	jne    2177 <subdir+0x447>
  close(fd);
    1e4a:	83 ec 0c             	sub    $0xc,%esp
    1e4d:	53                   	push   %ebx
    1e4e:	e8 a8 1a 00 00       	call   38fb <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e53:	59                   	pop    %ecx
    1e54:	5b                   	pop    %ebx
    1e55:	68 c2 45 00 00       	push   $0x45c2
    1e5a:	68 5e 45 00 00       	push   $0x455e
    1e5f:	e8 cf 1a 00 00       	call   3933 <link>
    1e64:	83 c4 10             	add    $0x10,%esp
    1e67:	85 c0                	test   %eax,%eax
    1e69:	0f 85 c6 03 00 00    	jne    2235 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    1e6f:	83 ec 0c             	sub    $0xc,%esp
    1e72:	68 5e 45 00 00       	push   $0x455e
    1e77:	e8 a7 1a 00 00       	call   3923 <unlink>
    1e7c:	83 c4 10             	add    $0x10,%esp
    1e7f:	85 c0                	test   %eax,%eax
    1e81:	0f 85 16 03 00 00    	jne    219d <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e87:	83 ec 08             	sub    $0x8,%esp
    1e8a:	6a 00                	push   $0x0
    1e8c:	68 5e 45 00 00       	push   $0x455e
    1e91:	e8 7d 1a 00 00       	call   3913 <open>
    1e96:	83 c4 10             	add    $0x10,%esp
    1e99:	85 c0                	test   %eax,%eax
    1e9b:	0f 89 2c 04 00 00    	jns    22cd <subdir+0x59d>
  if(chdir("dd") != 0){
    1ea1:	83 ec 0c             	sub    $0xc,%esp
    1ea4:	68 28 46 00 00       	push   $0x4628
    1ea9:	e8 95 1a 00 00       	call   3943 <chdir>
    1eae:	83 c4 10             	add    $0x10,%esp
    1eb1:	85 c0                	test   %eax,%eax
    1eb3:	0f 85 01 04 00 00    	jne    22ba <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    1eb9:	83 ec 0c             	sub    $0xc,%esp
    1ebc:	68 f6 45 00 00       	push   $0x45f6
    1ec1:	e8 7d 1a 00 00       	call   3943 <chdir>
    1ec6:	83 c4 10             	add    $0x10,%esp
    1ec9:	85 c0                	test   %eax,%eax
    1ecb:	0f 85 b9 02 00 00    	jne    218a <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    1ed1:	83 ec 0c             	sub    $0xc,%esp
    1ed4:	68 1c 46 00 00       	push   $0x461c
    1ed9:	e8 65 1a 00 00       	call   3943 <chdir>
    1ede:	83 c4 10             	add    $0x10,%esp
    1ee1:	85 c0                	test   %eax,%eax
    1ee3:	0f 85 a1 02 00 00    	jne    218a <subdir+0x45a>
  if(chdir("./..") != 0){
    1ee9:	83 ec 0c             	sub    $0xc,%esp
    1eec:	68 2b 46 00 00       	push   $0x462b
    1ef1:	e8 4d 1a 00 00       	call   3943 <chdir>
    1ef6:	83 c4 10             	add    $0x10,%esp
    1ef9:	85 c0                	test   %eax,%eax
    1efb:	0f 85 21 03 00 00    	jne    2222 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    1f01:	83 ec 08             	sub    $0x8,%esp
    1f04:	6a 00                	push   $0x0
    1f06:	68 c2 45 00 00       	push   $0x45c2
    1f0b:	e8 03 1a 00 00       	call   3913 <open>
  if(fd < 0){
    1f10:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ffff", 0);
    1f13:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f15:	85 c0                	test   %eax,%eax
    1f17:	0f 88 e0 04 00 00    	js     23fd <subdir+0x6cd>
  if(read(fd, buf, sizeof(buf)) != 2){
    1f1d:	83 ec 04             	sub    $0x4,%esp
    1f20:	68 00 20 00 00       	push   $0x2000
    1f25:	68 40 86 00 00       	push   $0x8640
    1f2a:	50                   	push   %eax
    1f2b:	e8 bb 19 00 00       	call   38eb <read>
    1f30:	83 c4 10             	add    $0x10,%esp
    1f33:	83 f8 02             	cmp    $0x2,%eax
    1f36:	0f 85 ae 04 00 00    	jne    23ea <subdir+0x6ba>
  close(fd);
    1f3c:	83 ec 0c             	sub    $0xc,%esp
    1f3f:	53                   	push   %ebx
    1f40:	e8 b6 19 00 00       	call   38fb <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f45:	58                   	pop    %eax
    1f46:	5a                   	pop    %edx
    1f47:	6a 00                	push   $0x0
    1f49:	68 5e 45 00 00       	push   $0x455e
    1f4e:	e8 c0 19 00 00       	call   3913 <open>
    1f53:	83 c4 10             	add    $0x10,%esp
    1f56:	85 c0                	test   %eax,%eax
    1f58:	0f 89 65 02 00 00    	jns    21c3 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f5e:	83 ec 08             	sub    $0x8,%esp
    1f61:	68 02 02 00 00       	push   $0x202
    1f66:	68 76 46 00 00       	push   $0x4676
    1f6b:	e8 a3 19 00 00       	call   3913 <open>
    1f70:	83 c4 10             	add    $0x10,%esp
    1f73:	85 c0                	test   %eax,%eax
    1f75:	0f 89 35 02 00 00    	jns    21b0 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f7b:	83 ec 08             	sub    $0x8,%esp
    1f7e:	68 02 02 00 00       	push   $0x202
    1f83:	68 9b 46 00 00       	push   $0x469b
    1f88:	e8 86 19 00 00       	call   3913 <open>
    1f8d:	83 c4 10             	add    $0x10,%esp
    1f90:	85 c0                	test   %eax,%eax
    1f92:	0f 89 0f 03 00 00    	jns    22a7 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    1f98:	83 ec 08             	sub    $0x8,%esp
    1f9b:	68 00 02 00 00       	push   $0x200
    1fa0:	68 28 46 00 00       	push   $0x4628
    1fa5:	e8 69 19 00 00       	call   3913 <open>
    1faa:	83 c4 10             	add    $0x10,%esp
    1fad:	85 c0                	test   %eax,%eax
    1faf:	0f 89 df 02 00 00    	jns    2294 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    1fb5:	83 ec 08             	sub    $0x8,%esp
    1fb8:	6a 02                	push   $0x2
    1fba:	68 28 46 00 00       	push   $0x4628
    1fbf:	e8 4f 19 00 00       	call   3913 <open>
    1fc4:	83 c4 10             	add    $0x10,%esp
    1fc7:	85 c0                	test   %eax,%eax
    1fc9:	0f 89 b2 02 00 00    	jns    2281 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    1fcf:	83 ec 08             	sub    $0x8,%esp
    1fd2:	6a 01                	push   $0x1
    1fd4:	68 28 46 00 00       	push   $0x4628
    1fd9:	e8 35 19 00 00       	call   3913 <open>
    1fde:	83 c4 10             	add    $0x10,%esp
    1fe1:	85 c0                	test   %eax,%eax
    1fe3:	0f 89 85 02 00 00    	jns    226e <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fe9:	83 ec 08             	sub    $0x8,%esp
    1fec:	68 0a 47 00 00       	push   $0x470a
    1ff1:	68 76 46 00 00       	push   $0x4676
    1ff6:	e8 38 19 00 00       	call   3933 <link>
    1ffb:	83 c4 10             	add    $0x10,%esp
    1ffe:	85 c0                	test   %eax,%eax
    2000:	0f 84 55 02 00 00    	je     225b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2006:	83 ec 08             	sub    $0x8,%esp
    2009:	68 0a 47 00 00       	push   $0x470a
    200e:	68 9b 46 00 00       	push   $0x469b
    2013:	e8 1b 19 00 00       	call   3933 <link>
    2018:	83 c4 10             	add    $0x10,%esp
    201b:	85 c0                	test   %eax,%eax
    201d:	0f 84 25 02 00 00    	je     2248 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2023:	83 ec 08             	sub    $0x8,%esp
    2026:	68 c2 45 00 00       	push   $0x45c2
    202b:	68 61 45 00 00       	push   $0x4561
    2030:	e8 fe 18 00 00       	call   3933 <link>
    2035:	83 c4 10             	add    $0x10,%esp
    2038:	85 c0                	test   %eax,%eax
    203a:	0f 84 a9 01 00 00    	je     21e9 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    2040:	83 ec 0c             	sub    $0xc,%esp
    2043:	68 76 46 00 00       	push   $0x4676
    2048:	e8 ee 18 00 00       	call   393b <mkdir>
    204d:	83 c4 10             	add    $0x10,%esp
    2050:	85 c0                	test   %eax,%eax
    2052:	0f 84 7e 01 00 00    	je     21d6 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2058:	83 ec 0c             	sub    $0xc,%esp
    205b:	68 9b 46 00 00       	push   $0x469b
    2060:	e8 d6 18 00 00       	call   393b <mkdir>
    2065:	83 c4 10             	add    $0x10,%esp
    2068:	85 c0                	test   %eax,%eax
    206a:	0f 84 67 03 00 00    	je     23d7 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    2070:	83 ec 0c             	sub    $0xc,%esp
    2073:	68 c2 45 00 00       	push   $0x45c2
    2078:	e8 be 18 00 00       	call   393b <mkdir>
    207d:	83 c4 10             	add    $0x10,%esp
    2080:	85 c0                	test   %eax,%eax
    2082:	0f 84 3c 03 00 00    	je     23c4 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    2088:	83 ec 0c             	sub    $0xc,%esp
    208b:	68 9b 46 00 00       	push   $0x469b
    2090:	e8 8e 18 00 00       	call   3923 <unlink>
    2095:	83 c4 10             	add    $0x10,%esp
    2098:	85 c0                	test   %eax,%eax
    209a:	0f 84 11 03 00 00    	je     23b1 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    20a0:	83 ec 0c             	sub    $0xc,%esp
    20a3:	68 76 46 00 00       	push   $0x4676
    20a8:	e8 76 18 00 00       	call   3923 <unlink>
    20ad:	83 c4 10             	add    $0x10,%esp
    20b0:	85 c0                	test   %eax,%eax
    20b2:	0f 84 e6 02 00 00    	je     239e <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    20b8:	83 ec 0c             	sub    $0xc,%esp
    20bb:	68 61 45 00 00       	push   $0x4561
    20c0:	e8 7e 18 00 00       	call   3943 <chdir>
    20c5:	83 c4 10             	add    $0x10,%esp
    20c8:	85 c0                	test   %eax,%eax
    20ca:	0f 84 bb 02 00 00    	je     238b <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    20d0:	83 ec 0c             	sub    $0xc,%esp
    20d3:	68 0d 47 00 00       	push   $0x470d
    20d8:	e8 66 18 00 00       	call   3943 <chdir>
    20dd:	83 c4 10             	add    $0x10,%esp
    20e0:	85 c0                	test   %eax,%eax
    20e2:	0f 84 90 02 00 00    	je     2378 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    20e8:	83 ec 0c             	sub    $0xc,%esp
    20eb:	68 c2 45 00 00       	push   $0x45c2
    20f0:	e8 2e 18 00 00       	call   3923 <unlink>
    20f5:	83 c4 10             	add    $0x10,%esp
    20f8:	85 c0                	test   %eax,%eax
    20fa:	0f 85 9d 00 00 00    	jne    219d <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    2100:	83 ec 0c             	sub    $0xc,%esp
    2103:	68 61 45 00 00       	push   $0x4561
    2108:	e8 16 18 00 00       	call   3923 <unlink>
    210d:	83 c4 10             	add    $0x10,%esp
    2110:	85 c0                	test   %eax,%eax
    2112:	0f 85 4d 02 00 00    	jne    2365 <subdir+0x635>
  if(unlink("dd") == 0){
    2118:	83 ec 0c             	sub    $0xc,%esp
    211b:	68 28 46 00 00       	push   $0x4628
    2120:	e8 fe 17 00 00       	call   3923 <unlink>
    2125:	83 c4 10             	add    $0x10,%esp
    2128:	85 c0                	test   %eax,%eax
    212a:	0f 84 22 02 00 00    	je     2352 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    2130:	83 ec 0c             	sub    $0xc,%esp
    2133:	68 3d 45 00 00       	push   $0x453d
    2138:	e8 e6 17 00 00       	call   3923 <unlink>
    213d:	83 c4 10             	add    $0x10,%esp
    2140:	85 c0                	test   %eax,%eax
    2142:	0f 88 f7 01 00 00    	js     233f <subdir+0x60f>
  if(unlink("dd") < 0){
    2148:	83 ec 0c             	sub    $0xc,%esp
    214b:	68 28 46 00 00       	push   $0x4628
    2150:	e8 ce 17 00 00       	call   3923 <unlink>
    2155:	83 c4 10             	add    $0x10,%esp
    2158:	85 c0                	test   %eax,%eax
    215a:	0f 88 cc 01 00 00    	js     232c <subdir+0x5fc>
  printf(1, "subdir ok\n");
    2160:	83 ec 08             	sub    $0x8,%esp
    2163:	68 0a 48 00 00       	push   $0x480a
    2168:	6a 01                	push   $0x1
    216a:	e8 e1 18 00 00       	call   3a50 <printf>
}
    216f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2172:	83 c4 10             	add    $0x10,%esp
    2175:	c9                   	leave  
    2176:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    2177:	50                   	push   %eax
    2178:	50                   	push   %eax
    2179:	68 a7 45 00 00       	push   $0x45a7
    217e:	6a 01                	push   $0x1
    2180:	e8 cb 18 00 00       	call   3a50 <printf>
    exit();
    2185:	e8 49 17 00 00       	call   38d3 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    218a:	50                   	push   %eax
    218b:	50                   	push   %eax
    218c:	68 02 46 00 00       	push   $0x4602
    2191:	6a 01                	push   $0x1
    2193:	e8 b8 18 00 00       	call   3a50 <printf>
    exit();
    2198:	e8 36 17 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    219d:	50                   	push   %eax
    219e:	50                   	push   %eax
    219f:	68 cd 45 00 00       	push   $0x45cd
    21a4:	6a 01                	push   $0x1
    21a6:	e8 a5 18 00 00       	call   3a50 <printf>
    exit();
    21ab:	e8 23 17 00 00       	call   38d3 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    21b0:	51                   	push   %ecx
    21b1:	51                   	push   %ecx
    21b2:	68 7f 46 00 00       	push   $0x467f
    21b7:	6a 01                	push   $0x1
    21b9:	e8 92 18 00 00       	call   3a50 <printf>
    exit();
    21be:	e8 10 17 00 00       	call   38d3 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    21c3:	53                   	push   %ebx
    21c4:	53                   	push   %ebx
    21c5:	68 64 50 00 00       	push   $0x5064
    21ca:	6a 01                	push   $0x1
    21cc:	e8 7f 18 00 00       	call   3a50 <printf>
    exit();
    21d1:	e8 fd 16 00 00       	call   38d3 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    21d6:	51                   	push   %ecx
    21d7:	51                   	push   %ecx
    21d8:	68 13 47 00 00       	push   $0x4713
    21dd:	6a 01                	push   $0x1
    21df:	e8 6c 18 00 00       	call   3a50 <printf>
    exit();
    21e4:	e8 ea 16 00 00       	call   38d3 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21e9:	53                   	push   %ebx
    21ea:	53                   	push   %ebx
    21eb:	68 d4 50 00 00       	push   $0x50d4
    21f0:	6a 01                	push   $0x1
    21f2:	e8 59 18 00 00       	call   3a50 <printf>
    exit();
    21f7:	e8 d7 16 00 00       	call   38d3 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    21fc:	50                   	push   %eax
    21fd:	50                   	push   %eax
    21fe:	68 8e 45 00 00       	push   $0x458e
    2203:	6a 01                	push   $0x1
    2205:	e8 46 18 00 00       	call   3a50 <printf>
    exit();
    220a:	e8 c4 16 00 00       	call   38d3 <exit>
    printf(1, "create dd/dd/ff failed\n");
    220f:	51                   	push   %ecx
    2210:	51                   	push   %ecx
    2211:	68 67 45 00 00       	push   $0x4567
    2216:	6a 01                	push   $0x1
    2218:	e8 33 18 00 00       	call   3a50 <printf>
    exit();
    221d:	e8 b1 16 00 00       	call   38d3 <exit>
    printf(1, "chdir ./.. failed\n");
    2222:	50                   	push   %eax
    2223:	50                   	push   %eax
    2224:	68 30 46 00 00       	push   $0x4630
    2229:	6a 01                	push   $0x1
    222b:	e8 20 18 00 00       	call   3a50 <printf>
    exit();
    2230:	e8 9e 16 00 00       	call   38d3 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2235:	52                   	push   %edx
    2236:	52                   	push   %edx
    2237:	68 1c 50 00 00       	push   $0x501c
    223c:	6a 01                	push   $0x1
    223e:	e8 0d 18 00 00       	call   3a50 <printf>
    exit();
    2243:	e8 8b 16 00 00       	call   38d3 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2248:	50                   	push   %eax
    2249:	50                   	push   %eax
    224a:	68 b0 50 00 00       	push   $0x50b0
    224f:	6a 01                	push   $0x1
    2251:	e8 fa 17 00 00       	call   3a50 <printf>
    exit();
    2256:	e8 78 16 00 00       	call   38d3 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    225b:	50                   	push   %eax
    225c:	50                   	push   %eax
    225d:	68 8c 50 00 00       	push   $0x508c
    2262:	6a 01                	push   $0x1
    2264:	e8 e7 17 00 00       	call   3a50 <printf>
    exit();
    2269:	e8 65 16 00 00       	call   38d3 <exit>
    printf(1, "open dd wronly succeeded!\n");
    226e:	50                   	push   %eax
    226f:	50                   	push   %eax
    2270:	68 ef 46 00 00       	push   $0x46ef
    2275:	6a 01                	push   $0x1
    2277:	e8 d4 17 00 00       	call   3a50 <printf>
    exit();
    227c:	e8 52 16 00 00       	call   38d3 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2281:	50                   	push   %eax
    2282:	50                   	push   %eax
    2283:	68 d6 46 00 00       	push   $0x46d6
    2288:	6a 01                	push   $0x1
    228a:	e8 c1 17 00 00       	call   3a50 <printf>
    exit();
    228f:	e8 3f 16 00 00       	call   38d3 <exit>
    printf(1, "create dd succeeded!\n");
    2294:	50                   	push   %eax
    2295:	50                   	push   %eax
    2296:	68 c0 46 00 00       	push   $0x46c0
    229b:	6a 01                	push   $0x1
    229d:	e8 ae 17 00 00       	call   3a50 <printf>
    exit();
    22a2:	e8 2c 16 00 00       	call   38d3 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    22a7:	52                   	push   %edx
    22a8:	52                   	push   %edx
    22a9:	68 a4 46 00 00       	push   $0x46a4
    22ae:	6a 01                	push   $0x1
    22b0:	e8 9b 17 00 00       	call   3a50 <printf>
    exit();
    22b5:	e8 19 16 00 00       	call   38d3 <exit>
    printf(1, "chdir dd failed\n");
    22ba:	50                   	push   %eax
    22bb:	50                   	push   %eax
    22bc:	68 e5 45 00 00       	push   $0x45e5
    22c1:	6a 01                	push   $0x1
    22c3:	e8 88 17 00 00       	call   3a50 <printf>
    exit();
    22c8:	e8 06 16 00 00       	call   38d3 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    22cd:	50                   	push   %eax
    22ce:	50                   	push   %eax
    22cf:	68 40 50 00 00       	push   $0x5040
    22d4:	6a 01                	push   $0x1
    22d6:	e8 75 17 00 00       	call   3a50 <printf>
    exit();
    22db:	e8 f3 15 00 00       	call   38d3 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    22e0:	53                   	push   %ebx
    22e1:	53                   	push   %ebx
    22e2:	68 43 45 00 00       	push   $0x4543
    22e7:	6a 01                	push   $0x1
    22e9:	e8 62 17 00 00       	call   3a50 <printf>
    exit();
    22ee:	e8 e0 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    22f3:	50                   	push   %eax
    22f4:	50                   	push   %eax
    22f5:	68 f4 4f 00 00       	push   $0x4ff4
    22fa:	6a 01                	push   $0x1
    22fc:	e8 4f 17 00 00       	call   3a50 <printf>
    exit();
    2301:	e8 cd 15 00 00       	call   38d3 <exit>
    printf(1, "create dd/ff failed\n");
    2306:	50                   	push   %eax
    2307:	50                   	push   %eax
    2308:	68 27 45 00 00       	push   $0x4527
    230d:	6a 01                	push   $0x1
    230f:	e8 3c 17 00 00       	call   3a50 <printf>
    exit();
    2314:	e8 ba 15 00 00       	call   38d3 <exit>
    printf(1, "subdir mkdir dd failed\n");
    2319:	50                   	push   %eax
    231a:	50                   	push   %eax
    231b:	68 0f 45 00 00       	push   $0x450f
    2320:	6a 01                	push   $0x1
    2322:	e8 29 17 00 00       	call   3a50 <printf>
    exit();
    2327:	e8 a7 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd failed\n");
    232c:	50                   	push   %eax
    232d:	50                   	push   %eax
    232e:	68 f8 47 00 00       	push   $0x47f8
    2333:	6a 01                	push   $0x1
    2335:	e8 16 17 00 00       	call   3a50 <printf>
    exit();
    233a:	e8 94 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/dd failed\n");
    233f:	52                   	push   %edx
    2340:	52                   	push   %edx
    2341:	68 e3 47 00 00       	push   $0x47e3
    2346:	6a 01                	push   $0x1
    2348:	e8 03 17 00 00       	call   3a50 <printf>
    exit();
    234d:	e8 81 15 00 00       	call   38d3 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    2352:	51                   	push   %ecx
    2353:	51                   	push   %ecx
    2354:	68 f8 50 00 00       	push   $0x50f8
    2359:	6a 01                	push   $0x1
    235b:	e8 f0 16 00 00       	call   3a50 <printf>
    exit();
    2360:	e8 6e 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/ff failed\n");
    2365:	53                   	push   %ebx
    2366:	53                   	push   %ebx
    2367:	68 ce 47 00 00       	push   $0x47ce
    236c:	6a 01                	push   $0x1
    236e:	e8 dd 16 00 00       	call   3a50 <printf>
    exit();
    2373:	e8 5b 15 00 00       	call   38d3 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2378:	50                   	push   %eax
    2379:	50                   	push   %eax
    237a:	68 b6 47 00 00       	push   $0x47b6
    237f:	6a 01                	push   $0x1
    2381:	e8 ca 16 00 00       	call   3a50 <printf>
    exit();
    2386:	e8 48 15 00 00       	call   38d3 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    238b:	50                   	push   %eax
    238c:	50                   	push   %eax
    238d:	68 9e 47 00 00       	push   $0x479e
    2392:	6a 01                	push   $0x1
    2394:	e8 b7 16 00 00       	call   3a50 <printf>
    exit();
    2399:	e8 35 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    239e:	50                   	push   %eax
    239f:	50                   	push   %eax
    23a0:	68 82 47 00 00       	push   $0x4782
    23a5:	6a 01                	push   $0x1
    23a7:	e8 a4 16 00 00       	call   3a50 <printf>
    exit();
    23ac:	e8 22 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    23b1:	50                   	push   %eax
    23b2:	50                   	push   %eax
    23b3:	68 66 47 00 00       	push   $0x4766
    23b8:	6a 01                	push   $0x1
    23ba:	e8 91 16 00 00       	call   3a50 <printf>
    exit();
    23bf:	e8 0f 15 00 00       	call   38d3 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    23c4:	50                   	push   %eax
    23c5:	50                   	push   %eax
    23c6:	68 49 47 00 00       	push   $0x4749
    23cb:	6a 01                	push   $0x1
    23cd:	e8 7e 16 00 00       	call   3a50 <printf>
    exit();
    23d2:	e8 fc 14 00 00       	call   38d3 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    23d7:	52                   	push   %edx
    23d8:	52                   	push   %edx
    23d9:	68 2e 47 00 00       	push   $0x472e
    23de:	6a 01                	push   $0x1
    23e0:	e8 6b 16 00 00       	call   3a50 <printf>
    exit();
    23e5:	e8 e9 14 00 00       	call   38d3 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    23ea:	51                   	push   %ecx
    23eb:	51                   	push   %ecx
    23ec:	68 5b 46 00 00       	push   $0x465b
    23f1:	6a 01                	push   $0x1
    23f3:	e8 58 16 00 00       	call   3a50 <printf>
    exit();
    23f8:	e8 d6 14 00 00       	call   38d3 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    23fd:	53                   	push   %ebx
    23fe:	53                   	push   %ebx
    23ff:	68 43 46 00 00       	push   $0x4643
    2404:	6a 01                	push   $0x1
    2406:	e8 45 16 00 00       	call   3a50 <printf>
    exit();
    240b:	e8 c3 14 00 00       	call   38d3 <exit>

00002410 <bigwrite>:
{
    2410:	55                   	push   %ebp
    2411:	89 e5                	mov    %esp,%ebp
    2413:	56                   	push   %esi
    2414:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    2415:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
    241a:	83 ec 08             	sub    $0x8,%esp
    241d:	68 15 48 00 00       	push   $0x4815
    2422:	6a 01                	push   $0x1
    2424:	e8 27 16 00 00       	call   3a50 <printf>
  unlink("bigwrite");
    2429:	c7 04 24 24 48 00 00 	movl   $0x4824,(%esp)
    2430:	e8 ee 14 00 00       	call   3923 <unlink>
    2435:	83 c4 10             	add    $0x10,%esp
    2438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    243f:	90                   	nop
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2440:	83 ec 08             	sub    $0x8,%esp
    2443:	68 02 02 00 00       	push   $0x202
    2448:	68 24 48 00 00       	push   $0x4824
    244d:	e8 c1 14 00 00       	call   3913 <open>
    if(fd < 0){
    2452:	83 c4 10             	add    $0x10,%esp
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2455:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2457:	85 c0                	test   %eax,%eax
    2459:	78 7e                	js     24d9 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    245b:	83 ec 04             	sub    $0x4,%esp
    245e:	53                   	push   %ebx
    245f:	68 40 86 00 00       	push   $0x8640
    2464:	50                   	push   %eax
    2465:	e8 89 14 00 00       	call   38f3 <write>
      if(cc != sz){
    246a:	83 c4 10             	add    $0x10,%esp
    246d:	39 d8                	cmp    %ebx,%eax
    246f:	75 55                	jne    24c6 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
    2471:	83 ec 04             	sub    $0x4,%esp
    2474:	53                   	push   %ebx
    2475:	68 40 86 00 00       	push   $0x8640
    247a:	56                   	push   %esi
    247b:	e8 73 14 00 00       	call   38f3 <write>
      if(cc != sz){
    2480:	83 c4 10             	add    $0x10,%esp
    2483:	39 d8                	cmp    %ebx,%eax
    2485:	75 3f                	jne    24c6 <bigwrite+0xb6>
    close(fd);
    2487:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    248a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2490:	56                   	push   %esi
    2491:	e8 65 14 00 00       	call   38fb <close>
    unlink("bigwrite");
    2496:	c7 04 24 24 48 00 00 	movl   $0x4824,(%esp)
    249d:	e8 81 14 00 00       	call   3923 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    24a2:	83 c4 10             	add    $0x10,%esp
    24a5:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    24ab:	75 93                	jne    2440 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    24ad:	83 ec 08             	sub    $0x8,%esp
    24b0:	68 57 48 00 00       	push   $0x4857
    24b5:	6a 01                	push   $0x1
    24b7:	e8 94 15 00 00       	call   3a50 <printf>
}
    24bc:	83 c4 10             	add    $0x10,%esp
    24bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24c2:	5b                   	pop    %ebx
    24c3:	5e                   	pop    %esi
    24c4:	5d                   	pop    %ebp
    24c5:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    24c6:	50                   	push   %eax
    24c7:	53                   	push   %ebx
    24c8:	68 45 48 00 00       	push   $0x4845
    24cd:	6a 01                	push   $0x1
    24cf:	e8 7c 15 00 00       	call   3a50 <printf>
        exit();
    24d4:	e8 fa 13 00 00       	call   38d3 <exit>
      printf(1, "cannot create bigwrite\n");
    24d9:	83 ec 08             	sub    $0x8,%esp
    24dc:	68 2d 48 00 00       	push   $0x482d
    24e1:	6a 01                	push   $0x1
    24e3:	e8 68 15 00 00       	call   3a50 <printf>
      exit();
    24e8:	e8 e6 13 00 00       	call   38d3 <exit>
    24ed:	8d 76 00             	lea    0x0(%esi),%esi

000024f0 <bigfile>:
{
    24f0:	55                   	push   %ebp
    24f1:	89 e5                	mov    %esp,%ebp
    24f3:	57                   	push   %edi
    24f4:	56                   	push   %esi
    24f5:	53                   	push   %ebx
    24f6:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    24f9:	68 64 48 00 00       	push   $0x4864
    24fe:	6a 01                	push   $0x1
    2500:	e8 4b 15 00 00       	call   3a50 <printf>
  unlink("bigfile");
    2505:	c7 04 24 80 48 00 00 	movl   $0x4880,(%esp)
    250c:	e8 12 14 00 00       	call   3923 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2511:	58                   	pop    %eax
    2512:	5a                   	pop    %edx
    2513:	68 02 02 00 00       	push   $0x202
    2518:	68 80 48 00 00       	push   $0x4880
    251d:	e8 f1 13 00 00       	call   3913 <open>
  if(fd < 0){
    2522:	83 c4 10             	add    $0x10,%esp
    2525:	85 c0                	test   %eax,%eax
    2527:	0f 88 5e 01 00 00    	js     268b <bigfile+0x19b>
    252d:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    252f:	31 db                	xor    %ebx,%ebx
    2531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    2538:	83 ec 04             	sub    $0x4,%esp
    253b:	68 58 02 00 00       	push   $0x258
    2540:	53                   	push   %ebx
    2541:	68 40 86 00 00       	push   $0x8640
    2546:	e8 e5 11 00 00       	call   3730 <memset>
    if(write(fd, buf, 600) != 600){
    254b:	83 c4 0c             	add    $0xc,%esp
    254e:	68 58 02 00 00       	push   $0x258
    2553:	68 40 86 00 00       	push   $0x8640
    2558:	56                   	push   %esi
    2559:	e8 95 13 00 00       	call   38f3 <write>
    255e:	83 c4 10             	add    $0x10,%esp
    2561:	3d 58 02 00 00       	cmp    $0x258,%eax
    2566:	0f 85 f8 00 00 00    	jne    2664 <bigfile+0x174>
  for(i = 0; i < 20; i++){
    256c:	83 c3 01             	add    $0x1,%ebx
    256f:	83 fb 14             	cmp    $0x14,%ebx
    2572:	75 c4                	jne    2538 <bigfile+0x48>
  close(fd);
    2574:	83 ec 0c             	sub    $0xc,%esp
    2577:	56                   	push   %esi
    2578:	e8 7e 13 00 00       	call   38fb <close>
  fd = open("bigfile", 0);
    257d:	5e                   	pop    %esi
    257e:	5f                   	pop    %edi
    257f:	6a 00                	push   $0x0
    2581:	68 80 48 00 00       	push   $0x4880
    2586:	e8 88 13 00 00       	call   3913 <open>
  if(fd < 0){
    258b:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", 0);
    258e:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2590:	85 c0                	test   %eax,%eax
    2592:	0f 88 e0 00 00 00    	js     2678 <bigfile+0x188>
  total = 0;
    2598:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    259a:	31 ff                	xor    %edi,%edi
    259c:	eb 30                	jmp    25ce <bigfile+0xde>
    259e:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    25a0:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    25a5:	0f 85 91 00 00 00    	jne    263c <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
    25ab:	89 fa                	mov    %edi,%edx
    25ad:	0f be 05 40 86 00 00 	movsbl 0x8640,%eax
    25b4:	d1 fa                	sar    %edx
    25b6:	39 d0                	cmp    %edx,%eax
    25b8:	75 6e                	jne    2628 <bigfile+0x138>
    25ba:	0f be 15 6b 87 00 00 	movsbl 0x876b,%edx
    25c1:	39 d0                	cmp    %edx,%eax
    25c3:	75 63                	jne    2628 <bigfile+0x138>
    total += cc;
    25c5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    25cb:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    25ce:	83 ec 04             	sub    $0x4,%esp
    25d1:	68 2c 01 00 00       	push   $0x12c
    25d6:	68 40 86 00 00       	push   $0x8640
    25db:	56                   	push   %esi
    25dc:	e8 0a 13 00 00       	call   38eb <read>
    if(cc < 0){
    25e1:	83 c4 10             	add    $0x10,%esp
    25e4:	85 c0                	test   %eax,%eax
    25e6:	78 68                	js     2650 <bigfile+0x160>
    if(cc == 0)
    25e8:	75 b6                	jne    25a0 <bigfile+0xb0>
  close(fd);
    25ea:	83 ec 0c             	sub    $0xc,%esp
    25ed:	56                   	push   %esi
    25ee:	e8 08 13 00 00       	call   38fb <close>
  if(total != 20*600){
    25f3:	83 c4 10             	add    $0x10,%esp
    25f6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25fc:	0f 85 9c 00 00 00    	jne    269e <bigfile+0x1ae>
  unlink("bigfile");
    2602:	83 ec 0c             	sub    $0xc,%esp
    2605:	68 80 48 00 00       	push   $0x4880
    260a:	e8 14 13 00 00       	call   3923 <unlink>
  printf(1, "bigfile test ok\n");
    260f:	58                   	pop    %eax
    2610:	5a                   	pop    %edx
    2611:	68 0f 49 00 00       	push   $0x490f
    2616:	6a 01                	push   $0x1
    2618:	e8 33 14 00 00       	call   3a50 <printf>
}
    261d:	83 c4 10             	add    $0x10,%esp
    2620:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2623:	5b                   	pop    %ebx
    2624:	5e                   	pop    %esi
    2625:	5f                   	pop    %edi
    2626:	5d                   	pop    %ebp
    2627:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    2628:	83 ec 08             	sub    $0x8,%esp
    262b:	68 dc 48 00 00       	push   $0x48dc
    2630:	6a 01                	push   $0x1
    2632:	e8 19 14 00 00       	call   3a50 <printf>
      exit();
    2637:	e8 97 12 00 00       	call   38d3 <exit>
      printf(1, "short read bigfile\n");
    263c:	83 ec 08             	sub    $0x8,%esp
    263f:	68 c8 48 00 00       	push   $0x48c8
    2644:	6a 01                	push   $0x1
    2646:	e8 05 14 00 00       	call   3a50 <printf>
      exit();
    264b:	e8 83 12 00 00       	call   38d3 <exit>
      printf(1, "read bigfile failed\n");
    2650:	83 ec 08             	sub    $0x8,%esp
    2653:	68 b3 48 00 00       	push   $0x48b3
    2658:	6a 01                	push   $0x1
    265a:	e8 f1 13 00 00       	call   3a50 <printf>
      exit();
    265f:	e8 6f 12 00 00       	call   38d3 <exit>
      printf(1, "write bigfile failed\n");
    2664:	83 ec 08             	sub    $0x8,%esp
    2667:	68 88 48 00 00       	push   $0x4888
    266c:	6a 01                	push   $0x1
    266e:	e8 dd 13 00 00       	call   3a50 <printf>
      exit();
    2673:	e8 5b 12 00 00       	call   38d3 <exit>
    printf(1, "cannot open bigfile\n");
    2678:	53                   	push   %ebx
    2679:	53                   	push   %ebx
    267a:	68 9e 48 00 00       	push   $0x489e
    267f:	6a 01                	push   $0x1
    2681:	e8 ca 13 00 00       	call   3a50 <printf>
    exit();
    2686:	e8 48 12 00 00       	call   38d3 <exit>
    printf(1, "cannot create bigfile");
    268b:	50                   	push   %eax
    268c:	50                   	push   %eax
    268d:	68 72 48 00 00       	push   $0x4872
    2692:	6a 01                	push   $0x1
    2694:	e8 b7 13 00 00       	call   3a50 <printf>
    exit();
    2699:	e8 35 12 00 00       	call   38d3 <exit>
    printf(1, "read bigfile wrong total\n");
    269e:	51                   	push   %ecx
    269f:	51                   	push   %ecx
    26a0:	68 f5 48 00 00       	push   $0x48f5
    26a5:	6a 01                	push   $0x1
    26a7:	e8 a4 13 00 00       	call   3a50 <printf>
    exit();
    26ac:	e8 22 12 00 00       	call   38d3 <exit>
    26b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    26b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    26bf:	90                   	nop

000026c0 <fourteen>:
{
    26c0:	55                   	push   %ebp
    26c1:	89 e5                	mov    %esp,%ebp
    26c3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    26c6:	68 20 49 00 00       	push   $0x4920
    26cb:	6a 01                	push   $0x1
    26cd:	e8 7e 13 00 00       	call   3a50 <printf>
  if(mkdir("12345678901234") != 0){
    26d2:	c7 04 24 5b 49 00 00 	movl   $0x495b,(%esp)
    26d9:	e8 5d 12 00 00       	call   393b <mkdir>
    26de:	83 c4 10             	add    $0x10,%esp
    26e1:	85 c0                	test   %eax,%eax
    26e3:	0f 85 97 00 00 00    	jne    2780 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    26e9:	83 ec 0c             	sub    $0xc,%esp
    26ec:	68 18 51 00 00       	push   $0x5118
    26f1:	e8 45 12 00 00       	call   393b <mkdir>
    26f6:	83 c4 10             	add    $0x10,%esp
    26f9:	85 c0                	test   %eax,%eax
    26fb:	0f 85 de 00 00 00    	jne    27df <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2701:	83 ec 08             	sub    $0x8,%esp
    2704:	68 00 02 00 00       	push   $0x200
    2709:	68 68 51 00 00       	push   $0x5168
    270e:	e8 00 12 00 00       	call   3913 <open>
  if(fd < 0){
    2713:	83 c4 10             	add    $0x10,%esp
    2716:	85 c0                	test   %eax,%eax
    2718:	0f 88 ae 00 00 00    	js     27cc <fourteen+0x10c>
  close(fd);
    271e:	83 ec 0c             	sub    $0xc,%esp
    2721:	50                   	push   %eax
    2722:	e8 d4 11 00 00       	call   38fb <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2727:	58                   	pop    %eax
    2728:	5a                   	pop    %edx
    2729:	6a 00                	push   $0x0
    272b:	68 d8 51 00 00       	push   $0x51d8
    2730:	e8 de 11 00 00       	call   3913 <open>
  if(fd < 0){
    2735:	83 c4 10             	add    $0x10,%esp
    2738:	85 c0                	test   %eax,%eax
    273a:	78 7d                	js     27b9 <fourteen+0xf9>
  close(fd);
    273c:	83 ec 0c             	sub    $0xc,%esp
    273f:	50                   	push   %eax
    2740:	e8 b6 11 00 00       	call   38fb <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2745:	c7 04 24 4c 49 00 00 	movl   $0x494c,(%esp)
    274c:	e8 ea 11 00 00       	call   393b <mkdir>
    2751:	83 c4 10             	add    $0x10,%esp
    2754:	85 c0                	test   %eax,%eax
    2756:	74 4e                	je     27a6 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2758:	83 ec 0c             	sub    $0xc,%esp
    275b:	68 74 52 00 00       	push   $0x5274
    2760:	e8 d6 11 00 00       	call   393b <mkdir>
    2765:	83 c4 10             	add    $0x10,%esp
    2768:	85 c0                	test   %eax,%eax
    276a:	74 27                	je     2793 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    276c:	83 ec 08             	sub    $0x8,%esp
    276f:	68 6a 49 00 00       	push   $0x496a
    2774:	6a 01                	push   $0x1
    2776:	e8 d5 12 00 00       	call   3a50 <printf>
}
    277b:	83 c4 10             	add    $0x10,%esp
    277e:	c9                   	leave  
    277f:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2780:	50                   	push   %eax
    2781:	50                   	push   %eax
    2782:	68 2f 49 00 00       	push   $0x492f
    2787:	6a 01                	push   $0x1
    2789:	e8 c2 12 00 00       	call   3a50 <printf>
    exit();
    278e:	e8 40 11 00 00       	call   38d3 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2793:	50                   	push   %eax
    2794:	50                   	push   %eax
    2795:	68 94 52 00 00       	push   $0x5294
    279a:	6a 01                	push   $0x1
    279c:	e8 af 12 00 00       	call   3a50 <printf>
    exit();
    27a1:	e8 2d 11 00 00       	call   38d3 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    27a6:	52                   	push   %edx
    27a7:	52                   	push   %edx
    27a8:	68 44 52 00 00       	push   $0x5244
    27ad:	6a 01                	push   $0x1
    27af:	e8 9c 12 00 00       	call   3a50 <printf>
    exit();
    27b4:	e8 1a 11 00 00       	call   38d3 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    27b9:	51                   	push   %ecx
    27ba:	51                   	push   %ecx
    27bb:	68 08 52 00 00       	push   $0x5208
    27c0:	6a 01                	push   $0x1
    27c2:	e8 89 12 00 00       	call   3a50 <printf>
    exit();
    27c7:	e8 07 11 00 00       	call   38d3 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    27cc:	51                   	push   %ecx
    27cd:	51                   	push   %ecx
    27ce:	68 98 51 00 00       	push   $0x5198
    27d3:	6a 01                	push   $0x1
    27d5:	e8 76 12 00 00       	call   3a50 <printf>
    exit();
    27da:	e8 f4 10 00 00       	call   38d3 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    27df:	50                   	push   %eax
    27e0:	50                   	push   %eax
    27e1:	68 38 51 00 00       	push   $0x5138
    27e6:	6a 01                	push   $0x1
    27e8:	e8 63 12 00 00       	call   3a50 <printf>
    exit();
    27ed:	e8 e1 10 00 00       	call   38d3 <exit>
    27f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002800 <rmdot>:
{
    2800:	55                   	push   %ebp
    2801:	89 e5                	mov    %esp,%ebp
    2803:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    2806:	68 77 49 00 00       	push   $0x4977
    280b:	6a 01                	push   $0x1
    280d:	e8 3e 12 00 00       	call   3a50 <printf>
  if(mkdir("dots") != 0){
    2812:	c7 04 24 83 49 00 00 	movl   $0x4983,(%esp)
    2819:	e8 1d 11 00 00       	call   393b <mkdir>
    281e:	83 c4 10             	add    $0x10,%esp
    2821:	85 c0                	test   %eax,%eax
    2823:	0f 85 b0 00 00 00    	jne    28d9 <rmdot+0xd9>
  if(chdir("dots") != 0){
    2829:	83 ec 0c             	sub    $0xc,%esp
    282c:	68 83 49 00 00       	push   $0x4983
    2831:	e8 0d 11 00 00       	call   3943 <chdir>
    2836:	83 c4 10             	add    $0x10,%esp
    2839:	85 c0                	test   %eax,%eax
    283b:	0f 85 1d 01 00 00    	jne    295e <rmdot+0x15e>
  if(unlink(".") == 0){
    2841:	83 ec 0c             	sub    $0xc,%esp
    2844:	68 2e 46 00 00       	push   $0x462e
    2849:	e8 d5 10 00 00       	call   3923 <unlink>
    284e:	83 c4 10             	add    $0x10,%esp
    2851:	85 c0                	test   %eax,%eax
    2853:	0f 84 f2 00 00 00    	je     294b <rmdot+0x14b>
  if(unlink("..") == 0){
    2859:	83 ec 0c             	sub    $0xc,%esp
    285c:	68 2d 46 00 00       	push   $0x462d
    2861:	e8 bd 10 00 00       	call   3923 <unlink>
    2866:	83 c4 10             	add    $0x10,%esp
    2869:	85 c0                	test   %eax,%eax
    286b:	0f 84 c7 00 00 00    	je     2938 <rmdot+0x138>
  if(chdir("/") != 0){
    2871:	83 ec 0c             	sub    $0xc,%esp
    2874:	68 01 3e 00 00       	push   $0x3e01
    2879:	e8 c5 10 00 00       	call   3943 <chdir>
    287e:	83 c4 10             	add    $0x10,%esp
    2881:	85 c0                	test   %eax,%eax
    2883:	0f 85 9c 00 00 00    	jne    2925 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2889:	83 ec 0c             	sub    $0xc,%esp
    288c:	68 cb 49 00 00       	push   $0x49cb
    2891:	e8 8d 10 00 00       	call   3923 <unlink>
    2896:	83 c4 10             	add    $0x10,%esp
    2899:	85 c0                	test   %eax,%eax
    289b:	74 75                	je     2912 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    289d:	83 ec 0c             	sub    $0xc,%esp
    28a0:	68 e9 49 00 00       	push   $0x49e9
    28a5:	e8 79 10 00 00       	call   3923 <unlink>
    28aa:	83 c4 10             	add    $0x10,%esp
    28ad:	85 c0                	test   %eax,%eax
    28af:	74 4e                	je     28ff <rmdot+0xff>
  if(unlink("dots") != 0){
    28b1:	83 ec 0c             	sub    $0xc,%esp
    28b4:	68 83 49 00 00       	push   $0x4983
    28b9:	e8 65 10 00 00       	call   3923 <unlink>
    28be:	83 c4 10             	add    $0x10,%esp
    28c1:	85 c0                	test   %eax,%eax
    28c3:	75 27                	jne    28ec <rmdot+0xec>
  printf(1, "rmdot ok\n");
    28c5:	83 ec 08             	sub    $0x8,%esp
    28c8:	68 1e 4a 00 00       	push   $0x4a1e
    28cd:	6a 01                	push   $0x1
    28cf:	e8 7c 11 00 00       	call   3a50 <printf>
}
    28d4:	83 c4 10             	add    $0x10,%esp
    28d7:	c9                   	leave  
    28d8:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    28d9:	50                   	push   %eax
    28da:	50                   	push   %eax
    28db:	68 88 49 00 00       	push   $0x4988
    28e0:	6a 01                	push   $0x1
    28e2:	e8 69 11 00 00       	call   3a50 <printf>
    exit();
    28e7:	e8 e7 0f 00 00       	call   38d3 <exit>
    printf(1, "unlink dots failed!\n");
    28ec:	50                   	push   %eax
    28ed:	50                   	push   %eax
    28ee:	68 09 4a 00 00       	push   $0x4a09
    28f3:	6a 01                	push   $0x1
    28f5:	e8 56 11 00 00       	call   3a50 <printf>
    exit();
    28fa:	e8 d4 0f 00 00       	call   38d3 <exit>
    printf(1, "unlink dots/.. worked!\n");
    28ff:	52                   	push   %edx
    2900:	52                   	push   %edx
    2901:	68 f1 49 00 00       	push   $0x49f1
    2906:	6a 01                	push   $0x1
    2908:	e8 43 11 00 00       	call   3a50 <printf>
    exit();
    290d:	e8 c1 0f 00 00       	call   38d3 <exit>
    printf(1, "unlink dots/. worked!\n");
    2912:	51                   	push   %ecx
    2913:	51                   	push   %ecx
    2914:	68 d2 49 00 00       	push   $0x49d2
    2919:	6a 01                	push   $0x1
    291b:	e8 30 11 00 00       	call   3a50 <printf>
    exit();
    2920:	e8 ae 0f 00 00       	call   38d3 <exit>
    printf(1, "chdir / failed\n");
    2925:	50                   	push   %eax
    2926:	50                   	push   %eax
    2927:	68 03 3e 00 00       	push   $0x3e03
    292c:	6a 01                	push   $0x1
    292e:	e8 1d 11 00 00       	call   3a50 <printf>
    exit();
    2933:	e8 9b 0f 00 00       	call   38d3 <exit>
    printf(1, "rm .. worked!\n");
    2938:	50                   	push   %eax
    2939:	50                   	push   %eax
    293a:	68 bc 49 00 00       	push   $0x49bc
    293f:	6a 01                	push   $0x1
    2941:	e8 0a 11 00 00       	call   3a50 <printf>
    exit();
    2946:	e8 88 0f 00 00       	call   38d3 <exit>
    printf(1, "rm . worked!\n");
    294b:	50                   	push   %eax
    294c:	50                   	push   %eax
    294d:	68 ae 49 00 00       	push   $0x49ae
    2952:	6a 01                	push   $0x1
    2954:	e8 f7 10 00 00       	call   3a50 <printf>
    exit();
    2959:	e8 75 0f 00 00       	call   38d3 <exit>
    printf(1, "chdir dots failed\n");
    295e:	50                   	push   %eax
    295f:	50                   	push   %eax
    2960:	68 9b 49 00 00       	push   $0x499b
    2965:	6a 01                	push   $0x1
    2967:	e8 e4 10 00 00       	call   3a50 <printf>
    exit();
    296c:	e8 62 0f 00 00       	call   38d3 <exit>
    2971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    297f:	90                   	nop

00002980 <dirfile>:
{
    2980:	55                   	push   %ebp
    2981:	89 e5                	mov    %esp,%ebp
    2983:	53                   	push   %ebx
    2984:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    2987:	68 28 4a 00 00       	push   $0x4a28
    298c:	6a 01                	push   $0x1
    298e:	e8 bd 10 00 00       	call   3a50 <printf>
  fd = open("dirfile", O_CREATE);
    2993:	5b                   	pop    %ebx
    2994:	58                   	pop    %eax
    2995:	68 00 02 00 00       	push   $0x200
    299a:	68 35 4a 00 00       	push   $0x4a35
    299f:	e8 6f 0f 00 00       	call   3913 <open>
  if(fd < 0){
    29a4:	83 c4 10             	add    $0x10,%esp
    29a7:	85 c0                	test   %eax,%eax
    29a9:	0f 88 43 01 00 00    	js     2af2 <dirfile+0x172>
  close(fd);
    29af:	83 ec 0c             	sub    $0xc,%esp
    29b2:	50                   	push   %eax
    29b3:	e8 43 0f 00 00       	call   38fb <close>
  if(chdir("dirfile") == 0){
    29b8:	c7 04 24 35 4a 00 00 	movl   $0x4a35,(%esp)
    29bf:	e8 7f 0f 00 00       	call   3943 <chdir>
    29c4:	83 c4 10             	add    $0x10,%esp
    29c7:	85 c0                	test   %eax,%eax
    29c9:	0f 84 10 01 00 00    	je     2adf <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    29cf:	83 ec 08             	sub    $0x8,%esp
    29d2:	6a 00                	push   $0x0
    29d4:	68 6e 4a 00 00       	push   $0x4a6e
    29d9:	e8 35 0f 00 00       	call   3913 <open>
  if(fd >= 0){
    29de:	83 c4 10             	add    $0x10,%esp
    29e1:	85 c0                	test   %eax,%eax
    29e3:	0f 89 e3 00 00 00    	jns    2acc <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    29e9:	83 ec 08             	sub    $0x8,%esp
    29ec:	68 00 02 00 00       	push   $0x200
    29f1:	68 6e 4a 00 00       	push   $0x4a6e
    29f6:	e8 18 0f 00 00       	call   3913 <open>
  if(fd >= 0){
    29fb:	83 c4 10             	add    $0x10,%esp
    29fe:	85 c0                	test   %eax,%eax
    2a00:	0f 89 c6 00 00 00    	jns    2acc <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    2a06:	83 ec 0c             	sub    $0xc,%esp
    2a09:	68 6e 4a 00 00       	push   $0x4a6e
    2a0e:	e8 28 0f 00 00       	call   393b <mkdir>
    2a13:	83 c4 10             	add    $0x10,%esp
    2a16:	85 c0                	test   %eax,%eax
    2a18:	0f 84 46 01 00 00    	je     2b64 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    2a1e:	83 ec 0c             	sub    $0xc,%esp
    2a21:	68 6e 4a 00 00       	push   $0x4a6e
    2a26:	e8 f8 0e 00 00       	call   3923 <unlink>
    2a2b:	83 c4 10             	add    $0x10,%esp
    2a2e:	85 c0                	test   %eax,%eax
    2a30:	0f 84 1b 01 00 00    	je     2b51 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    2a36:	83 ec 08             	sub    $0x8,%esp
    2a39:	68 6e 4a 00 00       	push   $0x4a6e
    2a3e:	68 d2 4a 00 00       	push   $0x4ad2
    2a43:	e8 eb 0e 00 00       	call   3933 <link>
    2a48:	83 c4 10             	add    $0x10,%esp
    2a4b:	85 c0                	test   %eax,%eax
    2a4d:	0f 84 eb 00 00 00    	je     2b3e <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    2a53:	83 ec 0c             	sub    $0xc,%esp
    2a56:	68 35 4a 00 00       	push   $0x4a35
    2a5b:	e8 c3 0e 00 00       	call   3923 <unlink>
    2a60:	83 c4 10             	add    $0x10,%esp
    2a63:	85 c0                	test   %eax,%eax
    2a65:	0f 85 c0 00 00 00    	jne    2b2b <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2a6b:	83 ec 08             	sub    $0x8,%esp
    2a6e:	6a 02                	push   $0x2
    2a70:	68 2e 46 00 00       	push   $0x462e
    2a75:	e8 99 0e 00 00       	call   3913 <open>
  if(fd >= 0){
    2a7a:	83 c4 10             	add    $0x10,%esp
    2a7d:	85 c0                	test   %eax,%eax
    2a7f:	0f 89 93 00 00 00    	jns    2b18 <dirfile+0x198>
  fd = open(".", 0);
    2a85:	83 ec 08             	sub    $0x8,%esp
    2a88:	6a 00                	push   $0x0
    2a8a:	68 2e 46 00 00       	push   $0x462e
    2a8f:	e8 7f 0e 00 00       	call   3913 <open>
  if(write(fd, "x", 1) > 0){
    2a94:	83 c4 0c             	add    $0xc,%esp
    2a97:	6a 01                	push   $0x1
  fd = open(".", 0);
    2a99:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2a9b:	68 11 47 00 00       	push   $0x4711
    2aa0:	50                   	push   %eax
    2aa1:	e8 4d 0e 00 00       	call   38f3 <write>
    2aa6:	83 c4 10             	add    $0x10,%esp
    2aa9:	85 c0                	test   %eax,%eax
    2aab:	7f 58                	jg     2b05 <dirfile+0x185>
  close(fd);
    2aad:	83 ec 0c             	sub    $0xc,%esp
    2ab0:	53                   	push   %ebx
    2ab1:	e8 45 0e 00 00       	call   38fb <close>
  printf(1, "dir vs file OK\n");
    2ab6:	58                   	pop    %eax
    2ab7:	5a                   	pop    %edx
    2ab8:	68 05 4b 00 00       	push   $0x4b05
    2abd:	6a 01                	push   $0x1
    2abf:	e8 8c 0f 00 00       	call   3a50 <printf>
}
    2ac4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ac7:	83 c4 10             	add    $0x10,%esp
    2aca:	c9                   	leave  
    2acb:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2acc:	50                   	push   %eax
    2acd:	50                   	push   %eax
    2ace:	68 79 4a 00 00       	push   $0x4a79
    2ad3:	6a 01                	push   $0x1
    2ad5:	e8 76 0f 00 00       	call   3a50 <printf>
    exit();
    2ada:	e8 f4 0d 00 00       	call   38d3 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2adf:	52                   	push   %edx
    2ae0:	52                   	push   %edx
    2ae1:	68 54 4a 00 00       	push   $0x4a54
    2ae6:	6a 01                	push   $0x1
    2ae8:	e8 63 0f 00 00       	call   3a50 <printf>
    exit();
    2aed:	e8 e1 0d 00 00       	call   38d3 <exit>
    printf(1, "create dirfile failed\n");
    2af2:	51                   	push   %ecx
    2af3:	51                   	push   %ecx
    2af4:	68 3d 4a 00 00       	push   $0x4a3d
    2af9:	6a 01                	push   $0x1
    2afb:	e8 50 0f 00 00       	call   3a50 <printf>
    exit();
    2b00:	e8 ce 0d 00 00       	call   38d3 <exit>
    printf(1, "write . succeeded!\n");
    2b05:	51                   	push   %ecx
    2b06:	51                   	push   %ecx
    2b07:	68 f1 4a 00 00       	push   $0x4af1
    2b0c:	6a 01                	push   $0x1
    2b0e:	e8 3d 0f 00 00       	call   3a50 <printf>
    exit();
    2b13:	e8 bb 0d 00 00       	call   38d3 <exit>
    printf(1, "open . for writing succeeded!\n");
    2b18:	53                   	push   %ebx
    2b19:	53                   	push   %ebx
    2b1a:	68 e8 52 00 00       	push   $0x52e8
    2b1f:	6a 01                	push   $0x1
    2b21:	e8 2a 0f 00 00       	call   3a50 <printf>
    exit();
    2b26:	e8 a8 0d 00 00       	call   38d3 <exit>
    printf(1, "unlink dirfile failed!\n");
    2b2b:	50                   	push   %eax
    2b2c:	50                   	push   %eax
    2b2d:	68 d9 4a 00 00       	push   $0x4ad9
    2b32:	6a 01                	push   $0x1
    2b34:	e8 17 0f 00 00       	call   3a50 <printf>
    exit();
    2b39:	e8 95 0d 00 00       	call   38d3 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    2b3e:	50                   	push   %eax
    2b3f:	50                   	push   %eax
    2b40:	68 c8 52 00 00       	push   $0x52c8
    2b45:	6a 01                	push   $0x1
    2b47:	e8 04 0f 00 00       	call   3a50 <printf>
    exit();
    2b4c:	e8 82 0d 00 00       	call   38d3 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b51:	50                   	push   %eax
    2b52:	50                   	push   %eax
    2b53:	68 b4 4a 00 00       	push   $0x4ab4
    2b58:	6a 01                	push   $0x1
    2b5a:	e8 f1 0e 00 00       	call   3a50 <printf>
    exit();
    2b5f:	e8 6f 0d 00 00       	call   38d3 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b64:	50                   	push   %eax
    2b65:	50                   	push   %eax
    2b66:	68 97 4a 00 00       	push   $0x4a97
    2b6b:	6a 01                	push   $0x1
    2b6d:	e8 de 0e 00 00       	call   3a50 <printf>
    exit();
    2b72:	e8 5c 0d 00 00       	call   38d3 <exit>
    2b77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2b7e:	66 90                	xchg   %ax,%ax

00002b80 <iref>:
{
    2b80:	55                   	push   %ebp
    2b81:	89 e5                	mov    %esp,%ebp
    2b83:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2b84:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2b89:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    2b8c:	68 15 4b 00 00       	push   $0x4b15
    2b91:	6a 01                	push   $0x1
    2b93:	e8 b8 0e 00 00       	call   3a50 <printf>
    2b98:	83 c4 10             	add    $0x10,%esp
    2b9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b9f:	90                   	nop
    if(mkdir("irefd") != 0){
    2ba0:	83 ec 0c             	sub    $0xc,%esp
    2ba3:	68 26 4b 00 00       	push   $0x4b26
    2ba8:	e8 8e 0d 00 00       	call   393b <mkdir>
    2bad:	83 c4 10             	add    $0x10,%esp
    2bb0:	85 c0                	test   %eax,%eax
    2bb2:	0f 85 bb 00 00 00    	jne    2c73 <iref+0xf3>
    if(chdir("irefd") != 0){
    2bb8:	83 ec 0c             	sub    $0xc,%esp
    2bbb:	68 26 4b 00 00       	push   $0x4b26
    2bc0:	e8 7e 0d 00 00       	call   3943 <chdir>
    2bc5:	83 c4 10             	add    $0x10,%esp
    2bc8:	85 c0                	test   %eax,%eax
    2bca:	0f 85 b7 00 00 00    	jne    2c87 <iref+0x107>
    mkdir("");
    2bd0:	83 ec 0c             	sub    $0xc,%esp
    2bd3:	68 db 41 00 00       	push   $0x41db
    2bd8:	e8 5e 0d 00 00       	call   393b <mkdir>
    link("README", "");
    2bdd:	59                   	pop    %ecx
    2bde:	58                   	pop    %eax
    2bdf:	68 db 41 00 00       	push   $0x41db
    2be4:	68 d2 4a 00 00       	push   $0x4ad2
    2be9:	e8 45 0d 00 00       	call   3933 <link>
    fd = open("", O_CREATE);
    2bee:	58                   	pop    %eax
    2bef:	5a                   	pop    %edx
    2bf0:	68 00 02 00 00       	push   $0x200
    2bf5:	68 db 41 00 00       	push   $0x41db
    2bfa:	e8 14 0d 00 00       	call   3913 <open>
    if(fd >= 0)
    2bff:	83 c4 10             	add    $0x10,%esp
    2c02:	85 c0                	test   %eax,%eax
    2c04:	78 0c                	js     2c12 <iref+0x92>
      close(fd);
    2c06:	83 ec 0c             	sub    $0xc,%esp
    2c09:	50                   	push   %eax
    2c0a:	e8 ec 0c 00 00       	call   38fb <close>
    2c0f:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2c12:	83 ec 08             	sub    $0x8,%esp
    2c15:	68 00 02 00 00       	push   $0x200
    2c1a:	68 10 47 00 00       	push   $0x4710
    2c1f:	e8 ef 0c 00 00       	call   3913 <open>
    if(fd >= 0)
    2c24:	83 c4 10             	add    $0x10,%esp
    2c27:	85 c0                	test   %eax,%eax
    2c29:	78 0c                	js     2c37 <iref+0xb7>
      close(fd);
    2c2b:	83 ec 0c             	sub    $0xc,%esp
    2c2e:	50                   	push   %eax
    2c2f:	e8 c7 0c 00 00       	call   38fb <close>
    2c34:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2c37:	83 ec 0c             	sub    $0xc,%esp
    2c3a:	68 10 47 00 00       	push   $0x4710
    2c3f:	e8 df 0c 00 00       	call   3923 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2c44:	83 c4 10             	add    $0x10,%esp
    2c47:	83 eb 01             	sub    $0x1,%ebx
    2c4a:	0f 85 50 ff ff ff    	jne    2ba0 <iref+0x20>
  chdir("/");
    2c50:	83 ec 0c             	sub    $0xc,%esp
    2c53:	68 01 3e 00 00       	push   $0x3e01
    2c58:	e8 e6 0c 00 00       	call   3943 <chdir>
  printf(1, "empty file name OK\n");
    2c5d:	58                   	pop    %eax
    2c5e:	5a                   	pop    %edx
    2c5f:	68 54 4b 00 00       	push   $0x4b54
    2c64:	6a 01                	push   $0x1
    2c66:	e8 e5 0d 00 00       	call   3a50 <printf>
}
    2c6b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c6e:	83 c4 10             	add    $0x10,%esp
    2c71:	c9                   	leave  
    2c72:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    2c73:	83 ec 08             	sub    $0x8,%esp
    2c76:	68 2c 4b 00 00       	push   $0x4b2c
    2c7b:	6a 01                	push   $0x1
    2c7d:	e8 ce 0d 00 00       	call   3a50 <printf>
      exit();
    2c82:	e8 4c 0c 00 00       	call   38d3 <exit>
      printf(1, "chdir irefd failed\n");
    2c87:	83 ec 08             	sub    $0x8,%esp
    2c8a:	68 40 4b 00 00       	push   $0x4b40
    2c8f:	6a 01                	push   $0x1
    2c91:	e8 ba 0d 00 00       	call   3a50 <printf>
      exit();
    2c96:	e8 38 0c 00 00       	call   38d3 <exit>
    2c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2c9f:	90                   	nop

00002ca0 <forktest>:
{
    2ca0:	55                   	push   %ebp
    2ca1:	89 e5                	mov    %esp,%ebp
    2ca3:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2ca4:	31 db                	xor    %ebx,%ebx
{
    2ca6:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2ca9:	68 68 4b 00 00       	push   $0x4b68
    2cae:	6a 01                	push   $0x1
    2cb0:	e8 9b 0d 00 00       	call   3a50 <printf>
    2cb5:	83 c4 10             	add    $0x10,%esp
    2cb8:	eb 13                	jmp    2ccd <forktest+0x2d>
    2cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid == 0)
    2cc0:	74 4a                	je     2d0c <forktest+0x6c>
  for(n=0; n<1000; n++){
    2cc2:	83 c3 01             	add    $0x1,%ebx
    2cc5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2ccb:	74 6b                	je     2d38 <forktest+0x98>
    pid = fork();
    2ccd:	e8 f9 0b 00 00       	call   38cb <fork>
    if(pid < 0)
    2cd2:	85 c0                	test   %eax,%eax
    2cd4:	79 ea                	jns    2cc0 <forktest+0x20>
  for(; n > 0; n--){
    2cd6:	85 db                	test   %ebx,%ebx
    2cd8:	74 14                	je     2cee <forktest+0x4e>
    2cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2ce0:	e8 f6 0b 00 00       	call   38db <wait>
    2ce5:	85 c0                	test   %eax,%eax
    2ce7:	78 28                	js     2d11 <forktest+0x71>
  for(; n > 0; n--){
    2ce9:	83 eb 01             	sub    $0x1,%ebx
    2cec:	75 f2                	jne    2ce0 <forktest+0x40>
  if(wait() != -1){
    2cee:	e8 e8 0b 00 00       	call   38db <wait>
    2cf3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cf6:	75 2d                	jne    2d25 <forktest+0x85>
  printf(1, "fork test OK\n");
    2cf8:	83 ec 08             	sub    $0x8,%esp
    2cfb:	68 9a 4b 00 00       	push   $0x4b9a
    2d00:	6a 01                	push   $0x1
    2d02:	e8 49 0d 00 00       	call   3a50 <printf>
}
    2d07:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2d0a:	c9                   	leave  
    2d0b:	c3                   	ret    
      exit();
    2d0c:	e8 c2 0b 00 00       	call   38d3 <exit>
      printf(1, "wait stopped early\n");
    2d11:	83 ec 08             	sub    $0x8,%esp
    2d14:	68 73 4b 00 00       	push   $0x4b73
    2d19:	6a 01                	push   $0x1
    2d1b:	e8 30 0d 00 00       	call   3a50 <printf>
      exit();
    2d20:	e8 ae 0b 00 00       	call   38d3 <exit>
    printf(1, "wait got too many\n");
    2d25:	52                   	push   %edx
    2d26:	52                   	push   %edx
    2d27:	68 87 4b 00 00       	push   $0x4b87
    2d2c:	6a 01                	push   $0x1
    2d2e:	e8 1d 0d 00 00       	call   3a50 <printf>
    exit();
    2d33:	e8 9b 0b 00 00       	call   38d3 <exit>
    printf(1, "fork claimed to work 1000 times!\n");
    2d38:	50                   	push   %eax
    2d39:	50                   	push   %eax
    2d3a:	68 08 53 00 00       	push   $0x5308
    2d3f:	6a 01                	push   $0x1
    2d41:	e8 0a 0d 00 00       	call   3a50 <printf>
    exit();
    2d46:	e8 88 0b 00 00       	call   38d3 <exit>
    2d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d4f:	90                   	nop

00002d50 <sbrktest>:
{
    2d50:	55                   	push   %ebp
    2d51:	89 e5                	mov    %esp,%ebp
    2d53:	57                   	push   %edi
  for(i = 0; i < 5000; i++){
    2d54:	31 ff                	xor    %edi,%edi
{
    2d56:	56                   	push   %esi
    2d57:	53                   	push   %ebx
    2d58:	83 ec 54             	sub    $0x54,%esp
  printf(stdout, "sbrk test\n");
    2d5b:	68 a8 4b 00 00       	push   $0x4ba8
    2d60:	ff 35 50 5e 00 00    	pushl  0x5e50
    2d66:	e8 e5 0c 00 00       	call   3a50 <printf>
  oldbrk = sbrk(0);
    2d6b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d72:	e8 e4 0b 00 00       	call   395b <sbrk>
  a = sbrk(0);
    2d77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    2d7e:	89 c3                	mov    %eax,%ebx
  a = sbrk(0);
    2d80:	e8 d6 0b 00 00       	call   395b <sbrk>
    2d85:	83 c4 10             	add    $0x10,%esp
    2d88:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 5000; i++){
    2d8a:	eb 06                	jmp    2d92 <sbrktest+0x42>
    2d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    a = b + 1;
    2d90:	89 c6                	mov    %eax,%esi
    b = sbrk(1);
    2d92:	83 ec 0c             	sub    $0xc,%esp
    2d95:	6a 01                	push   $0x1
    2d97:	e8 bf 0b 00 00       	call   395b <sbrk>
    if(b != a){
    2d9c:	83 c4 10             	add    $0x10,%esp
    2d9f:	39 f0                	cmp    %esi,%eax
    2da1:	0f 85 84 02 00 00    	jne    302b <sbrktest+0x2db>
  for(i = 0; i < 5000; i++){
    2da7:	83 c7 01             	add    $0x1,%edi
    *b = 1;
    2daa:	c6 06 01             	movb   $0x1,(%esi)
    a = b + 1;
    2dad:	8d 46 01             	lea    0x1(%esi),%eax
  for(i = 0; i < 5000; i++){
    2db0:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2db6:	75 d8                	jne    2d90 <sbrktest+0x40>
  pid = fork();
    2db8:	e8 0e 0b 00 00       	call   38cb <fork>
    2dbd:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2dbf:	85 c0                	test   %eax,%eax
    2dc1:	0f 88 91 03 00 00    	js     3158 <sbrktest+0x408>
  c = sbrk(1);
    2dc7:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    2dca:	83 c6 02             	add    $0x2,%esi
  c = sbrk(1);
    2dcd:	6a 01                	push   $0x1
    2dcf:	e8 87 0b 00 00       	call   395b <sbrk>
  c = sbrk(1);
    2dd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ddb:	e8 7b 0b 00 00       	call   395b <sbrk>
  if(c != a + 1){
    2de0:	83 c4 10             	add    $0x10,%esp
    2de3:	39 c6                	cmp    %eax,%esi
    2de5:	0f 85 56 03 00 00    	jne    3141 <sbrktest+0x3f1>
  if(pid == 0)
    2deb:	85 ff                	test   %edi,%edi
    2ded:	0f 84 49 03 00 00    	je     313c <sbrktest+0x3ec>
  wait();
    2df3:	e8 e3 0a 00 00       	call   38db <wait>
  a = sbrk(0);
    2df8:	83 ec 0c             	sub    $0xc,%esp
    2dfb:	6a 00                	push   $0x0
    2dfd:	e8 59 0b 00 00       	call   395b <sbrk>
    2e02:	89 c6                	mov    %eax,%esi
  amt = (BIG) - (uint)a;
    2e04:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2e09:	29 f0                	sub    %esi,%eax
  p = sbrk(amt);
    2e0b:	89 04 24             	mov    %eax,(%esp)
    2e0e:	e8 48 0b 00 00       	call   395b <sbrk>
  if (p != a) {
    2e13:	83 c4 10             	add    $0x10,%esp
    2e16:	39 c6                	cmp    %eax,%esi
    2e18:	0f 85 07 03 00 00    	jne    3125 <sbrktest+0x3d5>
  a = sbrk(0);
    2e1e:	83 ec 0c             	sub    $0xc,%esp
  *lastaddr = 99;
    2e21:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    2e28:	6a 00                	push   $0x0
    2e2a:	e8 2c 0b 00 00       	call   395b <sbrk>
  c = sbrk(-4096);
    2e2f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    2e36:	89 c6                	mov    %eax,%esi
  c = sbrk(-4096);
    2e38:	e8 1e 0b 00 00       	call   395b <sbrk>
  if(c == (char*)0xffffffff){
    2e3d:	83 c4 10             	add    $0x10,%esp
    2e40:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e43:	0f 84 c5 02 00 00    	je     310e <sbrktest+0x3be>
  c = sbrk(0);
    2e49:	83 ec 0c             	sub    $0xc,%esp
    2e4c:	6a 00                	push   $0x0
    2e4e:	e8 08 0b 00 00       	call   395b <sbrk>
  if(c != a - 4096){
    2e53:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    2e59:	83 c4 10             	add    $0x10,%esp
    2e5c:	39 d0                	cmp    %edx,%eax
    2e5e:	0f 85 93 02 00 00    	jne    30f7 <sbrktest+0x3a7>
  a = sbrk(0);
    2e64:	83 ec 0c             	sub    $0xc,%esp
    2e67:	6a 00                	push   $0x0
    2e69:	e8 ed 0a 00 00       	call   395b <sbrk>
  c = sbrk(4096);
    2e6e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  a = sbrk(0);
    2e75:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    2e77:	e8 df 0a 00 00       	call   395b <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2e7c:	83 c4 10             	add    $0x10,%esp
  c = sbrk(4096);
    2e7f:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    2e81:	39 c6                	cmp    %eax,%esi
    2e83:	0f 85 57 02 00 00    	jne    30e0 <sbrktest+0x390>
    2e89:	83 ec 0c             	sub    $0xc,%esp
    2e8c:	6a 00                	push   $0x0
    2e8e:	e8 c8 0a 00 00       	call   395b <sbrk>
    2e93:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    2e99:	83 c4 10             	add    $0x10,%esp
    2e9c:	39 c2                	cmp    %eax,%edx
    2e9e:	0f 85 3c 02 00 00    	jne    30e0 <sbrktest+0x390>
  if(*lastaddr == 99){
    2ea4:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2eab:	0f 84 18 02 00 00    	je     30c9 <sbrktest+0x379>
  a = sbrk(0);
    2eb1:	83 ec 0c             	sub    $0xc,%esp
    2eb4:	6a 00                	push   $0x0
    2eb6:	e8 a0 0a 00 00       	call   395b <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2ebb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    2ec2:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    2ec4:	e8 92 0a 00 00       	call   395b <sbrk>
    2ec9:	89 d9                	mov    %ebx,%ecx
    2ecb:	29 c1                	sub    %eax,%ecx
    2ecd:	89 0c 24             	mov    %ecx,(%esp)
    2ed0:	e8 86 0a 00 00       	call   395b <sbrk>
  if(c != a){
    2ed5:	83 c4 10             	add    $0x10,%esp
    2ed8:	39 c6                	cmp    %eax,%esi
    2eda:	0f 85 d2 01 00 00    	jne    30b2 <sbrktest+0x362>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ee0:	be 00 00 00 80       	mov    $0x80000000,%esi
    2ee5:	8d 76 00             	lea    0x0(%esi),%esi
    ppid = getpid();
    2ee8:	e8 66 0a 00 00       	call   3953 <getpid>
    2eed:	89 c7                	mov    %eax,%edi
    pid = fork();
    2eef:	e8 d7 09 00 00       	call   38cb <fork>
    if(pid < 0){
    2ef4:	85 c0                	test   %eax,%eax
    2ef6:	0f 88 9e 01 00 00    	js     309a <sbrktest+0x34a>
    if(pid == 0){
    2efc:	0f 84 76 01 00 00    	je     3078 <sbrktest+0x328>
    wait();
    2f02:	e8 d4 09 00 00       	call   38db <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2f07:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    2f0d:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    2f13:	75 d3                	jne    2ee8 <sbrktest+0x198>
  if(pipe(fds) != 0){
    2f15:	83 ec 0c             	sub    $0xc,%esp
    2f18:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2f1b:	50                   	push   %eax
    2f1c:	e8 c2 09 00 00       	call   38e3 <pipe>
    2f21:	83 c4 10             	add    $0x10,%esp
    2f24:	85 c0                	test   %eax,%eax
    2f26:	0f 85 34 01 00 00    	jne    3060 <sbrktest+0x310>
    2f2c:	8d 75 c0             	lea    -0x40(%ebp),%esi
    2f2f:	89 f7                	mov    %esi,%edi
    if((pids[i] = fork()) == 0){
    2f31:	e8 95 09 00 00       	call   38cb <fork>
    2f36:	89 07                	mov    %eax,(%edi)
    2f38:	85 c0                	test   %eax,%eax
    2f3a:	0f 84 8f 00 00 00    	je     2fcf <sbrktest+0x27f>
    if(pids[i] != -1)
    2f40:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f43:	74 14                	je     2f59 <sbrktest+0x209>
      read(fds[0], &scratch, 1);
    2f45:	83 ec 04             	sub    $0x4,%esp
    2f48:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f4b:	6a 01                	push   $0x1
    2f4d:	50                   	push   %eax
    2f4e:	ff 75 b8             	pushl  -0x48(%ebp)
    2f51:	e8 95 09 00 00       	call   38eb <read>
    2f56:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f59:	83 c7 04             	add    $0x4,%edi
    2f5c:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f5f:	39 c7                	cmp    %eax,%edi
    2f61:	75 ce                	jne    2f31 <sbrktest+0x1e1>
  c = sbrk(4096);
    2f63:	83 ec 0c             	sub    $0xc,%esp
    2f66:	68 00 10 00 00       	push   $0x1000
    2f6b:	e8 eb 09 00 00       	call   395b <sbrk>
    2f70:	83 c4 10             	add    $0x10,%esp
    2f73:	89 c7                	mov    %eax,%edi
    if(pids[i] == -1)
    2f75:	8b 06                	mov    (%esi),%eax
    2f77:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f7a:	74 11                	je     2f8d <sbrktest+0x23d>
    kill(pids[i]);
    2f7c:	83 ec 0c             	sub    $0xc,%esp
    2f7f:	50                   	push   %eax
    2f80:	e8 7e 09 00 00       	call   3903 <kill>
    wait();
    2f85:	e8 51 09 00 00       	call   38db <wait>
    2f8a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f8d:	83 c6 04             	add    $0x4,%esi
    2f90:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f93:	39 f0                	cmp    %esi,%eax
    2f95:	75 de                	jne    2f75 <sbrktest+0x225>
  if(c == (char*)0xffffffff){
    2f97:	83 ff ff             	cmp    $0xffffffff,%edi
    2f9a:	0f 84 a9 00 00 00    	je     3049 <sbrktest+0x2f9>
  if(sbrk(0) > oldbrk)
    2fa0:	83 ec 0c             	sub    $0xc,%esp
    2fa3:	6a 00                	push   $0x0
    2fa5:	e8 b1 09 00 00       	call   395b <sbrk>
    2faa:	83 c4 10             	add    $0x10,%esp
    2fad:	39 c3                	cmp    %eax,%ebx
    2faf:	72 61                	jb     3012 <sbrktest+0x2c2>
  printf(stdout, "sbrk test OK\n");
    2fb1:	83 ec 08             	sub    $0x8,%esp
    2fb4:	68 50 4c 00 00       	push   $0x4c50
    2fb9:	ff 35 50 5e 00 00    	pushl  0x5e50
    2fbf:	e8 8c 0a 00 00       	call   3a50 <printf>
}
    2fc4:	83 c4 10             	add    $0x10,%esp
    2fc7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fca:	5b                   	pop    %ebx
    2fcb:	5e                   	pop    %esi
    2fcc:	5f                   	pop    %edi
    2fcd:	5d                   	pop    %ebp
    2fce:	c3                   	ret    
      sbrk(BIG - (uint)sbrk(0));
    2fcf:	83 ec 0c             	sub    $0xc,%esp
    2fd2:	6a 00                	push   $0x0
    2fd4:	e8 82 09 00 00       	call   395b <sbrk>
    2fd9:	89 c2                	mov    %eax,%edx
    2fdb:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2fe0:	29 d0                	sub    %edx,%eax
    2fe2:	89 04 24             	mov    %eax,(%esp)
    2fe5:	e8 71 09 00 00       	call   395b <sbrk>
      write(fds[1], "x", 1);
    2fea:	83 c4 0c             	add    $0xc,%esp
    2fed:	6a 01                	push   $0x1
    2fef:	68 11 47 00 00       	push   $0x4711
    2ff4:	ff 75 bc             	pushl  -0x44(%ebp)
    2ff7:	e8 f7 08 00 00       	call   38f3 <write>
    2ffc:	83 c4 10             	add    $0x10,%esp
    2fff:	90                   	nop
      for(;;) sleep(1000);
    3000:	83 ec 0c             	sub    $0xc,%esp
    3003:	68 e8 03 00 00       	push   $0x3e8
    3008:	e8 56 09 00 00       	call   3963 <sleep>
    300d:	83 c4 10             	add    $0x10,%esp
    3010:	eb ee                	jmp    3000 <sbrktest+0x2b0>
    sbrk(-(sbrk(0) - oldbrk));
    3012:	83 ec 0c             	sub    $0xc,%esp
    3015:	6a 00                	push   $0x0
    3017:	e8 3f 09 00 00       	call   395b <sbrk>
    301c:	29 c3                	sub    %eax,%ebx
    301e:	89 1c 24             	mov    %ebx,(%esp)
    3021:	e8 35 09 00 00       	call   395b <sbrk>
    3026:	83 c4 10             	add    $0x10,%esp
    3029:	eb 86                	jmp    2fb1 <sbrktest+0x261>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    302b:	83 ec 0c             	sub    $0xc,%esp
    302e:	50                   	push   %eax
    302f:	56                   	push   %esi
    3030:	57                   	push   %edi
    3031:	68 b3 4b 00 00       	push   $0x4bb3
    3036:	ff 35 50 5e 00 00    	pushl  0x5e50
    303c:	e8 0f 0a 00 00       	call   3a50 <printf>
      exit();
    3041:	83 c4 20             	add    $0x20,%esp
    3044:	e8 8a 08 00 00       	call   38d3 <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    3049:	50                   	push   %eax
    304a:	50                   	push   %eax
    304b:	68 35 4c 00 00       	push   $0x4c35
    3050:	ff 35 50 5e 00 00    	pushl  0x5e50
    3056:	e8 f5 09 00 00       	call   3a50 <printf>
    exit();
    305b:	e8 73 08 00 00       	call   38d3 <exit>
    printf(1, "pipe() failed\n");
    3060:	52                   	push   %edx
    3061:	52                   	push   %edx
    3062:	68 f1 40 00 00       	push   $0x40f1
    3067:	6a 01                	push   $0x1
    3069:	e8 e2 09 00 00       	call   3a50 <printf>
    exit();
    306e:	e8 60 08 00 00       	call   38d3 <exit>
    3073:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3077:	90                   	nop
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3078:	0f be 06             	movsbl (%esi),%eax
    307b:	50                   	push   %eax
    307c:	56                   	push   %esi
    307d:	68 1c 4c 00 00       	push   $0x4c1c
    3082:	ff 35 50 5e 00 00    	pushl  0x5e50
    3088:	e8 c3 09 00 00       	call   3a50 <printf>
      kill(ppid);
    308d:	89 3c 24             	mov    %edi,(%esp)
    3090:	e8 6e 08 00 00       	call   3903 <kill>
      exit();
    3095:	e8 39 08 00 00       	call   38d3 <exit>
      printf(stdout, "fork failed\n");
    309a:	83 ec 08             	sub    $0x8,%esp
    309d:	68 f9 4c 00 00       	push   $0x4cf9
    30a2:	ff 35 50 5e 00 00    	pushl  0x5e50
    30a8:	e8 a3 09 00 00       	call   3a50 <printf>
      exit();
    30ad:	e8 21 08 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    30b2:	50                   	push   %eax
    30b3:	56                   	push   %esi
    30b4:	68 fc 53 00 00       	push   $0x53fc
    30b9:	ff 35 50 5e 00 00    	pushl  0x5e50
    30bf:	e8 8c 09 00 00       	call   3a50 <printf>
    exit();
    30c4:	e8 0a 08 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    30c9:	51                   	push   %ecx
    30ca:	51                   	push   %ecx
    30cb:	68 cc 53 00 00       	push   $0x53cc
    30d0:	ff 35 50 5e 00 00    	pushl  0x5e50
    30d6:	e8 75 09 00 00       	call   3a50 <printf>
    exit();
    30db:	e8 f3 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    30e0:	57                   	push   %edi
    30e1:	56                   	push   %esi
    30e2:	68 a4 53 00 00       	push   $0x53a4
    30e7:	ff 35 50 5e 00 00    	pushl  0x5e50
    30ed:	e8 5e 09 00 00       	call   3a50 <printf>
    exit();
    30f2:	e8 dc 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    30f7:	50                   	push   %eax
    30f8:	56                   	push   %esi
    30f9:	68 6c 53 00 00       	push   $0x536c
    30fe:	ff 35 50 5e 00 00    	pushl  0x5e50
    3104:	e8 47 09 00 00       	call   3a50 <printf>
    exit();
    3109:	e8 c5 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    310e:	53                   	push   %ebx
    310f:	53                   	push   %ebx
    3110:	68 01 4c 00 00       	push   $0x4c01
    3115:	ff 35 50 5e 00 00    	pushl  0x5e50
    311b:	e8 30 09 00 00       	call   3a50 <printf>
    exit();
    3120:	e8 ae 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3125:	56                   	push   %esi
    3126:	56                   	push   %esi
    3127:	68 2c 53 00 00       	push   $0x532c
    312c:	ff 35 50 5e 00 00    	pushl  0x5e50
    3132:	e8 19 09 00 00       	call   3a50 <printf>
    exit();
    3137:	e8 97 07 00 00       	call   38d3 <exit>
    exit();
    313c:	e8 92 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    3141:	57                   	push   %edi
    3142:	57                   	push   %edi
    3143:	68 e5 4b 00 00       	push   $0x4be5
    3148:	ff 35 50 5e 00 00    	pushl  0x5e50
    314e:	e8 fd 08 00 00       	call   3a50 <printf>
    exit();
    3153:	e8 7b 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk test fork failed\n");
    3158:	50                   	push   %eax
    3159:	50                   	push   %eax
    315a:	68 ce 4b 00 00       	push   $0x4bce
    315f:	ff 35 50 5e 00 00    	pushl  0x5e50
    3165:	e8 e6 08 00 00       	call   3a50 <printf>
    exit();
    316a:	e8 64 07 00 00       	call   38d3 <exit>
    316f:	90                   	nop

00003170 <validateint>:
}
    3170:	c3                   	ret    
    3171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    317f:	90                   	nop

00003180 <validatetest>:
{
    3180:	55                   	push   %ebp
    3181:	89 e5                	mov    %esp,%ebp
    3183:	56                   	push   %esi
  for(p = 0; p <= (uint)hi; p += 4096){
    3184:	31 f6                	xor    %esi,%esi
{
    3186:	53                   	push   %ebx
  printf(stdout, "validate test\n");
    3187:	83 ec 08             	sub    $0x8,%esp
    318a:	68 5e 4c 00 00       	push   $0x4c5e
    318f:	ff 35 50 5e 00 00    	pushl  0x5e50
    3195:	e8 b6 08 00 00       	call   3a50 <printf>
    319a:	83 c4 10             	add    $0x10,%esp
    319d:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    31a0:	e8 26 07 00 00       	call   38cb <fork>
    31a5:	89 c3                	mov    %eax,%ebx
    31a7:	85 c0                	test   %eax,%eax
    31a9:	74 63                	je     320e <validatetest+0x8e>
    sleep(0);
    31ab:	83 ec 0c             	sub    $0xc,%esp
    31ae:	6a 00                	push   $0x0
    31b0:	e8 ae 07 00 00       	call   3963 <sleep>
    sleep(0);
    31b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31bc:	e8 a2 07 00 00       	call   3963 <sleep>
    kill(pid);
    31c1:	89 1c 24             	mov    %ebx,(%esp)
    31c4:	e8 3a 07 00 00       	call   3903 <kill>
    wait();
    31c9:	e8 0d 07 00 00       	call   38db <wait>
    if(link("nosuchfile", (char*)p) != -1){
    31ce:	58                   	pop    %eax
    31cf:	5a                   	pop    %edx
    31d0:	56                   	push   %esi
    31d1:	68 6d 4c 00 00       	push   $0x4c6d
    31d6:	e8 58 07 00 00       	call   3933 <link>
    31db:	83 c4 10             	add    $0x10,%esp
    31de:	83 f8 ff             	cmp    $0xffffffff,%eax
    31e1:	75 30                	jne    3213 <validatetest+0x93>
  for(p = 0; p <= (uint)hi; p += 4096){
    31e3:	81 c6 00 10 00 00    	add    $0x1000,%esi
    31e9:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    31ef:	75 af                	jne    31a0 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    31f1:	83 ec 08             	sub    $0x8,%esp
    31f4:	68 91 4c 00 00       	push   $0x4c91
    31f9:	ff 35 50 5e 00 00    	pushl  0x5e50
    31ff:	e8 4c 08 00 00       	call   3a50 <printf>
}
    3204:	83 c4 10             	add    $0x10,%esp
    3207:	8d 65 f8             	lea    -0x8(%ebp),%esp
    320a:	5b                   	pop    %ebx
    320b:	5e                   	pop    %esi
    320c:	5d                   	pop    %ebp
    320d:	c3                   	ret    
      exit();
    320e:	e8 c0 06 00 00       	call   38d3 <exit>
      printf(stdout, "link should not succeed\n");
    3213:	83 ec 08             	sub    $0x8,%esp
    3216:	68 78 4c 00 00       	push   $0x4c78
    321b:	ff 35 50 5e 00 00    	pushl  0x5e50
    3221:	e8 2a 08 00 00       	call   3a50 <printf>
      exit();
    3226:	e8 a8 06 00 00       	call   38d3 <exit>
    322b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    322f:	90                   	nop

00003230 <bsstest>:
{
    3230:	55                   	push   %ebp
    3231:	89 e5                	mov    %esp,%ebp
    3233:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    3236:	68 9e 4c 00 00       	push   $0x4c9e
    323b:	ff 35 50 5e 00 00    	pushl  0x5e50
    3241:	e8 0a 08 00 00       	call   3a50 <printf>
    3246:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3249:	31 c0                	xor    %eax,%eax
    324b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    324f:	90                   	nop
    if(uninit[i] != '\0'){
    3250:	80 b8 20 5f 00 00 00 	cmpb   $0x0,0x5f20(%eax)
    3257:	75 22                	jne    327b <bsstest+0x4b>
  for(i = 0; i < sizeof(uninit); i++){
    3259:	83 c0 01             	add    $0x1,%eax
    325c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3261:	75 ed                	jne    3250 <bsstest+0x20>
  printf(stdout, "bss test ok\n");
    3263:	83 ec 08             	sub    $0x8,%esp
    3266:	68 b9 4c 00 00       	push   $0x4cb9
    326b:	ff 35 50 5e 00 00    	pushl  0x5e50
    3271:	e8 da 07 00 00       	call   3a50 <printf>
}
    3276:	83 c4 10             	add    $0x10,%esp
    3279:	c9                   	leave  
    327a:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    327b:	83 ec 08             	sub    $0x8,%esp
    327e:	68 a8 4c 00 00       	push   $0x4ca8
    3283:	ff 35 50 5e 00 00    	pushl  0x5e50
    3289:	e8 c2 07 00 00       	call   3a50 <printf>
      exit();
    328e:	e8 40 06 00 00       	call   38d3 <exit>
    3293:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    329a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000032a0 <bigargtest>:
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    32a6:	68 c6 4c 00 00       	push   $0x4cc6
    32ab:	e8 73 06 00 00       	call   3923 <unlink>
  pid = fork();
    32b0:	e8 16 06 00 00       	call   38cb <fork>
  if(pid == 0){
    32b5:	83 c4 10             	add    $0x10,%esp
    32b8:	85 c0                	test   %eax,%eax
    32ba:	74 44                	je     3300 <bigargtest+0x60>
  } else if(pid < 0){
    32bc:	0f 88 c5 00 00 00    	js     3387 <bigargtest+0xe7>
  wait();
    32c2:	e8 14 06 00 00       	call   38db <wait>
  fd = open("bigarg-ok", 0);
    32c7:	83 ec 08             	sub    $0x8,%esp
    32ca:	6a 00                	push   $0x0
    32cc:	68 c6 4c 00 00       	push   $0x4cc6
    32d1:	e8 3d 06 00 00       	call   3913 <open>
  if(fd < 0){
    32d6:	83 c4 10             	add    $0x10,%esp
    32d9:	85 c0                	test   %eax,%eax
    32db:	0f 88 8f 00 00 00    	js     3370 <bigargtest+0xd0>
  close(fd);
    32e1:	83 ec 0c             	sub    $0xc,%esp
    32e4:	50                   	push   %eax
    32e5:	e8 11 06 00 00       	call   38fb <close>
  unlink("bigarg-ok");
    32ea:	c7 04 24 c6 4c 00 00 	movl   $0x4cc6,(%esp)
    32f1:	e8 2d 06 00 00       	call   3923 <unlink>
}
    32f6:	83 c4 10             	add    $0x10,%esp
    32f9:	c9                   	leave  
    32fa:	c3                   	ret    
    32fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    32ff:	90                   	nop
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3300:	c7 04 85 80 5e 00 00 	movl   $0x5420,0x5e80(,%eax,4)
    3307:	20 54 00 00 
    for(i = 0; i < MAXARG-1; i++)
    330b:	83 c0 01             	add    $0x1,%eax
    330e:	83 f8 1f             	cmp    $0x1f,%eax
    3311:	75 ed                	jne    3300 <bigargtest+0x60>
    printf(stdout, "bigarg test\n");
    3313:	51                   	push   %ecx
    3314:	51                   	push   %ecx
    3315:	68 d0 4c 00 00       	push   $0x4cd0
    331a:	ff 35 50 5e 00 00    	pushl  0x5e50
    args[MAXARG-1] = 0;
    3320:	c7 05 fc 5e 00 00 00 	movl   $0x0,0x5efc
    3327:	00 00 00 
    printf(stdout, "bigarg test\n");
    332a:	e8 21 07 00 00       	call   3a50 <printf>
    exec("echo", args);
    332f:	58                   	pop    %eax
    3330:	5a                   	pop    %edx
    3331:	68 80 5e 00 00       	push   $0x5e80
    3336:	68 9d 3e 00 00       	push   $0x3e9d
    333b:	e8 cb 05 00 00       	call   390b <exec>
    printf(stdout, "bigarg test ok\n");
    3340:	59                   	pop    %ecx
    3341:	58                   	pop    %eax
    3342:	68 dd 4c 00 00       	push   $0x4cdd
    3347:	ff 35 50 5e 00 00    	pushl  0x5e50
    334d:	e8 fe 06 00 00       	call   3a50 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3352:	58                   	pop    %eax
    3353:	5a                   	pop    %edx
    3354:	68 00 02 00 00       	push   $0x200
    3359:	68 c6 4c 00 00       	push   $0x4cc6
    335e:	e8 b0 05 00 00       	call   3913 <open>
    close(fd);
    3363:	89 04 24             	mov    %eax,(%esp)
    3366:	e8 90 05 00 00       	call   38fb <close>
    exit();
    336b:	e8 63 05 00 00       	call   38d3 <exit>
    printf(stdout, "bigarg test failed!\n");
    3370:	50                   	push   %eax
    3371:	50                   	push   %eax
    3372:	68 06 4d 00 00       	push   $0x4d06
    3377:	ff 35 50 5e 00 00    	pushl  0x5e50
    337d:	e8 ce 06 00 00       	call   3a50 <printf>
    exit();
    3382:	e8 4c 05 00 00       	call   38d3 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3387:	52                   	push   %edx
    3388:	52                   	push   %edx
    3389:	68 ed 4c 00 00       	push   $0x4ced
    338e:	ff 35 50 5e 00 00    	pushl  0x5e50
    3394:	e8 b7 06 00 00       	call   3a50 <printf>
    exit();
    3399:	e8 35 05 00 00       	call   38d3 <exit>
    339e:	66 90                	xchg   %ax,%ax

000033a0 <fsfull>:
{
    33a0:	55                   	push   %ebp
    33a1:	89 e5                	mov    %esp,%ebp
    33a3:	57                   	push   %edi
    33a4:	56                   	push   %esi
  for(nfiles = 0; ; nfiles++){
    33a5:	31 f6                	xor    %esi,%esi
{
    33a7:	53                   	push   %ebx
    33a8:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    33ab:	68 1b 4d 00 00       	push   $0x4d1b
    33b0:	6a 01                	push   $0x1
    33b2:	e8 99 06 00 00       	call   3a50 <printf>
    33b7:	83 c4 10             	add    $0x10,%esp
    33ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    33c0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    33c5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    33ca:	83 ec 04             	sub    $0x4,%esp
    name[0] = 'f';
    33cd:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    33d1:	f7 e6                	mul    %esi
    name[5] = '\0';
    33d3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    33d7:	c1 ea 06             	shr    $0x6,%edx
    33da:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33dd:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    33e3:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    33e6:	89 f0                	mov    %esi,%eax
    33e8:	29 d0                	sub    %edx,%eax
    33ea:	89 c2                	mov    %eax,%edx
    33ec:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33f1:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    33f3:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33f8:	c1 ea 05             	shr    $0x5,%edx
    33fb:	83 c2 30             	add    $0x30,%edx
    33fe:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3401:	f7 e6                	mul    %esi
    3403:	89 f0                	mov    %esi,%eax
    3405:	c1 ea 05             	shr    $0x5,%edx
    3408:	6b d2 64             	imul   $0x64,%edx,%edx
    340b:	29 d0                	sub    %edx,%eax
    340d:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    340f:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3411:	c1 ea 03             	shr    $0x3,%edx
    3414:	83 c2 30             	add    $0x30,%edx
    3417:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    341a:	f7 e1                	mul    %ecx
    341c:	89 f1                	mov    %esi,%ecx
    341e:	c1 ea 03             	shr    $0x3,%edx
    3421:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3424:	01 c0                	add    %eax,%eax
    3426:	29 c1                	sub    %eax,%ecx
    3428:	89 c8                	mov    %ecx,%eax
    342a:	83 c0 30             	add    $0x30,%eax
    342d:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    3430:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3433:	50                   	push   %eax
    3434:	68 28 4d 00 00       	push   $0x4d28
    3439:	6a 01                	push   $0x1
    343b:	e8 10 06 00 00       	call   3a50 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3440:	58                   	pop    %eax
    3441:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3444:	5a                   	pop    %edx
    3445:	68 02 02 00 00       	push   $0x202
    344a:	50                   	push   %eax
    344b:	e8 c3 04 00 00       	call   3913 <open>
    if(fd < 0){
    3450:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3453:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3455:	85 c0                	test   %eax,%eax
    3457:	78 4d                	js     34a6 <fsfull+0x106>
    int total = 0;
    3459:	31 db                	xor    %ebx,%ebx
    345b:	eb 05                	jmp    3462 <fsfull+0xc2>
    345d:	8d 76 00             	lea    0x0(%esi),%esi
      total += cc;
    3460:	01 c3                	add    %eax,%ebx
      int cc = write(fd, buf, 512);
    3462:	83 ec 04             	sub    $0x4,%esp
    3465:	68 00 02 00 00       	push   $0x200
    346a:	68 40 86 00 00       	push   $0x8640
    346f:	57                   	push   %edi
    3470:	e8 7e 04 00 00       	call   38f3 <write>
      if(cc < 512)
    3475:	83 c4 10             	add    $0x10,%esp
    3478:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    347d:	7f e1                	jg     3460 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
    347f:	83 ec 04             	sub    $0x4,%esp
    3482:	53                   	push   %ebx
    3483:	68 44 4d 00 00       	push   $0x4d44
    3488:	6a 01                	push   $0x1
    348a:	e8 c1 05 00 00       	call   3a50 <printf>
    close(fd);
    348f:	89 3c 24             	mov    %edi,(%esp)
    3492:	e8 64 04 00 00       	call   38fb <close>
    if(total == 0)
    3497:	83 c4 10             	add    $0x10,%esp
    349a:	85 db                	test   %ebx,%ebx
    349c:	74 1e                	je     34bc <fsfull+0x11c>
  for(nfiles = 0; ; nfiles++){
    349e:	83 c6 01             	add    $0x1,%esi
    34a1:	e9 1a ff ff ff       	jmp    33c0 <fsfull+0x20>
      printf(1, "open %s failed\n", name);
    34a6:	83 ec 04             	sub    $0x4,%esp
    34a9:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34ac:	50                   	push   %eax
    34ad:	68 34 4d 00 00       	push   $0x4d34
    34b2:	6a 01                	push   $0x1
    34b4:	e8 97 05 00 00       	call   3a50 <printf>
      break;
    34b9:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    34bc:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    34c1:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    34c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34cd:	8d 76 00             	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    34d0:	89 f0                	mov    %esi,%eax
    34d2:	89 f1                	mov    %esi,%ecx
    unlink(name);
    34d4:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'f';
    34d7:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    34db:	f7 ef                	imul   %edi
    34dd:	c1 f9 1f             	sar    $0x1f,%ecx
    name[5] = '\0';
    34e0:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    34e4:	c1 fa 06             	sar    $0x6,%edx
    34e7:	29 ca                	sub    %ecx,%edx
    34e9:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34ec:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    34f2:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    34f5:	89 f0                	mov    %esi,%eax
    34f7:	29 d0                	sub    %edx,%eax
    34f9:	f7 e3                	mul    %ebx
    name[3] = '0' + (nfiles % 100) / 10;
    34fb:	89 f0                	mov    %esi,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34fd:	c1 ea 05             	shr    $0x5,%edx
    3500:	83 c2 30             	add    $0x30,%edx
    3503:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3506:	f7 eb                	imul   %ebx
    3508:	89 f0                	mov    %esi,%eax
    350a:	c1 fa 05             	sar    $0x5,%edx
    350d:	29 ca                	sub    %ecx,%edx
    350f:	6b d2 64             	imul   $0x64,%edx,%edx
    3512:	29 d0                	sub    %edx,%eax
    3514:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    3519:	f7 e2                	mul    %edx
    name[4] = '0' + (nfiles % 10);
    351b:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    351d:	c1 ea 03             	shr    $0x3,%edx
    3520:	83 c2 30             	add    $0x30,%edx
    3523:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3526:	ba 67 66 66 66       	mov    $0x66666667,%edx
    352b:	f7 ea                	imul   %edx
    352d:	c1 fa 02             	sar    $0x2,%edx
    3530:	29 ca                	sub    %ecx,%edx
    3532:	89 f1                	mov    %esi,%ecx
    nfiles--;
    3534:	83 ee 01             	sub    $0x1,%esi
    name[4] = '0' + (nfiles % 10);
    3537:	8d 04 92             	lea    (%edx,%edx,4),%eax
    353a:	01 c0                	add    %eax,%eax
    353c:	29 c1                	sub    %eax,%ecx
    353e:	89 c8                	mov    %ecx,%eax
    3540:	83 c0 30             	add    $0x30,%eax
    3543:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3546:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3549:	50                   	push   %eax
    354a:	e8 d4 03 00 00       	call   3923 <unlink>
  while(nfiles >= 0){
    354f:	83 c4 10             	add    $0x10,%esp
    3552:	83 fe ff             	cmp    $0xffffffff,%esi
    3555:	0f 85 75 ff ff ff    	jne    34d0 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
    355b:	83 ec 08             	sub    $0x8,%esp
    355e:	68 54 4d 00 00       	push   $0x4d54
    3563:	6a 01                	push   $0x1
    3565:	e8 e6 04 00 00       	call   3a50 <printf>
}
    356a:	83 c4 10             	add    $0x10,%esp
    356d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3570:	5b                   	pop    %ebx
    3571:	5e                   	pop    %esi
    3572:	5f                   	pop    %edi
    3573:	5d                   	pop    %ebp
    3574:	c3                   	ret    
    3575:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    357c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003580 <uio>:
{
    3580:	55                   	push   %ebp
    3581:	89 e5                	mov    %esp,%ebp
    3583:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    3586:	68 6a 4d 00 00       	push   $0x4d6a
    358b:	6a 01                	push   $0x1
    358d:	e8 be 04 00 00       	call   3a50 <printf>
  pid = fork();
    3592:	e8 34 03 00 00       	call   38cb <fork>
  if(pid == 0){
    3597:	83 c4 10             	add    $0x10,%esp
    359a:	85 c0                	test   %eax,%eax
    359c:	74 1b                	je     35b9 <uio+0x39>
  } else if(pid < 0){
    359e:	78 3d                	js     35dd <uio+0x5d>
  wait();
    35a0:	e8 36 03 00 00       	call   38db <wait>
  printf(1, "uio test done\n");
    35a5:	83 ec 08             	sub    $0x8,%esp
    35a8:	68 74 4d 00 00       	push   $0x4d74
    35ad:	6a 01                	push   $0x1
    35af:	e8 9c 04 00 00       	call   3a50 <printf>
}
    35b4:	83 c4 10             	add    $0x10,%esp
    35b7:	c9                   	leave  
    35b8:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    35b9:	b8 09 00 00 00       	mov    $0x9,%eax
    35be:	ba 70 00 00 00       	mov    $0x70,%edx
    35c3:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    35c4:	ba 71 00 00 00       	mov    $0x71,%edx
    35c9:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    35ca:	52                   	push   %edx
    35cb:	52                   	push   %edx
    35cc:	68 00 55 00 00       	push   $0x5500
    35d1:	6a 01                	push   $0x1
    35d3:	e8 78 04 00 00       	call   3a50 <printf>
    exit();
    35d8:	e8 f6 02 00 00       	call   38d3 <exit>
    printf (1, "fork failed\n");
    35dd:	50                   	push   %eax
    35de:	50                   	push   %eax
    35df:	68 f9 4c 00 00       	push   $0x4cf9
    35e4:	6a 01                	push   $0x1
    35e6:	e8 65 04 00 00       	call   3a50 <printf>
    exit();
    35eb:	e8 e3 02 00 00       	call   38d3 <exit>

000035f0 <argptest>:
{
    35f0:	55                   	push   %ebp
    35f1:	89 e5                	mov    %esp,%ebp
    35f3:	53                   	push   %ebx
    35f4:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    35f7:	6a 00                	push   $0x0
    35f9:	68 83 4d 00 00       	push   $0x4d83
    35fe:	e8 10 03 00 00       	call   3913 <open>
  if (fd < 0) {
    3603:	83 c4 10             	add    $0x10,%esp
    3606:	85 c0                	test   %eax,%eax
    3608:	78 39                	js     3643 <argptest+0x53>
  read(fd, sbrk(0) - 1, -1);
    360a:	83 ec 0c             	sub    $0xc,%esp
    360d:	89 c3                	mov    %eax,%ebx
    360f:	6a 00                	push   $0x0
    3611:	e8 45 03 00 00       	call   395b <sbrk>
    3616:	83 c4 0c             	add    $0xc,%esp
    3619:	83 e8 01             	sub    $0x1,%eax
    361c:	6a ff                	push   $0xffffffff
    361e:	50                   	push   %eax
    361f:	53                   	push   %ebx
    3620:	e8 c6 02 00 00       	call   38eb <read>
  close(fd);
    3625:	89 1c 24             	mov    %ebx,(%esp)
    3628:	e8 ce 02 00 00       	call   38fb <close>
  printf(1, "arg test passed\n");
    362d:	58                   	pop    %eax
    362e:	5a                   	pop    %edx
    362f:	68 95 4d 00 00       	push   $0x4d95
    3634:	6a 01                	push   $0x1
    3636:	e8 15 04 00 00       	call   3a50 <printf>
}
    363b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    363e:	83 c4 10             	add    $0x10,%esp
    3641:	c9                   	leave  
    3642:	c3                   	ret    
    printf(2, "open failed\n");
    3643:	51                   	push   %ecx
    3644:	51                   	push   %ecx
    3645:	68 88 4d 00 00       	push   $0x4d88
    364a:	6a 02                	push   $0x2
    364c:	e8 ff 03 00 00       	call   3a50 <printf>
    exit();
    3651:	e8 7d 02 00 00       	call   38d3 <exit>
    3656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    365d:	8d 76 00             	lea    0x0(%esi),%esi

00003660 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3660:	69 05 4c 5e 00 00 0d 	imul   $0x19660d,0x5e4c,%eax
    3667:	66 19 00 
    366a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    366f:	a3 4c 5e 00 00       	mov    %eax,0x5e4c
}
    3674:	c3                   	ret    
    3675:	66 90                	xchg   %ax,%ax
    3677:	66 90                	xchg   %ax,%ax
    3679:	66 90                	xchg   %ax,%ax
    367b:	66 90                	xchg   %ax,%ax
    367d:	66 90                	xchg   %ax,%ax
    367f:	90                   	nop

00003680 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3680:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3681:	31 c0                	xor    %eax,%eax
{
    3683:	89 e5                	mov    %esp,%ebp
    3685:	53                   	push   %ebx
    3686:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3689:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    368c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3690:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3694:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3697:	83 c0 01             	add    $0x1,%eax
    369a:	84 d2                	test   %dl,%dl
    369c:	75 f2                	jne    3690 <strcpy+0x10>
    ;
  return os;
}
    369e:	89 c8                	mov    %ecx,%eax
    36a0:	5b                   	pop    %ebx
    36a1:	5d                   	pop    %ebp
    36a2:	c3                   	ret    
    36a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000036b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    36b0:	55                   	push   %ebp
    36b1:	89 e5                	mov    %esp,%ebp
    36b3:	53                   	push   %ebx
    36b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    36b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    36ba:	0f b6 01             	movzbl (%ecx),%eax
    36bd:	0f b6 1a             	movzbl (%edx),%ebx
    36c0:	84 c0                	test   %al,%al
    36c2:	75 1d                	jne    36e1 <strcmp+0x31>
    36c4:	eb 2a                	jmp    36f0 <strcmp+0x40>
    36c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36cd:	8d 76 00             	lea    0x0(%esi),%esi
    36d0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    36d4:	83 c1 01             	add    $0x1,%ecx
    36d7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    36da:	0f b6 1a             	movzbl (%edx),%ebx
    36dd:	84 c0                	test   %al,%al
    36df:	74 0f                	je     36f0 <strcmp+0x40>
    36e1:	38 d8                	cmp    %bl,%al
    36e3:	74 eb                	je     36d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    36e5:	29 d8                	sub    %ebx,%eax
}
    36e7:	5b                   	pop    %ebx
    36e8:	5d                   	pop    %ebp
    36e9:	c3                   	ret    
    36ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    36f2:	29 d8                	sub    %ebx,%eax
}
    36f4:	5b                   	pop    %ebx
    36f5:	5d                   	pop    %ebp
    36f6:	c3                   	ret    
    36f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36fe:	66 90                	xchg   %ax,%ax

00003700 <strlen>:

uint
strlen(char *s)
{
    3700:	55                   	push   %ebp
    3701:	89 e5                	mov    %esp,%ebp
    3703:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3706:	80 3a 00             	cmpb   $0x0,(%edx)
    3709:	74 15                	je     3720 <strlen+0x20>
    370b:	31 c0                	xor    %eax,%eax
    370d:	8d 76 00             	lea    0x0(%esi),%esi
    3710:	83 c0 01             	add    $0x1,%eax
    3713:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3717:	89 c1                	mov    %eax,%ecx
    3719:	75 f5                	jne    3710 <strlen+0x10>
    ;
  return n;
}
    371b:	89 c8                	mov    %ecx,%eax
    371d:	5d                   	pop    %ebp
    371e:	c3                   	ret    
    371f:	90                   	nop
  for(n = 0; s[n]; n++)
    3720:	31 c9                	xor    %ecx,%ecx
}
    3722:	5d                   	pop    %ebp
    3723:	89 c8                	mov    %ecx,%eax
    3725:	c3                   	ret    
    3726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    372d:	8d 76 00             	lea    0x0(%esi),%esi

00003730 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3730:	55                   	push   %ebp
    3731:	89 e5                	mov    %esp,%ebp
    3733:	57                   	push   %edi
    3734:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3737:	8b 4d 10             	mov    0x10(%ebp),%ecx
    373a:	8b 45 0c             	mov    0xc(%ebp),%eax
    373d:	89 d7                	mov    %edx,%edi
    373f:	fc                   	cld    
    3740:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3742:	89 d0                	mov    %edx,%eax
    3744:	5f                   	pop    %edi
    3745:	5d                   	pop    %ebp
    3746:	c3                   	ret    
    3747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    374e:	66 90                	xchg   %ax,%ax

00003750 <strchr>:

char*
strchr(const char *s, char c)
{
    3750:	55                   	push   %ebp
    3751:	89 e5                	mov    %esp,%ebp
    3753:	8b 45 08             	mov    0x8(%ebp),%eax
    3756:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    375a:	0f b6 10             	movzbl (%eax),%edx
    375d:	84 d2                	test   %dl,%dl
    375f:	75 12                	jne    3773 <strchr+0x23>
    3761:	eb 1d                	jmp    3780 <strchr+0x30>
    3763:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3767:	90                   	nop
    3768:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    376c:	83 c0 01             	add    $0x1,%eax
    376f:	84 d2                	test   %dl,%dl
    3771:	74 0d                	je     3780 <strchr+0x30>
    if(*s == c)
    3773:	38 d1                	cmp    %dl,%cl
    3775:	75 f1                	jne    3768 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3777:	5d                   	pop    %ebp
    3778:	c3                   	ret    
    3779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3780:	31 c0                	xor    %eax,%eax
}
    3782:	5d                   	pop    %ebp
    3783:	c3                   	ret    
    3784:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    378b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    378f:	90                   	nop

00003790 <gets>:

char*
gets(char *buf, int max)
{
    3790:	55                   	push   %ebp
    3791:	89 e5                	mov    %esp,%ebp
    3793:	57                   	push   %edi
    3794:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3795:	31 f6                	xor    %esi,%esi
{
    3797:	53                   	push   %ebx
    3798:	89 f3                	mov    %esi,%ebx
    379a:	83 ec 1c             	sub    $0x1c,%esp
    379d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    37a0:	eb 2f                	jmp    37d1 <gets+0x41>
    37a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    37a8:	83 ec 04             	sub    $0x4,%esp
    37ab:	8d 45 e7             	lea    -0x19(%ebp),%eax
    37ae:	6a 01                	push   $0x1
    37b0:	50                   	push   %eax
    37b1:	6a 00                	push   $0x0
    37b3:	e8 33 01 00 00       	call   38eb <read>
    if(cc < 1)
    37b8:	83 c4 10             	add    $0x10,%esp
    37bb:	85 c0                	test   %eax,%eax
    37bd:	7e 1c                	jle    37db <gets+0x4b>
      break;
    buf[i++] = c;
    37bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    37c3:	83 c7 01             	add    $0x1,%edi
    37c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    37c9:	3c 0a                	cmp    $0xa,%al
    37cb:	74 23                	je     37f0 <gets+0x60>
    37cd:	3c 0d                	cmp    $0xd,%al
    37cf:	74 1f                	je     37f0 <gets+0x60>
  for(i=0; i+1 < max; ){
    37d1:	83 c3 01             	add    $0x1,%ebx
    37d4:	89 fe                	mov    %edi,%esi
    37d6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    37d9:	7c cd                	jl     37a8 <gets+0x18>
    37db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    37dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    37e0:	c6 03 00             	movb   $0x0,(%ebx)
}
    37e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37e6:	5b                   	pop    %ebx
    37e7:	5e                   	pop    %esi
    37e8:	5f                   	pop    %edi
    37e9:	5d                   	pop    %ebp
    37ea:	c3                   	ret    
    37eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    37ef:	90                   	nop
    37f0:	8b 75 08             	mov    0x8(%ebp),%esi
    37f3:	8b 45 08             	mov    0x8(%ebp),%eax
    37f6:	01 de                	add    %ebx,%esi
    37f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    37fa:	c6 03 00             	movb   $0x0,(%ebx)
}
    37fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3800:	5b                   	pop    %ebx
    3801:	5e                   	pop    %esi
    3802:	5f                   	pop    %edi
    3803:	5d                   	pop    %ebp
    3804:	c3                   	ret    
    3805:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    380c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003810 <stat>:

int
stat(char *n, struct stat *st)
{
    3810:	55                   	push   %ebp
    3811:	89 e5                	mov    %esp,%ebp
    3813:	56                   	push   %esi
    3814:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3815:	83 ec 08             	sub    $0x8,%esp
    3818:	6a 00                	push   $0x0
    381a:	ff 75 08             	pushl  0x8(%ebp)
    381d:	e8 f1 00 00 00       	call   3913 <open>
  if(fd < 0)
    3822:	83 c4 10             	add    $0x10,%esp
    3825:	85 c0                	test   %eax,%eax
    3827:	78 27                	js     3850 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3829:	83 ec 08             	sub    $0x8,%esp
    382c:	ff 75 0c             	pushl  0xc(%ebp)
    382f:	89 c3                	mov    %eax,%ebx
    3831:	50                   	push   %eax
    3832:	e8 f4 00 00 00       	call   392b <fstat>
  close(fd);
    3837:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    383a:	89 c6                	mov    %eax,%esi
  close(fd);
    383c:	e8 ba 00 00 00       	call   38fb <close>
  return r;
    3841:	83 c4 10             	add    $0x10,%esp
}
    3844:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3847:	89 f0                	mov    %esi,%eax
    3849:	5b                   	pop    %ebx
    384a:	5e                   	pop    %esi
    384b:	5d                   	pop    %ebp
    384c:	c3                   	ret    
    384d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3850:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3855:	eb ed                	jmp    3844 <stat+0x34>
    3857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    385e:	66 90                	xchg   %ax,%ax

00003860 <atoi>:

int
atoi(const char *s)
{
    3860:	55                   	push   %ebp
    3861:	89 e5                	mov    %esp,%ebp
    3863:	53                   	push   %ebx
    3864:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3867:	0f be 02             	movsbl (%edx),%eax
    386a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    386d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3870:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3875:	77 1e                	ja     3895 <atoi+0x35>
    3877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    387e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3880:	83 c2 01             	add    $0x1,%edx
    3883:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3886:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    388a:	0f be 02             	movsbl (%edx),%eax
    388d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3890:	80 fb 09             	cmp    $0x9,%bl
    3893:	76 eb                	jbe    3880 <atoi+0x20>
  return n;
}
    3895:	89 c8                	mov    %ecx,%eax
    3897:	5b                   	pop    %ebx
    3898:	5d                   	pop    %ebp
    3899:	c3                   	ret    
    389a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000038a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    38a0:	55                   	push   %ebp
    38a1:	89 e5                	mov    %esp,%ebp
    38a3:	57                   	push   %edi
    38a4:	8b 45 10             	mov    0x10(%ebp),%eax
    38a7:	8b 55 08             	mov    0x8(%ebp),%edx
    38aa:	56                   	push   %esi
    38ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    38ae:	85 c0                	test   %eax,%eax
    38b0:	7e 13                	jle    38c5 <memmove+0x25>
    38b2:	01 d0                	add    %edx,%eax
  dst = vdst;
    38b4:	89 d7                	mov    %edx,%edi
    38b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    38bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    38c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    38c1:	39 f8                	cmp    %edi,%eax
    38c3:	75 fb                	jne    38c0 <memmove+0x20>
  return vdst;
}
    38c5:	5e                   	pop    %esi
    38c6:	89 d0                	mov    %edx,%eax
    38c8:	5f                   	pop    %edi
    38c9:	5d                   	pop    %ebp
    38ca:	c3                   	ret    

000038cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    38cb:	b8 01 00 00 00       	mov    $0x1,%eax
    38d0:	cd 40                	int    $0x40
    38d2:	c3                   	ret    

000038d3 <exit>:
SYSCALL(exit)
    38d3:	b8 02 00 00 00       	mov    $0x2,%eax
    38d8:	cd 40                	int    $0x40
    38da:	c3                   	ret    

000038db <wait>:
SYSCALL(wait)
    38db:	b8 03 00 00 00       	mov    $0x3,%eax
    38e0:	cd 40                	int    $0x40
    38e2:	c3                   	ret    

000038e3 <pipe>:
SYSCALL(pipe)
    38e3:	b8 04 00 00 00       	mov    $0x4,%eax
    38e8:	cd 40                	int    $0x40
    38ea:	c3                   	ret    

000038eb <read>:
SYSCALL(read)
    38eb:	b8 05 00 00 00       	mov    $0x5,%eax
    38f0:	cd 40                	int    $0x40
    38f2:	c3                   	ret    

000038f3 <write>:
SYSCALL(write)
    38f3:	b8 10 00 00 00       	mov    $0x10,%eax
    38f8:	cd 40                	int    $0x40
    38fa:	c3                   	ret    

000038fb <close>:
SYSCALL(close)
    38fb:	b8 15 00 00 00       	mov    $0x15,%eax
    3900:	cd 40                	int    $0x40
    3902:	c3                   	ret    

00003903 <kill>:
SYSCALL(kill)
    3903:	b8 06 00 00 00       	mov    $0x6,%eax
    3908:	cd 40                	int    $0x40
    390a:	c3                   	ret    

0000390b <exec>:
SYSCALL(exec)
    390b:	b8 07 00 00 00       	mov    $0x7,%eax
    3910:	cd 40                	int    $0x40
    3912:	c3                   	ret    

00003913 <open>:
SYSCALL(open)
    3913:	b8 0f 00 00 00       	mov    $0xf,%eax
    3918:	cd 40                	int    $0x40
    391a:	c3                   	ret    

0000391b <mknod>:
SYSCALL(mknod)
    391b:	b8 11 00 00 00       	mov    $0x11,%eax
    3920:	cd 40                	int    $0x40
    3922:	c3                   	ret    

00003923 <unlink>:
SYSCALL(unlink)
    3923:	b8 12 00 00 00       	mov    $0x12,%eax
    3928:	cd 40                	int    $0x40
    392a:	c3                   	ret    

0000392b <fstat>:
SYSCALL(fstat)
    392b:	b8 08 00 00 00       	mov    $0x8,%eax
    3930:	cd 40                	int    $0x40
    3932:	c3                   	ret    

00003933 <link>:
SYSCALL(link)
    3933:	b8 13 00 00 00       	mov    $0x13,%eax
    3938:	cd 40                	int    $0x40
    393a:	c3                   	ret    

0000393b <mkdir>:
SYSCALL(mkdir)
    393b:	b8 14 00 00 00       	mov    $0x14,%eax
    3940:	cd 40                	int    $0x40
    3942:	c3                   	ret    

00003943 <chdir>:
SYSCALL(chdir)
    3943:	b8 09 00 00 00       	mov    $0x9,%eax
    3948:	cd 40                	int    $0x40
    394a:	c3                   	ret    

0000394b <dup>:
SYSCALL(dup)
    394b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3950:	cd 40                	int    $0x40
    3952:	c3                   	ret    

00003953 <getpid>:
SYSCALL(getpid)
    3953:	b8 0b 00 00 00       	mov    $0xb,%eax
    3958:	cd 40                	int    $0x40
    395a:	c3                   	ret    

0000395b <sbrk>:
SYSCALL(sbrk)
    395b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3960:	cd 40                	int    $0x40
    3962:	c3                   	ret    

00003963 <sleep>:
SYSCALL(sleep)
    3963:	b8 0d 00 00 00       	mov    $0xd,%eax
    3968:	cd 40                	int    $0x40
    396a:	c3                   	ret    

0000396b <uptime>:
SYSCALL(uptime)
    396b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3970:	cd 40                	int    $0x40
    3972:	c3                   	ret    

00003973 <cps>:
SYSCALL(cps)
    3973:	b8 16 00 00 00       	mov    $0x16,%eax
    3978:	cd 40                	int    $0x40
    397a:	c3                   	ret    

0000397b <nps>:
SYSCALL(nps)
    397b:	b8 17 00 00 00       	mov    $0x17,%eax
    3980:	cd 40                	int    $0x40
    3982:	c3                   	ret    

00003983 <chpr>:
SYSCALL(chpr)
    3983:	b8 18 00 00 00       	mov    $0x18,%eax
    3988:	cd 40                	int    $0x40
    398a:	c3                   	ret    

0000398b <date>:
SYSCALL(date)
    398b:	b8 19 00 00 00       	mov    $0x19,%eax
    3990:	cd 40                	int    $0x40
    3992:	c3                   	ret    
    3993:	66 90                	xchg   %ax,%ax
    3995:	66 90                	xchg   %ax,%ax
    3997:	66 90                	xchg   %ax,%ax
    3999:	66 90                	xchg   %ax,%ax
    399b:	66 90                	xchg   %ax,%ax
    399d:	66 90                	xchg   %ax,%ax
    399f:	90                   	nop

000039a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    39a0:	55                   	push   %ebp
    39a1:	89 e5                	mov    %esp,%ebp
    39a3:	57                   	push   %edi
    39a4:	56                   	push   %esi
    39a5:	53                   	push   %ebx
    39a6:	83 ec 3c             	sub    $0x3c,%esp
    39a9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    39ac:	89 d1                	mov    %edx,%ecx
{
    39ae:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    39b1:	85 d2                	test   %edx,%edx
    39b3:	0f 89 7f 00 00 00    	jns    3a38 <printint+0x98>
    39b9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    39bd:	74 79                	je     3a38 <printint+0x98>
    neg = 1;
    39bf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    39c6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    39c8:	31 db                	xor    %ebx,%ebx
    39ca:	8d 75 d7             	lea    -0x29(%ebp),%esi
    39cd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    39d0:	89 c8                	mov    %ecx,%eax
    39d2:	31 d2                	xor    %edx,%edx
    39d4:	89 cf                	mov    %ecx,%edi
    39d6:	f7 75 c4             	divl   -0x3c(%ebp)
    39d9:	0f b6 92 58 55 00 00 	movzbl 0x5558(%edx),%edx
    39e0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    39e3:	89 d8                	mov    %ebx,%eax
    39e5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    39e8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    39eb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    39ee:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    39f1:	76 dd                	jbe    39d0 <printint+0x30>
  if(neg)
    39f3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    39f6:	85 c9                	test   %ecx,%ecx
    39f8:	74 0c                	je     3a06 <printint+0x66>
    buf[i++] = '-';
    39fa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    39ff:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3a01:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3a06:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3a09:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    3a0d:	eb 07                	jmp    3a16 <printint+0x76>
    3a0f:	90                   	nop
    3a10:	0f b6 13             	movzbl (%ebx),%edx
    3a13:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3a16:	83 ec 04             	sub    $0x4,%esp
    3a19:	88 55 d7             	mov    %dl,-0x29(%ebp)
    3a1c:	6a 01                	push   $0x1
    3a1e:	56                   	push   %esi
    3a1f:	57                   	push   %edi
    3a20:	e8 ce fe ff ff       	call   38f3 <write>
  while(--i >= 0)
    3a25:	83 c4 10             	add    $0x10,%esp
    3a28:	39 de                	cmp    %ebx,%esi
    3a2a:	75 e4                	jne    3a10 <printint+0x70>
    putc(fd, buf[i]);
}
    3a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a2f:	5b                   	pop    %ebx
    3a30:	5e                   	pop    %esi
    3a31:	5f                   	pop    %edi
    3a32:	5d                   	pop    %ebp
    3a33:	c3                   	ret    
    3a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3a38:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    3a3f:	eb 87                	jmp    39c8 <printint+0x28>
    3a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a4f:	90                   	nop

00003a50 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3a50:	55                   	push   %ebp
    3a51:	89 e5                	mov    %esp,%ebp
    3a53:	57                   	push   %edi
    3a54:	56                   	push   %esi
    3a55:	53                   	push   %ebx
    3a56:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a59:	8b 75 0c             	mov    0xc(%ebp),%esi
    3a5c:	0f b6 1e             	movzbl (%esi),%ebx
    3a5f:	84 db                	test   %bl,%bl
    3a61:	0f 84 b8 00 00 00    	je     3b1f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    3a67:	8d 45 10             	lea    0x10(%ebp),%eax
    3a6a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    3a6d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3a70:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    3a72:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3a75:	eb 37                	jmp    3aae <printf+0x5e>
    3a77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a7e:	66 90                	xchg   %ax,%ax
    3a80:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3a83:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    3a88:	83 f8 25             	cmp    $0x25,%eax
    3a8b:	74 17                	je     3aa4 <printf+0x54>
  write(fd, &c, 1);
    3a8d:	83 ec 04             	sub    $0x4,%esp
    3a90:	88 5d e7             	mov    %bl,-0x19(%ebp)
    3a93:	6a 01                	push   $0x1
    3a95:	57                   	push   %edi
    3a96:	ff 75 08             	pushl  0x8(%ebp)
    3a99:	e8 55 fe ff ff       	call   38f3 <write>
    3a9e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    3aa1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3aa4:	0f b6 1e             	movzbl (%esi),%ebx
    3aa7:	83 c6 01             	add    $0x1,%esi
    3aaa:	84 db                	test   %bl,%bl
    3aac:	74 71                	je     3b1f <printf+0xcf>
    c = fmt[i] & 0xff;
    3aae:	0f be cb             	movsbl %bl,%ecx
    3ab1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3ab4:	85 d2                	test   %edx,%edx
    3ab6:	74 c8                	je     3a80 <printf+0x30>
      }
    } else if(state == '%'){
    3ab8:	83 fa 25             	cmp    $0x25,%edx
    3abb:	75 e7                	jne    3aa4 <printf+0x54>
      if(c == 'd'){
    3abd:	83 f8 64             	cmp    $0x64,%eax
    3ac0:	0f 84 9a 00 00 00    	je     3b60 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3ac6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3acc:	83 f9 70             	cmp    $0x70,%ecx
    3acf:	74 5f                	je     3b30 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3ad1:	83 f8 73             	cmp    $0x73,%eax
    3ad4:	0f 84 d6 00 00 00    	je     3bb0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3ada:	83 f8 63             	cmp    $0x63,%eax
    3add:	0f 84 8d 00 00 00    	je     3b70 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3ae3:	83 f8 25             	cmp    $0x25,%eax
    3ae6:	0f 84 b4 00 00 00    	je     3ba0 <printf+0x150>
  write(fd, &c, 1);
    3aec:	83 ec 04             	sub    $0x4,%esp
    3aef:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3af3:	6a 01                	push   $0x1
    3af5:	57                   	push   %edi
    3af6:	ff 75 08             	pushl  0x8(%ebp)
    3af9:	e8 f5 fd ff ff       	call   38f3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3afe:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    3b01:	83 c4 0c             	add    $0xc,%esp
    3b04:	6a 01                	push   $0x1
    3b06:	83 c6 01             	add    $0x1,%esi
    3b09:	57                   	push   %edi
    3b0a:	ff 75 08             	pushl  0x8(%ebp)
    3b0d:	e8 e1 fd ff ff       	call   38f3 <write>
  for(i = 0; fmt[i]; i++){
    3b12:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    3b16:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    3b19:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    3b1b:	84 db                	test   %bl,%bl
    3b1d:	75 8f                	jne    3aae <printf+0x5e>
    }
  }
}
    3b1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3b22:	5b                   	pop    %ebx
    3b23:	5e                   	pop    %esi
    3b24:	5f                   	pop    %edi
    3b25:	5d                   	pop    %ebp
    3b26:	c3                   	ret    
    3b27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b2e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    3b30:	83 ec 0c             	sub    $0xc,%esp
    3b33:	b9 10 00 00 00       	mov    $0x10,%ecx
    3b38:	6a 00                	push   $0x0
    3b3a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    3b3d:	8b 45 08             	mov    0x8(%ebp),%eax
    3b40:	8b 13                	mov    (%ebx),%edx
    3b42:	e8 59 fe ff ff       	call   39a0 <printint>
        ap++;
    3b47:	89 d8                	mov    %ebx,%eax
    3b49:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b4c:	31 d2                	xor    %edx,%edx
        ap++;
    3b4e:	83 c0 04             	add    $0x4,%eax
    3b51:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3b54:	e9 4b ff ff ff       	jmp    3aa4 <printf+0x54>
    3b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    3b60:	83 ec 0c             	sub    $0xc,%esp
    3b63:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3b68:	6a 01                	push   $0x1
    3b6a:	eb ce                	jmp    3b3a <printf+0xea>
    3b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    3b70:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    3b73:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3b76:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    3b78:	6a 01                	push   $0x1
        ap++;
    3b7a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    3b7d:	57                   	push   %edi
    3b7e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    3b81:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b84:	e8 6a fd ff ff       	call   38f3 <write>
        ap++;
    3b89:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    3b8c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b8f:	31 d2                	xor    %edx,%edx
    3b91:	e9 0e ff ff ff       	jmp    3aa4 <printf+0x54>
    3b96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b9d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    3ba0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    3ba3:	83 ec 04             	sub    $0x4,%esp
    3ba6:	e9 59 ff ff ff       	jmp    3b04 <printf+0xb4>
    3bab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3baf:	90                   	nop
        s = (char*)*ap;
    3bb0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3bb3:	8b 18                	mov    (%eax),%ebx
        ap++;
    3bb5:	83 c0 04             	add    $0x4,%eax
    3bb8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3bbb:	85 db                	test   %ebx,%ebx
    3bbd:	74 17                	je     3bd6 <printf+0x186>
        while(*s != 0){
    3bbf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    3bc2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    3bc4:	84 c0                	test   %al,%al
    3bc6:	0f 84 d8 fe ff ff    	je     3aa4 <printf+0x54>
    3bcc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3bcf:	89 de                	mov    %ebx,%esi
    3bd1:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3bd4:	eb 1a                	jmp    3bf0 <printf+0x1a0>
          s = "(null)";
    3bd6:	bb 50 55 00 00       	mov    $0x5550,%ebx
        while(*s != 0){
    3bdb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3bde:	b8 28 00 00 00       	mov    $0x28,%eax
    3be3:	89 de                	mov    %ebx,%esi
    3be5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bef:	90                   	nop
  write(fd, &c, 1);
    3bf0:	83 ec 04             	sub    $0x4,%esp
          s++;
    3bf3:	83 c6 01             	add    $0x1,%esi
    3bf6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3bf9:	6a 01                	push   $0x1
    3bfb:	57                   	push   %edi
    3bfc:	53                   	push   %ebx
    3bfd:	e8 f1 fc ff ff       	call   38f3 <write>
        while(*s != 0){
    3c02:	0f b6 06             	movzbl (%esi),%eax
    3c05:	83 c4 10             	add    $0x10,%esp
    3c08:	84 c0                	test   %al,%al
    3c0a:	75 e4                	jne    3bf0 <printf+0x1a0>
    3c0c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    3c0f:	31 d2                	xor    %edx,%edx
    3c11:	e9 8e fe ff ff       	jmp    3aa4 <printf+0x54>
    3c16:	66 90                	xchg   %ax,%ax
    3c18:	66 90                	xchg   %ax,%ax
    3c1a:	66 90                	xchg   %ax,%ax
    3c1c:	66 90                	xchg   %ax,%ax
    3c1e:	66 90                	xchg   %ax,%ax

00003c20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3c20:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c21:	a1 00 5f 00 00       	mov    0x5f00,%eax
{
    3c26:	89 e5                	mov    %esp,%ebp
    3c28:	57                   	push   %edi
    3c29:	56                   	push   %esi
    3c2a:	53                   	push   %ebx
    3c2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3c2e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
    3c30:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c33:	39 c8                	cmp    %ecx,%eax
    3c35:	73 19                	jae    3c50 <free+0x30>
    3c37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c3e:	66 90                	xchg   %ax,%ax
    3c40:	39 d1                	cmp    %edx,%ecx
    3c42:	72 14                	jb     3c58 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c44:	39 d0                	cmp    %edx,%eax
    3c46:	73 10                	jae    3c58 <free+0x38>
{
    3c48:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c4a:	8b 10                	mov    (%eax),%edx
    3c4c:	39 c8                	cmp    %ecx,%eax
    3c4e:	72 f0                	jb     3c40 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c50:	39 d0                	cmp    %edx,%eax
    3c52:	72 f4                	jb     3c48 <free+0x28>
    3c54:	39 d1                	cmp    %edx,%ecx
    3c56:	73 f0                	jae    3c48 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3c58:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c5b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c5e:	39 fa                	cmp    %edi,%edx
    3c60:	74 1e                	je     3c80 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3c62:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c65:	8b 50 04             	mov    0x4(%eax),%edx
    3c68:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c6b:	39 f1                	cmp    %esi,%ecx
    3c6d:	74 28                	je     3c97 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3c6f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    3c71:	5b                   	pop    %ebx
  freep = p;
    3c72:	a3 00 5f 00 00       	mov    %eax,0x5f00
}
    3c77:	5e                   	pop    %esi
    3c78:	5f                   	pop    %edi
    3c79:	5d                   	pop    %ebp
    3c7a:	c3                   	ret    
    3c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c7f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
    3c80:	03 72 04             	add    0x4(%edx),%esi
    3c83:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c86:	8b 10                	mov    (%eax),%edx
    3c88:	8b 12                	mov    (%edx),%edx
    3c8a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c8d:	8b 50 04             	mov    0x4(%eax),%edx
    3c90:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c93:	39 f1                	cmp    %esi,%ecx
    3c95:	75 d8                	jne    3c6f <free+0x4f>
    p->s.size += bp->s.size;
    3c97:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    3c9a:	a3 00 5f 00 00       	mov    %eax,0x5f00
    p->s.size += bp->s.size;
    3c9f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3ca2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3ca5:	89 10                	mov    %edx,(%eax)
}
    3ca7:	5b                   	pop    %ebx
    3ca8:	5e                   	pop    %esi
    3ca9:	5f                   	pop    %edi
    3caa:	5d                   	pop    %ebp
    3cab:	c3                   	ret    
    3cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003cb0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3cb0:	55                   	push   %ebp
    3cb1:	89 e5                	mov    %esp,%ebp
    3cb3:	57                   	push   %edi
    3cb4:	56                   	push   %esi
    3cb5:	53                   	push   %ebx
    3cb6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3cbc:	8b 3d 00 5f 00 00    	mov    0x5f00,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3cc2:	8d 70 07             	lea    0x7(%eax),%esi
    3cc5:	c1 ee 03             	shr    $0x3,%esi
    3cc8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    3ccb:	85 ff                	test   %edi,%edi
    3ccd:	0f 84 ad 00 00 00    	je     3d80 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3cd3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    3cd5:	8b 48 04             	mov    0x4(%eax),%ecx
    3cd8:	39 f1                	cmp    %esi,%ecx
    3cda:	73 71                	jae    3d4d <malloc+0x9d>
    3cdc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    3ce2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3ce7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3cea:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    3cf1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    3cf4:	eb 1b                	jmp    3d11 <malloc+0x61>
    3cf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3cfd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d00:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    3d02:	8b 4a 04             	mov    0x4(%edx),%ecx
    3d05:	39 f1                	cmp    %esi,%ecx
    3d07:	73 4f                	jae    3d58 <malloc+0xa8>
    3d09:	8b 3d 00 5f 00 00    	mov    0x5f00,%edi
    3d0f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3d11:	39 c7                	cmp    %eax,%edi
    3d13:	75 eb                	jne    3d00 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    3d15:	83 ec 0c             	sub    $0xc,%esp
    3d18:	ff 75 e4             	pushl  -0x1c(%ebp)
    3d1b:	e8 3b fc ff ff       	call   395b <sbrk>
  if(p == (char*)-1)
    3d20:	83 c4 10             	add    $0x10,%esp
    3d23:	83 f8 ff             	cmp    $0xffffffff,%eax
    3d26:	74 1b                	je     3d43 <malloc+0x93>
  hp->s.size = nu;
    3d28:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3d2b:	83 ec 0c             	sub    $0xc,%esp
    3d2e:	83 c0 08             	add    $0x8,%eax
    3d31:	50                   	push   %eax
    3d32:	e8 e9 fe ff ff       	call   3c20 <free>
  return freep;
    3d37:	a1 00 5f 00 00       	mov    0x5f00,%eax
      if((p = morecore(nunits)) == 0)
    3d3c:	83 c4 10             	add    $0x10,%esp
    3d3f:	85 c0                	test   %eax,%eax
    3d41:	75 bd                	jne    3d00 <malloc+0x50>
        return 0;
  }
}
    3d43:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3d46:	31 c0                	xor    %eax,%eax
}
    3d48:	5b                   	pop    %ebx
    3d49:	5e                   	pop    %esi
    3d4a:	5f                   	pop    %edi
    3d4b:	5d                   	pop    %ebp
    3d4c:	c3                   	ret    
    if(p->s.size >= nunits){
    3d4d:	89 c2                	mov    %eax,%edx
    3d4f:	89 f8                	mov    %edi,%eax
    3d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    3d58:	39 ce                	cmp    %ecx,%esi
    3d5a:	74 54                	je     3db0 <malloc+0x100>
        p->s.size -= nunits;
    3d5c:	29 f1                	sub    %esi,%ecx
    3d5e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    3d61:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    3d64:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    3d67:	a3 00 5f 00 00       	mov    %eax,0x5f00
}
    3d6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3d6f:	8d 42 08             	lea    0x8(%edx),%eax
}
    3d72:	5b                   	pop    %ebx
    3d73:	5e                   	pop    %esi
    3d74:	5f                   	pop    %edi
    3d75:	5d                   	pop    %ebp
    3d76:	c3                   	ret    
    3d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d7e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    3d80:	c7 05 00 5f 00 00 04 	movl   $0x5f04,0x5f00
    3d87:	5f 00 00 
    base.s.size = 0;
    3d8a:	bf 04 5f 00 00       	mov    $0x5f04,%edi
    base.s.ptr = freep = prevp = &base;
    3d8f:	c7 05 04 5f 00 00 04 	movl   $0x5f04,0x5f04
    3d96:	5f 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d99:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    3d9b:	c7 05 08 5f 00 00 00 	movl   $0x0,0x5f08
    3da2:	00 00 00 
    if(p->s.size >= nunits){
    3da5:	e9 32 ff ff ff       	jmp    3cdc <malloc+0x2c>
    3daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3db0:	8b 0a                	mov    (%edx),%ecx
    3db2:	89 08                	mov    %ecx,(%eax)
    3db4:	eb b1                	jmp    3d67 <malloc+0xb7>
