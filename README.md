<p align="center">
  <img src="./assets/banner.svg" width="100%" alt="Pura Sed - Bar & Restaurant Platform" />
</p>

<p align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=600&size=18&pause=1000&color=FF2A85&center=true&vCenter=true&width=650&height=35&lines=Gestion+de+Mesas+y+Comandas+en+Tiempo+Real;Despacho+Automatico+a+Cocina+y+Bar;Menu+Interactivo+con+Blazor+WebAssembly;Servicios+RESTful+con+ASP.NET+Core+Web+API;Analitica+de+Ventas+y+Cierre+por+Jornada" alt="Typing SVG" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/.NET-10.0%20%7C%209.0-512BD4?style=for-the-badge&logo=dotnet&logoColor=white" />
  <img src="https://img.shields.io/badge/Frontend-Blazor%20WASM-7928CA?style=for-the-badge&logo=blazor&logoColor=white" />
  <img src="https://img.shields.io/badge/Backend-ASP.NET%20Web%20API-00B4D8?style=for-the-badge&logo=dotnet&logoColor=white" />
  <img src="https://img.shields.io/badge/Database-SQL%20Server-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" />
  <img src="https://img.shields.io/badge/Gestion-Jira%20Software-0052CC?style=for-the-badge&logo=jira&logoColor=white" />
</p>

<p align="center">
  <b>Escuela Politécnica Nacional (EPN)</b> • Facultad de Ingeniería Eléctrica y Electrónica (FIEE)<br/>
  <i>ITID803: Diseño de Aplicaciones y Servicios para Internet (DASI) • Semestre 2026</i>
</p>

---

## 📌 1. Sobre el Proyecto

**Pura Sed** es una plataforma web moderna y responsiva orientada a la gestión integral de un bar nocturno. Digitaliza el ciclo completo de consumo: desde la consulta del menú y la comanda por mesa, hasta el despacho automático y el cierre de caja.

<table>
<tr>
<td width="50%">

### ⚠️ Problemática Actual (Gestión Manual)
* **Comandas en papel:** Pérdida de tiempo desplazándose a barra y cocina, provocando demoras y confusiones.
* **Menú físico o estático:** No refleja productos agotados en tiempo real ni promociones por horario.
* **Descontrol de existencias:** Barra y cocina no sincronizan mermas ni alertas de stock mínimo.
* **Cobro manual:** Dificultad para liquidar cuentas divididas y validar transferencias bancarias.

</td>
<td width="50%">

### 💡 Solución Implementada
* **Atención por Mesa con QR:** Clientes acceden al catálogo interactivo desde su móvil sin registros obligatorios.
* **Enrutamiento Automatizado:** Los tragos van a la barra y los platos a la cocina de forma inmediata.
* **Inventario Descentralizado:** Stock por áreas con descuento automático por pedido y bloqueo visual de agotados.
* **Pagos Flexibles:** Soporte para tarjeta (pasarela), transferencia y efectivo con facturación secuencial.

</td>
</tr>
</table>

---

## 💻 2. Tecnologías Utilizadas

<p align="center">
  <img src="https://skillicons.dev/icons?i=dotnet,cs,html,css,bootstrap,postman,git,github,vscode" />
</p>

| Área | Tecnología | Propósito en el Proyecto |
| :--- | :--- | :--- |
| **Plataforma Base** | `.NET SDK 10.0 / 9.0` | Ecosistema y motor de compilación unificado |
| **Frontend** | `Blazor WebAssembly` | Aplicación SPA ejecutada con C# nativo en el navegador del cliente |
| **Backend** | `ASP.NET Core Web API` | Microservicios RESTful desacoplados, middleware y políticas CORS |
| **Documentación** | `Swagger / OpenAPI` | Catálogo interactivo y contrato de endpoints para pruebas |
| **Base de Datos** | `Microsoft SQL Server` | Motor relacional transaccional para pedidos, inventario y auditoría |
| **ORM** | `Entity Framework Core` | Mapeo objeto-relacional y control de migraciones de base de datos |
| **Pruebas de API** | `Postman` | Verificación de respuestas JSON y códigos de estado HTTP |
| **Control de Versiones**| `Git & GitHub` | Estrategia de ramas `main` / `develop` y flujo colaborativo con Forks |
| **Gestión Ágil** | `Jira Software` | Tablero Scrum, backlog de historias de usuario y control de sprints |

---

## 👥 3. Equipo de Trabajo (Scrum Team)

