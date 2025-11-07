Allowance Wallet (Clarity Smart Contract)

This project implements an "Allowance Wallet" smart contract on the "Stacks blockchain", written in **Clarity** and tested using "Clarinet".  
The contract allows a "parent (controller)" to assign an "allowance" to another wallet (for example, a child or dependent), and the dependent can only withdraw up to the set allowance limit.


Features

| Feature | Description |
|--------|-------------|
| Set Allowance | The controller assigns a spending allowance to a specific user. |
| Increase / Decrease Allowance | The controller can modify the allowance at any time. |
| Withdraw Funds | The assigned user can withdraw STX up to their allowance limit. |
| View Allowance Balance | Anyone can check the stored allowance amount. |
| Permission Controls | Only the contract controller can change allowance values. |


Contract Structure

| Component | Description |
|----------|-------------|
| `allowances` map | Stores allowed amount per user wallet. |
| `controller` variable | The wallet that manages allowances. |
| Public functions | `set-allowance`, `increase-allowance`, `decrease-allowance`, `withdraw` |
| Read-only functions | `get-allowance`, `is-controller` |


Getting Started

1. Clone the repository
```bash
git clone https://github.com/yourname/allowance-wallet.git
cd allowance-wallet
