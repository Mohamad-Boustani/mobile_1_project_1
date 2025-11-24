# Mobile_1_Project_1

Simple personal finance Flutter app (first project by Mohamad Boustani).

Overview

- A small Flutter app to track transactions in multiple currencies (USD & LBP).
- Shows totals for income, expenses and balance per currency.
- Screens: Home / Add Transaction / Transaction List.

Notes

- The UI is basic and intended as a starter project.
- Data is currently held in-memory in `lib/Data.dart` (no persistence).
- To make the balances reactive after adding a transaction, the HomePage rebuilds on return from the
  Add Transaction screen.

