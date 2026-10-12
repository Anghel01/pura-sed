# Pura Sed - Sistema de Gestión de Bar

### ITID803: Diseño de Aplicaciones y Servicios para Internet (DASI)
**Carrera de Tecnologías de la Información**  
**Facultad de Ingeniería Eléctrica y Electrónica (FIEE)**  
**Escuela Politécnica Nacional**

---

## 📌 Descripción del Proyecto

Este repositorio contiene el desarrollo del sistema de gestión para el bar **"Pura Sed"**, implementado como proyecto formativo para la asignatura *Diseño de Aplicaciones y Servicios para Internet*.

El sistema se diseña bajo una arquitectura desacoplada moderna:
- **Backend:** ASP.NET Core Web API (.NET 8/9) para la lógica de negocio, persistencia y servicios RESTful documentados con Swagger.
- **Frontend:** Blazor WebAssembly para una interfaz interactiva de cliente enriquecida que se ejecuta directamente en el navegador mediante WebAssembly.
- **Metodología:** Ágil bajo el marco de trabajo **Scrum**, con ciclos de entrega semanales (Sprints) a lo largo de 16 semanas.

---

## 🎯 Objetivos del Sistema

Diseñar e implementar una solución web integral y responsiva que permita:
- **Catálogo y Menú:** Consultar menú interactivo clasificado por categorías (bebidas, comidas, combos y espectáculos) con soporte de variantes y promociones temporales.
- **Gestión de Pedidos:** Registro ágil por mesa (desde tablets/móviles), con enrutamiento automático de órdenes a las pantallas de Cocina y Bar.
- **Control de Inventario:** Descuento automático de existencias por consumo y señalización visual de productos agotados.
- **Reservas y Acceso:** Sistema de reservas en línea vinculado a códigos de acceso por mesa.
- **Cierre y Pagos:** Gestión de cuentas por mesa con múltiples métodos de pago (pasarela para tarjetas, validación de transferencias y cobro en efectivo) y emisión de comprobantes digitales.
- **Satisfacción y Analítica:** Encuesta post-consumo (atención y servicio general) y panel de reportes estadísticos por jornada para la administración.

---

## 🛠️ Tecnologías Utilizadas

| Categoría | Tecnología / Herramienta |
| :--- | :--- |
| **Plataforma base** | .NET SDK (8.0 / 9.0) |
| **Backend** | ASP.NET Core Web API & Entity Framework Core |
| **Frontend** | Blazor WebAssembly (C# en el cliente) |
| **Base de Datos** | Microsoft SQL Server |
| **Documentación API** | OpenAPI / Swagger |
| **Pruebas de Servicios** | Postman |
| **Control de Versiones** | Git & GitHub (Estrategia de ramas `main` / `develop`) |
| **Gestión Ágil** | Jira Software |
| **Entorno de Desarrollo** | Visual Studio Code / Visual Studio |

---

## 👥 Equipo Scrum

| Nombre | Rol Scrum | Responsabilidad |
| :--- | :--- | :--- |
| **Jose Naranjo** | **Product Owner** | Definición de requisitos, priorización del backlog y aceptación de entregables |
| **Jannys Garrido** | **Scrum Master / Dev** | Facilitación ágil, remoción de impedimentos y desarrollo frontend/backend |
| **Angel Chicaiza** | **Development Member** | Desarrollo de servicios, arquitectura y base de datos |
| **Angelo Conteron** | **Development Member** | Desarrollo de interfaces Blazor, integración de API y control de versiones |

---

## 📋 Backlog del Producto y Gestión Ágil

La planificación de historias de usuario, asignación de tareas y seguimiento del flujo de trabajo por Sprint se administra de forma activa en Jira Software:

🔗 **[Tablero Scrum en Jira - Proyecto Pura Sed](https://jannysgarrido21.atlassian.net/jira/software/projects/SCRUM/boards/1?filter=&groupBy=none)**

---

## 🚀 Cómo Ejecutar el Proyecto

### 1. Clonar el repositorio
```bash
git clone https://github.com/Anghel01/pura-sed.git
cd pura-sed
```

### 2. Cambiar a la rama de desarrollo
```bash
git checkout develop
```

### 3. Ejecutar el Backend (Web API)
```bash
cd BarAPI
dotnet run
```
> La API y la documentación interactiva de Swagger estarán disponibles en el puerto asignado (por ejemplo, `https://localhost:7001/swagger`).

### 4. Ejecutar el Frontend (Blazor WebAssembly)
En una nueva terminal:
```bash
cd BarCliente
dotnet run
```
> La interfaz de usuario cargará en el navegador (por ejemplo, `https://localhost:7100`).

---

## 📂 Estructura Planificada de la Solución

```text
pura-sed/
├── BarPuraSed.sln            # Archivo contenedor de la solución .NET
├── README.md                 # Documentación general del proyecto
├── .gitignore                # Reglas de exclusión para Git (.NET)
│
├── BarAPI/                   # [BACKEND] ASP.NET Core Web API
│   ├── Controllers/          # Controladores REST (ej. CombosController)
│   ├── Data/                 # Modelos de entidad y DbContext (EF Core)
│   ├── Migrations/           # Migraciones de base de datos SQL Server
│   ├── Program.cs            # Configuración de servicios, CORS y Middleware
│   └── BarAPI.csproj         # Definición del proyecto API
│
└── BarCliente/               # [FRONTEND] Blazor WebAssembly App
    ├── Pages/                # Vistas y componentes Razor
    ├── Shared/               # Componentes reutilizables y layouts
    ├── wwwroot/              # Recursos estáticos (CSS, íconos, imágenes)
    ├── Program.cs            # Inyección de dependencias y configuración HttpClient
    └── BarCliente.csproj     # Definición del proyecto Blazor
```

---

## 📅 Avance por Sprints

| Sprint / Semana | Entregable / Alcance | Estado |
| :---: | :--- | :---: |
| **Sprint 1 (Sem. 1)** | Configuración de entorno, definición de alcance, solución .NET, API combos y enlace inicial Blazor | **En progreso** |
| **Sprint 2 (Sem. 2)** | Diseño general del sistema y arquitectura de datos | Planificado |
| **Sprint 3 (Sem. 3)** | Registro y catálogo de gestión de productos y menú | Planificado |
| **Sprint 4 (Sem. 4)** | Módulo de pedidos y mesas | Planificado |

---

## 📌 Notas Adicionales
- Este proyecto se desarrolla con fines estrictamente académicos para la Escuela Politécnica Nacional.
- El ciclo de desarrollo es incremental, aplicando integración continua a través de la rama `develop`.
- Para reportar errores, impedimentos o mejoras técnicas, utilizar la sección de **Issues** o el tablero de **Jira**.