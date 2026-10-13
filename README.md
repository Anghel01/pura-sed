<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0d1117,35:1a0b2e,70:4b1248,100:ff0055&height=220&section=header&text=PURA%20SED&fontSize=62&fontColor=ffffff&fontAlignY=38&desc=Sistema%20Integral%20de%20Gestión%20de%20Bar%20%26%20Restaurante&descSize=20&descColor=ff77aa&descAlignY=58&animation=fadeIn" width="100%"/>
</p>

<p align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=600&size=18&pause=1000&color=FF2A85&center=true&vCenter=true&width=650&height=35&lines=🍹+Gestión+de+Mesas+y+Comandas+en+Tiempo+Real;⚡+Despacho+Automático+a+Cocina+y+Bar;📱+Menú+Interactivo+con+Blazor+WebAssembly;🔒+Servicios+RESTful+con+ASP.NET+Core+Web+API;📊+Analítica+de+Ventas+y+Cierre+por+Jornada" alt="Typing SVG" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/.NET_10_%7C_9-512BD4?style=for-the-badge&logo=dotnet&logoColor=white" />
  <img src="https://img.shields.io/badge/Blazor_WASM-512BD4?style=for-the-badge&logo=blazor&logoColor=white" />
  <img src="https://img.shields.io/badge/ASP.NET_Core_Web_API-512BD4?style=for-the-badge&logo=csharp&logoColor=white" />
  <img src="https://img.shields.io/badge/SQL_Server-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" />
  <img src="https://img.shields.io/badge/Jira_Scrum-0052CC?style=for-the-badge&logo=jira&logoColor=white" />
</p>

<p align="center">
  <b>Escuela Politécnica Nacional (EPN)</b> • Facultad de Ingeniería Eléctrica y Electrónica (FIEE)<br/>
  <i>ITID803: Diseño de Aplicaciones y Servicios para Internet (DASI) • Semestre 2026</i>
</p>

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=rect&color=0:ff0055,50:7928ca,100:00d9ff&height=3&section=header" width="100%"/>
</p>

## 📌 1. Sobre el Proyecto

**Pura Sed** es una solución web empresarial y responsiva diseñada para digitalizar de extremo a extremo las operaciones de un bar y restaurante nocturno. El proyecto reemplaza el flujo tradicional basado en papelitos y comandas físicas por una **arquitectura desacoplada en la nube**, reduciendo tiempos de espera, optimizando inventarios y enriqueciendo la experiencia del cliente.

<table>
<tr>
<td width="50%">

### ⚠️ Problemática Detectada
* **Comandas manuales en papel:** Desplazamientos innecesarios de meseros que enfrían comida y retrasan tragos.
* **Menú físico estático:** Imposibilidad de actualizar precios o marcar ítems agotados al instante.
* **Fuga de insumos:** Cocina y barra sin control sincronizado de stock mínimo.
* **Cuentas y cobro manual:** División de cuentas lenta y validación de transferencias desordenada.

</td>
<td width="50%">

### 💡 Solución Implementada
* **Atención por Mesa con QR:** Acceso instantáneo al menú interactivo sin fricción ni registro obligado.
* **Enrutamiento Inteligente:** La orden divide automáticamente tragos a la Barra y platos a la Cocina.
* **Inventario Descentralizado:** Descuento automático de existencias y bloqueo visual de agotados.
* **Pagos Transparentes:** Tarjeta, transferencia y efectivo con emisión de comprobante secuencial.

</td>
</tr>
</table>

---

## 🏛️ 2. Arquitectura del Sistema

El sistema implementa un modelo **Cliente-Servidor desacoplado** utilizando **Blazor WebAssembly** en el frontend y **ASP.NET Core Web API** en el backend.

```mermaid
flowchart TD
    subgraph CLIENTE [" 📱 Dispositivos Cliente "]
        MESA["📲 Tablet / Celular Mesa\n(Cliente QR)"]
        MESERO["📱 Celular Mesero\n(Toma de pedidos)"]
        BARRA["🖥️ Pantalla Barra\n(Despacho bebidas)"]
        COCINA["🖥️ Pantalla Cocina\n(Despacho comida)"]
        ADMIN["💻 PC Administración\n(Caja y Reportes)"]
    end

    subgraph FRONTEND [" ⚡ Frontend (Blazor WebAssembly) "]
        UI["PuraSed.Client\n(C# compilado a WASM en navegador)"]
    end

    subgraph BACKEND [" 🔒 Backend (ASP.NET Core Web API) "]
        API["PuraSed.WebApi\n(Controladores REST + Swagger OpenAPI)"]
        AUTH["Seguridad & Roles\n(Cifrado de claves)"]
        BIZ["Lógica de Negocio\n(Enrutamiento & Stock)"]
    end

    subgraph PERSISTENCIA [" 🗄️ Base de Datos "]
        DB[("Microsoft SQL Server\n(Transacciones ACID & Bitácora)")]
    end

    CLIENTE -->|Interacción Usuario| UI
    UI -->|HTTPS / JSON REST / CORS| API
    API --> AUTH
    API --> BIZ
    BIZ -->|Entity Framework Core| DB

    style CLIENTE fill:#0d1117,stroke:#ff0055,stroke-width:2px,color:#fff
    style FRONTEND fill:#1a0b2e,stroke:#7928ca,stroke-width:2px,color:#fff
    style BACKEND fill:#0a192f,stroke:#00d9ff,stroke-width:2px,color:#fff
    style PERSISTENCIA fill:#1c1917,stroke:#f59e0b,stroke-width:2px,color:#fff
```

