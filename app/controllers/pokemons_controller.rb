class PokemonsController < ApplicationController
	def capture
		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer = current_trainer
		@pokemon.save
		redirect_to :back
    end

    def damage
        @pokemon = Pokemon.find(params[:id])
        @pokemon.health = @pokemon.health - 10
        if @pokemon.save
            redirect_to :back
        end
        if @pokemon.health <= 0
            @pokemon.destroy
        end
    end

    def new
        @pokemon = Pokemon.new
    end

    def create
        @pokemon = Pokemon.create(pokemon_params)
        @id = current_trainer.id
        @pokemon.health = 100
        @pokemon.level = 1
        @pokemon.trainer = current_trainer
        if @pokemon.save 
            redirect_to "/trainers/" + @id.to_s
        else 
            flash[:error] = @pokemon.errors.full_messages.to_sentence
            redirect_to :back
        end  
    end

    def pokemon_params
        params.require(:pokemon).permit(:name)
    end
end