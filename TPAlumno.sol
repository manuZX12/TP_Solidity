// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
 
contract Alumnado {
 
    string private Nombre;
    string private Apellido;
    string private Curso;
    address private Docente;
    mapping (string => uint8) private NotasMaterias;
    string[] private NombreMaterias;
 
    constructor(string memory nombre, string memory apellido, string memory curso)
    {
        Nombre = nombre;
        Apellido = apellido;
        Curso = curso;
        Docente = msg.sender;
    }
 
     function nombre_completo() public view returns (string memory)
    {
        return AppendString(Nombre, " ", Apellido);
    }

    function apellido() public view returns (string memory)
    {
        return Apellido;
    }

    function curso() public view returns (string memory)
    {
        return Curso;
    }

    function AppendString(string memory a, string memory b, string memory c) public pure returns (string memory)
    {
        return string(abi.encodePacked(a,b,c));
    }
 
    function set_nota_materia(uint8 nota, string memory materia) public
    {
        require(Docente == msg.sender, "Ingrese un address con permisos suficientes");
        require(nota <= 100 && nota >= 1, "Nota Invalida");
        NotasMaterias[materia] = nota;
        NombreMaterias.push(materia);
    }
 
    function nota_materia(string memory materia) public view returns (uint)
    {
        uint nota = NotasMaterias[materia];  
        return nota;
    }
   
    function aprobo(string memory materia) public view returns (bool)
    {
        require(NotasMaterias[materia >= 60], return true);
       
    }
 
    function promedio() public view returns (uint)
    {
 
        uint cantItems = NombreMaterias.length;
        uint notaParaPromedio;
        uint notaFinal;
 
        for (uint i = 0; i < cantItems; i++){
            notaParaPromedio += NotasMaterias[NombreMaterias[i]];
        }
 
        notaFinal = notaParaPromedio / cantItems;
        return notaFinal;
    }
}
