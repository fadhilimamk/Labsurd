%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LABSURD - A Simple Text-Driven Adventure Game in the Spirit of Labtek X

%		 Permainan text adventure yang dibuat oleh :
%		 	1. Fadhil Imam Kurnia
%		 	2. Alif Ijlal W
%		 	3. Francisco Kenandi
%		 	4. Muhammad Hilmi A

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ------------------------------------------------------------------------------- Deklarasi Fakta Statik ------------------------------------------------------
% Berisi deklarasi fakta statik, yaitu fakta yang tidak berubah-ubah seiring berjalannya permainan.

tempat(sekre_HMIF).
tempat(lab_gaib).
tempat(lab_sister).
tempat(ruang_7602).
tempat(lab_pemrograman).
tempat(lab_basdat).

north(sekre_HMIF,lab_basdat).
north(lab_sister,sekre_HMIF).
north(ruang_7602,lab_sister).
south(sekre_HMIF,lab_sister).
south(lab_basdat,sekre_HMIF).
south(lab_sister,ruang_7602).
west(sekre_HMIF,lab_gaib).
west(lab_pemrograman,sekre_HMIF).
east(sekre_HMIF,lab_pemrograman).
east(lab_gaib,sekre_HMIF).

pintu(X,Y):-
	north(X,Y),south(Y,X).
pintu(X,Y):-
	north(Y,X),south(X,Y).
pintu(X,Y):-
	west(X,Y),east(Y,X).
pintu(X,Y):-
	west(Y,X),east(X,Y).

equipable(kapak).
equipable(pen).
equipable(celana_panjang).
equipable(sepatu).
equipable(password).
equipable(kunci_lemari).
equipable(pineapple).
equipable(baju_berkerah).
equipable(lolipop).
equipable(apple).

perabotan(lemari_besi).
perabotan(lemari_kayu).
perabotan(kotak_pensil).
perabotan(switch).
perabotan(parcel).

npc(kak_bimz).
npc(bu_ingus).

lokasi_npc(kak_bimz,sekre_HMIF).
lokasi_npc(bu_ingus,lab_pemrograman).

kombinasi([apple,pen,pineapple]).

% ------------------------------------------------------------------------------- Mulai program -----------------------------------------

start:-
	init_fakta_dinamik,
	write('     Hai Oedin, kamu sudah terbangun di tengah-tengah Labtek X'),nl,
	start_story,nl,
	instruction,
	looping.

looping:-																				% looping untuk perintah
	repeat,
	write('> '),
	read(X),
	do(X),nl,
	(menang ; skshabis ;X == quit),!.

init_fakta_dinamik:-																% Inisialisasi fakta dinamik, yaitu fakta yang dapat berubah dalam permainan
		assertz(here(sekre_HMIF)),									% Menyimpan posisi pemain
		assertz(mySKS(3)),													% Menyimpan SKS pemain (permainan berakhir jika SKS = 0)
		asserta(punya(ktm)),												% Menyimpan item yang dimiliki pemain
		assertz(lokasi(lemari_besi,sekre_HMIF)),		% Menyimpan lokasi-lokasi item, item dapat berpindah-pindah
		assertz(lokasi(celana_panjang,lemari_besi)),
		assertz(lokasi(sepatu,lemari_besi)),
		assertz(terkunci(sepatu)),
		assertz(terkunci(celana_panjang)),
		assertz(lokasi(kunci_lemari,lab_basdat)),
		assertz(lokasi(kapak,lab_basdat)),
		assertz(lokasi(parcel,lab_gaib)),
		assertz(lokasi(pineapple,parcel)),
		assertz(terkunci(pineapple)),
		assertz(lokasi(lemari_kayu,lab_gaib)),
		assertz(lokasi(switch,lab_gaib)),
		assertz(lokasi(baju_berkerah,lemari_kayu)),
		assertz(lokasi(lolipop,lemari_kayu)),
		assertz(terkunci(baju_berkerah)),
		assertz(terkunci(lolipop)),
		assertz(lokasi(apple,lab_pemrograman)),
		assertz(lokasi(kotak_pensil,lab_sister)),
		assertz(lokasi(pen,kotak_pensil)),
		assertz(off(lemari_besi)),
		assertz(off(parcel)),
		assertz(off(lemari_kayu)),
		assertz(on(kotak_pensil)),
		assertz(pernah_heal(0)),
		asserta(dialogbimz(1)),										% Menyimpan 'variable' untuk dialog
		asserta(dialogings(1)),
		asserta(countbimz(0)),
		asserta(cheat(0)),												% Side Quest
		asserta(count_aksi(0)).										% Menghitung aksi

