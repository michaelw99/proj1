class PokemonsController < ApplicationController
	def capture
		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer = current_trainer
		@pokemon.save
		redirect_to 'home#index'
    end

    def damage
        @pokemon = Pokemon.find(params[:id])
        @pokemon.health = @pokemon.health - 10
        if @pokemon.health <= 0
            @pokemon.destroy
        end
        if @pokemon.save
            redirect_to 'trainers#id'
        end
    end

    def new
        @pokemon = Pokemon.new
    end

    def create
        @pokemon = Pokemon.create(pokemon_params)
        @pokemon.health = 100
        @pokemon.level = 1
        @pokemon.trainer = current_trainer
        if @pokemon.save 
            redirect_to 'trainers#id'
        else 
            flash[:error] = @pokemon.errors.full_messages.to_sentence
            redirect_to 'home#index'
        end  
    end

    def pokemon_params
        params.require(:pokemon).permit(:name)
    end
end