# 🍹 Pura Sed - Sistema Integral de Gestión para Bares y Restaurantes

[![.NET Version](https://img.shields.io/badge/.NET-8.0%20%7C%209.0-purple.svg)](https://dotnet.microsoft.com/)
[![Frontend](https://img.shields.io/badge/Frontend-Blazor%20WebAssembly-blue.svg)](https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor)
[![Backend](https://img.shields.io/badge/Backend-ASP.NET%20Core%20Web%20API-green.svg)](https://dotnet.microsoft.com/apps/aspnet/apis)
[![Database](https://img.shields.io/badge/Database-SQL%20Server-red.svg)](https://www.microsoft.com/sql-server/)
[![Jira Board](https://img.shields.io/badge/Gestión-Jira%20Software-0052CC.svg)](https://jannysgarrido21.atlassian.net/jira/software/projects/SCRUM/boards/1?filter=&groupBy=none)

> **Asignatura:** ITID803 - Diseño de Aplicaciones y Servicios para Internet (DASI)  
> **Carrera:** Ingeniería en Tecnologías de la Información  
> **Facultad:** Facultad de Ingeniería Eléctrica y Electrónica (FIEE)  
> **Institución:** Escuela Politécnica Nacional (EPN)  
> **Período Académico:** 2026  

---

## 📖 1. Contexto y Definición del Negocio

**"Pura Sed"** es un establecimiento nocturno de alta demanda especializado en bebidas, alimentos, combos promocionales y espectáculos en vivo. 

### Problemática Actual (Gestión Manual Tradicional)
Actualmente el bar opera sin herramientas informáticas integradas:
* **Comandas manuales en papel:** Retrasos en traslados de meseros hacia cocina y barra, generando confusión en órdenes y demoras en atención.
* **Menú físico / QR estático (Canva):** No refleja en tiempo real productos agotados ni promociones por horario.
* **Fuga de información y stock desincronizado:** La barra y la cocina manejan insumos de forma aislada sin avisos de stock mínimo ni descuento automático de existencias.
* **Cobros y cuentas lentas:** Proceso manual para dividir cuentas, validar transferencias bancarias y emitir comprobantes.
* **Encuestas físicas de satisfacción:** Formatos en papel con baja tasa de respuesta y sin análisis estadístico inmediato.

### Solución Propuesta
Una plataforma web moderna, desacoplada y responsiva que digitaliza el ciclo completo de consumo:
1. **Atención por Mesa sin fricción:** Clientes acceden al catálogo interactivo desde su celular escaneando un código QR activado por reserva o asignación de mesa, sin requerir registros obligatorios.
2. **Despacho Digital Automatizado:** División inteligente del pedido; los tragos van instantáneamente a la pantalla del Bar y los platos a la pantalla de la Cocina.
3. **Control de Inventario por Áreas:** Administradores de Cocina y Bar gestionan sus propios insumos con descuento en tiempo real y bloqueo visual de ítems agotados.
4. **Múltiples Formas de Pago:** Pasarela web para cobro con tarjeta, verificación ágil de transferencias mediante comprobante digital y validación de efectivo en caja con facturación automática.
5. **Reportes por Jornada Nocturna:** Analítica de negocio que computa métricas considerando que el horario del bar cruza la medianoche (tarde hasta madrugada).

---

## 🏛️ 2. Arquitectura del Sistema

El sistema implementa una **Arquitectura Cliente-Servidor desacoplada**:

```
                       ┌──────────────────────────────────────────────┐
                       │            DISPOSITIVOS CLIENTE             │
                       │  Tablets Mesas / Celulares / PC Admin / Cocina │
                       └──────────────────────┬───────────────────────┘
                                              │
                                              │ HTTP / JSON (REST API)
                                              ▼
                       ┌──────────────────────────────────────────────┐
                       │          FRONTEND: BLAZOR WEBASSEMBLY        │
                       │       (Ejecución nativa C# en navegador)     │
                       └──────────────────────┬───────────────────────┘
                                              │
                                              │ CORS + HTTPS + JWT Tokens
                                              ▼
                       ┌──────────────────────────────────────────────┐
                       │        BACKEND: ASP.NET CORE WEB API         │
                       │     Controladores REST + Swagger OpenAPI     │
                       │         Lógica de Negocio & Seguridad        │
                       └──────────────────────┬───────────────────────┘
                                              │
                                              │ Entity Framework Core (ORM)
                                              ▼
                       ┌──────────────────────────────────────────────┐
                       │          BASE DE DATOS: SQL SERVER           │
                       │      Transacciones ACID + Historial/Logs     │
                       └──────────────────────────────────────────────┘
```

---

## 👥 3. Equipo de Trabajo y Metodología Scrum

El proyecto se gestiona bajo el marco de trabajo **Scrum**, con entregas incrementales semanales (Sprints) a lo largo de 16 semanas.

| Integrante | Rol Scrum | Responsabilidades Principales |
| :--- | :--- | :--- |
| **Jose Naranjo** | **Product Owner** | Definición y priorización del Product Backlog, criterios de negocio y validación de entregables. |
| **Jannys Garrido** | **Scrum Master / Dev** | Liderazgo ágil, gestión de ceremonias, remoción de impedimentos técnicos y desarrollo fullstack. |
| **Angel Chicaiza** | **Development Member** | Modelado de datos (SQL Server), lógica de backend (API), migraciones EF Core y servicios de despacho. |
| **Angelo Conteron** | **Development Member** | Desarrollo de interfaces de usuario en Blazor WASM, integración con servicios REST y control de versiones Git. |

### 📊 Tablero Oficial de Gestión Ágil (Jira)
El seguimiento de historias de usuario, asignación de tareas del Sprint y flujo Kanban se encuentra disponible en:  
👉 **[Acceder al Tablero Scrum en Jira Software](https://jannysgarrido21.atlassian.net/jira/software/projects/SCRUM/boards/1?filter=&groupBy=none)**

---

## 🧩 4. Módulos Principales del Sistema

```
                      MÓDULOS DE "PURA SED"
   ┌───────────────────────────┼───────────────────────────┐
   ▼                           ▼                           ▼
[Menú & Combos]         [Pedidos & Mesas]          [Inventario Áreas]
• Variantes             • Tablet mesa / Celular    • Barra vs Cocina
• Promociones temporales• Despacho automático      • Descuento por orden
• Espectáculos          • Tracking en tiempo real  • Bloqueo de agotados
   │                           │                           │
   ▼                           ▼                           ▼
[Reservas & Acceso]     [Pagos & Facturación]      [Analítica & Métricas]
• QR dinámico por mesa  • Tarjeta (Pasarela)       • Cierre por jornada
• Agenda de Asistente   • Transferencia (Comprobante)• Satisfacción (1-5 ⭐)
• Control de aforo      • Factura / Orden compra   • Exportación Excel
```

* **Módulo 1: Menú, Promociones y Espectáculos:** Precios base inmutables con descuentos promocionales porcentuales con vigencia temporal. Soporte para espectáculos en vivo y combos.
* **Módulo 2: Comandas y Despacho:** Separación automática del pedido según área de preparación (cocina o bar). Seguimiento visual del estado (*Pendiente ➔ En Preparación ➔ Listo*).
* **Módulo 3: Inventario Descentralizado:** Stock independiente para cocina y bar; aviso de stock crítico y cambio de estado a "Agotado" para evitar pedidos imposibles de despachar.
* **Módulo 4: Reservas y Gestión de Mesas:** Asistente del bar coordina reservas previas y clientes espontáneos mediante códigos QR vinculados a la sesión de mesa.
* **Módulo 5: Caja, Cobro y Facturación:** Soporte de pagos mixtos (tarjeta con pasarela segura, transferencia verificable y efectivo). Emisión de factura con numeración secuencial.
* **Módulo 6: Encuesta de Calidad:** Valoración de 1 a 5 estrellas para la atención del mesero y para el servicio general del bar tras el pago.
* **Módulo 7: Reportes Gerenciales:** Métricas consolidadas por jornada: productos más vendidos, horas pico, promedio de consumo y permanencia en espectáculos.

---

## 📋 5. Requisitos del Sistema

### Requisitos Funcionales (RF)

| ID | Requisito Funcional | Descripción del Comportamiento | Historias de Usuario |
| :---: | :--- | :--- | :---: |
| **RF-01** | Acceso del Cliente | Permite acceso mediante QR o código de reserva sin registro previo. | HU-01 |
| **RF-02** | Autenticación y Roles | Autenticación para personal (Mesero, Cocina, Bar, Asistente, Admin, Superadmin). | HU-02, HU-03 |
| **RF-03** | Auditoría y Bitácora | Registro inmutable de acciones críticas realizadas por el personal. | HU-04 |
| **RF-04** | Catálogo del Menú | Visualización de comidas, bebidas, variantes, combos y espectáculos. | HU-05, HU-06, HU-07, HU-09 |
| **RF-05** | Promociones Temporales | Creación de descuentos por porcentaje con fecha/hora de inicio y caducidad. | HU-08 |
| **RF-06** | Disponibilidad de Stock | Productos con stock en cero se ocultan al cliente y se sombrean al personal. | HU-10 |
| **RF-07** | Control de Inventario | Registro de ingresos y descuento automático al confirmarse cada orden. | HU-11, HU-12 |
| **RF-08** | Registro de Pedidos | Toma de pedidos por mesa desde tablet o dispositivo móvil. | HU-13 |
| **RF-09** | Enrutamiento de Comandas| Separación automática de ítems hacia pantallas de Bar o Cocina. | HU-14, HU-15 |
| **RF-10** | Seguimiento de Pedidos | Vista en tiempo real del progreso de la orden para el cliente. | HU-16 |
| **RF-11** | Módulo de Reservas | Registro, modificación y cancelación de reservas de mesas. | HU-17, HU-18, HU-19 |
| **RF-12** | Liquidación y Pagos | Procesamiento de cobros por tarjeta, transferencia bancaria o efectivo. | HU-20, HU-21, HU-22, HU-23 |
| **RF-13** | Facturación | Emisión de factura/orden con detalle de consumo y numeración única. | HU-24 |
| **RF-14** | Medición de Calidad | Encuesta automática de 1 a 5 estrellas para mesero y servicio general. | HU-25, HU-26 |
| **RF-15** | Reportes por Jornada | Estadísticas de ventas, productos estrella y desempeño de personal. | HU-27 a HU-31 |
| **RF-16** | Exportación de Datos | Descarga de informes estadísticos en formato Excel (.xlsx). | HU-32 |

### Requisitos No Funcionales (RNF)

| ID | Categoría | Criterio de Calidad |
| :---: | :--- | :--- |
| **RNF-01** | **Seguridad** | Cifrado obligatorio de contraseñas mediante algoritmos hash seguros. No se almacenan números de tarjetas en la base de datos (delegado a pasarela). |
| **RNF-02** | **Canal Seguro** | Comunicación obligatoria bajo protocolo HTTPS y validación de tokens/roles en cada endpoint de la API. |
| **RNF-03** | **Auditoría** | Bitácora de operaciones de solo lectura, persistente y no modificable. |
| **RNF-04** | **Disponibilidad** | 99% de disponibilidad garantizada en el horario de operación pico (17:00 a 02:00). |
| **RNF-05** | **Rendimiento** | Respuestas de la Web API en menos de 3 segundos bajo carga normal. |
| **RNF-06** | **Usabilidad** | Diseño responsivo adaptado para tablets de mesa, pantallas táctiles de barra/cocina y celulares. |
| **RNF-07** | **Integridad** | Bloqueo estricto a nivel de base de datos contra reservas duplicadas, pagos dobles y stock negativo. |
| **RNF-08** | **Mantenibilidad** | Separación clara de responsabilidades entre Frontend (Blazor WASM) y Backend (API REST) documentado con Swagger. |

---

## 📁 6. Estructura de la Solución .NET

```text
pura-sed/
├── BarPuraSed.sln            # Contenedor principal de la solución
├── README.md                 # Documentación técnica y de negocio
├── .gitignore                # Exclusiones de Git (bin, obj, .vs)
│
├── BarAPI/                   # [BACKEND - ASP.NET Core Web API]
│   ├── Controllers/          # Endpoints REST (ej. CombosController, PedidosController)
│   ├── Data/                 # DbContext, Mappings y Modelos de Entidad (EF Core)
│   ├── Migrations/           # Migraciones de base de datos SQL Server
│   ├── Program.cs            # Configuración de Inyección de Dependencias, CORS y Middleware
│   ├── appsettings.json      # Cadena de conexión a SQL Server y configuraciones
│   └── BarAPI.csproj         # Definición de dependencias del Backend
│
└── BarCliente/               # [FRONTEND - Blazor WebAssembly]
    ├── Pages/                # Vistas Razor (Index, Menu, Pedidos, Admin, etc.)
    ├── Shared/               # Componentes compartidos, Navbar, Layouts
    ├── wwwroot/              # Archivos estáticos (CSS, Bootstrap, imágenes)
    ├── Program.cs            # Registro de HttpClient y configuración del cliente WASM
    └── BarCliente.csproj     # Definición de dependencias del Frontend
```

---

## 🚀 7. Guía de Puesta en Marcha Local

### Prerrequisitos
* [.NET 8 o .NET 9 SDK](https://dotnet.microsoft.com/download)
* [SQL Server Express / Developer](https://www.microsoft.com/sql-server/)
* [Git](https://git-scm.com/)
* [Visual Studio Code](https://code.visualstudio.com/) o [Visual Studio 2022](https://visualstudio.microsoft.com/)

### Paso a paso

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/Anghel01/pura-sed.git
   cd pura-sed
   ```

2. **Posicionarse en la rama de integración:**
   ```bash
   git checkout develop
   ```

3. **Ejecutar el Backend (Web API):**
   ```bash
   cd BarAPI
   dotnet run
   ```
   *Swagger estará accesible en:* `https://localhost:7001/swagger` (o el puerto configurado en `launchSettings.json`).

4. **Ejecutar el Frontend (Blazor WebAssembly):**
   *Abrir una segunda terminal:*
   ```bash
   cd BarCliente
   dotnet run
   ```
   *La aplicación cargará en:* `https://localhost:7100`

---

## 📈 8. Cronograma de Sprints del Proyecto

| Sprint | Semana | Alcance y Entregables Clave | Estado |
| :---: | :---: | :--- | :---: |
| **1** | **Semana 1** | Configuración de entorno, definición de alcance, estructura .NET (Web API + Blazor WASM), CORS y endpoint `/api/combos`. | 🟡 **En progreso** |
| **2** | **Semana 2** | Modelado de datos en SQL Server, DbContext, migraciones EF Core y arquitectura en capas. | ⚪ Planificado |
| **3** | **Semana 3** | Gestión de productos, categorías, catálogo interactivo y variantes de bebidas. | ⚪ Planificado |
| **4** | **Semana 4** | Módulo de pedidos por mesa y despacho independiente hacia cocina y bar. | ⚪ Planificado |
| **5-16** | **Semanas 5 a 16** | Reservas QR, pasarela de pagos, facturación, encuestas de calidad, reportes nocturnos y despliegue en la nube. | ⚪ Planificado |

---

## 📄 9. Licencia y Uso Académico
Este proyecto ha sido desarrollado exclusivamente con fines académicos como parte de la formación profesional en Ingeniería de Tecnologías de la Información en la **Escuela Politécnica Nacional**. Todos los derechos reservados al equipo de desarrollo y docentes tutores.