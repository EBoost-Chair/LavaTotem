# LavaTotem by Wire2Brain<2754887003@qq.com>
# *Important:This copy of LavaTotem is a TEST VERSION 
# ===Game System===
$leadder=[0,0]
$player=[0,0]
$tr=[0,0]
$hp=100
$mp=100
$foot=0
$luck=0
$floor=1
$buff_af=0
$name=""
$mn=0
$dict=["Cereal Bar","Cereal Bar(Extended)","Chocolate Bar","Vacuumed Food","Vacummed Food(Extended)","S.V.F","Vitamin AF","Supper(Boxed!)","Nice Supper(Boxed!)","Super Supper(Boxed!)","Bronze Coin","Silver Coin","Gold Coin","\"Gold\" Coin","Drill","Laser Drill","Lava Gun","Coffee(Decaffeine)","Coffee","Coffee(Extended)","Monster Drink","Final Energy","Changer","Extender","Forget Pill"]
$team="Union"
$bpack=[]
# ====
# method:mapGene
# argument:no
# usage:use this to generate a new map
# * Important:use this will add 50 magic
# * if you do not want to add magic
# * use code like this:
#     mapGene()
#     $mp=$mp-50
# ====
def mapGene()
  $died=0
  $mp=$mp+50
  $Map=[[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
  $leadder[0]=Random.rand(10)
  $leadder[1]=Random.rand(10)
  $player[0]=Random.rand(10)
  $player[1]=Random.rand(10)
  $mn=Random.rand(4)+1
  if Random.rand(10) == 7
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
  $mn.times do |i|
    $Map[Random.rand(10)][Random.rand(10)]=8
  end
  if $luck == 1
    $Map[$tr[0]][$tr[1]]=11
    $luck=0
  end
  $Map.push([4,4,4,4,4,4,4,4,4,4])
end
# ====
# method:mapRend
# argument:no
# usage:rend the map
# ====
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
# ====
# method:moveEnemy
# arguments:x(int),y(int) => Enemy's position
# usage:use this to move enemy
# *Important:Enemy's AI will be added to this method in the future
# ====
def moveEnemy(x,y)
  such=Random.rand(5)
  if such==1
    aim=$Map[x-1][y]
    if aim==0
      $Map[x][y]=0
      $Map[x-1][y]=8
    end
    if aim == 5
      puts "Enemy was killed by lava!"
      $Map[x][y]=0
    end
    if aim == 10
      puts "Enemy attacks you!"
      $hp=$hp-20
    end
  end
  if such==2
    aim=$Map[x+1][y]
    if aim==0
      $Map[x][y]=0
      $Map[x+1][y]=8
    end
    if aim == 5
      $Map[x][y]=0
      puts "Enemy was killed by lava!"
    end
  end
  if such==4
    aim=$Map[x][y-1]
    if aim==0
      $Map[x][y]=0
      $Map[x][y-1]=8
    end
    if aim == 5
      puts "Enemy was killed by lava!"
      $Map[x][y]=0
    end
  end
  if such==3
    aim=$Map[x][y+1]
    if aim==0
      $Map[x][y]=0
      $Map[x][y+1]=8
    end
    if aim == 5
      puts "Enemy was killed by lava!"
      $Map[x][y]=0
    end
  end
end
# ====
# method:move
# arguments:position(int)
# usage:use this to move player
# ====
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
# ====
# method:showBpack
# arguments:no
# usage:use this to show what's in the backpack
# ====
def showBpack()
  puts "Backpack:"
  $bpack.each do |i|
    puts $dict[i]
  end
end
# ====
# method:magic
# argument:magic code(int)
# usage:use this to use magic according to the team setting
# ====
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
# ====
# method:help
# argument:no
# usage:use this to show the LavaTotem Help
# ====
def help()
  puts "LavaTotem Help"
  puts " m[1-4] move 1-4 is position.(e.g m1)"
  puts " p check the backpack"
  puts " u[1-3] use magic.(e.g. u1)"
  puts " b[number] use items.(e.g. b1)"
end
# ====
# method:showStatus
# argument:no
# usage:show player's status
# ====
def showStatus()
  puts "Name:"+$name
  puts "Team:"+$team
  puts "Floor:"+$floor.to_s
  puts "Health:"+$hp.to_s
  puts "Magic:"+$mp.to_s
end
# ====
# method:useItem
# argument:backpack code(int)
# usage:use item
# *Important:"backpack code" is a number that starts from 1
# *it isn't the index of $bpack
# ====
def useItem(bp)
  if $bpack.size < bp
    puts "Item does not exist."
  else
    puts "You use:"+$dict[$bpack[bp.to_i-1]]
  end
end
# ====
# method:gameOver
# argument:no
# usage:show Game Over
# ====
def gameOver()
  puts $name+" died,Game Over."
  puts "You finished "+$floor.to_s+" floors!"
  exit()
end
# ===Game Starts===
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
mapGene()
$mp=$mp-50
mapRend()
loop do
  10.times do |i|
    10.times do |j|
      if $Map[i][j]==8
        moveEnemy(i,j)
      end
    end
  end
  if $hp==0
    gameOver()
  end
  print ">>"
  a=gets()
  if /^s/ =~ a
    showStatus()
  end
  if /^b/ =~ a
    a.slice!(0)
    useItem(a.to_i())
  end
  if /^h/ =~ a
    help()
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