$leadder=[0,0]
$player=[0,0]
$hp=100
$foot=0
$floor=1
def mapGene()
  $Map=[[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
  $leadder[0]=Random.rand(10)
  $leadder[1]=Random.rand(10)
  $player[0]=Random.rand(10)
  $player[1]=Random.rand(10)   
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
      elsif j==9
        print "+"
      end
      print " "
    end
    print "\n"
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
end
mapGene()
mapRend()
loop do
  if $hp==0
    puts "Game Over"
    puts "You finished "+$floor.to_s+" floors!"
    exit()
  end
  puts "LavaTotem"
  puts "Floor:"+$floor.to_s
  puts "Health:"+$hp.to_s
  print "Please move(1-4):"
  a=gets().to_i()
  move(a)
  puts
  mapRend()
end
