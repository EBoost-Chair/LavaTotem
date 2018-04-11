$leadder=[0,0]
$player=[0,0]
$enemy=[0,0]
$tr=[0,0]
$efoot=0
$hp=100
$mp=100
$died=0
$foot=0
$luck=0
$floor=1
$buff_af=0
$name=""
$dict=["Cereal Bar","Cereal Bar(Extended)","Chocolate Bar","Vacuumed Food","Vacummed Food(Extended)","S.V.F","Vitamin AF","Supper(Boxed!)","Nice Supper(Boxed!)","Super Supper(Boxed!)","Bronze Coin","Silver Coin","Gold Coin","\"Gold\" Coin","Drill","Laser Drill","Lava Gun","Coffee(Decaffeine)","Coffee","Coffee(Extended)","Monster Drink","Final Energy","Changer","Extender","Forget Pill"]
$team="Union"
$bpack=[] 
puts "LavaTotem"
puts "Please tell me your name:"
print ">"
$name=gets().chop!
loop do
  puts "LavaTotem"
  puts "Please Select your team:"
  puts "[1]Faith"
  puts "[2]Union"
  puts "[3]Chaos"
  print ">"
  a=gets().to_i
  if a==1
    $team="Faith"
    break
  end
  if a==2
    $team="Union"
    break
  end
  if a==3
    $team="Chaos"
    break
  end
