package clasesPrincipales;

import java.util.ArrayList;

public class Gladiador {
	
	String apodo;
	String nombre;
	int nivel;
	int fuerza;
	int vida;
	int velocidad;
	double dinero;
	int categoria;
	Arma arma;
	Mascota mascota;
	ArrayList<Habilidad> habilidades;
	
	public Gladiador() {
		
	}
	
	public Gladiador(String apodo,String nombre,int nivel,int fuerza,int vida,int velocidad,double dinero,int categoria,Arma arma,Mascota mascota,ArrayList<Habilidad> habilidades) {
		this.apodo=apodo;
		this.nombre=nombre;
		this.nivel=nivel;
		this.fuerza=fuerza;
		this.vida=vida;
		this.velocidad=velocidad;
		this.dinero=dinero;
		this.categoria=categoria;
		this.arma=arma;
		this.mascota=mascota;
		this.habilidades=habilidades;
	}

	public String getApodo() {
		return apodo;
	}

	public String getNombre() {
		return nombre;
	}

	public int getNivel() {
		return nivel;
	}

	public int getFuerza() {
		return fuerza;
	}

	public int getVida() {
		return vida;
	}

	public int getVelocidad() {
		return velocidad;
	}

	public double getDinero() {
		return dinero;
	}

	public int getCategoria() {
		return categoria;
	}

	public Arma getArma() {
		return arma;
	}

	public Mascota getMascota() {
		return mascota;
	}

	public ArrayList<Habilidad> getHabilidades() {
		return habilidades;
	}
	
	
	

}
