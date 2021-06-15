package clasesPrincipales;

public class Mascota {
	
	int ID;
	String especie;
	int danio;
	int categoria;
	
	public Mascota() {
		
	}
	
	public Mascota(int ID,String especie,int danio,int categoria) {
		this.ID=ID;
		this.especie=especie;
		this.danio=danio;
		this.categoria=categoria;
	}

	public int getID() {
		return ID;
	}

	public String getEspecie() {
		return especie;
	}

	public int getDanio() {
		return danio;
	}

	public int getCategoria() {
		return categoria;
	}
	
	

}