end
def mapGene()
  $died=0
  $mp=$mp+50
  $Map=[[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
  $leadder[0]=Random.rand(10)
  $leadder[1]=Random.rand(10)
  $player[0]=Random.rand(10)
  $player[1]=Random.rand(10)
  if Random.rand(20) == 7
    $luck=1 
    $tr[0]=Random.rand(10)
    $tr[1]=Random.rand(10)
  end
  10.times do |j|
    10.times do |i|
      $Map[j][i]=Random.rand(6)
      if $Map[j][i]<4
        $Map[j][i]=0
      end
    end
  end
  $Map[$leadder[0]][$leadder[1]]=9
  $Map[$player[0]][$player[1]]=10
  $enemy[0]=Random.rand(10)
  $enemy[1]=Random.rand(10) 
  $Map[$enemy[0]][$enemy[1]]=8
  if $luck == 1
    $Map[$tr[0]][$tr[1]]=11
    $luck=0
  end
  $Map.push([4,4,4,4,4,4,4,4,4,4])
end
def mapRend()
  $Map.each do |i|
    i.each do |j|
      if j==10
        print "@"
      elsif j==0
        print " "
      elsif j==4
        print "#"
      elsif j==5
        print "X"
      elsif j==8
        print "A"
      elsif j==9
        print "+"
      elsif j==11
        print "*"
      end
      print " "
    end
    print "\n"
  end
end

def moveEnemy()
  such=Random.rand(5)
  if such==1
    aim=$Map[$enemy[0]-1][$enemy[1]]
    if aim==0
      $Map[$enemy[0]][$enemy[1]]=0
      $enemy[0]=$enemy[0]-1
      $Map[$enemy[0]][$enemy[1]]=8
      $efoot=aim
    end
    if aim == 5
      puts "Enemy was killed by lava!"
      $Map[$enemy[0]][$enemy[1]]=0
      $died=1
    end
    if aim == 10
      puts "Enemy attacks you!"
      $hp=$hp-20
    end
  end
  if such==2
    aim=$Map[$enemy[0]+1][$enemy[1]]
    if aim==0
      $Map[$enemy[0]][$enemy[1]]=0
      $enemy[0]=$enemy[0]+1
      $Map[$enemy[0]][$enemy[1]]=8
      $efoot=aim
    end
    if aim == 5
      $Map[$enemy[0]][$enemy[1]]=0
      $died=1
      puts "Enemy was killed by lava!"
    end
  end
  if such==4
    aim=$Map[$enemy[0]][$enemy[1]-1]
    if aim==0
      $Map[$enemy[0]][$enemy[1]]=0
      $enemy[1]=$enemy[1]-1
      $Map[$enemy[0]][$enemy[1]]=8
      $efoot=aim
    end
    if aim == 5
      puts "Enemy was killed by lava!"
      $Map[$enemy[0]][$enemy[1]]=0
      $died=1
    end
  end
  if such==3
    aim=$Map[$enemy[0]][$enemy[1]+1]
    if aim==0
      $Map[$enemy[0]][$enemy[1]]=0
      $enemy[1]=$enemy[1]+1
      $Map[$enemy[0]][$enemy[1]]=8
      $efoot=aim
    end
    if aim == 5
      puts "Enemy was killed by lava!"
      $Map[$enemy[0]][$enemy[1]]=0
      $died=1
    end
  end
end
def move(such)
  if such==1
    aim=$Map[$player[0]-1][$player[1]]
    if aim==0
      $Map[$player[0]][$player[1]]=$foot
      $player[0]=$player[0]-1
      $Map[$player[0]][$player[1]]=10
      $foot=aim
    end
    if aim == 11
      puts "You get the treasure!"
      $bpack.push(Random.rand(25))
      $Map[$player[0]-1][$player[1]]=0
    end
    if aim == 9
      puts "You can goes to the next floor!"
      $floor=$floor+1
      mapGene()
    end
    if aim == 5
      puts "Ouch!You stepped on the lava!"
      $hp=$hp-10
      $Map[$player[0]][$player[1]]=$foot
      $player[0]=$player[0]-1
      $Map[$player[0]][$player[1]]=10
      $foot=aim
    end
  end
  if such==2
    aim=$Map[$player[0]+1][$player[1]]
    if aim == 11
      puts "You get the treasure!"
      $bpack.push(Random.rand(25))
      $Map[$player[0]+1][$player[1]]=0
    end
    if aim==0
      $Map[$player[0]][$player[1]]=$foot
      $player[0]=$player[0]+1
      $Map[$player[0]][$player[1]]=10
      $foot=aim
    end
    if aim == 9
      puts "You can goes to the next floor!"
      $floor=$floor+1
      mapGene()
    end
    if aim == 5
      puts "Ouch!You stepped on the lava!"
      $hp=$hp-10
      $Map[$player[0]][$player[1]]=$foot
      $player[0]=$player[0]+1
      $Map[$player[0]][$player[1]]=10
      $foot=aim
    end
  end
  if such==4
    aim=$Map[$player[0]][$player[1]-1]
    if aim==0
      $Map[$player[0]][$player[1]]=$foot
      $player[1]=$player[1]-1
      $Map[$player[0]][$player[1]]=10
      $foot=aim
    end
    if aim == 11
      puts "You get the treasure!"
      $bpack.push(Random.rand(25))
      $Map[$player[0]][$player[1]-1]=0
    end
    if aim == 9
      puts "You can goes to the next floor!"
      $floor=$floor+1
      mapGene()
    end
    if aim == 5
      puts "Ouch!You stepped on the lava!"
      $hp=$hp-10
      $Map[$player[0]][$player[1]]=$foot
      $player[1]=$player[1]-1
      $Map[$player[0]][$player[1]]=10
      $foot=aim
    end
  end
  if such==3
    aim=$Map[$player[0]][$player[1]+1]
    if aim==0
      $Map[$player[0]][$player[1]]=$foot
      $player[1]=$player[1]+1
      $Map[$player[0]][$player[1]]=10
      $foot=aim
    end
    if aim == 11
      puts "You get the treasure!"
      $bpack.push(Random.rand(25))
      $Map[$player[0]][$player[1]+1]=0
    end
    if aim == 9
      puts "You can goes to the next floor!"
      $floor=$floor+1
      mapGene()
    end
    if aim == 5
      puts "Ouch!You stepped on the lava!"
      $hp=$hp-10
      $Map[$player[0]][$player[1]]=$foot
      $player[1]=$player[1]+1
      $Map[$player[0]][$player[1]]=10
      $foot=aim
    end
  end
end
def showBpack()
  puts "Backpack:"
  $bpack.each do |i|
    puts $dict[i]
  end
end
def magic(such)
  if $team=="Chaos"
    if such == 1 && $hp <= 30
      puts "You will die if you keep using this magic..."
    end
    if such == 2 && $mp <= 100
      puts "You don't have enough magic."
    end
    if such == 1 && $hp >= 30
      puts "Bloody Magic!"
      $hp=$hp-30
      $mp=$mp+20
    end
    if such == 2 && $mp >= 100
      puts "Rebuild The World!"
      $mp=$mp-100
      mapGene()
      $mp=$mp-50
    end
  end
  if $team=="Faith"
    if such == 1 && $mp <= 50
      puts "You don't have enough magic."
    end
    if such == 2 && $mp <= 100
      puts "You don't have enough magic."
    end
    if such == 1 && $mp >= 50
      puts "Cure Magic!"
      $mp=$mp-40
      $hp=$hp+20
    end
    if such == 2 && $mp >= 100
      puts "Rebuild The World!"
      $mp=$mp-100
      mapGene()
      $mp=$mp-50
    end
  end
end
mapGene()
$mp=$mp-50
mapRend()
loop do
  if $died==0
    moveEnemy()
  end
  if $hp==0
    puts "Game Over"
    puts "You finished "+$floor.to_s+" floors!"
    exit()
  end
  print ">>"
  a=gets()
  if /^s/ =~ a
    puts "Name:"+$name
    puts "Team:"+$team
    puts "Floor:"+$floor.to_s
    puts "Health:"+$hp.to_s
    puts "Magic:"+$mp.to_s
  end
  if /^b/ =~ a
    a.slice!(0)
    if $bpack.size < a.to_i
      puts "Item does not exist."
    else
      puts "You use:"+$dict[$bpack[a.to_i-1]]
    end
  end
  if /^h/ =~ a
    puts "LavaTotem Help"
    puts " m[1-4] move 1-4 is position.(e.g m1)"
    puts " p check the backpack"
    puts " u[1-3] use magic.(e.g. u1)"
    puts " b[number] use items.(e.g. b1)"
  end
  if /^p/ =~ a
    showBpack()
  end
  if /^m/ =~ a
    a.slice!(0)
    move(a.to_i)
  end
  if /^u/ =~ a
    a.slice!(0)
    magic(a.to_i)
  end
  puts
  mapRend()
end
