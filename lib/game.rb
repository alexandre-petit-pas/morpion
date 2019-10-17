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
 ╚════╝  ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝     ╚═╝".pink

      @joueur_1 = Player.new

      puts"
     ██╗ ██████╗ ██╗   ██╗███████╗██╗   ██╗██████╗     ██████╗
     ██║██╔═══██╗██║   ██║██╔════╝██║   ██║██╔══██╗    ╚════██╗
     ██║██║   ██║██║   ██║█████╗  ██║   ██║██████╔╝     █████╔╝
██   ██║██║   ██║██║   ██║██╔══╝  ██║   ██║██╔══██╗    ██╔═══╝
╚█████╔╝╚██████╔╝╚██████╔╝███████╗╚██████╔╝██║  ██║    ███████╗
 ╚════╝  ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝    ╚══════╝".light_blue

      if @joueur_1.valeur == "X" #si le joueur1 choisi X alors on assigne automatiquement "O" au joueur2
        @joueur_2 = Player.new(nil, "O")
      else
        @joueur_2 = Player.new(nil, "X")
      end

      @board = Board.new #on affiche le plateau

    end

    # On lance la partie
    def go
      puts "Notre soldat #{@joueur_1.nom} va jouer en premier" #on indique quel joueur joue en premier
      sleep 1 #permet d'avoir un petit temps d'attente de 1sec
      turn # On fait appel à la def turn ci-dessous
    end

    #On affiche les cases du plateau numérotées
    def turn
      tab = [["1", "2", "3"],["4", "5", "6"],["7", "8", "9"] ]
      puts "Les cases sont numérotées de la manière suivante : "
      tab.each do |x|
        puts "\t\t\t --- --- ---"
        puts "\t\t\t| "+x[0].to_s+" | "+x[1]+" | "+x[2]+" |"
        end
      puts "\t\t\t --- --- ---"
      sleep 1

      boucle = true
      var_intermediaire = 0
      nbr_tour = 1

      while boucle
        sleep 1
        if nbr_tour % 2 == 0 #Si le tour actuel est pair alors c'est le joueur 1 qui joue, sinon c'est le joueur 2
          puts "Soldat #{@joueur_2.nom}, où souhaitez-vous vous placer ? (choisir une case entre 1 et 9)"
        else
          puts "Soldat #{@joueur_1.nom}, où souhaitez-vous vous placer ? (choisir une case entre 1 et 9)"
        end

        #On place dans var_intermediaire le numéro de la case dans laquelle le joueur veut placer sa valeur
        var_intermediaire = gets.chomp
        var_intermediaire = var_intermediaire.to_i

        # On indique que le numéro de la case choisie doit être compris entre 1 et 9, sinon on retourne un message d'erreur ainsi qu'un gets.chomp pour que le joueur retente sa chance
        while (var_intermediaire < 1) || (9 < var_intermediaire)
          puts "Erreur ! Case invalide, réessayez."
          var_intermediaire = gets.chomp
          var_intermediaire = var_intermediaire.to_i
        end

        #On place la valeur du joueur dans la case choisie
        if nbr_tour % 2 == 0
          playing = @board.play(@joueur_2.valeur, var_intermediaire)
        else
          playing = @board.play(@joueur_1.valeur, var_intermediaire)
        end
        #On vérifie que la case choisie est bien vide, sinon ça retourne un message d'erreur présent dans le fichier board.rb
        while playing == false
          var_intermediaire = gets.chomp
          var_intermediaire = var_intermediaire.to_i
          if nbr_tour % 2 == 0
            playing = @board.play(@joueur_2.valeur, var_intermediaire)
          else
            playing = @board.play(@joueur_1.valeur, var_intermediaire)
          end
        end

        sleep 1
        @board.to_s #On ré-affiche le plateau

        # Ici, on vérifie si l'un des deux joueurs à gagné
        if @board.victory? == true
          if nbr_tour % 2 == 0
            puts "#{@joueur_2.nom} sort de ce combat victorieux ! Bravo !"
          else
            puts "#{@joueur_1.nom} sort de ce combat victorieux ! Bravo !"
          end
        end
        #On arrête la boucle en cas de victoire
        break if @board.victory? == true
        #Si ce n'est pas le cas, on incrémente le nombre de tour
        nbr_tour += 1
        #On recommence le jeu si le nombre de tour dépasse 9 et si aucun joueur n'a gagné
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

  class String #Classe permettant de changer la couleur de string
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end