instruction:-
	write('     Instruksi yang dapat gunakan diantaranya :'),nl,
	write('       start.                              -- Memulai permainan'),nl,
	write('       n.   s.   e.   w.                   -- untuk pindah tempat'),nl,
	write('       talk(Orang)                         -- untuk berbicara dengan seseorang'),nl,
	write('       take(Object)                        -- untuk mengambil sebuah Objek benda'),nl,
	write('       use(Thing,Object)                   -- untuk menggunakan sebuah Benda kepada Objek'),nl,
	write('       drop(Object)                        -- untuk meletakan sebuah Objek ke ruangan saat ini'),nl,
	write('       combine(Object1,Object2, Object3)   -- untuk menggabungkan 3 Objek menjadi 1, hati-hati '),nl,
	write('                                              benda yang digabung tidak bisa dipisah kembali '),nl,
	write('       stat.                               -- untuk melihat status pemain saat ini'),nl,
	write('       heal.                               -- untuk menambah SKS kamu'),nl,
	write('       look.                               -- untuk mengamati sekitarmu'),nl,
	write('       map.                                -- menampilkan peta posisi anda'),nl,
	write('       lookin(Object).                     -- untuk mengamati isi suatu benda'),nl,
	write('       instruction.                        -- untuk menampilkan pesan ini'),nl,
	write('       save(Filename).                     -- untuk menyimpan permainan yang sedang berjalan'),nl,
	write('       load(Filename).                     -- untuk membuka permainan yang telah disimpan'),nl,
	write('       quit.                               -- untuk mengakhiri permainan dan keluar'),nl.

start_story:-
      write('                    --------------                     \"Oedin! Bangunlah, kamu sekarang ada di Labtek X\", Kak Bimz sedang membangunkanmu.'),nl,
      write('                   |              |                    \"Kamu sekarang berada di Sekre HMIF, di tengah-tengah Labtek X yang legendaris\", '),nl,
      write('    n              |  lab_basdat  |                    lanjutnya lagi tanpa peduli kondisimu yang kebingungan'),nl,
      write('    ^              |              |                    Terdapat 6 ruangan di Labtek X ini, yaitu'),nl,
      write('    |    ---------- -------------- -----------------       1. Lab Basdat'),nl,
      write('    |   |          |              |                 |      2. Lab GaIB'),nl,
      write('        |          |              |                 |      3. Lab Pemrograman'),nl,
      write('        | lab_gaib |  sekre_HMIF  | lab_pemrograman |      4. Lab SisTer'),nl,
      write('        |          |              |                 |      5. Lab Sekre HMIF'),nl,
      write('        |          |              |                 |      6. Lab Ruang Sakti 7602'),nl,
      write('         ---------- -------------- -----------------   '),nl,
      write('                   |              |                    Kamu harus mencari 3 benda pusaka sakti dan menggunakannya di Ruang 7602 untuk dapat'),nl,
      write('                   |  lab_sister  |                    keluar dan menghancurkan Labtek X ini dengan selamat. Namun hati-hati, kamu hanya memiliki '),nl,
      write('                   |              |                    5 SKS (Satuan Keselamatan Semu). Setiap keslahan yang kamu lakukan akan mengurangi SKS-mu dan'),nl,
      write('                    --------------                     apabila SKS-mu habis maka kamu akan terjebak bersama Kak Bimz selamanya di Labtek X'),nl,
      write('                   |              |                    '),nl,
      write('                   |              |                    '),nl,
      write('                   |  ruang_7602  |                    '),nl,
      write('                   |              |                    '),nl,
      write('                   |              |                    '),nl,
      write('                    --------------                     '),nl
