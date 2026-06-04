# Power BI Model — Table Documentation

**Report:** Eficiência Fábrica PLN 2025  
**Generated:** 2026-03-13

---

## Table of Contents

1. [Unique](#1-unique)
2. [HeadOrdens](#2-headordens)
3. [Teor Resultado](#3-teor-resultado)
4. [Custo & Classe](#4-custo--classe)
5. [Tipo Ordem](#5-tipo-ordem)
6. [Recursos](#6-recursos)
7. [QA33](#7-qa33)
8. [Consumo](#8-consumo)

---

## 1. Unique

**Purpose:** Central fact table for production order BOM (Bill of Materials) consumption analysis. Each row represents a unique combination of a production order and one of its components, containing standard vs. actual quantities, loss calculations, concentration data, and cost breakdowns in USD. This is the main table used for factory efficiency (eficiência) calculations.

**Column count:** 75  
**Key relationships:**

- `Ordem` → `HeadOrdens[Ordem]` (links to order header)
- `Ordem` → `Status[Ordem]` (links to order status)
- `Componente STD` → `Custo & Classe[STD CODE]` (links to cost/class lookup)
- `Chave_HS` → `Teor Resultado[Chave HS]` (links to assay/content results)
- `Chave Conc` ← `Consumo[OrdemComponente]` (receives actual consumption balance)

| Column | Data Type | Purpose |
|--------|-----------|---------|
| Chave Conc | String | Composite key (Order + Component) used to join with the Consumo table |
| Chave | String | General-purpose composite key for row identification |
| Ordem | String | Production/process order number (SAP) |
| Material | String | Finished product material code |
| Desc Material | String | Description of the finished product |
| Componente | String | Actual raw material / component code consumed |
| Mat | String | Short material identifier |
| HS Determ | String | HS (Harmonized System) code determination flag or classification |
| Chave_HS | String | Composite key linking to content/assay results in Teor Resultado |
| Lote | String | Batch/lot number of the production order |
| Desc Componente | String | Description of the consumed component |
| Comp | String | Short component identifier |
| doc | String | SAP material document number for goods movements |
| Componente STD | String | Standard (planned) component code from the BOM |
| Descrição Componente STD | String | Description of the standard BOM component |
| Componente Grupo | String | Grouping code for component families |
| Descrição Componente Grupo | String | Description of the component group |
| Correction Qtd | Double | Manual quantity correction applied to consumption |
| Correction Loss | Double | Manual loss correction value |
| Comp. STD/Desc. | String | Concatenation of standard component code and description |
| Comp./Desc. | String | Concatenation of actual component code and description |
| Fator | String | Conversion or adjustment factor applied to the component |
| Conc. STD | Double | Standard (planned) concentration/content of the component |
| Custo | Double | Unit cost of the component |
| Qtd STD | Double | Standard (planned) quantity per the BOM |
| Qtd sem Loss | Double | Quantity required without considering loss factor |
| Loss | Double | Planned loss percentage |
| Loss STD | Double | Standard loss quantity (from BOM) |
| Qtd de Loss | Double | Absolute quantity of loss |
| Loss corrigido | Double | Corrected loss percentage after adjustments |
| Qtd de Loss corrigido | Double | Corrected absolute loss quantity |
| Consumo Ativo | Double | Consumption of the active ingredient |
| Ativo 100% | Double | Active ingredient quantity normalized to 100% purity |
| Resultado | Double | Assay/test result value for the component |
| Alvo | Double | Target value for assay/content |
| Dif Teor | Double | Difference between actual and target content/assay |
| Consumo Resultado | Double | Consumption adjusted by the assay result |
| Resultado 100% | Double | Assay result normalized to 100% basis |
| Apontamento | Double | Posted/reported production quantity (SAP confirmation) |
| Consumo | Double | Actual total consumption quantity |
| Necessário Oficial | Double | Official required quantity (per standard BOM + loss) |
| Necessário Corrigido | Double | Corrected required quantity after manual adjustments |
| Conc. ACT | Double | Actual concentration/content measured |
| Qtd. Conc. | Double | Quantity adjusted for concentration differences |
| Diferença Oficial | Double | Variance: actual vs. official required quantity |
| Diferença Corrigido | Double | Variance: actual vs. corrected required quantity |
| Qtd. Doc Ajuste | Double | Quantity from adjustment documents |
| Qtd. Teor | Double | Quantity attributed to content/assay variation |
| Qtd. Genuíno Oficial | Double | Genuine (unexplained) deviation — official basis |
| Qtd. Genuíno Corrigido | Double | Genuine (unexplained) deviation — corrected basis |
| Nec. s/ Loss Oficial | Double | Required qty without loss — official |
| Nec. s/ Loss Corrigido | Double | Required qty without loss — corrected |
| Diferença s/ Loss Oficial | Double | Variance without loss — official |
| Diferença s/ Loss Corrigido | Double | Variance without loss — corrected |
| Dif Oficial vs Corrigido | Double | Delta between official and corrected variances |
| Dif USD ABS | Double | Absolute variance in USD |
| Dif USD | Double | Signed variance in USD |
| Doc USD | Double | Adjustment document value in USD |
| Conc. USD | Double | Concentration adjustment value in USD |
| Genuíno USD Oficial | Double | Genuine deviation cost — official (USD) |
| Genuíno USD Corrigido | Double | Genuine deviation cost — corrected (USD) |
| Teor USD | Double | Content/assay impact in USD |
| VPC USD Oficial | Double | Variable Production Cost — official (USD) |
| VPC USD Corrigido | Double | Variable Production Cost — corrected (USD) |
| Var Conc. | Double | Concentration variance |
| Qtd Resultado | Double | Quantity derived from test results |
| Loss Qtd Oficial | Double | Loss in quantity — official |
| Loss Qtd Corrigido | Double | Loss in quantity — corrected |
| Qtd Loss Oficial | Double | Loss quantity — official calculation |
| Qtd Loss Corrigido | Double | Loss quantity — corrected calculation |
| Loss Oficial USD | Double | Loss cost — official (USD) |
| Loss Corrigido USD | Double | Loss cost — corrected (USD) |
| Chave_Ordem_STD | String | Composite key: Order + Standard component |
| Fator Loss Oficial | Double | Loss factor used in the official calculation |
| Fator Loss Corrigido | Double | Loss factor used in the corrected calculation |

---

## 2. HeadOrdens

**Purpose:** Order header dimension table. Contains one row per production order with its key attributes such as date, material, batch, resource, and order type. Serves as the primary link between the `Unique` fact table and date/resource/family/order-type dimensions.

**Column count:** 11  
**Key relationships:**

- `Data` → `LocalDateTable` (date dimension)
- `Recurso` → `Recursos[Recurso]` (resource lookup, bidirectional)
- `Tp Ordem` → `Tipo Ordem[AUART]` (order type lookup)
- `Material` → `Familia[Material]` (product family lookup, bidirectional)
- `Ordem` ← `Unique[Ordem]` (fact table)

| Column | Data Type | Purpose |
|--------|-----------|---------|
| Data | DateTime | Production order date |
| Ano | Int64 | Year extracted from the order date |
| Dia | Int64 | Day of the month extracted from the order date |
| Ordem | String | Production/process order number (SAP) |
| Material | String | Finished product material code |
| Lote | String | Batch/lot number |
| Tp Ordem | String | Order type code (SAP AUART field) |
| Recurso | String | Production resource/work center code |
| Ordem&Lote | String | Concatenation of order number and lot for unique identification |
| Mês | String | Month name or number |
| URL | String | Hyperlink (likely to a SAP transaction or detail page) |

---

## 3. Teor Resultado

**Purpose:** Assay/content test results dimension. Stores quality analysis results (e.g., active ingredient concentration) for materials used in production. Linked to the `Unique` table via a composite key, allowing efficiency calculations to account for raw material potency variations.

**Column count:** 19  
**Key relationships:**

- `Chave HS` ← `Unique[Chave_HS]` (receives lookup from fact table)

| Column | Data Type | Purpose |
|--------|-----------|---------|
| Amostragem | String | Sampling reference or identifier |
| Material | String | Raw material code being tested |
| Lote | String | Batch/lot number of the tested material |
| Teor | String | Content/assay type identifier (e.g., active ingredient code) |
| Resultado | Double | Measured assay result value (e.g., % purity) |
| Descricao | String | Description of the material or test |
| GpMerc | String | Merchandise group / material group classification |
| Mat&Teor | String | Composite key: Material + Assay type |
| Alvo | Double | Target/standard value for the assay |
| Ativo | String | Active ingredient flag or identifier |
| Chave | String | General composite key for the record |
| Mat&Ativo | String | Composite key: Material + Active ingredient |
| Ordem | String | Production order reference |
| Consumo Resultado | Double | Consumption quantity adjusted by the assay result |
| Resultado 100% | Double | Result normalized to 100% purity basis |
| HS Code | String | Harmonized System code for the material |
| Chave HS | String | Composite key used to join with Unique table |
| Mat | String | Short material identifier |
| Dif Teor | Double | Difference between actual result and target assay value |

---

## 4. Custo & Classe

**Purpose:** Cost and classification lookup table for standard BOM components. Maps each standard component code to its cost, concentration, and classification hierarchy (class/subclass). Used to convert quantity variances into USD cost impacts.

**Column count:** 8  
**Key relationships:**

- `STD CODE` ← `Unique[Componente STD]` (bidirectional filter)

| Column | Data Type | Purpose |
|--------|-----------|---------|
| STD CODE | String | Standard component code (unique identifier in this table) |
| STD DESCRIPTION | String | Description of the standard component |
| CONS STD UNIT VPC | Double | Standard unit Variable Production Cost for consumption |
| Classe | String | High-level classification of the component (e.g., raw material type) |
| Subclasse | String | Sub-classification within the class |
| Concentração STD | Double | Standard concentration/purity of the component |
| Custo | Double | Unit cost of the component (USD) |
| Code | String | Alternative or short code identifier |

---

## 5. Tipo Ordem

**Purpose:** Order type dimension table. Maps SAP order type codes (AUART) to their descriptions and a flag indicating whether orders of that type should be included in efficiency calculations.

**Column count:** 3  
**Key relationships:**

- `AUART` ← `HeadOrdens[Tp Ordem]`
- `AUART` ← `QA33[TpOrdem]`

| Column | Data Type | Purpose |
|--------|-----------|---------|
| AUART | String | SAP order type code (e.g., ZP01, ZP02) |
| Tipo | String | Human-readable description of the order type |
| Considerar | String | Flag (e.g., "Sim"/"Não") indicating whether this order type should be considered in reports |

---

## 6. Recursos

**Purpose:** Production resource / work center dimension table. Maps resource codes to their manufacturing cell and production unit, enabling drill-down from plant → production unit → cell → resource.

**Column count:** 3  
**Key relationships:**

- `Recurso` ← `HeadOrdens[Recurso]` (bidirectional)
- `Recurso` ← `QA33[Recurso]`

| Column | Data Type | Purpose |
|--------|-----------|---------|
| Recurso | String | Resource / work center code |
| Célula | String | Manufacturing cell or production line name |
| PU | String | Production Unit (plant area/department) |

---

## 7. QA33

**Purpose:** Quality inspection results table, corresponding to SAP transaction QA33 (inspection lot results). Contains detailed inspection characteristics, results, and specification limits for production orders. Used for quality analysis and conformity tracking.

**Column count:** 37  
**Key relationships:**

- `Data` → `LocalDateTable` (date dimension)
- `Recurso` → `Recursos[Recurso]` (resource lookup)
- `TpOrdem` → `Tipo Ordem[AUART]` (order type lookup)

| Column | Data Type | Purpose |
|--------|-----------|---------|
| Resultado | Double | Numerical inspection result value |
| Inf | Double | Lower specification limit (numeric) |
| Sup | Double | Upper specification limit (numeric) |
| Volume | Double | Batch volume or quantity inspected |
| Ordem | String | Production/process order number |
| Material | String | Material code of the inspected product |
| Descricao | String | Material description |
| Mat | String | Short material identifier |
| Ordem&Lote | String | Composite key: Order + Lot |
| TpOrdem | String | Order type code (SAP AUART) |
| Recurso | String | Resource / work center where production occurred |
| Amostragem | String | Sampling procedure reference |
| Operacao | String | Inspection operation number |
| Desc Operacao | String | Description of the inspection operation |
| numberAmostra | String | Sample number within the inspection lot |
| Amostra | String | Sample identifier |
| TpAmostra | String | Sample type (e.g., in-process, final) |
| DU_Amostra | String | Decision of use / sample disposition |
| No | String | Sequential number of the characteristic within the operation |
| Caracteristica | String | Inspection characteristic code |
| Descricao Caracteristica | String | Description of the inspection characteristic |
| Lote | String | Batch/lot number |
| Chave | String | Composite key for the inspection record |
| Especificacao | String | Specification text or range description |
| ResultadoTXT | String | Result as text (for non-numeric characteristics) |
| InfTXT | String | Lower limit as text |
| SupTXT | String | Upper limit as text |
| UM | String | Unit of measure for the characteristic |
| casaDecimais | Double | Number of decimal places for the result |
| Avaliacao | String | Evaluation/assessment outcome (e.g., Accepted/Rejected) |
| DinamicAvaliacao | String | Dynamic evaluation status |
| Mes | String | Month of the inspection |
| Data | DateTime | Date of the inspection |
| Ano | String | Year of the inspection |
| Dia | String | Day of the inspection |
| Caract | String | Short characteristic code |
| Resultado 100% | Double | Result normalized to 100% basis (e.g., dry weight) |

---

## 8. Consumo

**Purpose:** Actual goods-movement consumption balance table. Provides the net consumed quantity (balance) for each order-component combination, which is compared against standard/required quantities in the `Unique` table to compute variances.

**Column count:** 2  
**Key relationships:**

- `OrdemComponente` → `Unique[Chave Conc]` (bidirectional)

| Column | Data Type | Purpose |
|--------|-----------|---------|
| OrdemComponente | String | Composite key: Order + Component (matches Unique.Chave Conc) |
| Saldo | Double | Net consumption balance (sum of goods issues minus reversals) |

---

## Entity-Relationship Summary

```
Recursos ←── HeadOrdens ──→ Tipo Ordem
   ↑              ↑  ↓           ↑
   │              │  Familia     │
   │              │              │
   └──── QA33 ────┘──────────────┘
                  
Consumo ←→ Unique ──→ HeadOrdens
               │ ──→ Status
               │ ←→ Custo & Classe
               └──→ Teor Resultado
```

**Key data flow:**
1. **HeadOrdens** provides the order header (date, material, resource, type).
2. **Unique** expands each order into its BOM components with standard vs. actual quantities and USD cost impacts.
3. **Consumo** feeds the actual consumption balance back into Unique.
4. **Teor Resultado** provides assay/content corrections.
5. **Custo & Classe** provides unit costs and component classification.
6. **Recursos** and **Tipo Ordem** are shared dimensions for both HeadOrdens and QA33.
7. **QA33** holds independent quality inspection data at the characteristic level.
