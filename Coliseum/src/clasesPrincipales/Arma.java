package clasesPrincipales;

import enumerados.Tipo;

public class Arma {
	
	int ID;
	String nombre;
	int danio;
	Tipo tipo;
	int categoria;
	
	public Arma() {
		
	}
	
	public Arma(int ID,String nombre,int danio,Tipo tipo,int categoria) {
		this.ID=ID;
		this.nombre=nombre;
		this.danio=danio;
		this.tipo=tipo;
		this.categoria=categoria;
	}

	public int getID() {
		return ID;
	}

	public String getNombre() {
		return nombre;
	}

	public int getDanio() {
		return danio;
	}

	public Tipo getTipo() {
		return tipo;
	}

	public int getCategoria() {
		return categoria;
	}
	
	

}