.

% ------------------------------------------------------------------------------- Perintah - perintah yang dapat digunakan -------------------

do(instruction):-instruction,tambah_aksi,!.
do(talk(X)):-talk(X),tambah_aksi,!.
do(take(X)):-take(X),tambah_aksi,!.
do(use(X,Y)):-use(X,Y),tambah_aksi,!.
do(drop(X)):-write('Kamu menjatuhkan '),write(X),nl,drop(X),tambah_aksi,!.
do(combine(X,Y,Z)):-combine(X,Y,Z),tambah_aksi,!.
do(stat):-stat,tambah_aksi,!.
do(heal):-healme,tambah_aksi,!.
do(look):-look,tambah_aksi,!.
do(map):-map,tambah_aksi,!.
do(lookin(Object)):-lookin(Object),tambah_aksi,!.
do(save(Filename)):-save(Filename),tambah_aksi,!.
do(load(Filename)):-load_data(Filename),tambah_aksi,!.
do(s):-s,tambah_aksi,!.
do(n):-n,tambah_aksi,!.
do(w):-w,tambah_aksi,!.
do(e):-e,tambah_aksi,!.
do(quit):-quit,!.
do(_):-
	write('Instruksi salah!').

tambah_aksi:-
	count_aksi(X),
	Y is X + 1,
	retractall(count_aksi(_)),
	asserta(count_aksi(Y)),!.

% ------------------------------------------------------------------------------- Navigasi -------------------
s:-
	here(Asal),
	south(Asal,Tujuan),
	dapat_ke(Tujuan),
	pindah_ke(Tujuan),!.
s:-write('kamu tidak bisa ke selatan, tidak ada pintu disana'),nl.

w:-
	here(Asal),
	west(Asal,Tujuan),
	dapat_ke(Tujuan),
	pindah_ke(Tujuan),!.
w:-write('kamu tidak bisa ke barat, tidak ada pintu disana'),nl.

e:-
	here(Asal),
	east(Asal,Tujuan),
	dapat_ke(Tujuan),
	(Tujuan == lab_pemrograman),
	pindah_ke(Tujuan),
	(
		\+ punya(baju_berkerah),
		\+ punya(sepatu),
		\+ punya(celana_panjang)
	),
	write('Tiba tiba Bu Ingus menegurmu!'),nl,
	talk(bu_ingus),pindah_ke(Asal),!.

e:-
	here(Asal),
	east(Asal,Tujuan),
	dapat_ke(Tujuan),
	pindah_ke(Tujuan),!.

e:-write('kamu tidak bisa ke timur, tidak ada pintu disana'),nl.

n:-
	here(Asal),
	north(Asal,Tujuan),
	dapat_ke(Tujuan),
	pindah_ke(Tujuan),!.
n:-write('kamu tidak bisa ke utara, tidak ada pintu disana'),nl.

dapat_ke(Tujuan):-
	here(Asal),
	pintu(Asal,Tujuan),!.
dapat_ke(Tujuan):-
	write('Kamu tidak bisa ke '),write(Tujuan),nl,fail.

pindah_ke(Tujuan):-
	retract(here(_)),
	asserta(here(Tujuan)),
	write('Sekarang kamu berada di '),write(Tujuan),nl.

% ------------------------------------------------------------------------------- Implementasi perintah map -------------------

