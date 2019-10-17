require_relative 'board.rb' #On fait appel à Board.rb et de Player.rb
require_relative 'player.rb'
require 'colorize'

class Game

    def initialize #On créé 2 joueurs
      puts "
     ██╗ ██████╗ ██╗   ██╗███████╗██╗   ██╗██████╗      ██╗
     ██║██╔═══██╗██║   ██║██╔════╝██║   ██║██╔══██╗    ███║
     ██║██║   ██║██║   ██║█████╗  ██║   ██║██████╔╝    ╚██║
██   ██║██║   ██║██║   ██║██╔══╝  ██║   ██║██╔══██╗     ██║
╚█████╔╝╚██████╔╝╚██████╔╝███████╗╚██████╔╝██║  ██║     ██║
 ╚════╝  ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝     ╚═╝".colorize(:pink)

      @joueur_1 = Player.new

      puts"
     ██╗ ██████╗ ██╗   ██╗███████╗██╗   ██╗██████╗     ██████╗
     ██║██╔═══██╗██║   ██║██╔════╝██║   ██║██╔══██╗    ╚════██╗
     ██║██║   ██║██║   ██║█████╗  ██║   ██║██████╔╝     █████╔╝
██   ██║██║   ██║██║   ██║██╔══╝  ██║   ██║██╔══██╗    ██╔═══╝
╚█████╔╝╚██████╔╝╚██████╔╝███████╗╚██████╔╝██║  ██║    ███████╗
 ╚════╝  ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝    ╚══════╝"

      if @joueur_1.valeur == "X"
        @joueur_2 = Player.new(nil, "O")
      else
        @joueur_2 = Player.new(nil, "X")
      end

      @board = Board.new

    end

    def go
      # On lance la partie,
      puts "\n #{@joueur_1.nom} va jouer le premier"
      sleep 2
      turn #On fait appel à la méthode turn ci-dessous
    end

    def turn
      #On affiche les cases avec ses numéros
      tab = [["1", "2", "3"],["4", "5", "6"],["7", "8", "9"] ]
      puts "Les cases sont numérotés de manière suivant: "
      tab.each do |x|
        puts "\t\t\t --- --- ---"
        puts "\t\t\t| "+x[0].to_s+" | "+x[1]+" | "+x[2]+" |"
        end
      puts "\t\t\t --- --- ---"
      sleep 3

      boucle = true
      var_intermediaire = 0
      nbr_tour = 1
      #On tourne le boucle
      while boucle
        #Si le nombre de tour est paire, alors c'est le deuxième joueur qui joue
        sleep 2 #Petit pause
        if nbr_tour % 2 == 0
          puts "\n#{@joueur_2.nom}, vous allez vous placez où? (case entre 1 à 9)\n"
        else
          puts "\n#{@joueur_1.nom}, vous allez vous placez où? (case entre 1 à 9)\n"
        end
        #On place dans var_intermediaire le numero de case où le joueur veux placer
        var_intermediaire = gets.chomp
        var_intermediaire = var_intermediaire.to_i
        #Les numéros de case doivent être compris entre 1 à 9
        while (var_intermediaire < 1) || (9 < var_intermediaire)
          puts "Error, mauvaise endroit. Reessayez ! "
          var_intermediaire = gets.chomp
          var_intermediaire = var_intermediaire.to_i
        end
        #On place la valeur du joueur au numéros du case choisi
        if nbr_tour % 2 == 0
          playing = @board.play(@joueur_2.valeur, var_intermediaire)
        else
          playing = @board.play(@joueur_1.valeur, var_intermediaire)
        end
        #On check si un joueur a placé dans un placement non-vide
        while playing == false
          var_intermediaire = gets.chomp
          var_intermediaire = var_intermediaire.to_i
          if nbr_tour % 2 == 0
            playing = @board.play(@joueur_2.valeur, var_intermediaire)
          else
            playing = @board.play(@joueur_1.valeur, var_intermediaire)
          end
        end
        #On affiche le board à chaque fois
        sleep 1
        @board.to_s
        #On check si quelqu'un a gagné
        if @board.victory? == true
          if nbr_tour % 2 == 0
            puts "#{@joueur_2.nom} a gagner!"
          else
            puts "#{@joueur_1.nom} a gagner!"
          end
        end
        #On affiche le vainqueur et arrête la boucle si on a une victoire
        break if @board.victory? == true
        #On incrémente le nombre de tour sinon
        nbr_tour += 1
        #On recommence le jeux si le nombre de tour dépasse 9 et si personne n'a gagné
        if nbr_tour == 10
          puts "Match nul, on recommence!"
          nbr_tour = 1
          #On réinitialise la table
          @board.array_case = tab
          @board.to_s
        end
      end

    end

  end
