class BoardCase
    attr_accessor :valeur, :num_case

    # On créé les variables @valeur et @num_case
    def initialize(valeur, num_case)
      @valeur = valeur
      @num_case = num_case
    end

    # On change la @valeur en string
    def to_s
      @valeur.to_s
    end

  end
