public class Lasagna {

	public int expectedMinutesInOven(){
		return 40;
	}

	public int remainingMinutesInOven(int minutes){
		return (40 - minutes);
	}

	public int preparationTimeInMinutes(int layers){
		return (layers*2);
	}

	public int totalTimeInMinutes(int layers, int minutes){
		int prep_time = this.preparationTimeInMinutes(layers);
		return (prep_time + minutes);
	}
}
