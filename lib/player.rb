class Player
    attr_accessor :nom, :valeur

    def initialize(nom= nil, valeur= nil)
      #S'il n'y a pas de nom de base, on demande au joueur de rentrer un nom
      if nom == nil
        puts "Quel est votre nom de guerre ?"
        nom = gets.chomp
      end
      @nom = nom
      #S'il n'y a pas de valeur de base, on demande au joueur de choisir entre la valeur X ou la valeur O
      if valeur == nil
        puts "Choisissez entre X ou O, avec quoi préfèrez-vous jouer ?"
        prise = gets.chomp
        while prise != "X" && prise != "O" #Si l'utilisateur choisi une autre valeur que X et O, on lui retourne un message d'erreur
        puts "Non non non ! Tu dois choisir entre X ou O"
        prise = gets.chomp
        end
        valeur = prise
      end
      @valeur = valeur

    end

  end
