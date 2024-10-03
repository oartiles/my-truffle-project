# My Truffle Project

Este es un proyecto Truffle avanzado que implementa un sistema de préstamos similar a Aave. El proyecto incluye contratos inteligentes para manejar depósitos, préstamos y colaterales, utilizando oráculos para obtener precios en tiempo real.

## Objetivos del Proyecto

- Desarrollar un sistema de préstamos descentralizado que permita a los usuarios pedir prestado y prestar activos de manera segura.
- Implementar un mecanismo de colateralización para garantizar la seguridad de los préstamos.
- Utilizar oráculos para obtener precios en tiempo real de los activos.
- Proporcionar una interfaz de usuario para interactuar con los contratos inteligentes.

## Contratos

- `contracts/Migrations.sol`: Este archivo contiene el contrato Migrations, que se utiliza para realizar migraciones en el proyecto Truffle.
- `contracts/MyToken.sol`: Este archivo contiene el contrato MyToken, que implementa un token ERC20 básico.
- `contracts/DepositContract.sol`: Este archivo contiene el contrato DepositContract, que maneja los depósitos y retiros de tokens.
- `contracts/LendingProtocol.sol`: Este archivo contiene el contrato LendingProtocol, que maneja los préstamos y los pagos de intereses.
- `contracts/ChainlinkOracle.sol`: Este archivo contiene el contrato ChainlinkOracle, que utiliza Chainlink para obtener el precio de ETH en USD.

## Migraciones

- `migrations/1_initial_migration.js`: Este archivo contiene un script de migración inicial que se ejecuta cuando se realiza la migración del proyecto Truffle.
- `migrations/2_deploy_token.js`: Este archivo contiene un script de migración para desplegar el contrato MyToken.
- `migrations/3_deploy_deposit_contract.js`: Este archivo contiene un script de migración para desplegar el contrato DepositContract.
- `migrations/4_deploy_lending_protocol.js`: Este archivo contiene un script de migración para desplegar el contrato LendingProtocol junto con el oráculo de Chainlink.

## Pruebas

- `test/depositContractTest.js`: Este archivo contiene pruebas para el contrato DepositContract.
- `test/lendingProtocolTest.js`: Este archivo contiene pruebas para el contrato LendingProtocol.

## Configuración de Truffle

- `truffle-config.js`: Este archivo es el archivo de configuración principal de Truffle. Contiene la configuración para la red de blockchain, el compilador de Solidity y otros ajustes relacionados con el proyecto.

## Documentación

- `README.md`: Este archivo contiene la documentación del proyecto.

## Funcionamiento del Proyecto

### Depósitos y Retiros

Los usuarios pueden depositar tokens en el contrato DepositContract. Los tokens depositados se almacenan en el contrato y los usuarios pueden retirarlos en cualquier momento.

### Préstamos y Colaterales

El contrato LendingProtocol permite a los usuarios pedir prestado tokens proporcionando un colateral. El colateral debe ser al menos igual al valor del préstamo solicitado. El contrato utiliza un oráculo de Chainlink para obtener el precio en tiempo real del activo proporcionado como colateral.

### Oráculo de Precios

El contrato ChainlinkOracle utiliza Chainlink para obtener el precio de ETH en USD. Esto garantiza que el valor del colateral se evalúe correctamente en función del precio actual del mercado.

### Seguridad y Garantías

Para garantizar la seguridad de los usuarios en sus préstamos, el sistema implementa las siguientes medidas:

- **Colateralización**: Los usuarios deben proporcionar un colateral que sea al menos igual al valor del préstamo solicitado. Esto garantiza que el préstamo esté respaldado por un activo de valor equivalente.
- **Oráculos de Precios**: Utilizamos oráculos de Chainlink para obtener precios en tiempo real de los activos. Esto asegura que el valor del colateral se evalúe correctamente en función del precio actual del mercado.
- **Pruebas Exhaustivas**: El proyecto incluye pruebas exhaustivas para garantizar que los contratos inteligentes funcionen correctamente y que no haya vulnerabilidades.

## Ventajas de Utilizar un Sistema Descentralizado de Préstamos

- **Transparencia**: Todos los préstamos y transacciones se registran en la blockchain, lo que proporciona transparencia total.
- **Seguridad**: Los contratos inteligentes garantizan que las reglas del sistema se apliquen de manera automática y sin intervención humana.
- **Accesibilidad**: Cualquier persona con una conexión a Internet y una billetera compatible puede participar en el sistema de préstamos.
- **Eficiencia**: Las transacciones se procesan de manera rápida y eficiente en la blockchain, sin necesidad de intermediarios.

## Requisitos

- Node.js
- Truffle
- Ganache (o cualquier cliente de blockchain compatible)
- MetaMask (o cualquier billetera compatible con Ethereum)

## Instalación y Uso

1. Clona el repositorio:

    ```sh
    git clone https://github.com/tu-usuario/tu-repositorio.git
    cd tu-repositorio
    ```

2. Instala las dependencias:

    ```sh
    npm install
    ```

3. Configura y ejecuta Ganache:

    - Abre Ganache y crea un nuevo espacio de trabajo.

4. Despliega los contratos:

    ```sh
    truffle migrate --reset
    ```

5. Ejecuta las pruebas:

    ```sh
    truffle test
    ```

6. Interactúa con los contratos:

    - Usa la consola de Truffle:

        ```sh
        truffle console
        ```

    - O ejecuta scripts de interacción:

        ```sh
        truffle exec interact.js
        ```

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o un pull request para discutir cualquier cambio que te gustaría realizar.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.
