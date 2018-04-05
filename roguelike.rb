$leadder=[0,0]
$player=[0,0]
$enemy=[0,0]
$efoot=0
$hp=100
$mp=100
$died=0
$foot=0
$floor=1
def mapGene()
  $died=0
  $mp=$mp+50
  $Map=[[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
  $leadder[0]=Random.rand(10)
  $leadder[1]=Random.rand(10)
  $player[0]=Random.rand(10)
  $player[1]=Random.rand(10)
  $enemy[0]=Random.rand(10)
  $enemy[1]=Random.rand(10)   
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
  $Map[$enemy[0]][$enemy[1]]=8
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
  if such == 5 && $mp >= 50 && $Map[$player[0]].include?(9) == false
    puts "Lava Wall!"
    $Map[$player[0]]=[5,5,5,5,5,5,5,5,5,5]
    $foot=5
    $Map[$player[0]][$player[1]]=10
    $mp=$mp-50
  end
  if such == 6 && $hp >= 20
    puts "Bloody Magic!"
    $hp=$hp-10
    $mp=$mp+20
  end
  if such == 8 && $mp >= 100
    puts "Rebuild The World!"
    $mp=$mp-100
    mapGene()
    $mp=$mp-50
  end
  if such == 7 && $mp >= 50
    puts "Cure Magic!"
    $mp=$mp-50
    $hp=$hp+20
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
  puts "LavaTotem"
  puts "Floor:"+$floor.to_s
  puts "Health:"+$hp.to_s
  puts "Magic:"+$mp.to_s
  print "Please move(1-4) or use magic(5-8):"
  a=gets().to_i()
  move(a)
  puts
  mapRend()
end