<table align="center" width="100%">
  <tr>
    <td align="center" width="25%">
      <img src="https://ui-avatars.com/api/?name=Jose+Naranjo&background=ff0055&color=fff&size=96&rounded=true" width="80px"/><br/>
      <b>Jose Naranjo</b><br/>
      <code>Product Owner</code><br/>
      <sub>Definición de requerimientos y aceptación de entregables</sub>
    </td>
    <td align="center" width="25%">
      <img src="https://ui-avatars.com/api/?name=Jannys+Garrido&background=7928ca&color=fff&size=96&rounded=true" width="80px"/><br/>
      <b>Jannys Garrido</b><br/>
      <code>Scrum Master / Dev</code><br/>
      <sub>Facilitación ágil, remoción de impedimentos y desarrollo</sub>
    </td>
    <td align="center" width="25%">
      <img src="https://ui-avatars.com/api/?name=Angel+Chicaiza&background=00d9ff&color=000&size=96&rounded=true" width="80px"/><br/>
      <b>Angel Chicaiza</b><br/>
      <code>Development Member</code><br/>
      <sub>Arquitectura de datos, lógica de backend y base de datos</sub>
    </td>
    <td align="center" width="25%">
      <img src="https://ui-avatars.com/api/?name=Angelo+Conteron&background=00ff88&color=000&size=96&rounded=true" width="80px"/><br/>
      <b>Angelo Conteron</b><br/>
      <code>Development Member</code><br/>
      <sub>Interfaces Blazor WASM, UX/UI y control de versiones Git</sub>
    </td>
  </tr>
</table>

---

## 📋 4. Backlog del Producto y Gestión Ágil

El desarrollo del proyecto se planifica y ejecuta mediante **Sprints semanales** bajo el marco Scrum. Las **32 Historias de Usuario (HU-01 a HU-32)**, sus criterios de aceptación y el flujo de tareas se administran activamente en el tablero oficial:

<p align="center">
  <a href="https://jannysgarrido21.atlassian.net/jira/software/projects/SCRUM/boards/1?filter=&groupBy=none">
    <img src="https://img.shields.io/badge/Jira_Software-Acceder_al_Tablero_Scrum_Oficial-0052CC?style=for-the-badge&logo=jira&logoColor=white" height="42px"/>
  </a>
</p>

---

## 📂 5. Estructura de la Solución .NET

```text
pura-sed/
├── PuraSed.slnx              # 📦 Solución contenedora (.NET XML format)
├── README.md                 # 📄 Documentación visual del proyecto
├── .gitignore                # 🛡️ Reglas de exclusión para Git (.NET)
│
├── assets/                   # 🎨 Recursos vectoriales del repositorio
│   ├── banner.svg            # Banner principal de Pura Sed
│   └── architecture.svg      # Diagrama de arquitectura panorámico
│
├── PuraSed.WebApi/           # ⚙️ [BACKEND] ASP.NET Core Web API
│   ├── Controllers/          # Controladores REST (ej. CombosController)
│   ├── Properties/           # Perfiles de ejecución (launchSettings.json)
│   ├── appsettings.json      # Configuración y variables del servidor
│   ├── Program.cs            # Inyección de dependencias, Middleware y CORS
│   └── PuraSed.WebApi.csproj # Cédula del proyecto Backend y paquetes NuGet
│
└── PuraSed.Client/           # 🎨 [FRONTEND] Blazor WebAssembly
    ├── Layout/               # Estructuras visuales (MainLayout, NavMenu)
    ├── Pages/                # Vistas Razor (Home, Counter, Weather, etc.)
    ├── wwwroot/              # Archivos estáticos (Bootstrap, CSS, íconos)
    ├── Program.cs            # Inicializador de Blazor WASM y HttpClient
    └── PuraSed.Client.csproj # Cédula del proyecto Frontend
```

---

## 🚀 6. Guía de Ejecución Local

### Prerrequisitos
* [.NET SDK 8, 9 o 10](https://dotnet.microsoft.com/download)
* [Visual Studio 2022+](https://visualstudio.microsoft.com/) o [Visual Studio Code](https://code.visualstudio.com/)
* [Git](https://git-scm.com/)

### Paso a paso

```bash
# 1. Clonar el repositorio
git clone https://github.com/Anghel01/pura-sed.git
cd pura-sed

# 2. Cambiar a la rama de desarrollo
git checkout develop

# 3. Restaurar dependencias de la solución
dotnet restore

# 4. Iniciar el Backend (Web API)
cd PuraSed.WebApi
dotnet run
# -> Swagger interactivo en: https://localhost:7001/swagger

# 5. En otra terminal, iniciar el Frontend (Blazor WASM)
cd PuraSed.Client
dotnet run
# -> Aplicación web cargando en: https://localhost:7100
```

---

## 🏛️ 7. Arquitectura del Sistema

El sistema implementa una **arquitectura desacoplada en 4 niveles** diseñada para alto rendimiento, responsividad en dispositivos táctiles e integridad transaccional:

<p align="center">
  <img src="./assets/architecture.svg" width="100%" alt="Diagrama de Arquitectura de Pura Sed" />
</p>

---

## 📄 8. Licencia y Uso Académico

Este proyecto ha sido desarrollado exclusivamente con fines académicos como parte de la formación profesional en Ingeniería de Tecnologías de la Información en la **Escuela Politécnica Nacional**. Todos los derechos reservados al equipo de desarrollo y docentes tutores.