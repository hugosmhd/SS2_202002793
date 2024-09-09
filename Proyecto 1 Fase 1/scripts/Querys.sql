
-- CREACION DE TABLA TEMPORAL
CREATE TABLE temporal (
    FechaComp DATE,
    CodProveedor NVARCHAR(50),
    NombreProveedor NVARCHAR(255),
    DireccionProveedor NVARCHAR(max),
    NumeroProveedor NVARCHAR(50),
    WebProveedor NVARCHAR(255),
    CodProducto NVARCHAR(50),
    NombreProducto NVARCHAR(255),
    MarcaProducto NVARCHAR(100),
    Categoria NVARCHAR(100),
    SodSuSursal NVARCHAR(50),
    NombreSucursal NVARCHAR(255),
    DireccionSucursal NVARCHAR(max),
    Region NVARCHAR(100),
    Departamento NVARCHAR(100),
    Unidades INT,
    CostoU DECIMAL(18, 2),
    FechaVenta DATE,
    CodigoCliente NVARCHAR(50),
    NombreCliente NVARCHAR(255),
    TipoCliente NVARCHAR(50),
    DireccionCliente NVARCHAR(max),
    NumeroCliente NVARCHAR(50),
    CodVendedor NVARCHAR(50),
    NombreVendedor NVARCHAR(255),
    Vacacionista NVARCHAR(100),
    PrecioUnitario DECIMAL(18, 2)
);


-- DATA WAREHOUSE

CREATE TABLE Compra (
    CompraID INT IDENTITY(1,1) PRIMARY KEY,  
    Fecha DATE NOT NULL,                      
    CodProveedor NVARCHAR(50),                
    CodProducto NVARCHAR(50),                 
    SodSuSursal NVARCHAR(50),                 
    Unidades INT,  
    CostoU DECIMAL(10, 2) 

    CONSTRAINT FK_Compra_Proveedor FOREIGN KEY (CodProveedor) REFERENCES DimProveedor(CodProveedor) ON DELETE CASCADE,
    CONSTRAINT FK_Compra_Producto FOREIGN KEY (CodProducto) REFERENCES DimProducto(CodProducto) ON DELETE CASCADE,
    CONSTRAINT FK_Compra_Sucursal FOREIGN KEY (SodSuSursal) REFERENCES DimSucursal(SodSuSursal) ON DELETE CASCADE
);

CREATE TABLE Venta (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,  
    Fecha DATE NOT NULL,                      
    CodigoCliente NVARCHAR(50),                
    CodVendedor NVARCHAR(50),                
    CodProducto NVARCHAR(50),                 
    SodSuSursal NVARCHAR(50),                 
    Unidades INT,  
    PrecioUnitario DECIMAL(10, 2) 
	 
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (CodigoCliente) REFERENCES DimCliente(CodigoCliente) ON DELETE CASCADE,
    CONSTRAINT FK_Venta_Vendedor FOREIGN KEY (CodVendedor) REFERENCES DimVendedor(CodVendedor) ON DELETE CASCADE,
    CONSTRAINT FK_Venta_Producto FOREIGN KEY (CodProducto) REFERENCES DimProducto(CodProducto) ON DELETE CASCADE,
    CONSTRAINT FK_Venta_Sucursal FOREIGN KEY (SodSuSursal) REFERENCES DimSucursal(SodSuSursal) ON DELETE CASCADE
);


// DIMENSIONES COMPRAS 

CREATE TABLE DimProveedor (
    CodProveedor NVARCHAR(50) PRIMARY KEY,
    NombreProveedor NVARCHAR(255),
    DireccionProveedor NVARCHAR(max),
    NumeroProveedor NVARCHAR(50),
    WebProveedor NVARCHAR(255)
);

CREATE TABLE DimProducto (
    CodProducto NVARCHAR(50) PRIMARY KEY,        
    NombreProducto NVARCHAR(255) NOT NULL,
    MarcaProducto NVARCHAR(100) NOT NULL, 
    Categoria NVARCHAR(100) NOT NULL     
);

CREATE TABLE DimSucursal (
    SodSuSursal NVARCHAR(50) PRIMARY KEY,        
    NombreSucursal NVARCHAR(255), 
    DireccionSucursal NVARCHAR(max),
    Region NVARCHAR(100),         
    Departamento NVARCHAR(100)    
);

// DIMENSIONES VENTAS

CREATE TABLE DimCliente (
    CodigoCliente NVARCHAR(50) PRIMARY KEY,
    NombreCliente NVARCHAR(255),
    TipoCliente NVARCHAR(50),
    DireccionCliente NVARCHAR(max),
    NumeroCliente NVARCHAR(50)
);

CREATE TABLE DimVendedor (
    CodVendedor NVARCHAR(50) PRIMARY KEY,
    NombreVendedor NVARCHAR(255),
    Vacacionista NVARCHAR(50)
);

-- CONSULTA COUNT
SELECT 
  (SELECT COUNT(*) FROM Compra) AS TotalCompra,
  (SELECT COUNT(*) FROM Venta) AS TotalVenta,
  (SELECT COUNT(*) FROM DimProducto) AS TotalDimProducto,
  (SELECT COUNT(*) FROM DimCliente) AS TotalDimCliente,
  (SELECT COUNT(*) FROM DimProveedor) AS TotalDimProveedor,
  (SELECT COUNT(*) FROM DimSucursal) AS TotalDimSucursal,
  (SELECT COUNT(*) FROM DimVendedor) AS TotalDimVendedor;