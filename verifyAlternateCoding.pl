#\perl\bin
use strict;

my $inFileName = "AlternateCoding01.csv";
my $outFileName = "AlternateCoding01.summary.txt";
my @attributes=();
my @attrNames=();
my $cmd="";
my $reccnt=0;
my $numAttr=0;
my $ndx=0;

my $sec= my $min= my $hour=my $mday=my $mon=my $year=my $wday=my $yday=my $isdst="00";
getCurTime();

my $start="Start Time: $year.$mon.$mday $hour:$min:$sec\n";
print $start;

open(INFILE, "< $inFileName") 
  || die "Can't open $inFileName for input\n";
open(OUTFILE, "> $outFileName") 
  || die "Can't open $outFileName for output\n";  
  
  
# 0, 1,       2,           3         , 4      ,5       , 6    , 7 , 8     , 9      , 10    , 11    , 12     , 13
#ST,USFS_Code,Description,Montane_low,Montane,Subalpine,Alpine,Dry,Non_Dry,Alluviam,Glacial,Sed_mix,Ign_Meta,Aquolis_cmplx,Argiborolis_Pachic,Borohemists_cmplx,Bross,Bullwark,Bullwark_Cmplx,Catamount,Catamount_cmplx,Cathedral,Como,Cryaquepts_cmplx,Cryaquepts_Typic,Cryaquolis,Cryaquolis_Typic,Cryoborolis_cmplx,Cryoquolis_cmplx,Cryoquolis_Typic_cmplx,Cryorthents,Cryorthents_cmplx,Cryumbrepts,Cryumbrepts_cmplx,Gateview,Gothic,Granile,Haploborolis,Legault,Legault_cmplx,Leighcan,Leighcan_cmplx,Leighcan_warm,Moran,Ratake,Ratake_cmplx,Rogert,Supervisor-Limber_cmplx,Troutville,Unspecified,Vanet,Wetmore,Bouldery_ext,Rock_Land,Rock_Land_cmplx,Rock_Outcrop,Rock_Outcrop_cmplx,Rubbly,Stony,Stony_extreme,Stony_very,Till_Substratum
#36,8707,"Bross family - Rock land - Cryumbrepts complex, extremely stony.",,,,1,,,,,,1,,,,1,,,,,,,,,,,,,,,,,1,,,,,,,,,,,,,,,,,,,,1,,,,,,1,,


my $filename="";
my $wfilename="";
my $ndx=0;

while (<INFILE>)
{
  chomp();
  if ($_)
  {
    print "$_\n";
    # record keeping
      $reccnt++;
      
    # split directory listing into parts
      @attributes = split(/,/);
    
    if ($reccnt == 1)
    { @attrNames = @attributes; # split(/,/);
    }
    else
    {
      $numAttr = @attributes;
      print OUTFILE " $attributes[0] $attributes[1] $attributes[2]\n        ";
      for ($ndx = 13; $ndx < $numAttr; $ndx++) {
        if ($attributes[$ndx] ne '')
        { print OUTFILE " $attrNames[$ndx]";
        }
      }
      print OUTFILE "\n\n";     
    }
  }
}  

close(INFILE);
close(OUTFILE);

getCurTime();
print "$reccnt records processed\n";
my $end="End   Time: $year.$mon.$mday $hour:$min:$sec\n";
print "$end";
exit(0);



#######################################
sub getCurTime()
{
  ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
  #print "sec=$sec,min=$min,hour=$hour,day=$mday,month=$mon,year=$year,weekday=$wday,dayofyear=$yday,DST=$isdst\n";
  $year+=1900;
  $mon++;
 
  if ($mday < "10") { $mday = "0".$mday; }
  if ($mon < "10") { $mon = "0".$mon; }
  if ($hour < "10") { $hour = "0".$hour; }
  if ($min < "10") { $min = "0".$min; }
  if ($sec < "10") { $sec = "0".$sec; }
}