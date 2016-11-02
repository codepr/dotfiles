#!/usr/bin/perl

use strict;
use warnings;

my $text = "Torna a giocare. Dopo lo scandalo, i tradimenti coniugali e lo stop all’attività. Tiger Woods, ovvero quello che era il golfista più forte del mondo torna a calcare il green e si sottoppone all’assedio del media. Parlando di tutto: dal tradimento nei confronti della moglie all’ammissione di aver avuto decine di amanti al punto da diventare “sesso-dipendente”, alla decisione di confessare tutto e di farsi curare pur di tornare a giocare.
Nella sua prima conferenza stampa dopo la tempesta, tenuta ad Augusta, in Georgia, per il suo ritorno alla attività agonistica in occasione dei Masters americani,  Woods recita molti ‘mea culpa’. Conditi da alcuni “mi spiace” e “adesso sono un uomo nuovo”. Per il campione, vincere sarà ormai “irrilevante” se paragonato “al male provocato alla famiglia”. Woods spiega che in questi cinque mesi ha “guardato dentro se stesso” ed è stato “duro”. Soprattutto per aver causato l’ulteriore “assalto della stampa sulla vita di mia moglie e dei miei figli”. Per questo, aggiunge, la moglie ha deciso di non seguirlo al torneo di Augusta. I fan, invece, non l’hanno dimenticato: “La loro accoglienza mi ha travolto”.";
my $sentenceCount = 0;
my $wordCount = 0;
my $charCount = 0;
++$sentenceCount while $text =~ /["']?[A-Z][^.?!]+((?![.?!]['"]?\s["']?[A-Z][^.?!]).)+[.?!'"]+/g;
$text =~ s/[^\wÈèòàù\(\)\[\]\{\}]/ /g;
++$wordCount while $text =~ /\S+/g;
$text =~ s/[[:punct:]][[:space:]]//g;
++$charCount while $text =~ /[a-zA-Z0-9_Èàòèù\(\)\[\]\{\}]/g;

my $gulpease = 89 + (((300 * $sentenceCount) - (10 * $charCount)) / $wordCount);

print $gulpease;