---

## 💻 3. Tecnologías Utilizadas

<p align="center">
  <img src="https://skillicons.dev/icons?i=dotnet,cs,html,css,bootstrap,postman,git,github,vscode" />
</p>

| Área | Tecnología | Propósito |
| :--- | :--- | :--- |
| **Plataforma** | `.NET SDK 10.0 / 9.0` | Ecosistema y motor de compilación unificado |
| **Frontend** | `Blazor WebAssembly` | Interfaz interactiva SPA ejecutada con C# nativo en el cliente |
| **Backend** | `ASP.NET Core Web API` | Microservicios RESTful, inyección de dependencias y CORS |
| **Documentación** | `Swagger / OpenAPI` | Especificación y catálogo interactivo de endpoints |
| **Base de Datos** | `Microsoft SQL Server` | Motor relacional con integridad referencial |
| **ORM** | `Entity Framework Core` | Mapeo objeto-relacional y migraciones de esquema |
| **Pruebas** | `Postman` | Verificación de contratos y respuestas HTTP de la API |
| **Control de Versiones**| `Git & GitHub` | Control de ramas (`main` / `develop`) y flujo colaborativo |
| **Gestión Ágil** | `Jira Software` | Tablero Scrum, épicas, historias y seguimiento de sprints |

---

## 👥 4. Equipo de Trabajo (Scrum Team)

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

## 📋 5. Backlog del Producto y Gestión Ágil

El desarrollo del proyecto se gestiona bajo ciclos de entrega continuos (Sprints semanales). El detalle completo de las **Historias de Usuario (HU-01 a HU-32)**, tareas técnicas y criterios de aceptación se gestionan en tiempo real en nuestro tablero:

<p align="center">
  <a href="https://jannysgarrido21.atlassian.net/jira/software/projects/SCRUM/boards/1?filter=&groupBy=none">
    <img src="https://img.shields.io/badge/Jira_Software-Acceder_al_Tablero_Scrum_Oficial-0052CC?style=for-the-badge&logo=jira&logoColor=white" height="42px"/>
  </a>
</p>

---

## 📂 6. Estructura de la Solución .NET

```text
pura-sed/
├── PuraSed.slnx              # 📦 Solución contenedora (.NET 9/10 XML format)
├── README.md                 # 📄 Documentación visual del proyecto
├── .gitignore                # 🛡️ Reglas de exclusión para Git (.NET)
│
├── PuraSed.WebApi/           # ⚙️ [BACKEND] ASP.NET Core Web API
│   ├── Controllers/          # Controladores REST (ej. CombosController)
│   ├── Properties/           # Perfiles de ejecución (launchSettings.json)
│   ├── appsettings.json      # Configuración y variables del servidor
│   ├── Program.cs            # Punto de entrada, Middleware, Swagger y CORS
│   └── PuraSed.WebApi.csproj # Cédula del proyecto Backend y paquetes NuGet
│
└── PuraSed.Client/           # 🎨 [FRONTEND] Blazor WebAssembly
    ├── Layout/               # Estructuras visuales (MainLayout, NavMenu)
    ├── Pages/                # Vistas Razor (Home, Counter, Menu, Pedidos)
    ├── wwwroot/              # Archivos estáticos (Bootstrap, CSS, íconos)
    ├── Program.cs            # Inicializador de Blazor WASM y HttpClient
    └── PuraSed.Client.csproj # Cédula del proyecto Frontend
```

---

## 🚀 7. Guía de Ejecución Local

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
# -> Swagger disponible en: https://localhost:7001/swagger

# 5. En otra terminal, iniciar el Frontend (Blazor WASM)
cd PuraSed.Client
dotnet run
# -> Aplicación cargando en: https://localhost:7100
```

---

## 📅 8. Cronograma y Avance por Sprints

| Sprint / Semana | Entregable / Alcance | Estado |
| :---: | :--- | :---: |
| **Sprint 1 (Sem. 1)** | Configuración de entorno, estructura .NET (`PuraSed.slnx`), Web API + Blazor y CORS | 🟢 **Terminado** |
| **Sprint 2 (Sem. 2)** | Modelado relacional en SQL Server, DbContext y migraciones EF Core | 🟡 En progreso |
| **Sprint 3 (Sem. 3)** | Catálogo interactivo de productos, combos y variantes | ⚪ Planificado |
| **Sprint 4 (Sem. 4)** | Módulo de pedidos por mesa y despacho automático a cocina/bar | ⚪ Planificado |
| **Sprint 5-16** | Reservas QR, pasarela de pago, facturación, encuestas y analítica | ⚪ Planificado |

---

## 📄 9. Licencia y Uso Académico

Este proyecto ha sido desarrollado exclusivamente con fines académicos como parte de la formación profesional en Ingeniería de Tecnologías de la Información en la **Escuela Politécnica Nacional**. Todos los derechos reservados al equipo de desarrollo y docentes tutores.

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:ff0055,50:4b1248,100:0d1117&height=120&section=footer" width="100%"/>
</p>