map:-
	here(sekre_HMIF),
	write('Posisimu sekarang : sekre_HMIF'),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('    n              |  lab_basdat  |                    '),nl,
	write('    ^              |              |                    '),nl,
	write('    |    ---------- -------------- -----------------   '),nl,
	write('    |   |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        | lab_gaib |      here    | lab_pemrograman |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('         ---------- -------------- -----------------   '),nl,
	write('                   |              |                    '),nl,
	write('                   |  lab_sister  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |  ruang_7602  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),!.

map:-
	here(lab_basdat),
	write('Posisimu sekarang : lab_basdat'),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('    n              |     here     |                    '),nl,
	write('    ^              |              |                    '),nl,
	write('    |    ---------- -------------- -----------------   '),nl,
	write('    |   |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        | lab_gaib |  sekre_HMIF  | lab_pemrograman |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('         ---------- -------------- -----------------   '),nl,
	write('                   |              |                    '),nl,
	write('                   |  lab_sister  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |  ruang_7602  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),!.

map:-
	here(lab_gaib),
	write('Posisimu sekarang : lab_gaib'),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('    n              |  lab_basdat  |                    '),nl,
	write('    ^              |              |                    '),nl,
	write('    |    ---------- -------------- -----------------   '),nl,
	write('    |   |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        |   here   |  sekre_HMIF  | lab_pemrograman |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('         ---------- -------------- -----------------   '),nl,
	write('                   |              |                    '),nl,
	write('                   |  lab_sister  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |  ruang_7602  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),!.

map:-
	here(lab_pemrograman),
	write('Posisimu sekarang : lab_pemrograman'),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('    n              |  lab_basdat  |                    '),nl,
	write('    ^              |              |                    '),nl,
	write('    |    ---------- -------------- -----------------   '),nl,
	write('    |   |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        | lab_gaib |  sekre_HMIF  |       here      |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('         ---------- -------------- -----------------   '),nl,
	write('                   |              |                    '),nl,
	write('                   |  lab_sister  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |  ruang_7602  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),!.

map:-
	here(lab_sister),
	write('Posisimu sekarang : lab_sister'),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('    n              |  lab_basdat  |                    '),nl,
	write('    ^              |              |                    '),nl,
	write('    |    ---------- -------------- -----------------   '),nl,
	write('    |   |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        | lab_gaib |  sekre_HMIF  | lab_pemrograman |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('         ---------- -------------- -----------------   '),nl,
	write('                   |              |                    '),nl,
	write('                   |     here     |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |  ruang_7602  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),!.

map:-
	here(ruang_7602),
	write('Posisimu sekarang : ruang_7602'),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('    n              |  lab_basdat  |                    '),nl,
	write('    ^              |              |                    '),nl,
	write('    |    ---------- -------------- -----------------   '),nl,
	write('    |   |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        | lab_gaib |  sekre_HMIF  | lab_pemrograman |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('        |          |              |                 |  '),nl,
	write('         ---------- -------------- -----------------   '),nl,
	write('                   |              |                    '),nl,
	write('                   |  lab_sister  |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |     here     |                    '),nl,
	write('                   |              |                    '),nl,
	write('                   |              |                    '),nl,
	write('                    --------------                     '),!.

% ------------------------------------------------------------------------------- Implementasi perintah use -------------------

use(lolipop,kak_bimz):-
	retract(punya(lolipop)),
	assertz(punya(password)),
	write('Kak Bimz memberikanmu password untuk switch'),nl,!.
use(kunci_lemari,lemari_besi):-
	punya(kunci_lemari),
	here(Posisi),
	lokasi(lemari_besi,Posisi),
	retract(off(lemari_besi)),
	assertz(on(lemari_besi)),
	retract(terkunci(celana_panjang)),
	retract(terkunci(sepatu)),
	write('Lemari besi berhasil dibuka'),nl,!.
use(pen,parcel):-
	punya(pen),
	here(Posisi),
	lokasi(parcel,Posisi),
	retract(off(parcel)),
	assertz(on(parcel)),
	retract(terkunci(pineapple)),
	write('Hmmm, parcel berhasil kamu sobek dengan pen'),nl,!.
use(kapak,lemari_kayu):-
	punya(kapak),
	here(Posisi),
	lokasi(lemari_kayu,Posisi),
	retract(off(lemari_kayu)),
	assertz(on(lemari_kayu)),
	retract(terkunci(baju_berkerah)),
	retract(terkunci(lolipop)),
	write('Brakkk, kamu berhasil menghancurkan lemari kayu! Sekarang itu terbuka'),nl,!.
use(password,switch):-
	punya(password),
	here(Posisi),
	lokasi(switch,Posisi),
	retract(cheat(0)),
	asserta(cheat(1)),
	write('Wow kamu berhasil menyelesaikan side quest!! Sekarang SKS kamu tidak akan bisa berkurang'),nl,!.

use(_,_):-
	cheat(0),
	decSKS,
	write('Apa yang kamu lakukan? Sepertinya kamu melakukan kesalahan, SKS kamu berkurang lagi!'),nl.

use(_,_):-
	cheat(1),
	decSKS,
	write('Apa yang kamu lakukan? Sepertinya kamu melakukan kesalahan, seharusnya SKS kamu berkurang.'),nl,
	write('Untung kamu memiliki cheat.'),nl.

% ------------------------------------------------------------------------------- Implementasi perintah drop -------------------

drop(Barang):-
	here(Tempat),
	retract(punya(Barang)),
	assertz(lokasi(Barang,Tempat)),
	write('Kamu menaruh '),write(Barang),write(' di '),write(Tempat),nl.

% ------------------------------------------------------------------------------- Implementasi perintah look -------------------

list_barang(Tempat):-
  lokasi(X,Tempat),
  tab(2),write(X),nl,
  fail.
list_barang(_).

list_pintu(Tempat):-
	pintu(X,Tempat),
	tab(2),write(X),nl,
	fail.
	list_pintu(_).

list_npc(Tempat):-
	lokasi_npc(X,Tempat),
	tab(2),write(X),nl,
	fail.
list_npc(_).

lookin(Barang):-
	lokasi(_,Barang),
	off(Barang),nl,nl,
	write(Barang),write(' belum terbuka. Carilah sesuatu untuk membukanya'),nl,!.
lookin(Barang):-
	lokasi(_,Barang),
	on(Barang),
	write('Isi dalam '),write(Barang),nl,
	list_barang(Barang).
lookin(Barang):-
	write(Barang),write(' tidak bisa dilihat isinya'),nl,!.

look:-
	here(Posisi),
	write('Kamu sekarang berada di '),write(Posisi),nl,
	write('Di dalam '),write(Posisi),write(' ada barang barang berikut:'),nl,
	list_barang(Posisi),
	write('Kamu dapat berpindah ke ruangan berikut:'),nl,
	list_pintu(Posisi),
	write('Orang yang berada di '),write(Posisi),write(' :'),nl,
	list_npc(Posisi).


% ------------------------------------------------------------------------------- Implementasi perintah take -------------------


take(Thing) :-
	isHere(Thing),
	isDapatDiambil(Thing),
	simpan(Thing),
	write('Sekarang kamu memiliki '),write(Thing),!.
take(_).

isHere(Thing):-												%isHere
	here(Here),
	lokasi(Thing,Here),!.
isHere(Thing):-
	here(Here),
	lokasi(Thing,X),
	lokasi(X,Here),!.
isHere(X):-														%else
	write(X),write(' tidak ada disini.'),nl,!,fail.

isDapatDiambil(Thing):-
	perabotan(Thing),
	write('Sepertinya '),write(Thing),write(' tidak dapat diambil.'),nl,!,fail.
isDapatDiambil(Thing):-
	terkunci(Thing),
	write('Sepertinya '),write(Thing),write(' tidak ada disini.'),nl,!,fail.
isDapatDiambil(_).

simpan(Thing):-
	retract(lokasi(Thing,_)),
	assertz(punya(Thing)).



% ------------------------------------------------------------------------------- Implementasi perintah stat -------------------

list_item:-
	punya(X),
	tab(2),write(X),nl,fail.
list_item.

stat:-
	mySKS(X),
	write('Jumlah SKS kamu sekarang : '), write(X),nl,
	write('Barang yang kamu miliki : '), nl,list_item,nl,!.


decSKS:-
		retract(mySKS(X)),
		Y is X-1,
		asserta(mySKS(Y)).

healme:-
	here(sekre_HMIF),
	pernah_heal(0),
	retract(pernah_heal(0)),
	asserta(pernah_heal(1)),
	retract(mySKS(X)),
	Y is X+1,
	asserta(mySKS(Y)),
	write('SKS-mu sudah bertambah menjadi '),write(Y),nl,!.
healme:-
	here(sekre_HMIF),
	pernah_heal(1),
	write('Kamu sudah menggunakan heal sebelumnya!'),nl,!.
healme:-
	write('Kak Bimz tidak disini....'),nl.


% ------------------------------------------------------------------------------- Implementasi perintah talk -------------------

talk(kak_bimz):-
	here(sekre_HMIF),
	bimz,
	retract(countbimz(X)),
	Y is X+1,
	asserta(countbimz(Y)),!.

talk(bu_ingus):-
		here(lab_pemrograman),
		ings,!.

talk(_):-
	write('Sepertinya kamu salah panggil orang').

	bimz :-
		countbimz(10),                                                                                                           /*easter egg*/
		write('Kak Bimz :\"2 hari yang lalu aku bermimpi menjadi air mancur sebuah kolam raksasa. Kuharap itu bukan takdirku nantinya. Sungguh geli membayangkan disuruh'),nl,
		write('mengucurkan air terus-menerus ke atas.\"'),!.
	bimz :-
		dialogbimz(1),
		write('Kak Bimz : ''''Maaf apabila perkenalan tadi terlalu cepat. Anyway, kenapa tidak mencoba melihat-lihat sekitar terlebih dahulu? Cobalah untuk pergi ke '),nl,
		write('ruangan di timur sana. Tenang saja, Labtek X sebegitu ajaib sehingga kau tidak perlu memperdulikan arah, cukup pikirkan arah mata angin dan jika'),nl,
		write('kau ingin ke sana, kau akan kesana.'''''),nl,!.
	bimz :-
		dialogbimz(2),
		write('Kak Bimz : ''''Oh, aku lupa mengingatkanmu. Pergi carilah pakaian bekas di sekitar sini. Jangan tanya aku bagaimana pakaian-pakaian tersebut ada disini;  '),nl,
		write('semua yang ada di Labtek X tidak pernah cukup logis namun tidak pernah pula cukup tidak logis'''''),nl,!.
	bimz :-
		dialogbimz(3),
		write('Kak Bimz : ''''Hahaha, jangan dipaksa. Carilah kuncinya di Lab Basdas,sebelah utara dari sini. '),nl,
		retract(dialogbimz(3)),
		asserta(dialogbimz(4)),!.
	bimz :-
		dialogbimz(4),
		write('Kak Bimz : ''''Kenapa aku mengetahuinya? Tentu saja, kan aku yang menyembunyikannya. Kupikir kau harus kupaksa berjalan-jalan sejenak setelah kau siuman. '),nl,
		write('Hehehe.'''''),nl,!.
	bimz :-
		dialogbimz(5),
		write('Kak Bimz : ''''Kemarilah jika kau butuh SKS tambahan, pelukan hangatku bisa menyelesaikan masalah itu <3'''''),nl,
		retract(dialogbimz(5)),
		asserta(dialogbimz(6)),!.
	bimz :-
		dialogbimz(6),
		write('Kak Bimz : ''''Kuharap aku juga bisa keluar bersamamu ketika kau telah berhasil menghancurkan Labtek X ini”'''''),nl,
		retract(dialogbimz(6)),
		asserta(dialogbimz(7)),!.
	bimz :-
		dialogbimz(7),
		write('Kak Bimz : ''''Pada awalnya aku sedikit bersyukur kebutuhan biologisku hilang semenjak terkena kutukan disini. Tapi serius, aku merindukan kamar mandi.”'''''),nl,
		retract(dialogbimz(7)),
		asserta(dialogbimz(5)),!.

	ings :-
		punya(baju_berkerah),
		punya(sepatu),
		punya(celana_panjang),
		(
			dialogings(1);
			dialogings(3)
		 ),
		retract(dialogings(_)),
		asserta(dialogings(4)),
		retractall(dialogbimz(_)),
		asserta(dialogbimz(5)),
		write('Bu Ingus : ''''Terima kasih, ya. Silahkan berkeliling atau apapun tujuanmu tadi'''''),nl,!.
	ings :-
		punya(baju_berkerah),
		punya(sepatu),
		punya(celana_panjang),
		dialogings(4),
		write('Bu Ingus : ''''Maaf, tolong jangan ganggu. Aku sedang sibuk.'''''),nl,!.
	ings :-
		dialogings(1),
		retract(dialogings(1)),
		asserta(dialogings(3)),
		retractall(dialogbimz(_)),
		asserta(dialogbimz(2)),
		write('Bu Ingus : ''''Eh, halo- tunggu, maaf anak muda, kembalilah dengan memakai pakaian sopan dan rapi jika kau ingin masuk'''''),nl,!.
	ings :-
		retractall(dialogings(_)),
		asserta(dialogings(3)),
		cheat(0),
		decSKS,
		write('''''...........'''''),nl,
		write('Entah kenapa tiba-tiba kau merasa kurang enak badan sesaat. SKS kamu berkurang'),nl,!.
	ings :-
		retractall(dialogings(_)),
		asserta(dialogings(3)),
		cheat(1),
		write('Bu Ingus : Untung saja kamu pintar, saya tidak bisa mengurangi SKS kamu. Tapi kamu masih belum berpakaian sopan!'),nl,!.



% ------------------------------------------------------------------------------- Implementasi perintah combine -------------------

combine(_,_,_):-
	here(Posisi),
	\+ (Posisi == ruang_7602),
	tab(2),write('Anda hanya bisa mengkombinasikan di ruang_7602'),nl.

combine(X,Y,Z):-
	kombinasi(List),
	member(X,List),!,
	member(Y,List),!,
	member(Z,List),!,
	punya(X),
	punya(Y),
	punya(Z),
	retract(punya(X)),
	retract(punya(Y)),
	retract(punya(Z)),
	here(Posisi),
	(Posisi == ruang_7602),
	tab(2),write('Anda mengkombinasikan '), write(X), write(', '), write(Y), write(', dan '), write(Z),nl,
	assertz(punya(pen_pineapple_apple)),!.

combine(X,Y,Z):-
	kombinasi(List),
	member(X,List),!,
	member(Y,List),!,
	member(Z,List),!,
	\+ punya(X),
	tab(2),write('Anda belum memiliki '), write(X),nl,fail.

combine(X,Y,Z):-
	kombinasi(List),
	member(X,List),!,
	member(Y,List),!,
	member(Z,List),!,
	\+ punya(Y),
	tab(2),write('Anda belum memiliki '), write(Y),nl,fail.

combine(X,Y,Z):-
	kombinasi(List),
	member(X,List),!,
	member(Y,List),!,
	member(Z,List),!,
	\+ punya(Z),
	tab(2),write('Anda belum memiliki '), write(Z),nl.

combine(X,Y,Z):-
	tab(2), write('Anda tidak bisa mengkombinasikan '), write(X), write(', '), write(Y), write(', dan '), write(Z),nl.

% ------------------------------------------------------------------------------- Kondisi akhir permainan -------------------
quit:-
	write('Kamu mau menyerah?'),nl,
	write('Yaah, kamu terjebak selamanya di Labtek X'),nl,nl,
	count_aksi(X),
	write('Jumlah aksi yang sudah kamu lakukan : '),write(X),nl,nl,
	reset.

menang:-
	here(ruang_7602),
	punya(pen_pineapple_apple),
	write('Tiba tiba benda sakti itu memancarkan cahaya, dan kamu berhasil keluar dari Labtek X'),nl,
	write('Selamat kamu menang !!!'),nl,nl,
	count_aksi(X),
	write('Jumlah aksi yang sudah kamu lakukan : '),write(X),nl,nl,
	reset.

skshabis:-
	mySKS(0),
	write('SKS kamu sudah 0'),nl,
	write('Kamu terjebak selama-lamanya di Labtek X!!!'),nl,nl,
	count_aksi(X),
	write('Jumlah aksi yang sudah kamu lakukan : '),write(X),nl,nl,
	reset.

% ------------------------------------------------------------------------------- Save permainan -------------------
save(Filename):-
	mySKS(Nyawa),
	here(Tempat),
	dialogbimz(A),
	dialogings(B),
	countbimz(C),
	pernah_heal(D),
	cheat(E),
	count_aksi(F),
	open(Filename,write,Stream),
	(
		write(Stream,'mySKS('),write(Stream,Nyawa),write(Stream,').'),nl(Stream),
		write(Stream,'here('),write(Stream,Tempat),write(Stream,').'),nl(Stream),
		write(Stream,'dialogbimz('),write(Stream,A),write(Stream,').'),nl(Stream),
		write(Stream,'dialogings('),write(Stream,B),write(Stream,').'),nl(Stream),
		write(Stream,'countbimz('),write(Stream,C),write(Stream,').'),nl(Stream),
		write(Stream,'pernah_heal('),write(Stream,D),write(Stream,').'),nl(Stream),
		write(Stream,'cheat('),write(Stream,E),write(Stream,').'),nl(Stream),
		write(Stream,'count_aksi('),write(Stream,F),write(Stream,').'),nl(Stream),
		save_item(Stream),
		save_lokasi(Stream),
		save_on(Stream),
		save_off(Stream),
		save_terkunci(Stream)
	),
	close(Stream).

save_item(Stream):-
	punya(Item),
	write(Stream,'punya('),write(Stream,Item),write(Stream,').'),nl(Stream),fail.
save_item(_).

save_lokasi(Stream):-
	lokasi(Item,Tempat),
	write(Stream,'lokasi('),write(Stream,Item),write(Stream,','),write(Stream,Tempat),write(Stream,').'),nl(Stream),fail.
save_lokasi(_).

save_on(Stream):-
	on(Thing),
	write(Stream,'on('),write(Stream,Thing),write(Stream,').'),nl(Stream),fail.
save_on(_).

save_off(Stream):-
	off(Thing),
	write(Stream,'off('),write(Stream,Thing),write(Stream,').'),nl(Stream),fail.
save_off(_).

save_terkunci(Stream):-
	terkunci(Thing),
	write(Stream,'terkunci('),write(Stream,Thing),write(Stream,').'),nl(Stream),fail.
save_terkunci(_).

load_data(Filename):-
	file_exists(Filename),
	reset,
	open(Filename,read,Stream),
	(
		repeat,
		read_term(Stream, X, []),
		bacaFakta(X), !
	),
	close(Stream).
load_data(Filename):-
	write('Tidak ada data dengan nama'),write(Filename),nl.

bacaFakta(end_of_file):- !.
bacaFakta(X):-
	asserta(X),!,
	fail.

% ------------------------------------------------------------------------------- Reset permainan -------------------
% Menghilangkan fakta dinamik dari permainan
reset:-
	retractall(mySKS(_)),
	retractall(here(_)),
	retractall(cheat(_)),
	retractall(lokasi(_,_)),
	retractall(punya(_)),
	retractall(off(_)),
	retractall(on(_)),
	retractall(terkunci(_)),
	retractall(count_aksi(_)),
	retract(pernah_heal(_)),
	retract(dialogbimz(_)),
	retract(dialogings(_)),
	retract(countbimz(_)).
